Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266345AbUHaDKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266345AbUHaDKx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 23:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266341AbUHaDKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 23:10:53 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:53742 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S266345AbUHaDKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 23:10:50 -0400
Subject: Re: [PATCH] Allow cluster-wide flock
From: Steve French <smfrench@austin.rr.com>
To: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Content-Type: text/plain
Message-Id: <1093921852.2444.34.camel@smfhome.smfdom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 30 Aug 2004 22:11:07 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm concerned that the overloading of
> f_op->lock() may break behaviour on NFS and CIFS.

Seems like a clear case that if their behavior is different we have to
be able to distinguish between them and there is a risk of overloading
f_op->lock().  It would not be particularly hard to carry them on the wire
(ie as network requests using a slightly modified newer SMBLockingX 
that would work to Samba).   Do you want these locks enforced [both] on the
client and server too (if there are races in the lock state when multiple
clients are created/deleting locks)?

> NFS currently has a test in nfs_lock() that causes it to return -ENOLCK
> if the argument is not a posix lock. 

I am willing to use a more relaxed semantic than that, but will
need to add an optional extension to the CIFS Protocol Unix Extensions
to distinguish the three (at least) types of locks

>
> Any comment on the effects on CIFS, Steven?

I am not sure I can answer until I get the current 2.6.9 locking
code working again and have time to prototype/experiment.
Cifs locking code regressed in two places 
(one of which I have fixed recently).  This is not the
usual impossible problem of trying to reconcile POSIX vs. 
SMB/CIFS locks well enough to pass connectathon lock tests 7 
and 10 to both Windows and Samba servers.  CIFS (the network
protocol) only defines mandatory locks (and overlapping locks are
not coalesced into one larger lock).  Since some clients such
as Windows (and OS/2, DOS etc - but not Unix & Linux 
clients) expect mandatory locks (rather than Advisory) 
there is not a perfect solution without extending the
protocol to allow the client to tell the server
that the locks are Advisory vs. Mandatory
(so after discussions with others on the Samba team this
is something that I am likely to do this year on the client
(ie optionally extend the protocol to distinguish the
two lock types), as soon as jra has time to change
the Samba server side) ... 

but in the meantime the CIFS lock code is broken. It looks like
the  global fs change to fix posix locking last week
broke cifs.  unlock (at least in connectathon 
lock subtest 7) can generate over CIFS a message:
	Attempting to free lock with active block list
probably because an additional change to unlock is necessary
in fs/cifs/file.c  I did fix one unrelated bug in the 
cifs lock code yesterday but today was trying to understand
what test 7 is attempting to do and why the block list is
not freed for cifs (but works locally).

