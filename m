Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315893AbSFYUpa>; Tue, 25 Jun 2002 16:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSFYUp3>; Tue, 25 Jun 2002 16:45:29 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:64014 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S315893AbSFYUp3> convert rfc822-to-8bit; Tue, 25 Jun 2002 16:45:29 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: ide driver bug fix for the error message "hda: bad special flag0x03"
Date: Tue, 25 Jun 2002 15:45:23 -0500
Message-ID: <5A96E87E2BA0714ABBEA2C8F3F3F667C0AA681@cceexc19.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ide driver bug fix for the error message "hda: bad special flag0x03"
Thread-Index: AcIch3adizQdDxUeQqeuDX+QFYwPwwAAGABQ
From: "Shen, JT" <JT.Shen@hp.com>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Jun 2002 20:45:24.0340 (UTC) FILETIME=[3ADC2B40:01C21C89]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This problem is commonly found in an embedded SCSI system where there is no IDE hard drive. In that case, the cdrom device will have the device node /dev/hda. If you issue the command:

  cat /proc/ide/hda/identify

  or try to read the file /proc/ide/hda/identify

the kernel will print out the following message to the system log:

       "hda: bad special flag 0x03"

The user may think something is wrong but in reality nothing is wrong. And we don't want to see this message comes out when nothing is wrong.

JT

-----Original Message-----
From: Marcelo Tosatti [mailto:marcelo@conectiva.com.br]
Sent: Tuesday, June 25, 2002 2:34 PM
To: Shen, JT
Cc: andre@linux-ide.org; linux-kernel@vger.kernel.org
Subject: Re: ide driver bug fix for the error message "hda: bad special
flag0x03"



Mind to explain the problem in detail/

On Tue, 25 Jun 2002, Shen, JT wrote:

> diff -Naur linux-2.4.19-10/drivers/ide/ide-probe.c linux-2.4.19-11/drivers/ide/ide-probe.c
> --- linux-2.4.19-10/drivers/ide/ide-probe.c	Fri Jun 21 15:14:46 2002
> +++ linux-2.4.19-11/drivers/ide/ide-probe.c	Mon Jun 24 15:19:15 2002
> @@ -131,6 +131,7 @@
>  				type = ide_cdrom;	/* Early cdrom models used zero */
>  			case ide_cdrom:
>  				drive->removable = 1;
> +				drive->special.all = 0;
>  #ifdef CONFIG_PPC
>  				/* kludge for Apple PowerBook internal zip */
>  				if (!strstr(id->model, "CD-ROM") && strstr(id->model, "ZIP")) {
>
>
>
>
>
>
>
>
> Andre,
>
> Above is the patch that will fix the bug that when a user issue the command:
>
>    
>
> the message "hda: bad special flag 0x03" gets written to the system log.  This will happen because the .config file that RedHat uses to create the kernel image has the flag CONFIG_BLK_DEV_IDECD=m.  Thus in ide.c code, it won't call ide_cdrom_reinit(). So for CDROM the special flag is left as 0x03.
>
>
> The solution is to set the special flags to 0 when it is discovered as cdrom in ide-probe.c.
>
> Let me know if you have any question.
>
> Thanks,
>
> JT
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

