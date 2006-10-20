Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423237AbWJTVmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423237AbWJTVmR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992755AbWJTVmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:42:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3972 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992753AbWJTVmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:42:14 -0400
Date: Fri, 20 Oct 2006 14:41:53 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] netpoll: rework skb transmit queue
Message-ID: <20061020144153.2bbeaf9d@dxpl.pdx.osdl.net>
In-Reply-To: <200610202316.03940.ak@suse.de>
References: <20061020.134209.85688168.davem@davemloft.net>
	<200610202301.29859.ak@suse.de>
	<20061020.140859.95896187.davem@davemloft.net>
	<200610202316.03940.ak@suse.de>
X-Mailer: Sylpheed-Claws 2.5.3 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 23:16:03 +0200
Andi Kleen <ak@suse.de> wrote:

> On Friday 20 October 2006 23:08, David Miller wrote:
> > From: Andi Kleen <ak@suse.de>
> > Date: Fri, 20 Oct 2006 23:01:29 +0200
> > 
> > > netpoll always played a little fast'n'lose with various locking rules.
> > 
> > The current code is fine, it never reenters ->poll, because it
> > maintains a "->poll_owner" which it checks in netpoll_send_skb()
> > before trying to call back into ->poll.
> 
> I was more thinking of reentry of the interrupt handler in 
> the driver etc. A lot of them also do printk, but that is fortunately
> caught higher level.
> 
> -Andi

One problem is that with netconsole the NAPI poll routine can be
called with IRQ's disabled. This means that calls to dev_kfree_skb()
are incorrect in this context. The driver would have to use dev_kfree_skb_any()
instead.
