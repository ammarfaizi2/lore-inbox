Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267175AbTAPQ2r>; Thu, 16 Jan 2003 11:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267180AbTAPQ2r>; Thu, 16 Jan 2003 11:28:47 -0500
Received: from cm19173.red.mundo-r.com ([213.60.19.173]:15511 "EHLO
	demo.mitica") by vger.kernel.org with ESMTP id <S267175AbTAPQ2q>;
	Thu, 16 Jan 2003 11:28:46 -0500
To: "Andrey Borzenkov" <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, chmouel@mandrakesoft.com
Subject: Re: Does file read-ahead in 2.4 really read ahead?
References: <E18WvfL-0000rr-00@f13.mail.ru>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <E18WvfL-0000rr-00@f13.mail.ru>
Date: 16 Jan 2003 17:46:21 +0100
Message-ID: <m2of6hvy8y.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "andrey" == Andrey Borzenkov <arvidjaar@mail.ru> writes:

The last time that I looked, file_readahead was basically not used
in the whole kernel.  Sorry for the delay.

Later, Juan.

andrey> The following analysis is based on Mandrake 2.4.20-2mdk kernel, but the problems exists since 2.4.18 and probably earlier so it is unlikely to be a Mandrake-specific. I have pure IDE hardware; situation may be different on SCSI.
andrey> It appears that when do_generic_file_read queues readahead requests, it never ever runs tq_disk to trigger actual read. And in the worst case (when it is the first request in queue) it means that device queue remains plugged until next run_task_queue run. The effects are

andrey> - read-ahead may be delayed for as long as next read from device. In case of busy system doing much disk IO it is not as obvious (because tq_disk is run often); in case of single-user system running single-threaded aplication it makes read-ahead actually useless.

andrey> - it kills supermount. Supermount checks for media change on every file operation (sans actual read). For IDE ide_do_request blocks until queue is unplugged. In the worst case it happens first on next kupdated run i.e. 5 seconds. That explains terrible performance of supermount on CDs under some usage patterns (rpm /mnt/cdrom/*.rpm being the best example).

andrey> Comment at the end of generic_file_readahead suggets that it should unplug the queue:

andrey> /*
andrey> * If we tried to read ahead some pages,
andrey> * If we tried to read ahead asynchronously,
andrey> *   Try to force unplug of the device in order to start an asynchronous
andrey> *   read IO request.

andrey> but it never happens as far as I can tell.

andrey> Is it intended behaviour? 

andrey> -andrey

andrey> P.S. Please Cc on replies as I am not on lkml

andrey> P.P.S. Juan, Chmouel, I have patch for yet another bug that makes IDE CD-ROMs usable with supermount again, need to verify it. Unfortunately it cannot be generalized for HDs or SCSI devices.


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
