Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267072AbSL3W1O>; Mon, 30 Dec 2002 17:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267078AbSL3W1O>; Mon, 30 Dec 2002 17:27:14 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:16557 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267072AbSL3W1N>;
	Mon, 30 Dec 2002 17:27:13 -0500
Message-ID: <3E10C991.4060807@colorfullife.com>
Date: Mon, 30 Dec 2002 23:32:49 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Muli Ben-Yehuda <mulix@mulix.org>
CC: Oliver Neukum <oliver@neukum.name>, linux-kernel@vger.kernel.org
Subject: Re: question on context of kfree_skb()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mulix wrote:

>dev_kfree_skb_any() should be called when you could be either
>executing in interrupt context or not. 
>
dev_kfree_skb_any() can misdetect the context: You must not use the 
function if you hold an irq spinlock and you might be running from BH or 
process context.

cpu 1:    cpu 2:
acquire one of the networking bh lock
             acquire the driver spin_lock_irq()
hardware interrupt
try to acquire the driver irq spinlock
--> spin.
              dev_kfree_skb_any(): !in_irq(), calls kfree_skb
              kfree_skb tries to acquire the network lock that
              cpu 1 owns
              --> spin.

And deadlock.

--
    Manfred



