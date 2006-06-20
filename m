Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbWFTL0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbWFTL0m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbWFTL0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:26:42 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:60427 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932588AbWFTL0l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:26:41 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 20 Jun 2006 11:26:39.0462 (UTC) FILETIME=[65EDC060:01C6945C]
Content-class: urn:content-classes:message
Subject: Re: emergency or init=/bin/sh mode and terminal signals
Date: Tue, 20 Jun 2006 07:26:39 -0400
Message-ID: <Pine.LNX.4.61.0606200716340.7695@chaos.analogic.com>
In-Reply-To: <20060619220920.GB5788@implementation.residence.ens-lyon.fr>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: emergency or init=/bin/sh mode and terminal signals
thread-index: AcaUXGX0CCKG4ml9TpiuhHKB/IqPvw==
References: <20060618212303.GD4744@bouh.residence.ens-lyon.fr> <Pine.LNX.4.61.0606190730070.27378@chaos.analogic.com> <20060619220920.GB5788@implementation.residence.ens-lyon.fr>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Samuel Thibault" <samuel.thibault@ens-lyon.org>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Jun 2006, Samuel Thibault wrote:

> linux-os (Dick Johnson), le Mon 19 Jun 2006 07:37:02 -0400, a écrit :
>> You can't allow some terminal input to affect init. It has been the
>> de facto standard in Unix, that the only time one should have a
>> controlling terminal is after somebody logs in and owns something to
>> control.
>
> Ok. The following still makes sense, doesn't it? (i.e. set a session for
> the emergency shell)
>
> --- linux-2.6.17-orig/init/main.c	2006-06-18 19:22:40.000000000 +0200
> +++ linux-2.6.17-perso/init/main.c	2006-06-20 00:07:07.000000000 +0200
> @@ -729,6 +729,11 @@
> 	run_init_process("/sbin/init");
> 	run_init_process("/etc/init");
> 	run_init_process("/bin/init");
> +
> +	/* Set a session for the shell.  */
> +	sys_setsid();
> +	sys_ioctl(0, TIOCSCTTY, 1);
> +
> 	run_init_process("/bin/sh");
>
> 	panic("No init found.  Try passing init= option to kernel.");
>

Well this makes 'sense' however, you should not modify the kernel
for this, you should do (trivialized and not tested):

int main(int count, char *argv[], char *env[])
{
    setsid();
    strcpy(argv[0], "/bin/bash");
    ioctl(0, TIOCSCTTY, 1);
    execve(argv[0], argv, env);
}

That gets you a shell with ^C capability. You could also
set up some signal handlers to minimize the potential of
killing your 'init' even though bash will set up its own.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
