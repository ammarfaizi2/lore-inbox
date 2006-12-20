Return-Path: <linux-kernel-owner+w=401wt.eu-S932093AbWLTADm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWLTADm (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 19:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWLTADm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 19:03:42 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47408 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932093AbWLTADm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 19:03:42 -0500
Date: Tue, 19 Dec 2006 16:03:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Michal Sabala <lkml@saahbs.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 mmap hangs unrelated apps
Message-Id: <20061219160315.ea83ca38.akpm@osdl.org>
In-Reply-To: <1166570378.5760.52.camel@lade.trondhjem.org>
References: <20061215023014.GC2721@prosiaczek>
	<1166199855.5761.34.camel@lade.trondhjem.org>
	<20061215175030.GG6220@prosiaczek>
	<1166211884.5761.49.camel@lade.trondhjem.org>
	<20061215210642.GI6220@prosiaczek>
	<1166219054.5761.56.camel@lade.trondhjem.org>
	<20061219142624.230b28c0.akpm@osdl.org>
	<1166570378.5760.52.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006 18:19:38 -0500
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

>     NFS: Fix race in nfs_release_page()
>     
>     invalidate_inode_pages2() may set the dirty bit on a page owing to the call
>     to unmap_mapping_range() after the page was locked. In order to fix this,
>     NFS has hooked the releasepage() method. This, however leads to deadlocks
>     in other parts of the VM.

hmm, subtle.

>     Fix is to add a new callback: flushpage(), which will write out a dirty
>     page that is under the page lock.
>     

I guess this might permit us to clean up some of the nasties in
invalidate_inode_pages2() - if the page comes dirty again, write it again. 
But the requirement that the page remain locked makes it hard.  Need to
think about it some more.

Are you sure this is the cause of the NFS problem?

>  	.prepare_write = nfs_prepare_write,
>  	.commit_write = nfs_commit_write,
>  	.invalidatepage = nfs_invalidate_page,
> -	.releasepage = nfs_release_page,

A NULL ->releasepage means that try_to_release_page() will call
try_to_free_buffers() if PagePrivate().  I suspect you'll need a stub to
prevent this.

(We were supposed to stop doing that about four years ago - change it so
that all a_ops must implement ->releasepage, but nobody got around to it).

