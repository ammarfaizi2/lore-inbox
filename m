Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261379AbTC0VVv>; Thu, 27 Mar 2003 16:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261377AbTC0VVu>; Thu, 27 Mar 2003 16:21:50 -0500
Received: from pizda.ninka.net ([216.101.162.242]:16103 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261378AbTC0VVs>;
	Thu, 27 Mar 2003 16:21:48 -0500
Date: Thu, 27 Mar 2003 13:29:54 -0800 (PST)
Message-Id: <20030327.132954.96279785.davem@redhat.com>
To: torvalds@transmeta.com
Cc: dane@aiinet.com, shmulik.hen@intel.com,
       bonding-devel@lists.sourceforge.net,
       bonding-announce@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       mingo@redhat.com, kuznet@ms2.inr.ac.ru
Subject: Re: BUG or not? GFP_KERNEL with interrupts disabled.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030327.125507.104718048.davem@redhat.com>
References: <Pine.LNX.4.44.0303271120230.31459-100000@home.transmeta.com>
	<20030327.113933.123322481.davem@redhat.com>
	<20030327.125507.104718048.davem@redhat.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "David S. Miller" <davem@redhat.com>
   Date: Thu, 27 Mar 2003 12:55:07 -0800 (PST)

Alexey has pointed out a bug in my changes.

   @@ -1088,6 +1086,9 @@ void smp_percpu_timer_interrupt(struct p
    				     : /* no outputs */
    				     : "r" (pstate));
    	} while (time_after_eq(tick, compare));
   +
   +	local_irq_enable();
   +	irq_exit();
    }
    
    static void __init smp_setup_percpu_timer(void)

Of course this is bogus.

The IRQ enable needs to occur in the irq_exit() branch right
before do_softirq() is invoked.
