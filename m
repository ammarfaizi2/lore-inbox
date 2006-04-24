Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWDXOWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWDXOWY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 10:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWDXOWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 10:22:24 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:960 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S1750781AbWDXOWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 10:22:22 -0400
Date: Mon, 24 Apr 2006 16:22:14 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
X-X-Sender: simlo@lifa03.phys.au.dk
To: Jan Kiszka <jan.kiszka@googlemail.com>
cc: Esben Nielsen <simlo@phys.au.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@davemloft.net>
Subject: Re: Van Jacobson's net channels and real-time
In-Reply-To: <58d0dbf10604210153r208504d4r4a7f4139e711ff7f@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0604212332110.30761-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2006, Jan Kiszka wrote:

> 2006/4/20, Esben Nielsen <simlo@phys.au.dk>:
>> Before I start, where is VJ's code? I have not been able to find it anywhere.
>>
>> With the preempt-realtime branch maturing and finding it's way into the
>> mainline kernel, using Linux (without sub-kernels) for real-time applications
>> is becomming an realistic option without having to do a lot of hacks in the
>> kernel on your own.
>
> Well, commenting on this statement would likely create a thread of its own...

We have had that last year I think...

>
>> But the network stack could be improved and some of the
>> ideas in Van Jacobson's net channels could be usefull when receiving network
>> packages with real-time latencies.
>
> ... so it's better to focus on a fruitful discussion on these
> interesting ideas which may lay the ground for a future coexistence of
> both hard-RT and throughput optimised networking stacks in the
> mainline kernel. I'm slightly sceptical, but maybe I'll be proven
> wrong.

Scaling over many CPUs and RT share some common techniques. The two goals
are not the same but they are not completely opposit, nor orthorgonal
goals, but rather like two arrows pointing in the same general direction.

>
> My following remarks are biased toward hart-RT. What may appear
> problematic in this context could be a non-issue for scenarios where
> the overall throughput counts, not individual packet latencies.
>
>>
>> Finding the end point in the receive interrupt and send of the packet to
>> the receiving process directly is a good idea if it is fast enough to do
>> so in the interrupt context (and I think it can be done very fast). One
>
> This heavily depends on the protocol to parse. Single-packet messages
> based on TCP, UDP, or whatever, are yet easy to demux: some table for
> the frame type, some for the IP protocol, and another for the port (or
> an overall hash for a single table) -> here's the receiver.
>
> But now think of fragmented IP packets. The first piece can be
> assigned normally, but the succeeding fragments require a dynamically
> added detection in that critical demux path (IP fragments are
> identified by src+dest IP, protocol, and an arbitrary ID). Each
> pending chain of fragments for a netchannel would create yet another
> demux rule. But I'm also curious to see the code used for this by Van
> Jacobson.

Turn off fragmentation :-) Web servers often do that (giving a lot of
trouble to pppoe users). IPv6 is also defined without fragmentation at
this level, right?
A good first solution would be to send framented IP through the usual IP
stack.


>
> BTW, that's the issue we also face in RTnet when handling UDP/IP under
> hart-RT constraints. We avoid unbounded demux complexity by setting a
> hard limit on the number of open chains. If you want to have a look at
> the code: www.rtnet.org

I am only on the net about 30 min every 2nd day. I write mails offline and
send them later - that is why I am so late at answering.

>
>> problem in the current setup, is that everything has to go through the
>> soft interrupt.  That is even if you make a completely new, non-IP
>> protocol, the latency for delivering the frame to your application is
>> still limited by the latency of the IP-stack because it still have to go
>> through soft irq which might be busy working on IP packages. Even if you
>> open a raw socket, the latency is limited to the latency of the soft irq.
>> At work we use a widely used commercial RTOS. It got exactly the same
>> problem of having every network packet being handled by the same thread.
>
> The question of _where_ to do that demultiplexing is actually not that
> critical as _how_ to do it - and with which complexity. For hard-RT,
> it should to be O(1) or, if not feasible, O(n), where n is only
> influenced by the RT applications and their traffic footprints, but
> not by an unknown set of non-RT applications and communication links.
> [Even with O(1) demux, the pure numbers of incoming non-RT packets can
> still cause QoS crosstalk - a different issue.]

Yep, ofcourse. But not obviouse to people in not familiar with
deterministic RT. I assume that you mean the same by "hard RT" as I mean
by "deterministic RT". Old discussions on lkml has shown that there is a
lot of disagreement about what is meant :-)

>
>>
>> Buffer management is another issue. On the RTOS above you make a buffer pool
>> per network device for receiving packages. On Linux received packages are taken
>> from the global memory pool with GFP_ATOMIC. On both systems you can easily run
>> out of buffers if they are not freed back to the pool fast enough. In that
>> case you will just have to drop packages as they are received. Without
>> having the code to VJ's net channels, it looks like they solve the problem:
>> Each end receiver provides his own receive resources. If a receiver can't cope
>> with  all the traffic, it will loose packages, the others wont. That makes it
>> safe to run important real-time traffic along with some unpredictable, low
>> priority  TCP/IP traffic. If the TCP/IP receivers does not run fast enough,
>> their packages will be dropped, but the driver will not drop the real-time
>> packages. The nice thing about a real-time task is that you know it's latency
>> and therefore know how many receive buffers it needs to avoid loosing
>> packages in a worst case scenario.
>
> Yep, this is a core feature for RT networking. And this is essentially
> the way we handle it in RTnet for quite some time: "Here is a filled
> buffer for you. Give me an empty one from your pool, and it will be
> yours. If you can't, I'll drop it!" The existing concept works quite
> well for single consumers. But it's still a tricky thing when
> considering multiple consumers sharing a physical buffer. RTnet
> doesn't handle this so far (except for packet capturing). I have some
> rough ideas for a generic solution in my mind, but RTnet users didn't
> ask for this so far loudly, thus no further effort was spent on it.
>

Exchanging skbs instead of simply handing over skbs is ofcourse a good
idea, but it will slow down the stack slightly.  VJ _might_ have made
stuff more effective.

> Actually the pre-allocation issue is not only limited to skb-based
> networking. It's one reason why we have separate RT Firewire and RT USB
> projects. The restrictions and modifications they require make them
> unhandy for standard use but perfectly fitting for deterministic
> applications.
>
>
> Ok, to sum up what I see as the core topics for the first steps: we
> need A) a mechanism to use pre-allocated buffers for certain
> communication links and B) a smart early-demux algorithm of manageable
> complexity which decides what receiver has to be accounted for an
> incoming packet.
>
> The former is widely a question of restructuring the existing code,
> but the latter is still unclear to me. Let me sketch my first idea:
>
> struct pattern {
>        unsigned long offset;
>        unsigned long mask;
>        unsigned long value; /* buffer[offset] & mask == value? */
> }
>
> struct rule {
>        struct list_head rules;
>        int pattern_count;
>        struct pattern pattern[MAX_PATTERNS_PER_RULE];
>        struct netchannel *destination;
> }
>
> For each incoming packet, the NIC or a demux thread would then walk
> its list of rules, apply all patterns, and push the packet into the
> channel on match. Kind of generic and protocol-agnostic, but will
> surely not scale very well, specifically when allowing rules for
> fragmented messages popping up. An optimisation might be to use
> hard-coded pattern checks for the well-known protocols (UDP, TCP, IP
> fragment, etc.). But maybe I'm just overseeing THE simple solution of
> the problem now, am I?
>

I came up with a simple, quite general idea - but not general enough
to include fragmentation. See below.

> Once we had those two core features in the kernel, it would start
> making sense to think about how to manage other modifications to NIC
> drivers, protocols, and APIs gracefully that are required or desirable
> for hard-RT networking.
>
> Looking forward to further discussions!
>
You will have it :-)

> Jan
>

Here is a simple filter idea. The kernel have to put a maximum
filter length to make the filtering deterministic.

filter.h:
----------------------------------------------------------------------
/*
 * Copyright (c) 2006 Esben Nielsen
 *
 * Distributeable under GPL
 *
 * Released under the terms of the GNU GPL v2.0.
 */

#ifndef FILTER_H
#define FILTER_H

enum rx_action_type
{
	LOOK_AT_BYTE,
	GIVE_TO_CHANNEL
};

struct rx_action
{
	int usage;
	enum rx_action_type type;
	union
	{
		struct {
			unsigned long offset;
			struct rx_action *actions[256];
			struct rx_action *not_that_long;
		} look_at_byte;
		struct {
			struct netchannel *channel;
			struct rx_action *cont;
		} give_to_channel;
	} args;
};

#endif
------------------------------------------------------------------------

filter.c:
-----------------------------------------------------------------------
/*
 * Copyright (c) 2006 Esben Nielsen
 *
 * Distributeable under GPL
 *
 * Released under the terms of the GNU GPL v2.0.
 */

#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <errno.h>

#include "filter.h"

void do_rx_actions(struct rx_action *act, const unsigned char *data,
		unsigned long int length)
{
 start:
	switch(act->type)
	{
	case LOOK_AT_BYTE:
		if(act->args.look_at_byte.offset >= length)
			act = act->args.look_at_byte.not_that_long;
		else
			act = act->args.look_at_byte.actions
				[data[act->args.look_at_byte.offset]];

		goto start;
	case GIVE_TO_CHANNEL:
		netchannel_receive(act->args.give_to_channel.channel, data, length);
		act = act->args.give_to_channel.cont;
		if(act)
			goto start;
		break;
	default:
		BUG_ON(1);

	}
}



extern struct netchannel * const default_netchannel;

struct rx_action default_action;

struct rx_action *get_action(struct rx_action *act)
{
	act->usage++;
	return act;
}

struct rx_action *alloc_rx_action(enum rx_action_type type)
{
	struct rx_action *res = malloc(sizeof(struct rx_action));
	if(res) {
		int i;
		res->usage = 1;
		res->type = type;

		switch(type)
		{
		case LOOK_AT_BYTE:
			for(i=0;i<256;i++)
				res->args.look_at_byte.actions[i] =
					get_action(&default_action);

			res->args.look_at_byte.not_that_long =
				get_action(&default_action);
			break;
		case GIVE_TO_CHANNEL:
			res->args.give_to_channel.channel =
				default_netchannel;
			res->args.give_to_channel.cont = NULL;
			break;
		default:
			BUG_ON(1);
		}
	}

	return res;
}


void free_rx_action(struct rx_action **a_ref)
{
	int i;
	struct rx_action *a = *a_ref;
	*a_ref = NULL;

	if(!a)
		return;

	a->usage--;
	if(a->usage)
		return;

	switch(a->type)
	{
	case LOOK_AT_BYTE:
		for(i=0; i<256;i++)
			free_rx_action(&a->args.look_at_byte.actions[i]);
		free_rx_action(&a->args.look_at_byte.not_that_long);
		break;
	case GIVE_TO_CHANNEL:
		free_rx_action(&a->args.give_to_channel.cont);;
		break;
	default:
		BUG_ON(1);

	}
	free(a);
}

struct rx_action *make_look_at_byte(unsigned long offset, unsigned char val,
				    struct rx_action *todo)
{
	struct rx_action *act;
	if(!todo)
		return NULL;


	act = alloc_rx_action(LOOK_AT_BYTE);
	if( !act) {
		free_rx_action(&todo);
		return NULL;
	}

	act->args.look_at_byte.offset = offset;
	free_rx_action(&act->args.look_at_byte.actions[val]);
	act->args.look_at_byte.actions[val] = todo;

	return act;

}
struct rx_action *ethernet_to_ip(struct rx_action *todo)
{
	return make_look_at_byte( 12, 0x08, make_look_at_byte( 13, 0, todo) );
}

struct rx_action *ethernet_to_udp(struct rx_action *todo)
{
	return ethernet_to_ip(make_look_at_byte( 23, 17 /* IPPROTO_UDP */,
						 todo));
}


struct rx_action *ethernet_to_udp_port(struct rx_action *todo, uint16_t port)
{
	return ethernet_to_udp
		(make_look_at_byte( 36, port>>8,
				    make_look_at_byte(37,port & 0xFF,todo)));
}

struct rx_action *merge_rx_actions(struct rx_action *act1,
				   struct rx_action *act2);

struct rx_action *merge_give_to_channel(struct rx_action *give,
					struct rx_action *other)
{
	int was_not_zero;
	struct rx_action *res =
		alloc_rx_action(GIVE_TO_CHANNEL);
	if(!res)
		return NULL;

	BUG_ON(give->type!=GIVE_TO_CHANNEL);

	res->args.give_to_channel.channel =
		give->args.give_to_channel.channel;
	was_not_zero = (res->args.give_to_channel.cont != NULL);
	res->args.give_to_channel.cont =
		merge_rx_actions(give->args.give_to_channel.cont, other);

	if( was_not_zero && !res->args.give_to_channel.cont ) {
		free_rx_action(&res);
		return NULL;
	}
	return res;
}


struct rx_action *merge_rx_actions(struct rx_action *act1,
				   struct rx_action *act2)
{

	if( !act1 || act1 == &default_action)
		return act2 ? get_action(act2) : NULL;

	if( !act2 || act2 == &default_action)
		return get_action(act1);

	switch(act1->type)
	{
	case LOOK_AT_BYTE:
		switch(act2->type)
		{
		case LOOK_AT_BYTE:
			if( act1->args.look_at_byte.offset ==
			    act2->args.look_at_byte.offset ) {
				int i;
				struct rx_action *res =
					alloc_rx_action(LOOK_AT_BYTE);
				if(!res)
					return NULL;

				res->args.look_at_byte.offset =
					act1->args.look_at_byte.offset;

				for(i=0; i<256; i++) {
					free_rx_action(&res->args.look_at_byte.
						       actions[i]);
					res->args.look_at_byte.actions[i] =
						merge_rx_actions
						( act1->args.look_at_byte.actions[i],
						  act2->args.look_at_byte.actions[i]);
					if(!res->args.look_at_byte.actions[i]) {
						free_rx_action(&res);
						return NULL;
					}
				}
				res->args.look_at_byte.not_that_long =
					merge_rx_actions
					( act1->args.look_at_byte.not_that_long,
					  act2->args.look_at_byte.not_that_long);
				if(!res->args.look_at_byte.not_that_long) {
					free_rx_action(&res);
					return NULL;
				}

				return res;
			}
			if( act2->args.look_at_byte.offset <
			    act1->args.look_at_byte.offset ) {
				struct rx_action *tmp;
				tmp = act1;
				act1 = act2;
				act2 = tmp;
			}

			if( act1->args.look_at_byte.offset <
			    act2->args.look_at_byte.offset ) {
int i;
				struct rx_action *res =
					alloc_rx_action(LOOK_AT_BYTE);
				if(!res)
					return NULL;

				res->args.look_at_byte.offset =
					act1->args.look_at_byte.offset;

				for(i=0; i<256; i++) {
					free_rx_action(&res->args.look_at_byte.
						       actions[i]);
					res->args.look_at_byte.actions[i] =
						merge_rx_actions(act1->args.look_at_byte.actions[i],act2);
					if(!res->args.look_at_byte.actions[i]) {
						free_rx_action(&res);
						return NULL;
					}
				}

				res->args.look_at_byte.not_that_long =
					merge_rx_actions(act1->args.look_at_byte.not_that_long, act2);
				if(!res->args.look_at_byte.not_that_long) {
					free_rx_action(&res);
					return NULL;
				}
				return res;
			}
			else
				BUG_ON(1);
		case GIVE_TO_CHANNEL:
			return merge_give_to_channel(act2,act1);
		}
		BUG_ON(1);
		break;
	case GIVE_TO_CHANNEL:
		return merge_give_to_channel(act1,act2);
	}
	BUG_ON(1);
	return NULL;
}

void init_rx_actions()
{
	default_action.usage = 1;
	default_action.type = GIVE_TO_CHANNEL;
	default_action.args.give_to_channel.channel =
		default_netchannel;
	default_action.args.give_to_channel.cont = NULL;
}

struct netdevice {
	struct rx_action *action;
	struct mutex *change_action_lock;
};

int add_action_to_device(struct netdevice *dev, struct rx_action *act)
{
	struct rx_action *new, *old;

	mutex_lock(&dev->change_action_lock);
	new = merge_rx_actions(dev->action, act);
	if(!new) {
		mutex_unlock(&dev->change_action_lock);
		return -ENOMEM;
	}
	old = dev->action;
	dev->action = new;
	mutex_unlock(&dev->change_action_lock);
	syncronize_rcu();
	free_rx_action(&old);
	return 0;
}


