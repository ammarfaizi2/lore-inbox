Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267445AbUJLSZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267445AbUJLSZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 14:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUJLSZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 14:25:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8099 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266572AbUJLSZ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 14:25:28 -0400
Message-ID: <416C2189.4080302@pobox.com>
Date: Tue, 12 Oct 2004 14:25:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Christoph Hellwig <hch@infradead.org>, Mark Lord <lsml@rtr.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: driver hacking tips (was Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3)
References: <4161A06D.8010601@rtr.ca>	<416547B6.5080505@rtr.ca>	<20041007150709.B12688@i			nfradead.org>	<4165624C.5060405@rtr.ca>	<416565DB.4050006@pobox.com>	<4165	A	4	5D.2090200@rtr.ca>	<4165A766.1040104@pobox.com>	<4165A85D.7080704@rtr.ca	>		<4	165AB1B.8000204@pobox.com>	<4165ACF8.8060208@rtr.ca>		<20041007221537.	A17	712@infradead.org>	<1097241583.2412.15.camel@mulgrave>		<4166AF2F.607090	4@rtr.ca> <1097249266.1678.40.camel@mulgrave>		<4166B48E.3020006@rtr.ca>	<1097250465.2412.49.camel@mulgrave> 	<416C0D55.1020603@rtr.ca>	<1097601478.2044.103.camel@mulgrave>  <416C12CC.1050301@rtr.ca> <1097602220.2044.119.camel@mulgrave> <416C157A.6030400@rtr.ca> <416C177B.6030504@pobox.com> <416C19B9.7000806@rtr.ca>
In-Reply-To: <416C19B9.7000806@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[subject changed as this knowledge can benefit others as well]

In addition to agreeing with James' most recently assessment of 
qs_process_sff_entry(), I wanted to interject a bit of more general 
discussion...

Two main, but unrelated, driver-writing points:

1) Putting almost all your in-irq code into a tasklet can be quite 
convenient, if your situation is amenable to that.  The benefits are

a) your irq handler is tiny,

	ack irqs
	tasklet_schedule()

b) data can be synchronized without a lock, if the data is only used in 
the tasklet or in between tasklet_disable/tasklet_enable pairs.

c) you can "call" your in-irq code from places other than your irq 
handler, and let the tasklet subsystem synchronize the tasklet schedule. 
  no worries about disabling interrupts, they will just do (a) as 
described above.


2) You want to avoid a model (like qs_process_sff_entry, alas) where you 
have one single, huge "event completion" path, called from various 
points in the driver.  Instead, do your best to make sure event/action 
as fine-grained as possible.

Storage drivers that want to handle long-running events, or events that 
need process context, typically want to either fire off events 
_asynchronously_ via schedule_work(), or have a long-running thread that 
does nothing but processes an internal driver event queue.  It's really 
programmer's preference at that point, as having a single (or per-host) 
event queue thread can sometimes be more simple than async work queue code.

	Jeff



