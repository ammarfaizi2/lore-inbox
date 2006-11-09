Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423303AbWKIOOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423303AbWKIOOb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 09:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966018AbWKIOOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 09:14:31 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:48318 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S966017AbWKIOOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 09:14:30 -0500
Message-ID: <455337B8.5000902@pobox.com>
Date: Thu, 09 Nov 2006 09:14:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Brice Goglin <Brice.Goglin@ens-lyon.org>,
       Jens Axboe <jens.axboe@oracle.com>,
       Gregor Jasny <gjasny@googlemail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       Douglas Gilbert <dougg@torque.net>, monty@xiph.org
Subject: Re: 2.6.19-rc3 system freezes when ripping with cdparanoia at ioctl(SG_IO)
References: <9d2cd630610291120l3f1b8053i5337cf3a97ba6ff0@mail.gmail.com> <20061030114503.GW4563@kernel.dk> <9d2cd630610300517q5187043eieb0880047ddd03eb@mail.gmail.com> <20061030132745.GE4563@kernel.dk> <4552F905.3020109@ens-lyon.org> <45533468.1060400@gmail.com>
In-Reply-To: <45533468.1060400@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> This works for most PATA ATAPI devices.  Most devices detect reversed 
> transfer and terminate the command promptly.  But this doesn't seem to 
> be true for SATA device.  Many just hang and time out commands with the 
> wrong transfer direction.  If you consider that most early SATA ATAPI 
> devices are actually PATA + bridge, this is sorta inevitable.  The 
> PATA-SATA bridge cannot issue D2H FIS to abort the command by itself. 
> It's just mirroring the status of PATA side and PATA side doesn't know 
> SATA protocol mismatch has occurred.
> 
> So, IDENTIFY w/ write-DMA protocol times out after quite some seconds. 
> This is where things go worse from bad.  SATA controllers which have 
> shadow TF registers don't handle timeout conditions very well, 
> especially when they're waiting for data transfer.  They basically hold 
> the PCI bus and hang till the transfer completes (which never happens). 
>  That's where the hard lock up comes from.
> 
> Jens, I think we need to match block sg's behavior to SCSI's.  Monty, 
> the timeout and hard lock up are due to hardware restrictions.  Kernel 
> and libata can't do much about it.  So, please find other way to detect 
> interface.


Mapping 'bidirectional' is a bit difficult.  It might be reasonable to 
interpret that as "userspace doesn't know" at lower layers, and then 
fill in a data transfer direction based on ATA command opcode.

Given that there are stupid apps/libs out there in the field with this 
behavior, even if the apps are fixed I think we are stuck with the 
stupidities.  At the very least, we could abort commands that transfer 
data in the opposite direction from indicated, based on a command opcode 
table.

	Jeff


