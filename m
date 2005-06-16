Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVFPWHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVFPWHZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 18:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVFPWHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 18:07:25 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:36300 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261822AbVFPWHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 18:07:06 -0400
Date: Thu, 16 Jun 2005 15:07:26 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: junjie cai <junjiec@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, shemminger@osdl.org
Subject: Re: is synchronize_net in inet_register_protosw necessary?
Message-ID: <20050616220726.GA1862@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <ca992f11050614071857cd069b@mail.gmail.com> <20050616171502.GA1321@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050616171502.GA1321@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2005 at 10:15:02AM -0700, Paul E. McKenney wrote:
> On Tue, Jun 14, 2005 at 11:18:08PM +0900, junjie cai wrote:
> > hi all.
> > i am a newbie to linux kernel.
> > in a arm926 board i found that it took about 30ms to finish
> > the (net/ipv4/af_inet.c:898) inet_register_protosw
> > because of the synchronize_net call during profiling.
> > synchronize_net finally calls synchronize_rcu, so i think
> > this is to make the change visiable after a list_add_rcu.
> > but according to the Document/listRCU.txt it seems that
> > a list insertation does not necessarily do call_rcu etc.
> > may i have any mistakes, please kindly tell me.
> 
> From a strict RCU viewpoint, you are quite correct.  But sometimes
> the overall locking protocol (which almost always includes other things
> besides just RCU) places additional constraints on the code.  My guess is
> that the networking folks needed to ensure that the new protocol is seen
> by all packets that are received after inet_register_protosw() returns.
> 
> But I need to defer to networking guys on this one.

Hello, Junjie,

Ran into one of the networking guys off-list.  Apparently, the
synchronize_net() is there out of paranoia.  It might be necessary,
but he could not think of a reason for its being there.  If you want
to shave 30ms off of your boot time by removing it, here is his
suggested test procedure:

o	Write a small dummy protocol as a module.

o	On an SMP machine, have one process repeated modprobe/rmmod
	while another process repeatedly does socket() calls for
	the dummy protocol.

							Thanx, Paul
