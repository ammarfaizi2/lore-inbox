Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263335AbUD2Emw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbUD2Emw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 00:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUD2Emw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 00:42:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:64911 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263335AbUD2Emg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 00:42:36 -0400
Date: Wed, 28 Apr 2004 21:42:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: busterbcook@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: pdflush eating a lot of CPU on heavy NFS I/O
Message-Id: <20040428214215.52426907.akpm@osdl.org>
In-Reply-To: <1083212515.2856.247.camel@lade.trondhjem.org>
References: <Pine.LNX.4.58.0404280009300.28371@ozma.hauschen>
	<20040427230203.1e4693ac.akpm@osdl.org>
	<Pine.LNX.4.58.0404280826070.31093@ozma.hauschen>
	<20040428124809.418e005d.akpm@osdl.org>
	<Pine.LNX.4.58.0404281534110.3044@ozma.hauschen>
	<1083187174.2856.162.camel@lade.trondhjem.org>
	<Pine.LNX.4.58.0404282254290.13673@ozma.hauschen>
	<1083212515.2856.247.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> On Wed, 2004-04-28 at 23:55, Brent Cook wrote:
> 
> > ozma:/home /home nfs rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=ozma 0 0
> 
> OK, then it's not the case that it is doing synchronous I/O.
> 
> I see that we're failing to set wbc->encountered_congestion in the case
> where a nonblocking writeback is forced to exit due to congestion. Could
> that be causing pdflush to loop Andrew?

It should be OK - after writepages completes the inode-level writeback code
will inspect BDI_write_congested and will propagate that into the
writeback_control for the top-level writeback code to ponder.

The pdflush silliness has been seen on smbfs and reiserfs too, so...

It looks like the problem is that the inode is stuck on the superblock's
s_io list, and we keep calling writepage(s) and writepage(s) keeps on
redirtying the page rather than writing it.  If so, moving the page off
s_io should fix it up.


