Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271450AbTGQOAt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 10:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271458AbTGQOAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 10:00:49 -0400
Received: from ierw.net.avaya.com ([198.152.13.101]:33766 "EHLO
	ierw.net.avaya.com") by vger.kernel.org with ESMTP id S271450AbTGQOAr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 10:00:47 -0400
From: "Bhavesh P. Davda" <bhavesh@avaya.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <fischer@norbit.de>, <dahinds@users.sourceforge.net>,
       "Marcelo Tosatti" <marcelo@conectiva.com.br>
Subject: RE: [PATCH] AHA152x driver hangs on PCMCIA card eject, kernel2.4.22-pre6
Date: Thu, 17 Jul 2003 08:15:39 -0600
Message-ID: <003201c34c6d$e62386a0$6e260987@rnd.avaya.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <1058361370.6633.6.camel@dhcp22.swansea.linux.org.uk>
X-OriginalArrivalTime: 17 Jul 2003 14:15:39.0418 (UTC) FILETIME=[E6397FA0:01C34C6D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Wednesday, July 16, 2003 7:16 AM
> To: Bhavesh P. Davda
> Cc: Linux Kernel Mailing List; fischer@norbit.de;
> dahinds@users.sourceforge.net; Marcelo Tosatti
> Subject: Re: [PATCH] AHA152x driver hangs on PCMCIA card eject,
> kernel2.4.22-pre6
>
>
> On Maw, 2003-07-15 at 22:56, Bhavesh P. Davda wrote:
> > 2. A change to the aha152x_cs stub driver to not use the SCSI
> error-handling
> > thread code. The aha152x_cs driver calls scsi_unregister_module() as a
> > queued timer task when it gets a CS_EVENT_CARD_REMOVAL event,
> which causes
> > scsi_unregister_host() to do a down() on a semaphore, calling
> schedule(),
> > when executing the timer_bh for the timer.
>
> Right - scsi_unregister should not be called on a timer event, instead
> it needs to kick off a task queue


Thanks. I will give this a shot for the aha152x_cs stub driver, and post
another patch (unless David Hinds or Juergen Fischer get around to it
first).

However, the same problem exists for all the PCMCIA SCSI stub drivers, who
have all chosen to NOT use the scsi error handling thread, by setting
use_new_eh_code to 0 in the Scsi_Host_Template. I don't feel comfortable
posting patches to those stub drivers (fdomain, nsp, qlogic) to do the same,
since I don't have the hardware to test with.

Also, I wanted to warn you of a couple of leaps of faith I had to make to
answer questions I had for this patch:

1. Can the AIC-6360 host adapter ever have all 1's in the REV and DMACNTRL0
registers? I am guessing not, but waiting on specs from Adaptec to answer
this question.

2. What happens if there is no physical device hanging off an I/O port
address? I am guessing, that on an i386 host, the inb returns 0xFF, but am
not sure what happens on other architectures. I have a question outstanding
to Intel for this.

Thanks

- Bhavesh
--
Bhavesh P. Davda     E-mail    : bhavesh@avaya.com
Avaya Inc.           Phone/Fax : (303) 538-4438
Room B3-B03, 1300 West 120th Avenue
Westminster, CO 80234

