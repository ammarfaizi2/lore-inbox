Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261705AbSI0Oaj>; Fri, 27 Sep 2002 10:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261706AbSI0Oaj>; Fri, 27 Sep 2002 10:30:39 -0400
Received: from web13101.mail.yahoo.com ([216.136.174.146]:40581 "HELO
	web13101.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261705AbSI0Oaf>; Fri, 27 Sep 2002 10:30:35 -0400
Message-ID: <20020927143553.75880.qmail@web13101.mail.yahoo.com>
Date: Fri, 27 Sep 2002 15:35:53 +0100 (BST)
From: =?iso-8859-1?q?will=20fitzgerald?= <linux_learning@yahoo.co.uk>
Subject: what do these 9 network functions actually do?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

this message is not as long as you think so please
help!!

 i was hoping someone could explain what is it exactly
that each of these functions do.
 a general over all description will do. i'm just
trying to get my head around the kernel functionality.
 i've inserted printk's into a linux router and i'm
just testing some stuff on ip forwarding.
i have supplied the full code to the functions. i'm
using kernel 2.4.14 (old i know!!!!)

skb_bond() in dev.c
net_rx_action() calls it, it returns and then
net_rx_action calls ip_rcv() but what is skb_bond
doing?

/* Reparent skb to master device. This function is
called
 * only from net_rx_action under BR_NETPROTO_LOCK. It
is misuse
 * of BR_NETPROTO_LOCK, but it is OK for now.
 */
static __inline__ void skb_bond(struct sk_buff *skb)
{
	struct net_device *dev = skb->dev;

	if (dev->master) {
		dev_hold(dev->master);
		skb->dev = dev->master;
		dev_put(dev);
	}
}

****************************************************8
  skb_shared() in skbuff.h
  ip_rcv() calls it befoe doing a NF_HOOK to call
ip_rcv_finish() again i'm not sure of what it does.

    /**
 *	skb_shared - is the buffer shared
 *	@skb: buffer to check
 *
 *	Returns true if more than one person has a
reference to this
 *	buffer.
 */
static inline int skb_shared(struct sk_buff *skb)
{
	return (atomic_read(&skb->users) != 1);
}

******************************************************
skb_cloned() in skbuff.h
it seems to be linked to skb_shared() according to the
comments.  ip_forwad() calls  calling
rt_tos2priority() and skb_cow() and skb_cow calls
skb_cloned().
what is skb cloned used for?

/**
 *	skb_cloned - is the buffer a clone
 *	@skb: buffer to check
 *
 *	Returns true if the buffer was generated with
skb_clone() and is
 *	one of multiple shared copies of the buffer. Cloned
buffers are
 *	shared data so must not be written to under normal
circumstances.
 */

*****************************************************
static inline int skb_cloned(struct sk_buff *skb)
{
	return skb->cloned &&
atomic_read(&skb_shinfo(skb)->dataref) != 1;
}
*****************************************************
  rt_tos2priority in route.h
  does it give security priority information? even
though i don't have a firewall set on my linux router
(experimenting with networks, hobbie) , it gets called
  as i have inserted printk's to test if it gets
called.

static inline char rt_tos2priority(u8 tos)
{
	return ip_tos2prio[IPTOS_TOS(tos)>>1];
}


****************************************************
 ip_decrease_ttl() in net/ip.h
 whats the purpose of this?

  /* The function in 2.2 was invalid, producing wrong
result for
 * check=0xFEFF. It was noticed by Arthur Skawina
_year_ ago. --ANK(000625) */
static inline
int ip_decrease_ttl(struct iphdr *iph)
{
	u32 check = iph->check;
	check += __constant_htons(0x0100);
	iph->check = check + (check>=0xFFFF);
	return --iph->ttl;
}

*****************************************************
ip_send() in net/ip.h
ip_forward_finish() calls this function. what does
this line "skb->len > skb->dst->pmtu" do in order to
make the decision of calling one of two functions?

static inline int ip_send(struct sk_buff *skb)
{
	if (skb->len > skb->dst->pmtu)
		return ip_fragment(skb, ip_finish_output);
	else
		return ip_finish_output(skb);
}


*****************************************************
  neigh_resolve_output() in neighbour.c
  this calls the next two functions below. its called
from ip_finish_output2()
  does this lookup fib tables or cahces etc?

int neigh_resolve_output(struct sk_buff *skb)
{
	struct dst_entry *dst = skb->dst;
	struct neighbour *neigh;

	if (!dst || !(neigh = dst->neighbour))
		goto discard;

	__skb_pull(skb, skb->nh.raw - skb->data);

	if (neigh_event_send(neigh, skb) == 0) {
		int err;
		struct net_device *dev = neigh->dev;
		if (dev->hard_header_cache && dst->hh == NULL) {
			write_lock_bh(&neigh->lock);
			if (dst->hh == NULL)
				neigh_hh_init(neigh, dst, dst->ops->protocol);
			err = dev->hard_header(skb, dev,
ntohs(skb->protocol), neigh->ha, NULL, skb->len);
			write_unlock_bh(&neigh->lock);
		} else {
			read_lock_bh(&neigh->lock);
			err = dev->hard_header(skb, dev,
ntohs(skb->protocol), neigh->ha, NULL, skb->len);
			read_unlock_bh(&neigh->lock);
		}
		if (err >= 0)
			return neigh->ops->queue_xmit(skb);
		kfree_skb(skb);
		return -EINVAL;
	}
	return 0;

discard:
	NEIGH_PRINTK1("neigh_resolve_output: dst=%p
neigh=%p\n", dst, dst ? dst->neighbour : NULL);
	kfree_skb(skb);
	return -EINVAL;
}


***************************************************
neigh_event_send() in neighbour.h

what does this function check in order to call the
next function:   __neigh_event_send(neigh, skb)

    static inline int neigh_event_send(struct
neighbour *neigh, struct sk_buff *skb)
{
	neigh->used = jiffies;
	if
(!(neigh->nud_state&(NUD_CONNECTED|NUD_DELAY|NUD_PROBE)))
		return __neigh_event_send(neigh, skb);
	return 0;
}


******************************************************
__neigh_event_send() in neighbour.c
what exactly is going on here? after the above
function has returned its result this one gets
executed.

int __neigh_event_send(struct neighbour *neigh, struct
sk_buff *skb)
{
	write_lock_bh(&neigh->lock);
	if
(!(neigh->nud_state&(NUD_CONNECTED|NUD_DELAY|NUD_PROBE)))
{
		if (!(neigh->nud_state&(NUD_STALE|NUD_INCOMPLETE)))
{
			if (neigh->parms->mcast_probes +
neigh->parms->app_probes) {
				atomic_set(&neigh->probes,
neigh->parms->ucast_probes);
				neigh->nud_state = NUD_INCOMPLETE;
				neigh_hold(neigh);
				neigh->timer.expires = jiffies +
neigh->parms->retrans_time;
				add_timer(&neigh->timer);
				write_unlock_bh(&neigh->lock);
				neigh->ops->solicit(neigh, skb);
				atomic_inc(&neigh->probes);
				write_lock_bh(&neigh->lock);
			} else {
				neigh->nud_state = NUD_FAILED;
				write_unlock_bh(&neigh->lock);

				if (skb)
					kfree_skb(skb);
				return 1;
			}
		}
		if (neigh->nud_state == NUD_INCOMPLETE) {
			if (skb) {
				if (skb_queue_len(&neigh->arp_queue) >=
neigh->parms->queue_len) {
					struct sk_buff *buff;
					buff = neigh->arp_queue.next;
					__skb_unlink(buff, &neigh->arp_queue);
					kfree_skb(buff);
				}
				__skb_queue_tail(&neigh->arp_queue, skb);
			}
			write_unlock_bh(&neigh->lock);
			return 1;
		}
		if (neigh->nud_state == NUD_STALE) {
			NEIGH_PRINTK2("neigh %p is delayed.\n", neigh);
			neigh_hold(neigh);
			neigh->nud_state = NUD_DELAY;
			neigh->timer.expires = jiffies +
neigh->parms->delay_probe_time;
			add_timer(&neigh->timer);
		}
	}
	write_unlock_bh(&neigh->lock);
	return 0;
}


thank you for your time,
regards will.






__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
