Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262848AbULRHrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbULRHrE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 02:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbULRHrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 02:47:03 -0500
Received: from orb.pobox.com ([207.8.226.5]:50576 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262853AbULRHph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 02:45:37 -0500
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.10-rc3-bk11
From: Scott Feldman <sfeldma@pobox.com>
Reply-To: sfeldma@pobox.com
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
In-Reply-To: <87k6rhc4uk.fsf@coraid.com>
References: <87k6rhc4uk.fsf@coraid.com>
Content-Type: text/plain
Message-Id: <1103356085.3369.140.camel@sfeldma-mobl.dsl-verizon.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 17 Dec 2004 23:48:05 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-17 at 07:38, Ed L Cashin wrote:

> +       ETH_P_AOE = 0x88a2,

include/linux/if_ether.h already defines this as ETH_P_EDP2=0x88A2; use
that.

> +static int
> +aoehdr_atainit(struct aoedev *d, struct aoe_hdr *h)
> +{
> +       u16 type = __constant_cpu_to_be16(ETH_P_AOE);
                                                                                How about __constant_htons()?
                                                                                > +aoecmd_cfg(ushort aoemajor, unsigned char aoeminor)
> +{
> +       struct aoe_hdr *h;
> +       struct aoe_cfghdr *ch;
> +       struct sk_buff *skb, *sl;
> +       struct net_device *ifp;
> +       u16 aoe_type = __constant_cpu_to_be16(ETH_P_AOE);

Ditto

> +enum {
> +       IFLISTSZ = 1024,
> +};
> +
> +static char aoe_iflist[IFLISTSZ];
> +
> +int
> +is_aoe_netif(struct net_device *ifp)
> +{
> +       register char *p, *q;
> +       register int len;
> +
> +       if (aoe_iflist[0] == '\0')
> +               return 1;
> +
> +       for (p = aoe_iflist; *p; p = q + strspn(q, WHITESPACE)) {
> +               q = p + strcspn(p, WHITESPACE);
> +               if (q != p)
> +                       len = q - p;
> +               else
> +                       len = strlen(p); /* last token in aoe_iflist
*/
> +
> +               if (strlen(ifp->name) == len && !strncmp(ifp->name, p,
len))
> +                       return 1;
> +               if (q == p)
> +                       break;
> +       }
> +
> +       return 0;
> +}

This is getting called for every skb received.  Do you really want to
walk a string array looking for "eth0" or "eth1" for every receive
packet?  Maybe making the locals "register" helps speed things up.  :-)

Seriously, can you achieve the same by registering the packet type
handler for each dev and let netif_receive_skb() do the check for
skb->dev == packet_type->dev?

> +skb_check(struct sk_buff *skb)
> +{
> +       if (skb_is_nonlinear(skb))
> +       if ((skb = skb_share_check(skb, GFP_ATOMIC)))
> +       if (skb_linearize(skb, GFP_ATOMIC) < 0) {
> +               dev_kfree_skb(skb);
> +               return NULL;
> +       }

indentation of if's

> + * (1) i have no idea if this is redundant, but i can't figure why
> + * the ifp is passed in if it is.

This isn't necessary - see deliver_skb()

> +       skb->len += ETH_HLEN;   /* (2) */

You want to do a skb_push(skb, ETH_HLEN) here instead to keep skb->len
and skb->data corresponding (basically to undo the skb->pull() in
eth_type_trans()).  skb->mac.raw will still be correct.

> +       n = __be32_to_cpu(*((u32 *) h->tag));

Use ntohl() variant since this is network header field.

> +       if (h->verfl & AOEFL_ERR) {
> +               n = h->err;
> +               if (n > NECODES)
> +                       n = 0;
> +               printk(KERN_CRIT "aoe: aoenet_rcv: error packet from
%d.%d; "
> +                       "ecode=%d '%s'\n",
> +                      __be16_to_cpu(*((u16 *) h->major)), h->minor,
> +                       h->err, aoe_errlist[n]);
> +               goto exit;
> +       }

Is there a better way to handle errors than flooding the log?

> +       dev_kfree_skb(skb);

kfree_skb() should be enough.

-scott

