Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946098AbWKJOf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946098AbWKJOf7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 09:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424399AbWKJOf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 09:35:59 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:49828 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1424398AbWKJOf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 09:35:58 -0500
Message-ID: <45548D3E.2010405@openvz.org>
Date: Fri, 10 Nov 2006 17:31:26 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Ingo Molnar <mingo@redhat.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@elte.hu,
       Kirill Korotaev <dev@openvz.org>
Subject: Re: [RFC] [PATCH] Fix misrouted interrupts deadlocks
References: <455484E4.1020100@openvz.org> <1163167950.1980.4.camel@earth>
In-Reply-To: <1163167950.1980.4.camel@earth>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> On Fri, 2006-11-10 at 16:55 +0300, Pavel Emelianov wrote:
>> -                       int ok = misrouted_irq(irq);
>> +                       int ok;
>> +
>> +                       spin_unlock(&desc->lock);
>> +                       ok = misrouted_irq(irq);
>> +                       spin_lock(&desc->lock); 
> 
> your fix looks reasonable to me - it's a thinko to call misrouted_irq()
> with the descriptor lock still held. (btw., how did you find it -
> lockdep spinlock debugging or NMI watchdog?)

It was NMI watchdog who reported the deadlock. With lockdep
turned on it wouldn't be caught - local_irq_enable_in_hardirq()
is nothing but a "do { } while (0)" if CONFIG_LOCKDEP=y :)

The second issue (with 2 cpus involved) was discovered
by code examining.

> Acked-by: Ingo Molnar <mingo@redhat.com>
> 
> 	Ingo
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

