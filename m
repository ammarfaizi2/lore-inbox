Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269700AbUINUSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269700AbUINUSO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 16:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269773AbUINUOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 16:14:52 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:38078 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269737AbUINUKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 16:10:51 -0400
Subject: Re: I2O Updates + Questions
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41473F00.50109@shadowconnect.com>
References: <1095174189.16988.10.camel@localhost.localdomain>
	 <41473F00.50109@shadowconnect.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095188880.17043.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 14 Sep 2004 20:08:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-14 at 19:57, Markus Lidel wrote:
> > - Add recieve_to_virt and send_to_virt to clean up remaining
> >   virt_to_* usage. (I've tweaked them to reflect the i2o_dma
> >   objects) so hopefully I got it right
> > - Post an 8 byte startup message area. Some Promises scribble on the
> >   wrong dword. Also catch this
> > - Fix several cases where messages got written to I/O space without
> >   i2o_raw_writel
> > - Fix a case where we skipped dpt controllers on quiesce and didnt
> >   skip them on enable
> > - Add some bits to try and get promise behaving again
> > - Cleaned up the probe loop
> > - Removed the remainder of i2o_retry and used the trick I was using
> >   in my test code from back whenever- on congestion report BUS_BUSY
> >   and leave it to the scsi layer
> 
> Ohohhh... i2o_core.c shouldn't be there anymore... I've split up 
> i2o_core.c in own files e. g. iop.c, pci.c, ...

Ah probably someone didnt propogate the deletion. That happens. 

> > Looking at the code the event stuff seems totally broken in the new code
> > both in core and the commented out i2o_block code (which now leaks
> 
> The I2O Block driver doesn't use the event notifaction anymore, instead 
> it uses the probe and remove functions to add or remove disks...

It sets the event pointer so seems to get called with an event which it
fails to reply to (as required) and fails to kfree the kmalloc'd 
message. It would also be nice to keep the 0x20 message watch for
promise cards (at least when testing) since a promise firmware crash
isnt otherwise visible except as 16Mb of I/O going missing
> 
> > memory). Also i2o_scsi error path does a readl on msg->body[3] which is
> > wrong as msg->body[3] is in kernel space and its contents are an I2O
> > side message value so should get fed to i2o_send_to_virt().
> 
> The msg points to the outbound queue of the controller, don't i need a 
> readl there?

Messages from the controller to the kernel are in kernel memory. They
are the ones we allocated and posted. The data in body[3] is a message
offset in I2O space if I remember rightly.

> > Other question is message size - right now it uses the 2.4 message size
> > which is twice what all the vendors recommend as working best (and
> > doesn't work at all on AMI)
> 
> The message size from the outbound queue of the I2O controller?
> 
> Yep, the dpt_i2o driver even set it to 17 instead of 128 :-)
> 
> Sorry for the mistake with the i2o_core.c.
> 
> Thanks for taking time to look at the I2O driver!

No problem. I'll take a look at the split version of the driver and see
if the same fixes are needed. Since the bugs involved go back to my
original code they may well do.

Alan

