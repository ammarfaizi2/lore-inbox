Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267738AbUG3QwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267738AbUG3QwW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 12:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267743AbUG3QwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 12:52:22 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:26346 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S267738AbUG3Qu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 12:50:27 -0400
Message-ID: <410A7CBF.2020708@colorfullife.com>
Date: Fri, 30 Jul 2004 18:52:15 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Gigabit Ethernet support for forcedeth
References: <20040730100421.GB8175@redhat.com> <410A4A1C.4040608@colorfullife.com> <20040730162023.GD8175@redhat.com>
In-Reply-To: <20040730162023.GD8175@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:

>>Which phy is used by your board? Could you enable dprintk (near line 
>>115) and reload the driver?
>>    
>>
>
>I've enabled dprintk and captured *.debug syslog output from a normal
>boot.  Here is the result:
>
>http://cyberelk.net/tim/tmp/forcedeth-debug
>
>  
>
The log is very odd - why are there two lines with

> forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.28.

Did you rmmod/insmod the driver twice?


Could you manually insmod the driver, wait for two seconds and then call 
ifup? The new driver
- resets the phy during _probe. The result is no link for a few seconds, 
until autonegotiation has completed.
- check if there is a link during _open(). If there is a link, it's 
used. If there is no link, then it relies on the link irq to detect it.

I frequently see the "no link" messages during ifup, but on my system 
the driver recovers as soon as the autonegotiation is completed. Perhaps 
I must add a link handling timer that polls for link changes.

If a delay before ifup is not enough: manually call nv_link_irq even if 
NVREG_IRQ_LINK is not set. If this is not enough: comment out the 
NVREG_MIISTAT_LINKCHANGE test in nv_link_irq.

--
    Manfred
--
    Manfred
