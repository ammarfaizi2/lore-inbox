Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267268AbUBSOZy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 09:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267284AbUBSOZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 09:25:54 -0500
Received: from leon.mat.uni.torun.pl ([158.75.2.17]:36496 "EHLO
	Leon.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id S267268AbUBSOZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:25:52 -0500
Date: Thu, 19 Feb 2004 15:25:45 +0100 (CET)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@Juliusz
To: linux-kernel@vger.kernel.org
cc: Michal Wronski <wrona@mat.uni.torun.pl>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: [RFC][PATCH] 0/6 POSIX message queues
Message-ID: <Pine.GSO.4.58.0402191501450.18841@Juliusz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Following parts contain splitted into 6 subpatches implementation of POSIX
message queues. It was reviewed and improved by Manfred Spraul (much more
in fact then the small note in the mqueue.c header says). The library is
available at
http://www.mat.uni.torun.pl/~wrona/posix_ipc.

Following text gives overview what particular patches do (slighty
edited version of
http://colorfullife.com/~manfred/Linux-kernel/pmq/info.txt).

Awaiting comments.
Krzysztof Benedyczak

--------

Posix message queue support for Linux

Patch against 2.6.2

Sub-patches:

patch-mq-01-codemove:
	Move support functions from ipc/msg.c to ipc/util.c.  No code change.

patch-mq-02-syscalls:
	Add posix message queue syscalls for i386.
	The arch maintainer should pick the syscalls up for their archs.
	Notes:
		- no mq_close: functionality identical to close.
		  Slight spec violation: mq_close(open()) is supposed to fail.
		- mq_getattr merged into mq_setattr:
		  mq_setattr must return the old values.
		  Thus: mq_getsetattr() with new val==NULL for mq_getattr.

patch-mq-03-core:
	Core implementation.
	The arch maintainers should update signal code if needed.
	Notes:
		- mq_notify(,SIGEV_THREAD) is implemented with file
		  descriptors: mq_notify returned a pollable fd.
		  Reading from the fd returns NOTIFY_WOKENUP if a message was
		  receive and NOTIFY_REMOVED if notify was cancled,
		  respectively. Only one byte is returned - should be
		  byte order and word size independant.
		- Not all libfs helpers are used - preparation for mounting
		  the posix mqueue filesystem from user space.
		- open posix conformance results:
		  * mq_close(0) succeeds, should fail.
		    Ignored - side effect of implementing message queue as
		    fds.
		  * mq_unlink(<uninitialized str>) fails with EINVAL,
		    should fail with -ENOENT. Ignored, test is bogus.
		    mq_unlink("/nonexistant") fails with -ENOENT.

patch-mq-04-linuxext-poll:
	Linux extension: allow poll() on message queue fds.

patch-mq-05-linuxext-mount:
	Allows mounting mqueue fs.
	Gives removal with rm, creation with touch, etc.
