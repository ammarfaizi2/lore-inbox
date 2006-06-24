Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWFXWhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWFXWhF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 18:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWFXWhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 18:37:05 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:51932 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751142AbWFXWhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 18:37:04 -0400
Message-ID: <449DBE88.5020809@garzik.org>
Date: Sat, 24 Jun 2006 18:36:56 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: castet.matthieu@free.fr, B.Zolnierkiewicz@elka.pw.edu.pl, htejun@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: + via-pata-controller-xfer-fixes.patch added to -mm tree
References: <200606242214.k5OMEHCU005963@shell0.pdx.osdl.net>
In-Reply-To: <200606242214.k5OMEHCU005963@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org wrote:
> The patch titled
> 
>      VIA PATA controller xfer fixes
> 
> has been added to the -mm tree.  Its filename is
> 
>      via-pata-controller-xfer-fixes.patch
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
> 
> ------------------------------------------------------
> Subject: VIA PATA controller xfer fixes
> From: matthieu castet <castet.matthieu@free.fr>
> 
> 
> On via controller(vt8235) and pata via, some ATAPI devices (CDR-6S48) fail
> in the xfer mode initialisation.  This make the boot slow and the drive
> unsuable.
> 
> It seems the interrupt for xfer mode is done before the drive is ready, so
> the current libata code skip the interrupt.  But no new interrupt is done
> by the controller, so the xfer mode fails.
> 
> A quirk is to wait for 10 us (by step of 1 us) and see if the device
> becomes ready in the case of SETFEATURES_XFER feature.  The problem seems
> pata_via only, so the quirk is put in the pata_via interrupt handler as
> Tejun Heo request.
> 
> It won't affect working devices, as we don't wait if the device is already
> ready.  It will adds an extra ata_altstatus in order to avoid to duplicate
> ata_host_intr, but only in the case of SETFEATURES_XFER (with should happen
> only few times).
> 
> Sorry for the lack of changelog in my previous mail, I tought the old
> changelog + move it in pata via interrupt was enought.  And sorry again, I
> sent you a bad patch (I forgot a quitl refresh).

Data point #1:

Here I quote from drivers/ide generic code ide_config_drive_speed() in 
ide-iops.c:

    /*
     * Allow status to settle, then read it again.
     * A few rare drives vastly violate the 400ns spec here,
     * so we'll wait up to 10usec for a "good" status
     * rather than expensively fail things immediately.
     * This fix courtesy of Matthew Faupel & Niccolo Rigacci.
     */
    for (i = 0; i < 10; i++) {
            udelay(1);
            if (OK_STAT((stat = hwif->INB(IDE_STATUS_REG)),
			  DRIVE_READY, BUSY_STAT|DRQ_STAT|ERR_STAT)) {
                    error = 0;
                    break;
            }
    }

And there is similar logic in ide_wait_stat().  wait_drive_not_busy() in 
ide-taskfile.c waits for up to 1 ms.


Data point #2:

libata was originally based on the "highly correct" (or one version 
thereof) programming sequences found in Hale Landis's free ATADRVR 
(http://www.ata-atapi.com/).  Hale's ATADRVR, which was MS-DOS based and 
not threaded or asynchronous at all, did the following after every 
command execution (sent taskfile to hardware):

	if (device is ATAPI)
		sleep(150 ms)


Overall, I've no clue what to do on older PATA hardware, so my 
"insightful" suggestions are largely (a) follow drivers/ide code and/or 
(b) listen to any old fogies with deep historical knowledge.

