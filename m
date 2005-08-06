Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVHFHoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVHFHoe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 03:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVHFHoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 03:44:34 -0400
Received: from mx2.elte.hu ([157.181.151.9]:19664 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262019AbVHFHoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 03:44:32 -0400
Date: Sat, 6 Aug 2005 09:45:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Matt Mackall <mpm@selenic.com>, Steven Rostedt <rostedt@goodmis.org>,
       Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, John B?ckstrand <sandos@home.se>,
       davem@davemloft.net
Subject: Re: [PATCH] netpoll can lock up on low memory.
Message-ID: <20050806074503.GA5914@elte.hu>
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel> <p73ek987gjw.fsf@bragg.suse.de> <1123249743.18332.16.camel@localhost.localdomain> <20050805135551.GQ8266@wotan.suse.de> <1123251013.18332.28.camel@localhost.localdomain> <20050805141426.GU8266@wotan.suse.de> <1123252591.18332.45.camel@localhost.localdomain> <20050805200156.GF7425@waste.org> <20050805212610.GA8266@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805212610.GA8266@wotan.suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> On Fri, Aug 05, 2005 at 01:01:57PM -0700, Matt Mackall wrote:
> > The netpoll philosophy is to assume that its traffic is an absolute
> > priority - it is better to potentially hang trying to deliver a panic
> > message than to give up and crash silently.
> 
> That would be ok if netpoll was only used to deliver panics. But it is 
> not. It delivers all messages, and you cannot hang the kernel during 
> that. Actually even for panics it is wrong, because often it is more 
> important to reboot in a panic than (with a panic timeout) to actually 
> deliver the panic. That's needed e.g. in a failover cluster.

without going into the merits of this discussion, reliable failover 
clusters must include (and do include) an external ability to cut power.  
No amount of in-kernel logic will prevent the kernel from hanging, given 
a bad enough kernel bug.

So the right question is not 'can we prevent the kernel from hanging, 
ever' (we cannot), but 'which change makes it less likely for the kernel 
to hang'. (and, obviously: assuming all other kernel components are 
functioning per specification, netpoll itself most not hang :-)

even a plain printk to VGA can hang in certain kernel crashes. Netpoll 
is more complex and thus has more exposure to hangs. E.g. netpoll relies 
on the network driver to correctly recycle skbs within a bound amount of 
time. If the network driver leaks skbs, it's game over for netpoll.

[ i'd prefer a hang over nondeterministic behavior, and e.g. losing 
  console messages is sure nondeterministic behavior. What if the 
  console message is "WARNING: the box has just been broken into"? ]

we could do one thing (see the patch below): i think it would be useful 
to fill up the netlogging skb queue straight at initialization time.  
Especially if netpoll is used for dumping alone, the system might not be 
in a situation to fill up the queue at the point of crash, so better be 
a bit more prepared and keep the pipeline filled.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- net/core/netpoll.c.orig
+++ net/core/netpoll.c
@@ -720,6 +720,8 @@ int netpoll_setup(struct netpoll *np)
 	}
 	/* last thing to do is link it to the net device structure */
 	ndev->npinfo = npinfo;
+	/* fill up the skb queue */
+	refill_skbs();
 
 	return 0;
 
