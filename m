Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284751AbRLPStZ>; Sun, 16 Dec 2001 13:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284762AbRLPStL>; Sun, 16 Dec 2001 13:49:11 -0500
Received: from mons.uio.no ([129.240.130.14]:6909 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S284751AbRLPSsy>;
	Sun, 16 Dec 2001 13:48:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15388.60557.527680.468341@charged.uio.no>
Date: Sun, 16 Dec 2001 19:48:45 +0100
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More fun with fsx.
In-Reply-To: <Pine.LNX.4.33.0112161625200.876-100000@Appserv.suse.de>
In-Reply-To: <Pine.LNX.4.33.0112161557070.876-100000@Appserv.suse.de>
	<Pine.LNX.4.33.0112161625200.876-100000@Appserv.suse.de>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave Jones <davej@suse.de> writes:

     > On Sun, 16 Dec 2001, Dave Jones wrote:
    >> > > Full log of the failcase is at
    >> > > http://www.codemonkey.org.uk/cruft/nfs-fsx.txt
    >> > Which kernel and mount options?
    >> client 2.4.13-ac5, server 2.4.17rc1, default options, nothing
    >> special.  I'll try to reproduce with a newer kernel on the
    >> client.

     > Yup, it's still there with 2.4.17-rc1 as the client too.  Exact
     > same failure.

I found the bug. It's a pretty ugly race...

The problem is that although the inode->i_sem semaphore protects you
against races with ordinary writes, it does *not* protect you against
the memory management routines (such as page_launder()) from calling
writepage() on dirty pages.
For most local filesystems, this is not a problem, since they can call
vmtruncate() *before* they do their thing on the disk itself.  For
non-local filesystems, you usually can't do this, since you cannot
guarantee that the RPC call will succeed on the server.

The only solution I can see, is to force a synchronous write of those
dirty pages to the server prior to calling setattr. I've updated the
patch on

   http://www.fys.uio.no/~trondmy/src/2.4.17/linux-2.4.17-fattr.dif

to do this. Fixes the race for me...

Cheers,
   Trond
