Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264663AbSJ3LUJ>; Wed, 30 Oct 2002 06:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264664AbSJ3LUJ>; Wed, 30 Oct 2002 06:20:09 -0500
Received: from smtp01.uc3m.es ([163.117.136.121]:55561 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S264663AbSJ3LUI>;
	Wed, 30 Oct 2002 06:20:08 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200210301126.g9UBQN610194@oboe.it.uc3m.es>
Subject: catch-22 in current partitioning layer
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Wed, 30 Oct 2002 12:26:23 +0100 (MET)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.5.44

1) a module which needs to create a device needs to call add_disk
   in it's init, or it seems the kernel won't allow opens of the
   device node.

   * But it can't call add_disk normally without invoking
   * check_partitions (escape, do so with capacity=0 or minors=1)
   * which will stall as it needs to read the device or its
   * backer on disk, and we're still in init ...

   This hits NBD. Pavel's kernel NBD escaped (luckily?-) because his
   device is not partitionable, and so he called add_disk with
   minors=1 even though capacity was set to maximum. But he narrowly
   missed hanging in init.

   It's not clear how we're supposed to /subsequently/ go out and find
   some partitions over NBD, or how to avoid the races in doing so,
   since we are already sort of open for business.  HEEEEELP. My own
   ENBD is being hit by this because it is partitionable.

   Can someone document the new genhd and partitions interfaces?
   I'm confused as anything, and fed up hunting for disappeared things
   that now seem to be available via strings of pointer references off
   of new structs (how do I get to rescan_partitions, for example!).

2) Partitions, ah yes, partitions.

   Well, seems the kernel is similarly not permitting opens of minors
   until we've run the partition check in add_disk. That's good
   encapsulation if you are planning on doing i/o to them, but I
   was planning on doing ioctls! And I don't think it's fair to
   stop me doing ioctls to the minors. Well, we can argue that, but it
   will break my userspace tools, and I'd rather not introduce 
   incompatibilities between kernel versions.
   
   In any case, I don't think it's fair to equate minors with
   partitions. Partitions are ONE use of minors. I use minors as
   indices, to indicate which channel to a device should be used.
   The device has its partition structure, and any partition can
   be served (I'm speaking of requests) via any channel, i.e.,
   any minor.

   * My catch 22 is that I can't start using the channels/minors to
   * talk to the remote device (ENBD) until I've opened the device
   * and done the partition search via add_disk, which won't work 
   * until the channels are open ...


Help. I'm still fairly sane, but this is hurting.

Ideally, what I would like, is to be able to open the minors for 
ioctls before allowing them to be open for r/w as partitions. Then
I don't need to do any changes. I open NOBLOCK for ioctls, if
that's any help.

Now, what's with this register_region business?  Can I maybe open 256
devices on the same major, with 1 minor each, just to enable
communications to the remote, then read the remote partition table, then
unregister them all, then register them all again this time with 16
minors per device, as I originally wanted?  No!  The partition check
will fail, because there are too many partitions (>0) !

Help.

OK, I know what the userspace solution is, but I don't want to do it:
Make all ioctls go the the whole disk minor. And keep them there. And
even then, how am I supposed to rescan the device for partitions and
avoid the races that must be in progress for access to those partitions
at startup?




Peter
