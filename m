Return-Path: <linux-kernel-owner+w=401wt.eu-S964966AbWLTJkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWLTJkP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 04:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbWLTJkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 04:40:15 -0500
Received: from TYO200.gate.nec.co.jp ([210.143.35.50]:49006 "EHLO
	tyo200.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964966AbWLTJkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 04:40:13 -0500
Message-ID: <458903ED.9040207@bx.jp.nec.com>
Date: Wed, 20 Dec 2006 18:35:41 +0900
From: Keiichi KII <k-keiichi@bx.jp.nec.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.19 2/6] support multiple logging agents
References: <457E498C.1050806@bx.jp.nec.com> <457E4C65.6030802@bx.jp.nec.com> <20061212184250.GJ13687@waste.org>
In-Reply-To: <20061212184250.GJ13687@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >>  static struct netpoll np = {
 >> >      .name = "netconsole",
 >> >      .dev_name = "eth0",
 >> > @@ -69,23 +84,91 @@ static struct netpoll np = {
 >> >      .drop = netpoll_queue,
 >> >  };
 >
 > Shouldn't this piece get dropped in this patch?
 >

This piece isn't in -mm tree, but this piece is in 2.6.19.
Which version should I follow ?

 >> -static int configured = 0;
 >> +static int add_netcon_dev(const char* target_opt)
 >> +{
 >> +    static atomic_t netcon_dev_count = ATOMIC_INIT(0);
 >
 > Hiding this inside a function seems wrong. Why do we need a count? If
 > we've already got a spinlock, why does it need to be atomic?
 >

We don't have a spinlock for add_netcon_dev, because we don't need
to get a spinlock for add_netcon_dev except for list operation.
So, it must be atomic.

 >>      local_irq_save(flags);
 >> +    spin_lock(&netconsole_dev_list_lock);
 >>      for(left = len; left; ) {
 >>          frag = min(left, MAX_PRINT_CHUNK);
 >> -        netpoll_send_udp(&np, msg, frag);
 >> +        list_for_each_entry(dev, &active_netconsole_dev, list) {
 >> +            spin_lock(&dev->netpoll_lock);
 >> +            netpoll_send_udp(&dev->np, msg, frag);
 >> +            spin_unlock(&dev->netpoll_lock);
 >
 > Why do we need a lock here? Why isn't the list lock sufficient? What
 > happens if either lock is held when we get here?
 >

The netpoll_lock is for each structure containing information related to netpoll
(remote IP address and port, local IP address and port and so on).
If we don't take a spinlock for each structure, the target IP address and port
number are subject to change on the way sending packets.

-- 
Keiichi KII
NEC Corporation OSS Promotion Center
E-mail: k-keiichi@bx.jp.nec.com
