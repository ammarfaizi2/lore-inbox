Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbVIIO74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbVIIO74 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 10:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbVIIO74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 10:59:56 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:54801 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750868AbVIIO74 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 10:59:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.61.0509091017020.4550@chaos.analogic.com>
References: <20050909132725.C23462@pixie.comlab> <Pine.LNX.4.61.0509090829260.8368@chaos.analogic.com> <20050909143804.A23692@pixie.comlab> <Pine.LNX.4.61.0509091017020.4550@chaos.analogic.com>
X-OriginalArrivalTime: 09 Sep 2005 14:59:51.0970 (UTC) FILETIME=[218A9020:01C5B54F]
Content-class: urn:content-classes:message
Subject: Re: 2.6.13: loop ioctl crashes
Date: Fri, 9 Sep 2005 10:59:54 -0400
Message-ID: <Pine.LNX.4.61.0509091056010.4657@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.13: loop ioctl crashes
Thread-Index: AcW1TyGRExz70PGkTNK6F/6z0TyPtw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ian Collier" <Ian.Collier@comlab.ox.ac.uk>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Sep 2005, Richard B. Johnson wrote:

> On Fri, 9 Sep 2005, Ian Collier wrote:
>
>> On Fri, Sep 09, 2005 at 08:32:10AM -0400, linux-os (Dick Johnson) wrote:
>>> I guess you are trying to do a copy_from_user() with a spin-lock
>>> being held or the interrupts otherwise disabled. You can hold
>>> a semaphore, to prevent somebody else from interfering with
>>> you, but you cannot hold a spin-lock during copy/to/from/user().
>>
>> Well, I didn't write the code (it's right there in drivers/block/loop.c
>> in 2.6.13) and I can't see where there's a spin-lock.  In fact it does
>> use a semaphore.
>>
>> imc
>> -
>
> Try to see if it is really the loop device or something that is
> interfacing with it. Here I copy the contents of a DOS floppy
> to a file, then mount the file through the loop device:
>
> Script started on Fri 09 Sep 2005 10:17:27 AM EDT
> [root@chaos driver]# cp /dev/fd0 image
> [root@chaos driver]# ls -la image
> -rw-r-----  1 root root 1474560 Sep  9 10:18 image
> [root@chaos driver]# mount -o loop image /mnt
> [root@chaos driver]# ls -la /mnt
> total 894
> drwxr-xr-x   2 root root   7168 Dec 31  1969 [01;34m.[00m
> drwxr-xr-x  26 root root   4096 Sep  9 08:41 [01;34m..[00m
> -rwxr-xr-x   1 root root    170 Apr 10  2003 [01;32mautoexec.bat[00m
> -rwxr-xr-x   1 root root  86413 Jul 30  2002 [01;32mcommand.com[00m
> -rwxr-xr-x   1 root root   2882 Apr  9  2003 [01;32mconfig.sys[00m
> -rwxr-xr-x   1 root root  16967 Mar 27  2003 [01;32merr_lev.bat[00m
> -rwxr-xr-x   1 root root   5874 Jan 21  2002 [01;32mfdxxms.sys[00m
> -rwxr-xr-x   1 root root   3173 Mar 27  2003 [01;32mfindramd.exe[00m
> -rwxr-xr-x   1 root root  41293 Aug  4  2002 [01;32mkernel.sys[00m
> -rwxr-xr-x   1 root root 719592 Jun 28  2004 [01;32msw.exe[00m
> -rwxr-xr-x   1 root root  25084 Sep 28  2000 [01;32mtdsk.exe[00m
> [root@chaos driver]# umount /mnt
> [root@chaos driver]# exit
>
> Script done on Fri 09 Sep 2005 10:18:55 AM EDT
>
>

Ignore what I wrote following the stuff above:

The code wasn't broken after all. Function fget() didn't
dereference a pointer. It just got a number as 'arg' so
it didn't have to copy to/from anything.

The stuff that was dereferenced did use the correct
copy/to/from() code.

>
> This seems to work okay in 2.6.13, however I don't think it
> __should__ work because in lo_ioctl(), the following
> functions reference 'arg' without using copy/to/from/user() or
> put/get/user():
> 	loop_set_fd (vi fget()),
> 	loop_change_fd (via fget()),
> 	loop_get_status (via memset() and others),
> 	loop_get_status_old,
> 	loop_set_status64,
> 	loop_get_status64,
>        ... etc.
>
> Basically, anything that uses ioctl() on the loop device may find
> that they crash the system. This code is broken.
>
> Anton Altaparmakov last 'touched' that code in Feb 2005. Maybe
> he can fix the ioctl procedure to use the correct interface to
> user-land????

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.53 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
