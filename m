Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750743AbWFDQen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWFDQen (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 12:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWFDQem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 12:34:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:33739 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750743AbWFDQem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 12:34:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=acJiIPShObLbF8TiyGHS+g4rRenWYiiR+SHli8yhwig8tAQRdI21aWXC2Td3WLWQOXdFLMZLDDQY0+L+4Wy0DINIKvzCte1JqwjK+2ldDW0z6mynCLYmDATpIv+VkjSbwRLRoO0ZOsPn9Ym7M7oyHoSB6En92wS9nE6Cdgo9Hzg=
Date: Sun, 4 Jun 2006 18:34:55 +0100 (BST)
X-X-Sender: simlo@localhost
To: Steven Rostedt <rostedt@goodmis.org>
cc: Esben Nielsen <nielsen.esben@googlemail.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 3/5] [PREEMPT_RT] Changing interrupt handlers from running
 in thread to hardirq and back runtime.
In-Reply-To: <1149367140.13993.119.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606041834090.9391@localhost>
References: <20060602165336.147812000@localhost>  <Pine.LNX.4.64.0606022322010.9307@localhost>
 <1149367140.13993.119.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Jun 2006, Steven Rostedt wrote:

> On Fri, 2006-06-02 at 23:23 +0100, Esben Nielsen wrote:
>> Makes it possible for the e100 ethernet driver to have it's interrupt handler
>> in both hard-irq and threaded context under PREEMPT_RT.
>>
>> Index: linux-2.6.16-rt23.spin_mutex/drivers/net/e100.c
>> ===================================================================
>> --- linux-2.6.16-rt23.spin_mutex.orig/drivers/net/e100.c
>> +++ linux-2.6.16-rt23.spin_mutex/drivers/net/e100.c
>> @@ -530,7 +530,7 @@ struct nic {
>>   	enum ru_state ru_running;
>>
>>   	spinlock_t cb_lock			____cacheline_aligned;
>> -	spinlock_t cmd_lock;
>> +	spin_mutex_t cmd_lock;
>>   	struct csr __iomem *csr;
>>   	enum scb_cmd_lo cuc_cmd;
>>   	unsigned int cbs_avail;
>> @@ -1950,6 +1950,30 @@ static int e100_rx_alloc_list(struct nic
>>   	return 0;
>>   }
>>
>> +static int e100_change_context(int irq, void *dev_id,
>> +			       enum change_context_cmd cmd)
>> +{
>> +	struct net_device *netdev = dev_id;
>> +	struct nic *nic = netdev_priv(netdev);
>> +
>> +	switch(cmd)
>> +	{
>> +	case IRQ_TO_HARDIRQ:
>> +		if(!spin_mutexes_can_spin())
>> +			return -ENOSYS;
>> +
>> +		spin_mutex_to_spin(&nic->cmd_lock);
>> +		break;
>> +	case IRQ_CAN_THREAD:
>> +		/* Ok - return 0 */
>> +		break;
>
> Why even bother with the IRQ_CAN_THREAD.  If this would be anything
> other than OK, then we shouldn't be using that request_irq2 (yuck!) call
> in the first place.
>
Just for the sake of generality. Nothing else. It would be very unlikely, 
as you say, that it wouldn't return 0.

> -- Steve

Esben

