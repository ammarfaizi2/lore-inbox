Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264971AbUDUGCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264971AbUDUGCj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 02:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264972AbUDUGCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 02:02:39 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:3996 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264971AbUDUGCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 02:02:34 -0400
Date: Wed, 21 Apr 2004 11:30:21 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
To: Matt Mackall <mpm@selenic.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, mingo@elte.hu,
       suparna@in.ibm.com
Subject: Re: Problem with Netpoll based netdumping and NAPI
Message-ID: <20040421060021.GB3716@in.ibm.com>
Reply-To: hari@in.ibm.com
References: <20040419125148.GA4495@in.ibm.com> <20040419174254.GQ1175@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040419174254.GQ1175@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On Mon, Apr 19, 2004 at 12:42:54PM -0500, Matt Mackall wrote:
> [changed cc: from linux-net to netdev]
> 
> On Mon, Apr 19, 2004 at 06:21:48PM +0530, Hariprasad Nellitheertha wrote:
> > Hi All,
> > 
> > I am facing a problem while trying to network dump using LKCD. My 
> > debugging so far indicates that this is due to both NAPI and NETPOLL 
> > being enabled.
> > 
> > I am using LKCD on the 2.6.5 kernel and both the client and server are 
> > i386 boxes. The dumping machine has an e100 card. I have built the kernel
> > with both CONFIG_E100_NAPI and CONFIG_NET_POLL_CONTROLLER (and the other
> > netpoll related options) selected.
> > 
> > LKCD uses netpoll for its network dump implementation. The problem we see
> > is that the network dump driver does not receive any packet from the 
> > card driver and hence dumping fails. In e100_intr(), we call 
> > netif_rx_schedule() if we are using the NAPI feature. netif_rx_schedule, 
> > in turn, ends up adding the processing of this packet to the NET_RX_SOFTIRQ 
> > softirq.
> 
> Netpoll should be manually calling the NAPI poll function like this 
> after calling the interrupt handler (in netpoll_poll()):
> 
>       /* If scheduling is stopped, tickle NAPI bits */
>          if(trapped && np->dev->poll &&
>             test_bit(__LINK_STATE_RX_SCHED, &np->dev->state))
>                  np->dev->poll(np->dev, &budget);
> 
> Please ensure that LKCD is calling netpoll_set_trap(1) which tells it
> that packet scheduling is stopped.

This was indeed the problem. We were not calling netpoll_set_trap in LKCD.
Adding this fixed the problem. Thanks so much for your help with this.

Regards, Hari

> 
> I've tested this path primarily with tg3 and kgdb-over-ethernet, but
> it should be functionally quite similar to e100 and lkcd.
> 
> -- 
> Matt Mackall : http://www.selenic.com : Linux development and consulting

-- 
Hariprasad Nellitheertha
Linux Technology Center
India Software Labs
IBM India, Bangalore
