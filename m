Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267528AbUJLRnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267528AbUJLRnz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 13:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267518AbUJLRnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 13:43:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64671 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267435AbUJLRmd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 13:42:33 -0400
Message-ID: <416C177B.6030504@pobox.com>
Date: Tue, 12 Oct 2004 13:42:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Christoph Hellwig <hch@infradead.org>, Mark Lord <lsml@rtr.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
References: <4161A06D.8010601@rtr.ca>	<416547B6.5080505@rtr.ca>	<20041007150709.B12688@i			nfradead.org>	<4165624C.5060405@rtr.ca>	<416565DB.4050006@pobox.com>	<4165	A	4	5D.2090200@rtr.ca>	<4165A766.1040104@pobox.com>	<4165A85D.7080704@rtr.ca	>		<4	165AB1B.8000204@pobox.com>	<4165ACF8.8060208@rtr.ca>		<20041007221537.	A17	712@infradead.org>	<1097241583.2412.15.camel@mulgrave>		<4166AF2F.607090	4@rtr.ca> <1097249266.1678.40.camel@mulgrave>		<4166B48E.3020006@rtr.ca>	<1097250465.2412.49.camel@mulgrave> 	<416C0D55.1020603@rtr.ca>	<1097601478.2044.103.camel@mulgrave>  <416C12CC.1050301@rtr.ca> <1097602220.2044.119.camel@mulgrave> <416C157A.6030400@rtr.ca>
In-Reply-To: <416C157A.6030400@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> It's been there since day one.  The interrupt handling sometimes requires
> more functionality than is available at interrupt time, so it uses
> schedule_work to have a bottom half re-run itself from thread context.
> This is needed in the error-processing and hot plug paths.


ewwww  :)  If you find yourself calling your irq path from 
non-irq-context code, back up, you're going down the wrong path.

The usual way to do what you want is either

1) wrap all code that _might_ be called from inside interrupt handler 
inside spin_lock_irqsave() [except when you are in the interrupt 
handler, of course, which is merely spin_lock()

Any code that checks "if (in_interrupt())" should be shot on sight :)


2) have both interrupt and non-interrupt contexts fire a tasklet using 
tasklet_schedule().  Your tasklet function then does the real work.

	Jeff


