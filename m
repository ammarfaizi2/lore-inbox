Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbTJHLkF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 07:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbTJHLkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 07:40:05 -0400
Received: from gate.corvil.net ([213.94.219.177]:1803 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S261360AbTJHLkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 07:40:01 -0400
Message-ID: <3F83F62D.5090805@draigBrady.com>
Date: Wed, 08 Oct 2003 12:34:05 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marko Rauhamaa <marko@pacujo.net>
CC: linux-kernel@vger.kernel.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Jamal Hadi Salim <hadi@cyberus.ca>,
       Robert Olsson <Robert.Olsson@data.slu.se>
Subject: Re: NAPI Race?
References: <m3smm4qvf0.fsf@lumo.pacujo.net>
In-Reply-To: <m3smm4qvf0.fsf@lumo.pacujo.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marko Rauhamaa wrote:
> It looks to me like net_rx_action() might suffer from a race, which in
> turn might explain some weirdness in my driver test results.
> 
> Here's the essence of the function from net/core/dev.c:
> 
> net_rx_action()
> {
>         local_irq_disable();
>         while (!list_empty(&queue->poll_list)) {
>                 local_irq_enable();
>                 /* do stuff */
>                 local_irq_disable();
>         }
>         local_irq_enable();
> }
> 
> Say I receive a packet. net_rx_action() processes it in the while loop
> and reenables interrupts. But just before net_rx_action() returns, I
> receive another packet, and __netif_rx_schedule() gets called from the
> driver. Then the soft irq is raised from within itself. If I'm not
> interrupted for some other reason, the packet will get processed only at
> the next jiffie when the soft irq is invoked again.
> 
> Am I mistaken?

Probably not, as I tested the reception timing
accuracy against an independent hardware "packet
timestamper", and out of 2 million packets,
3 were delayed by up to 5ms on the linux box
(e100 NAPI). There were about 10 packets delayed
between 1ms and 5ms.

Pádraig.

