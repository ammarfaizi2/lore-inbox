Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270021AbUJHPbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270021AbUJHPbt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 11:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270025AbUJHP3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 11:29:00 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:41403 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S270032AbUJHP16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 11:27:58 -0400
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Mark Lord <lkml@rtr.ca>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       Mark Lord <lsml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <4166AF2F.6070904@rtr.ca>
References: <4161A06D.8010601@rtr.ca>
	<416547B6.5080505@rtr.ca>	<20041007150709.B12688@infradead.org>
	<4165624C.5060405@rtr.ca>	<416565DB.4050006@pobox.com>
	<4165A45D.2090200@rtr.ca>	<4165A766.1040104@pobox.com>
	<4165A85D.7080704@rtr.ca>	<4165AB1B.8000204@pobox.com>
	<4165ACF8.8060208@rtr.ca> 	<20041007221537.A17712@infradead.org>
	<1097241583.2412.15.camel@mulgrave>  <4166AF2F.6070904@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 08 Oct 2004 10:27:41 -0500
Message-Id: <1097249266.1678.40.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 10:15, Mark Lord wrote:
> > Actually, the driver has no need for a thread at all.  Since you're
> > simply using it to fire hotplug events, use schedule_work instead.
> 
> That worries me some, because the mid-layer will perform blocking I/O
> and the like, and I'm not sure how much that stuff may depend on its
> own usage (any?) of workqueues.  If you believe it to be safe,
> then I'll nuke the kthread entirely.

We use this already for other entities that require user context like
domain validation.  It seems to work as advertised.

> > scsi_done() doesn't require a lock
> 
> Really?  I wonder why the mid-layer is so religious about
> doing the lock around every invocation of it today?

It's not if you look at other drivers.  There's no harm in taking the
lock, so none of the old ones got updated, but the lock isn't needed. 
The idea is that if you're holding the lock naturally (say in an
interrupt routine) there's no need to drop it artificially.  However,
you definitely shouldn't take it artificially like you do.

> > - Your emulated commands assume they're non-sg and issued through the
> > kernel (i.e. you don't kmap and you don't do SG).  This will blow up on
> > the first inquiry submitted via SG_IO for instance.
> 
> The SG is tested for and simply failed -- there is no need today for
> SG usage on those code paths.  If there turns out to be a need for that
> interface with this driver in the future, we can add it.  Just like most
> of the other drivers currently treat it.

And you've tested this with things like SUSE's hwinfo utility which
seems to send INQUIRIES on its own?

> What is the "kmap" semantic, and how should it be applied here?

kmap is used to make a user page visible to the kernel.

Really, I suppose, libata should provide the interfaces for doing this
work for emulated commands.

James


