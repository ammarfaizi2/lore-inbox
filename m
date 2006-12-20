Return-Path: <linux-kernel-owner+w=401wt.eu-S965150AbWLTRFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbWLTRFO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 12:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbWLTRFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 12:05:13 -0500
Received: from waste.org ([66.93.16.53]:44492 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965150AbWLTRFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 12:05:12 -0500
X-Greylist: delayed 881 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 12:05:11 EST
Date: Wed, 20 Dec 2006 10:40:46 -0600
From: Matt Mackall <mpm@selenic.com>
To: Keiichi KII <k-keiichi@bx.jp.nec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.19 2/6] support multiple logging agents
Message-ID: <20061220164046.GW13687@waste.org>
References: <457E498C.1050806@bx.jp.nec.com> <457E4C65.6030802@bx.jp.nec.com> <20061212184250.GJ13687@waste.org> <458903ED.9040207@bx.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458903ED.9040207@bx.jp.nec.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 06:35:41PM +0900, Keiichi KII wrote:
> >>  static struct netpoll np = {
> >> >      .name = "netconsole",
> >> >      .dev_name = "eth0",
> >> > @@ -69,23 +84,91 @@ static struct netpoll np = {
> >> >      .drop = netpoll_queue,
> >> >  };
> >
> > Shouldn't this piece get dropped in this patch?
> >
> 
> This piece isn't in -mm tree, but this piece is in 2.6.19.
> Which version should I follow ?

-mm, probably.

> >> -static int configured = 0;
> >> +static int add_netcon_dev(const char* target_opt)
> >> +{
> >> +    static atomic_t netcon_dev_count = ATOMIC_INIT(0);
> >
> > Hiding this inside a function seems wrong. Why do we need a count? If
> > we've already got a spinlock, why does it need to be atomic?
> >
> 
> We don't have a spinlock for add_netcon_dev, because we don't need
> to get a spinlock for add_netcon_dev except for list operation.
> So, it must be atomic.

Or you can just increment the list counter inside the lock.

> 
> >>      local_irq_save(flags);
> >> +    spin_lock(&netconsole_dev_list_lock);
> >>      for(left = len; left; ) {
> >>          frag = min(left, MAX_PRINT_CHUNK);
> >> -        netpoll_send_udp(&np, msg, frag);
> >> +        list_for_each_entry(dev, &active_netconsole_dev, list) {
> >> +            spin_lock(&dev->netpoll_lock);
> >> +            netpoll_send_udp(&dev->np, msg, frag);
> >> +            spin_unlock(&dev->netpoll_lock);
> >
> > Why do we need a lock here? Why isn't the list lock sufficient? What
> > happens if either lock is held when we get here?
> >
> 
> The netpoll_lock is for each structure containing information related to 
> netpoll
> (remote IP address and port, local IP address and port and so on).
> If we don't take a spinlock for each structure, the target IP address and 
> port
> number are subject to change on the way sending packets.

Why can't you simply define the list lock as protecting all the
structures on the list?

-- 
Mathematics is the supreme nostalgia of our time.
