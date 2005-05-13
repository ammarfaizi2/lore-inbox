Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbVEMB0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVEMB0p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 21:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVEMBRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 21:17:09 -0400
Received: from fire.osdl.org ([65.172.181.4]:10430 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262215AbVEMA6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 20:58:06 -0400
Date: Thu, 12 May 2005 17:57:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: linda.dunaphant@ccur.com
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: NFS: msync required for data writes to server?
Message-Id: <20050512175720.74ea6a3e.akpm@osdl.org>
In-Reply-To: <1115925686.6319.3.camel@lindad>
References: <1115925686.6319.3.camel@lindad>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linda Dunaphant <linda.dunaphant@ccur.com> wrote:
>
> Hi Trond,
> 
> On our 2.6.9 based systems, data written using mmap(MAP_SHARED) on a NFS
> client is *never* being pushed out to the server if an explicit msync call
> is not issued before the munmap.
> 
> On 11/12/04, there was a message thread concerning NFS corruption when
> using mmap/munmap:
> 
> http://marc.theaimsgroup.com/?l=linux-nfs&m=110028817508318&w=2
> 
> In this thread you stated:
> 
>      mmap() offers absolutely NO guarantees that the file will be synced to
>      disk on close. Use msync(MS_SYNC) if you want such a guarantee.
> 
> Are you saying that the data will *never* be written to the server?  Could
> you please clarify your position on this further? 

The dirty pages will float about in memory until something causes them to
be written back.  That "something" could be
msync/fsync/sync/pdflush/journal commit or, eventually, the VM system
deciding that it wants to reuse that physical page for something else.

So yes, the page will eventually be written to the server, but not for
quite some time.

In the case where the page was dirtied by mmap and was then unmapped (via
munmap or via program exit), the page will be marked dirty in pagecache
when its pagetable entry is unmapped.  That makes the page's dirtiness
visible to the VFS and the page will be written out approximately 30
seconds later by pdflush.
