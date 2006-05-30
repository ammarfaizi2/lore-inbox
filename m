Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWE3MBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWE3MBw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWE3MBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:01:52 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:62697 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751285AbWE3MBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:01:51 -0400
Subject: Long delay on bootup with wait_hwif_ready
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andi Kleen <ak@suse.de>,
       Pavel Machek <pavel@suse.cz>, Matt Domsch <Matt_Domsch@dell.com>,
       David Balazic <david.balazic@hermes.si>
Content-Type: text/plain
Date: Tue, 30 May 2006 08:01:00 -0400
Message-Id: <1148990460.11270.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got a board I'm working with which has the following IDE controller.

# lspci
...
0000:00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
..

On boot up there's a 35 second delay that happens right here:

(happens on 2.6.9 - 2.6.16)

	/* Now make sure both master & slave are ready */
	SELECT_DRIVE(&hwif->drives[0]);
	hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
	mdelay(2);
	rc = ide_wait_not_busy(hwif, 35000);
	if (rc)
		return rc;
	SELECT_DRIVE(&hwif->drives[1]);
	hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
	mdelay(2);
Delaying function
          |
          V
	rc = ide_wait_not_busy(hwif, 35000);

There is no secondary drive, but for some reason the return of the
status is 0x80 which is "busy".  So on boot up, we wait every time for
this 35 second timeout.

I noticed that this was discussed before (got my CC from this thread):
http://marc.theaimsgroup.com/?l=linux-kernel&m=108890865325793&w=2
But I didn't see a solution at the end.

So my question is. Is this just a bad response from hardware, or is
there a better way to find out if the drive exists or not?

My current work around is to remove the wait for the second drive
(removed the if(rc) from above to always return there), which is not
robust, but suites my needs.

-- Steve


