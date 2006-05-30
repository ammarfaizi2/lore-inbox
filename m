Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWE3MKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWE3MKL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWE3MKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:10:10 -0400
Received: from mail4.hermes.si ([193.77.5.145]:10251 "EHLO mail4.hermes.si")
	by vger.kernel.org with ESMTP id S1750934AbWE3MKJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:10:09 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Long delay on bootup with wait_hwif_ready
Date: Tue, 30 May 2006 14:10:06 +0200
Message-ID: <B216E7A91F67B6429E3ACF162402A02D0E5F90@hsl-lj-mail.hermes.si>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Long delay on bootup with wait_hwif_ready
Thread-Index: AcaD4L1N0imdthNjSTOie7QaM3O6UAAAKo5Q
From: "David Balazic" <david.balazic@hermes.si>
To: "Steven Rostedt" <rostedt@goodmis.org>,
       "LKML" <linux-kernel@vger.kernel.org>
Cc: "Jeff Garzik" <jgarzik@pobox.com>, "Andi Kleen" <ak@suse.de>,
       "Pavel Machek" <pavel@suse.cz>, "Matt Domsch" <Matt_Domsch@dell.com>,
       "David Balazic" <david.balazic@hermes.si>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

My "final conclusion" last time was, that there is some memory
area, that comes out too short in certain cases.
This is some early kernel boot code, that deals with the BIOS (and
confuses it, it seems, by running out the mentioned memory area).

As I understood, the kernel could be tweaked to increase/decrease
the problemtatic memory area (or the usage of it).

It is some kind of stack, heap or segment, I don't know, but somebody
mentioned it last time.

Regards,
David

PS: Feel free to ask me for testing patches ;-)
I still have the same PC (with a certain weird behavior lately,
I can't switch the IDE mode from "RAID" to "normal" ...)



> -----Original Message-----
> From: Steven Rostedt [mailto:rostedt@goodmis.org] 
> Sent: Tuesday, May 30, 2006 2:01 PM
> To: LKML
> Cc: Jeff Garzik; Andi Kleen; Pavel Machek; Matt Domsch; David Balazic
> Subject: Long delay on bootup with wait_hwif_ready
> 
> 
> Hi,
> 
> I got a board I'm working with which has the following IDE controller.
> 
> # lspci
> ...
> 0000:00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 
> IDE (rev 01)
> ..
> 
> On boot up there's a 35 second delay that happens right here:
> 
> (happens on 2.6.9 - 2.6.16)
> 
> 	/* Now make sure both master & slave are ready */
> 	SELECT_DRIVE(&hwif->drives[0]);
> 	hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
> 	mdelay(2);
> 	rc = ide_wait_not_busy(hwif, 35000);
> 	if (rc)
> 		return rc;
> 	SELECT_DRIVE(&hwif->drives[1]);
> 	hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
> 	mdelay(2);
> Delaying function
>           |
>           V
> 	rc = ide_wait_not_busy(hwif, 35000);
> 
> There is no secondary drive, but for some reason the return of the
> status is 0x80 which is "busy".  So on boot up, we wait every time for
> this 35 second timeout.
> 
> I noticed that this was discussed before (got my CC from this thread):
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108890865325793&w=2
> But I didn't see a solution at the end.
> 
> So my question is. Is this just a bad response from hardware, or is
> there a better way to find out if the drive exists or not?
> 
> My current work around is to remove the wait for the second drive
> (removed the if(rc) from above to always return there), which is not
> robust, but suites my needs.
> 
> -- Steve
> 
> 
> 
