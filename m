Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318791AbSHGSUr>; Wed, 7 Aug 2002 14:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318793AbSHGSUn>; Wed, 7 Aug 2002 14:20:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30469 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318791AbSHGSTi>;
	Wed, 7 Aug 2002 14:19:38 -0400
Date: Wed, 7 Aug 2002 19:23:14 +0100
From: Matthew Wilcox <willy@debian.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "David S. Miller" <davem@redhat.com>, george@mvista.com, willy@debian.org,
       kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: softirq parameters
Message-ID: <20020807192314.H24631@parcelfarce.linux.theplanet.co.uk>
References: <20020804172650.N24631@parcelfarce.linux.theplanet.co.uk> <3D4D668F.3A29DD10@mvista.com> <20020804.223746.89817190.davem@redhat.com> <20020807152423.3577a5cc.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020807152423.3577a5cc.rusty@rustcorp.com.au>; from rusty@rustcorp.com.au on Wed, Aug 07, 2002 at 03:24:23PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 03:24:23PM +1000, Rusty Russell wrote:
> Partially agree.  Removing all args might be worthwhile.  But all these
> softirqs use the "cpu" arg to access per-cpu data, which should be
> changed to use the per_cpu_data mechanism anyway, which removes the
> point of the arg.

I see.  That makes a lot of sense.

> Things haven't been changed over because I haven't pushed the per-cpu
> interface changes (required for some archs 8() to Linus yet.  But you'll
> want them so we can save space (you only need allocate per-cpu data for
> cpus where cpu_possible(i) is true).

So what we want is something more like:

struct softnet_data softnet_data __per_cpu_data = { NULL };

static void void net_tx_action(void *arg)
{
	struct softnet_data *data = arg;
	if (arg->completion_queue) {
	...
}

	open_softirq(NET_TX_SOFTIRQ, net_tx_action, softnet_data);

and have kernel/softirq.c do:

                do {
                        if (pending & 1)
                                h->action(this_cpu(h->data));
                        h++;
                        pending >>= 1;
                } while (pending);

right?

-- 
Revolutions do not require corporate support.
