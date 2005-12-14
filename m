Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbVLNSst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbVLNSst (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 13:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbVLNSst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 13:48:49 -0500
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:36555 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S964882AbVLNSss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 13:48:48 -0500
Subject: Re: [PATCH/RFC] SPI: add async message handing library to David
	Brownell's core
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>,
       dpervushin@gmail.com, akpm@osdl.org, greg@kroah.com,
       basicmark@yahoo.com, komal_shah802003@yahoo.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
In-Reply-To: <20051213170629.7240d211.vwool@ru.mvista.com>
References: <20051212182026.4e393d5a.vwool@ru.mvista.com>
	 <20051213170629.7240d211.vwool@ru.mvista.com>
Content-Type: text/plain
Organization: StreetFire Sound Labs
Date: Wed, 14 Dec 2005 10:48:42 -0800
Message-Id: <1134586122.24118.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.streetfiresound.liquidweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - streetfiresound.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-13 at 17:06 +0300, Vitaly Wool wrote:
> Greetings,
> 
> This thingie hasn't been thoroughly tested yet, but it's lightweight
> and easy to understand so I don't think solving the problems that 
> may arise will take long. Though I haven't actually done that yet, 
> I'm sure that Stephen's PXA SSP driver will become easier to understand 
> and less in footprint and will work faster when it's rewritten using 
> this library. (Yes, I do expect performance improvement here as the 
> current implementation schedules multiple tasklets, so 
> scheduling penalty is high.)

Is this really true?  Is tasklet scheduling "harder" than kernal thread
scheduling?  A close look at my PXA SSP SPI implementation will reveal
that my design is nearly lock-less and callable from any execution
context (i.e. interrupt context).

In general, the "pump_transfer" and "pump_message" tasklets should
mutually exclusive (anything else is a programming
mistake). I certainly could collapse the tasklets into a single one if
you think this would be better?

> + * spi_queue - (internal) queue the message to be processed asynchronously
> + * @spi: SPI device to perform transfer to/from
> + * @msg: message to be sent
> + * Description:
> + * 	This function queues the message to SPI controller's queue.
> + */
> +static int spi_queue(struct spi_device *spi, struct spi_message *msg)
> +{
> +	struct threaded_async_data *td = spi->master->context;
> +	int rc = 0;
> +
> +	if (!td) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	msg->spi = spi;
> +	down(&td->lock);
> +	list_add_tail(&msg->queue, &td->msgs);
> +	dev_dbg(spi->dev.parent, "message has been queued\n");
> +	up(&td->lock);
> +	wake_up_interruptible(&td->wq);
> +
> +out:
> +	return rc;
> +}
> +

This can not be invoke this from "interrupt context" which is a
requirement for my SPI devices (CS8415A, CS8405A, CS4341).


