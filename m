Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUEONxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUEONxX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 09:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbUEONxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 09:53:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7322 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262085AbUEONxV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 09:53:21 -0400
Date: Sat, 15 May 2004 14:53:18 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Oleg Drokin <green@linuxhacker.ru>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: NFS & long symlinks = stack overflow
Message-ID: <20040515135318.GP17014@parcelfarce.linux.theplanet.co.uk>
References: <20040515132149.GA14880@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040515132149.GA14880@linuxhacker.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2004 at 04:21:49PM +0300, Oleg Drokin wrote:
> Hello!
> 
>    For some time already I am investigating problems where fsstress run on
>    NFS where NFSD is run on ext3 crashes in something like a hour.
>    (but does not crash on reiserfs). On x86 crash looks like stack overflow
>    (deref of pointer with last 3 digits being zero in kmap directly after
>    get_current() call on 2.4.2x).
> 
>    Finally I was able to reduce a test case to two simple operations
>    that reproduce the problem 100% reliably:
> 
> [root@ranma root]# mount ranma:/testing /mnt -t nfs
> [root@ranma root]# cd /mnt
> [root@ranma mnt]# perl -e 'symlink("a"x4095, "f")'; ls -la f
> Segmentation fault
> 
>    (btw if you try to pass in something like 4090 worth of symbols, then
>    subsequent ls won't crash, but last few symbols of link content will be
>    corrupted)

Lovely.  The real limit imposed by client (apparently not enforced, though)
is PAGE_CACHE_SIZE - 4 - 1.  What are the protocol limits?  I've been looking
into the same area for other reasons just now and all I could find was NFS v2
"no more than 1024 bytes", no information on v3 or v4.

Trond?
