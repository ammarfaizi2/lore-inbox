Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbSLLRqX>; Thu, 12 Dec 2002 12:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264901AbSLLRqW>; Thu, 12 Dec 2002 12:46:22 -0500
Received: from air-2.osdl.org ([65.172.181.6]:21186 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264886AbSLLRqT>;
	Thu, 12 Dec 2002 12:46:19 -0500
Subject: Re: [PATCH] Notifier for significant events on i386
From: Stephen Hemminger <shemminger@osdl.org>
To: vamsi@in.ibm.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Levon <levon@movementarian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021212130406.A20253@in.ibm.com>
References: <1039471369.1055.161.camel@dell_ss3.pdx.osdl.net>
	 <20021211165153.A17546@in.ibm.com> <20021211111639.GJ9882@holomorphy.com>
	 <20021211171337.A17600@in.ibm.com>
	 <20021211202727.GF20735@compsoc.man.ac.uk>
	 <1039641336.18587.30.camel@irongate.swansea.linux.org.uk>
	 <1039652384.1649.17.camel@dell_ss3.pdx.osdl.net>
	 <20021212130406.A20253@in.ibm.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1039715615.1649.80.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 12 Dec 2002 09:53:35 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 23:34, Vamsi Krishna S . wrote:
> On Thu, Dec 12, 2002 at 12:25:47AM +0000, Stephen Hemminger wrote:
> > 
> > This patch changes notifier to use RCU.  No interface change, just a little
> > more memory in each notifier_block. Also some formatting cleanup.
> > Please review and give comments.
> > 
> > <snip patch>
> 
> This looks good. I have a few of comments:
> 
> - add read_lock_rcu() / read_unlock_rcu() around the loop in
>   notifier_call_chain() to be preempt-safe.
> 
> - I would suggest using struct list_head in the notifier_block
>   and use the RCU list routines from include/linux/list.h
>   instead of spreading subtle RCU memory-barrier black magic.

That would be good for a new interface, but the existing code depends on
the single linked behavior. Many initializer's are pre-C99 style, and
more importantly there is no distinction between a list element and a
list head.  To work with list macros the head has to be initialized
correctly.  It is better not to worry about changing the interface and
avoid having to change all the calling code.

The only advantage to the doubly-linked list (besides std macros) is
that it is possible to unregister without knowing the head. There was a
patch several months ago to do singly-linked list macros but it looks
like it never got accepted.  If the obscurity of the macro's is desired
then maybe the way to go is creating a slist.h with RCU extensions. 


> - Even though RCU list reading is lockless, premption needs to
>   be disabled while reading as mentioned above. So, we do
>   need an __notifier_call_chain() version for those handlers
>   that could sleep inside the handler: they will have to
>   handle the required locking themselves.

The use of notifier today is limited to things that can't sleep. As far
as I can tell, it is intended for system events like reboot, panic;
where sleeping doesn't make sense.  I think that is why the original
notifier_call_chain did not grab the read_lock.

-- 
Stephen Hemminger <shemminger@osdl.org>
Open Source Devlopment Lab

