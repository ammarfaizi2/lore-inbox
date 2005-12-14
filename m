Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbVLNTl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbVLNTl5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 14:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbVLNTl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 14:41:56 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:54128 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S932436AbVLNTlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 14:41:55 -0500
Message-ID: <43A07577.5080501@ru.mvista.com>
Date: Wed, 14 Dec 2005 22:41:43 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: stephen@streetfiresound.com
CC: linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>,
       dpervushin@gmail.com, akpm@osdl.org, greg@kroah.com,
       basicmark@yahoo.com, komal_shah802003@yahoo.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
Subject: Re: [PATCH/RFC] SPI: add async message handing library to David	Brownell's
 core
References: <20051212182026.4e393d5a.vwool@ru.mvista.com>	 <20051213170629.7240d211.vwool@ru.mvista.com> <1134586122.24118.52.camel@localhost.localdomain>
In-Reply-To: <1134586122.24118.52.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Street wrote:

>On Tue, 2005-12-13 at 17:06 +0300, Vitaly Wool wrote:
>  
>
>>Greetings,
>>
>>This thingie hasn't been thoroughly tested yet, but it's lightweight
>>and easy to understand so I don't think solving the problems that 
>>may arise will take long. Though I haven't actually done that yet, 
>>I'm sure that Stephen's PXA SSP driver will become easier to understand 
>>and less in footprint and will work faster when it's rewritten using 
>>this library. (Yes, I do expect performance improvement here as the 
>>current implementation schedules multiple tasklets, so 
>>scheduling penalty is high.)
>>    
>>
>
>Is this really true?  Is tasklet scheduling "harder" than kernal thread
>scheduling?  A close look at my PXA SSP SPI implementation will reveal
>that my design is nearly lock-less and callable from any execution
>context (i.e. interrupt context).
>  
>
It's harder in your case because the tasklet is created each time it's 
scheduled again, as far as I see it in your impleemntation.
Each SPI controller thread is created only once so it's more lightweight 
than what you do.

>>+ * spi_queue - (internal) queue the message to be processed asynchronously
>>+ * @spi: SPI device to perform transfer to/from
>>+ * @msg: message to be sent
>>+ * Description:
>>+ * 	This function queues the message to SPI controller's queue.
>>+ */
>>+static int spi_queue(struct spi_device *spi, struct spi_message *msg)
>>+{
>>+	struct threaded_async_data *td = spi->master->context;
>>+	int rc = 0;
>>+
>>+	if (!td) {
>>+		rc = -EINVAL;
>>+		goto out;
>>+	}
>>+
>>+	msg->spi = spi;
>>+	down(&td->lock);
>>+	list_add_tail(&msg->queue, &td->msgs);
>>+	dev_dbg(spi->dev.parent, "message has been queued\n");
>>+	up(&td->lock);
>>+	wake_up_interruptible(&td->wq);
>>+
>>+out:
>>+	return rc;
>>+}
>>+
>>    
>>
>
>This can not be invoke this from "interrupt context" which is a
>requirement for my SPI devices (CS8415A, CS8405A, CS4341).
>
>
>  
>
Okay, not a major issue though. Change mutexes to 
spin_lock_irq/spin_unlock_irq and it's callable from an interrupt 
context, right?

Vitaly
