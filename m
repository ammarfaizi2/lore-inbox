Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264749AbTAJJcu>; Fri, 10 Jan 2003 04:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264756AbTAJJct>; Fri, 10 Jan 2003 04:32:49 -0500
Received: from mx9.mail.ru ([194.67.57.19]:23826 "EHLO mx9.mail.ru")
	by vger.kernel.org with ESMTP id <S264749AbTAJJcr>;
	Fri, 10 Jan 2003 04:32:47 -0500
From: "Andrey Borzenkov" <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Cc: quintela@mandrakesoft.com, chmouel@mandrakesoft.com
Subject: Does file read-ahead in 2.4 really read ahead=?koi8-r?Q?=3F?=
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Fri, 10 Jan 2003 12:41:27 +0300
Reply-To: "Andrey Borzenkov" <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E18WvfL-0000rr-00@f13.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following analysis is based on Mandrake 2.4.20-2mdk kernel, but the problems exists since 2.4.18 and probably earlier so it is unlikely to be a Mandrake-specific. I have pure IDE hardware; situation may be different on SCSI.

It appears that when do_generic_file_read queues readahead requests, it never ever runs tq_disk to trigger actual read. And in the worst case (when it is the first request in queue) it means that device queue remains plugged until next run_task_queue run. The effects are

- read-ahead may be delayed for as long as next read from device. In case of busy system doing much disk IO it is not as obvious (because tq_disk is run often); in case of single-user system running single-threaded aplication it makes read-ahead actually useless.

- it kills supermount. Supermount checks for media change on every file operation (sans actual read). For IDE ide_do_request blocks until queue is unplugged. In the worst case it happens first on next kupdated run i.e. 5 seconds. That explains terrible performance of supermount on CDs under some usage patterns (rpm /mnt/cdrom/*.rpm being the best example).

Comment at the end of generic_file_readahead suggets that it should unplug the queue:

/*
 * If we tried to read ahead some pages,
 * If we tried to read ahead asynchronously,
 *   Try to force unplug of the device in order to start an asynchronous
 *   read IO request.

but it never happens as far as I can tell.

Is it intended behaviour? 

-andrey

P.S. Please Cc on replies as I am not on lkml

P.P.S. Juan, Chmouel, I have patch for yet another bug that makes IDE CD-ROMs usable with supermount again, need to verify it. Unfortunately it cannot be generalized for HDs or SCSI devices.
