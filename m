Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131168AbRAWQTj>; Tue, 23 Jan 2001 11:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131159AbRAWQT3>; Tue, 23 Jan 2001 11:19:29 -0500
Received: from smtp1.libero.it ([193.70.192.51]:39625 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S131157AbRAWQTV>;
	Tue, 23 Jan 2001 11:19:21 -0500
Date: Tue, 23 Jan 2001 19:19:54 +0100
From: antirez <antirez@invece.org>
To: linux-kernel@vger.kernel.org
Subject: ICMP spoofing protection: Is this code sane?
Message-ID: <20010123191953.O721@palla>
Reply-To: antirez@invece.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

I'm trying to implement a way to add some protection
against ICMP DF set but fragmentation required packets spoofing.
This is a netfilter hook that should implement an HMAC
based protection, but I'm not sure that my code is sane,
and before to post it to bugtraq, and crash all the boxes
of the users that will load the module, I want to learn
if it's ok.

Thanks in advance for your support.

p.s. obviously comments about the protection design used will
     help as weel.

-- 
Salvatore Sanfilippo              |                      <antirez@invece.org>
http://www.kyuzz.org/antirez      |      PGP: finger antirez@tella.alicom.com

--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="trusted-icmp.c"

/* Trusted-ICMP
 * Copyright(C) 2001 Salvatore Sanfilippo <antirez@invece.org>
 *
 * This code is under the GPL version 2 license.
 *
 * This kernel module for Linux 2.4 implements a quite sane way to
 * trust ICMP "DF set but fragmentation required" (DFSFR) packets.
 * Don't expect maximum security here since we must fight with
 * the standard IP header and the compatibility issue.
 *
 * COMMENTS:
 *
 * An attacker can spoof a DFSFR packet with the effect of a
 * fake PMTU discovery. This DoS is hard to avoid, and AFAIK
 * even IPSEC don't fix this. A way to make the attack harder to do
 * is to sign the outgoing packet IP header, that will be
 * quoted in the ICMP, and check the signature before to accept it.
 *
 * NOTE: this module improves security only against the ICMP
 *       DF set but fragmentation required spoofing, not more.
 *
 * The problem is to find some space to store the signature.
 * A way may be to store it in a new IP option. Fully standard
 * TCP/IP stacks should skip the option and accept the packet,
 * but unfortunatelly many firewalls will drop this packets anyway.
 * Another problem is that to do this we need to expand the
 * packet, and this can result in a packet bigger that the interface MTU.
 * Finally if the IP header already contains 40 bytes of options
 * there is no room for our option.
 *
 * Fortunatelly the ID field of the IP protocol isn't useful
 * when the DF bit is set in the IP header. The ID is used in fragmentation,
 * but the DF bit prevents the fragmentation. Note also that only
 * packets with the DF bit set can result in a DFSFR ICMP.
 * The problem here is that the ID field is only 16 bit. This will
 * make the attack about 2^16 times harder to do (in the middle case
 * 2^15 packets are required), it isn't so good, but better that
 * nothing, considering that all this don't break the RFC in any way
 * (read more to see how for implementation details the attacker
 * will need only 2^14 packets in the middle case to mount the attack).
 *
 * As an additional protection this module can use the TOS field
 * to reach better security. This isn't ok since it breaks the TOS
 * information, and is disabled by default.
 *
 * DETAILS
 *
 * This module performs a very simple work:
 * It generates a key using the Linux's pseudo-random built-in generator.
 * The key is refreshed after a timeout, or after a given number
 * of packets sent. For every outgoing packet with the DF bit set
 * the IP ID (and the TOS if the option is enabled) is replaced
 * with an HMAC, that uses a weaker/faster version of MD4.
 * This should not be a problem since the attacker can't collect
 * more than one signature for every IP address he own, and since
 * the key is changed in a short period. The 16-bit-only signature
 * is the real problem here.
 * 
 * When an DFSFR ICMP packet is received we check the signature,
 * and drop it if don't match. We need to check the signature against
 * the current key and the last key, since the key may be no longer
 * the same when we get the ICMP: this isn't good... since gives
 * to the attacker double chances to guess the 16-bit HMAC. Actually
 * the attacker needs only 2^14 packets in the middle case to
 * perform the attack, but I can't get better than this.
 *
 * NOTE: This patch will work better if the PMTU cache expire time
 *       is very short.
 *
 * More comments inside the code.
 *
 * DISCLAIMERS
 *
 * I tested this patch against my not-SMP linux 2.4 box for some day.
 * I feel that it is stable and works without problems but I can't ensure this.
 * USE IT AT YOUR RISK.
 */

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/socket.h>
#include <linux/ip.h>
#include <linux/tcp.h>
#include <linux/netfilter.h>
#include <linux/netfilter_ipv4.h>
#include <linux/random.h>
#include <linux/string.h>
#include <linux/param.h>
#include <linux/sched.h>
#include <linux/net.h>
#include <linux/in.h>
#include <net/ip.h>
#include <net/icmp.h>
#include <net/tcp.h>
#include <asm/atomic.h>
#include <asm/spinlock.h>

#if 0
#define TI_DEBUG printk
#else
#define TI_DEBUG(x, y...)
#endif

/* An overkill, may compensate the entropy overstimation but is here just
 * to fit the block size of the weak-MD4 hash function */
#define KEY_LEN 40 /* This means 40 *bytes* */

/* This time should be the maximum lifetime of an internet segment * 2.
 * Anyway we truncated it at 30 seconds that is quite realistic --
 * Note that this can't create big problems even if we got
 * the ICMP after more than 30 seconds.
 * The KEY_TTL_PACKETS timeout is here just to enforce our policy
 * but every attacker can collect just one-ID-for-IP-address for every 
 * different key, so should be useless */
#define KEY_TTL_TIME	30*HZ
#define KEY_TTL_PACKETS	10000

/* Do you want that the TOS field is used to store additional
 * 8 bit of the hash?
 * This makes the protection more secure but isn't ok under the
 * RFC state of view. Anyway:
 * 2^16 = 65536, this leaves the attack quite realistic.
 * 2^24 = 16777216, times more strong.
 *
 * WARNING: Set it to zero if unsure */
static int use_tos = 0;

static __u32 key[KEY_LEN/4];
static __u32 old_key[KEY_LEN/4];
static unsigned long key_timeout;
/* We use an atomic counter for the sent-packet key expire,
 * and a read/write spinlock for the two keys and the key timestamp */
static atomic_t key_sent;
static rwlock_t key_lock = RW_LOCK_UNLOCKED;

/* The output filter signs the packets, while
 * the input filter checks the signature */
struct nf_hook_ops output_filter, input_filter;

static __u32 halfMD4Transform (__u32 const buf[4], __u32 const in[8]);
static void put_sign(__u8 *dest, struct iphdr *ip, __u8 *key);
static void get_new_key(void);

static unsigned int output_handler(	unsigned int hooknum,
					struct sk_buff **skb,
					const struct net_device *in,
					const struct net_device *out,
					int (*okfn)(struct sk_buff *))
{
	struct iphdr *ip;
	__u32 hash;

	if ((*skb)->len < sizeof(struct iphdr))
		goto accept;
	ip  = (*skb)->nh.iph;

	/* Don't sign packets with DF unset, for this packets
	 * the IP ID should not be modified */
	if ((ntohs(ip->frag_off) & IP_DF) == 0)
		goto accept;

	/* Get a new key if the old one expired */
	read_lock_bh(&key_lock); /* protect key_timeout */
	if (jiffies >= key_timeout) {
		read_unlock_bh(&key_lock);
		get_new_key();
	} else {
		read_unlock_bh(&key_lock);
		if (atomic_read(&key_sent) >= KEY_TTL_PACKETS)
			get_new_key();
		atomic_inc(&key_sent);
	}

	put_sign((__u8*)&hash, ip, (__u8*)key);
	/* No endianess convertion in the following code, since
	 * the sender is the only receiver of this information. */
	ip->id = hash & 0xFFFF;
	if (use_tos)
		ip->tos = (hash >> 16) & 0xFF;

	ip_send_check(ip); /* Compute the IP checksum */

accept:
	return NF_ACCEPT;
}

static unsigned int input_handler(	unsigned int hooknum,
					struct sk_buff **skb,
					const struct net_device *in,
					const struct net_device *out,
					int (*okfn)(struct sk_buff *))
{
	struct iphdr *ip, *qip;
	struct icmphdr *icmp;
	int len;
	__u32 hash;

	ip  = (*skb)->nh.iph;
	len = (*skb)->len;
	/* IP header len sanity check */
	if (len < sizeof(struct iphdr))
		goto drop;

	/* We are interested only in ICMP */
	if (ip->protocol != IPPROTO_ICMP)
		goto accept;

	/* ICMP header len sanity check */
	if (len < ((ip->ihl * 4) + sizeof(struct icmphdr)))
		goto drop;
	icmp = (struct icmphdr*) ((void*)ip + (ip->ihl * 4));

	/* Accept all the others ICMPs */
	if (icmp->type != ICMP_DEST_UNREACH ||
	    icmp->code != ICMP_FRAG_NEEDED)
		goto accept;

	/* Jump to the quoted IP packet */
	qip = (struct iphdr*) ((void*)icmp + sizeof(struct icmphdr));
	len -= (ip->ihl * 4) + sizeof(struct icmphdr);

	/* quoted IP header len sanity check */
	if (len < sizeof(struct iphdr))
		goto drop;

	/* Check the signature:
	 * We need to check with both the new and the old key */
	put_sign((__u8*)&hash, qip, (__u8*)key);
	if (qip->id == (hash & 0xFFFF) &&
	    (!use_tos || qip->tos == ((hash >> 16) & 0xFF))) {
		TI_DEBUG("trusted-icmp: good ICMP received (new key)\n");
		goto accept;
	}

	put_sign((__u8*)&hash, qip, (__u8*)old_key);
	if (qip->id == (hash & 0xFFFF) &&
	    (!use_tos || qip->tos == ((hash >> 16) & 0xFF))) {
		TI_DEBUG("trusted-icmp: good ICMP received (old key)\n");
		goto accept;
	}

	if (net_ratelimit())
		printk("trusted-icmp: Spoofed ICMP from %d.%d.%d.%d "
			"(ref %d.%d.%d.%d -> %d.%d.%d.%d proto %d)\n",
			NIPQUAD(ip->saddr), NIPQUAD(qip->saddr),
			NIPQUAD(qip->daddr), qip->protocol);

drop:
	return NF_DROP;
accept:
	return NF_ACCEPT;
}

/* Weaker&Faster MD4 hash function -- grepped from the Linux random driver */

/* F, G and H are basic MD4 functions: selection, majority, parity */
#define F(x, y, z) ((z) ^ ((x) & ((y) ^ (z))))
#define G(x, y, z) (((x) & (y)) + (((x) ^ (y)) & (z)))
#define H(x, y, z) ((x) ^ (y) ^ (z))

/*
 * The generic round function.  The application is so specific that
 * we don't bother protecting all the arguments with parens, as is generally
 * good macro practice, in favor of extra legibility.
 * Rotation is separate from addition to prevent recomputation
 */
#define ROUND(f, a, b, c, d, x, s)	\
	(a += f(b, c, d) + x, a = (a << s) | (a >> (32-s)))
#define K1 0
#define K2 013240474631UL
#define K3 015666365641UL

/*
 * Basic cut-down MD4 transform.  Returns only 32 bits of result.
 */
static __u32 halfMD4Transform (__u32 const buf[4], __u32 const in[8])
{
	__u32	a = buf[0], b = buf[1], c = buf[2], d = buf[3];

	/* Round 1 */
	ROUND(F, a, b, c, d, in[0] + K1,  3);
	ROUND(F, d, a, b, c, in[1] + K1,  7);
	ROUND(F, c, d, a, b, in[2] + K1, 11);
	ROUND(F, b, c, d, a, in[3] + K1, 19);
	ROUND(F, a, b, c, d, in[4] + K1,  3);
	ROUND(F, d, a, b, c, in[5] + K1,  7);
	ROUND(F, c, d, a, b, in[6] + K1, 11);
	ROUND(F, b, c, d, a, in[7] + K1, 19);

	/* Round 2 */
	ROUND(G, a, b, c, d, in[1] + K2,  3);
	ROUND(G, d, a, b, c, in[3] + K2,  5);
	ROUND(G, c, d, a, b, in[5] + K2,  9);
	ROUND(G, b, c, d, a, in[7] + K2, 13);
	ROUND(G, a, b, c, d, in[0] + K2,  3);
	ROUND(G, d, a, b, c, in[2] + K2,  5);
	ROUND(G, c, d, a, b, in[4] + K2,  9);
	ROUND(G, b, c, d, a, in[6] + K2, 13);

	/* Round 3 */
	ROUND(H, a, b, c, d, in[3] + K3,  3);
	ROUND(H, d, a, b, c, in[7] + K3,  9);
	ROUND(H, c, d, a, b, in[2] + K3, 11);
	ROUND(H, b, c, d, a, in[6] + K3, 15);
	ROUND(H, a, b, c, d, in[1] + K3,  3);
	ROUND(H, d, a, b, c, in[5] + K3,  9);
	ROUND(H, c, d, a, b, in[0] + K3, 11);
	ROUND(H, b, c, d, a, in[4] + K3, 15);

	return buf[1] + b;	/* "most hashed" word */
	/* Alternative: return sum of all words? */
}

#undef ROUND
#undef F
#undef G
#undef H
#undef K1
#undef K2
#undef K3

static void put_sign(__u8 *dest, struct iphdr *ip, __u8 *key)
{
	__u32 secret[12], hash;

	secret[0] = ip->saddr;
	secret[1] = ip->daddr;
	memcpy(secret+2, key, KEY_LEN);

	read_lock_bh(&key_lock);
	hash = halfMD4Transform(secret+8, secret);
	read_unlock_bh(&key_lock);
	memcpy(dest, &hash, 4);
}

static void get_new_key(void)
{
	write_lock_bh(&key_lock);
	memcpy(old_key, key, KEY_LEN);
	get_random_bytes(key, KEY_LEN);
	key_timeout = jiffies + KEY_TTL_TIME;
	write_unlock_bh(&key_lock);

	atomic_set(&key_sent, 0);
	TI_DEBUG("trusted-icmp: new key generated\n");
}

int init_module(void)
{
	int result;

	get_new_key();
	/* At init the old and current key must be tha same */
	memcpy(old_key, key, KEY_LEN);

	output_filter.list.next = NULL;
	output_filter.list.prev = NULL;
	output_filter.hook = output_handler;
	output_filter.pf = PF_INET; /* IPv4 */
	output_filter.hooknum = NF_IP_POST_ROUTING;

	input_filter.list.next = NULL;
	input_filter.list.prev = NULL;
	input_filter.hook = input_handler;
	input_filter.pf = PF_INET; /* IPv4 */
	input_filter.hooknum = NF_IP_LOCAL_IN;

	result = nf_register_hook(&output_filter);
	if (result)
		return result;
	result = nf_register_hook(&input_filter);
	if (result) {
		nf_unregister_hook(&output_filter);
		return result;
	}

	printk(KERN_INFO "trusted-icmp: module loaded\n");
	return 0;
}

void cleanup_module(void)
{
	nf_unregister_hook(&output_filter);
	nf_unregister_hook(&input_filter);
	printk(KERN_INFO "trusted-icmp: module removed\n");
}

--7iMSBzlTiPOCCT2k--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
