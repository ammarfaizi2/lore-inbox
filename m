Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161256AbVIPSnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161256AbVIPSnV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161257AbVIPSnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:43:21 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:1224 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1161256AbVIPSnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:43:20 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=PKuo2HcDFZest/N4L8yTYUdmAERkSWXzaGv8Xsmcjnjp28cyuD7naUqO0tKc1jU+4
	FB8s5HRCzFfLCl9VKni7Q==
Date: Fri, 16 Sep 2005 11:43:02 -0700
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org, basicmark@yahoo.com
Subject: Re: [RFC][PATCH] SPI subsystem
Cc: dpervushin@ru.mvista.com
References: <20050916175536.87846.qmail@web30315.mail.mud.yahoo.com>
In-Reply-To: <20050916175536.87846.qmail@web30315.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050916184302.4C6B985EB8@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thinking about it, for blocking transfers the core
> could call the adapters transfer routine and then
> start a wait on completeion. When the message has been
> sent the adapter would finish the completeion and the
> call to the core would then return (I think this is
> how the mmc core layer does it). How do you feel about
> that sugguestion? 

It resembles some code in my patch, which you included in your reply.
I've deleted the other parts; see at the end of this message.

(By the way, you should trim down your email replies and stop re-wrapping
things to 56-character borders... it breaks attribution prefixes as well
as patches, and makes your posts hard to read.)


> How would you feel about having a list head for
> messages in the adapter structure? I think every
> adapter driver would at least need this.

It's just as simple to use:

	struct my_spi_controller {
		struct spi_master	master;
		struct list_head	queue;
		... register pointers
		... and other controller-private state
	};

I prefer the information hiding approach.  In this case, no code
outside the controller driver ever has any business looking at that
queue; they shouldn't even be able to see it.  That way there will
be no temptation to change it and break anything.


> > As for MMC ... it'll be interesting to watch that
> > play out; won't the mmc_block code need to change?
>
> I don't know, I would hope not. If the mmc core is
> completely generic then I think I should only have to
> write a driver like mmci and not have to change the
> mmc_block or mmc core layers.

I seem to recall MMC/SD card specs showing different commands are
used in SPI mode than MMC/SD mode.  I'd be (pleasantly) surprised if
current mmc_block code already understood them.  (As I recall, the
specs from SanDisk were pretty informative.)

- Dave


> > +int spi_sync(struct spi_device *spi, struct spi_message *message)
> > +{
> > +	DECLARE_COMPLETION(done);
> > +	int status;
> > +
> > +	message->complete = spi_sync_complete;
> > +	message->context = &done;
> > +	status = spi_async(spi, message);
> > +	if (status == 0)
> > +		wait_for_completion(&done);
> > +	message->context = NULL;
> > +	return status;
> > +}
> > +EXPORT_SYMBOL(spi_sync);
