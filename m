Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318132AbSGRPsB>; Thu, 18 Jul 2002 11:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318148AbSGRPsB>; Thu, 18 Jul 2002 11:48:01 -0400
Received: from ihemail1.lucent.com ([192.11.222.161]:31913 "EHLO
	ihemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id <S318132AbSGRPsA>; Thu, 18 Jul 2002 11:48:00 -0400
From: stoffel@lucent.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15670.58295.8003.858959@gargle.gargle.HOWL>
Date: Thu, 18 Jul 2002 11:50:15 -0400
To: Bill Davidsen <davidsen@tmr.com>
Cc: stoffel@lucent.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Backups done right (was [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
In-Reply-To: <Pine.LNX.3.96.1020718105612.7522B-100000@gatekeeper.tmr.com>
References: <15668.39927.923118.516621@gargle.gargle.HOWL>
	<Pine.LNX.3.96.1020718105612.7522B-100000@gatekeeper.tmr.com>
X-Mailer: VM 6.95 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bill> On Tue, 16 Jul 2002 stoffel@lucent.com wrote:
>> 3a. lock mirrored volume, flush any outstanding transactions, break
>> mirror.
>> --or--
>> 3b. snapshot filesystem to another volume.

Bill> Good summary. The problem is that 3a either requires a double
Bill> morror or leaving the f/s un mirrored, and 3b can take a very
Bill> long time for a big f/s.

Yup, 3a isn't a totally perfect solution, though triple mirrors (if
you can afford them) work well.  We actually do this for some servers
where we can't afford the application down time of locking the DB for
extended times, but we also don't have triple mirrors either.  It's a
tradeoff.

I really prefer 3b, since it's more efficient, faster, and more
robust.  To snapshot a filesystem, all you need to do is:

 - create backing store for the snapshot, usually around 10-15% of the
   size of the original volume.  Depends on volatility of data.
 - lock the app(s).
 - lock the filesystem and flush pending transactions.
 - copy the metadata describing the filesystem
 - insert a COW handler into the FS block write path
 - mount the snapshot elsewhere
 - unlock the FS
 - unlock the app

Whenever the app writes a block into the FS, copy the original block
to the backing store, then write the new block to storage.  

All the backups see if the quiescent data store, so it can do a clean
backup.  

When you're done, just unmount the snapshot and delete it, then remove
the backing store.  There is an overhead for doing this, but it's
better than having to unmirror/remirror whole block devices to do a
backup.  And cheaper in terms of disk space too. 

Bill> In general mauch of this can be addressed by only backing up
Bill> small f/s and using an application backup utility to backup the
Bill> big stuff. Fortunately the most common problem apps are
Bill> databases and and they include this capability.

Define what a small file system is these days, since it could be 100gb
for some people.  *grin*.  It's a matter of making the tools scale
well so that the data can be secured properly.  

To do a proper backup requires that all layers talk to each other, and
have some means of doing a RW lock and flush of pending transactions.
If you have that, you can do it.  If you don't, you need to either
goto single user mode, re-mount RO, or pray.

John
