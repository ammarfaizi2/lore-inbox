Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbULVNT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbULVNT5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 08:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbULVNT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 08:19:57 -0500
Received: from main.gmane.org ([80.91.229.2]:10626 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261985AbULVNTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 08:19:52 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed L Cashin <ecashin@coraid.com>
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.10-rc3-bk11
Date: Wed, 22 Dec 2004 08:19:50 -0500
Message-ID: <87hdme31xl.fsf@coraid.com>
References: <87k6rhc4uk.fsf@coraid.com>
	<1103356085.3369.140.camel@sfeldma-mobl.dsl-verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-34-231-146.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:6XShcQQDlsEspKXU0fB/NKZ9i+k=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Feldman <sfeldma@pobox.com> writes:

...
>> +static char aoe_iflist[IFLISTSZ];
>> +
>> +int
>> +is_aoe_netif(struct net_device *ifp)
>> +{
>> +       register char *p, *q;
>> +       register int len;
>> +
>> +       if (aoe_iflist[0] == '\0')
>> +               return 1;
>> +
>> +       for (p = aoe_iflist; *p; p = q + strspn(q, WHITESPACE)) {
>> +               q = p + strcspn(p, WHITESPACE);
>> +               if (q != p)
>> +                       len = q - p;
>> +               else
>> +                       len = strlen(p); /* last token in aoe_iflist
> */
>> +
>> +               if (strlen(ifp->name) == len && !strncmp(ifp->name, p,
> len))
>> +                       return 1;
>> +               if (q == p)
>> +                       break;
>> +       }
>> +
>> +       return 0;
>> +}
>
> This is getting called for every skb received.  Do you really want to
> walk a string array looking for "eth0" or "eth1" for every receive
> packet?  Maybe making the locals "register" helps speed things up.  :-)
>
> Seriously, can you achieve the same by registering the packet type
> handler for each dev and let netif_receive_skb() do the check for
> skb->dev == packet_type->dev?

We'd like to keep state in the driver in order to be able to control
both outgoing and incoming traffic.  I'm not sure this check will
become a performance problem, but anyone with who can measure it is
welcome to speak up.  I suspect that optimizing this now would be a
case of premature optimization.

>> + * (1) i have no idea if this is redundant, but i can't figure why
>> + * the ifp is passed in if it is.
>
> This isn't necessary - see deliver_skb()

Thanks.  That looks like the only place our packet handler is called.

>> +       skb->len += ETH_HLEN;   /* (2) */
>
> You want to do a skb_push(skb, ETH_HLEN) here instead to keep skb->len
> and skb->data corresponding (basically to undo the skb->pull() in
> eth_type_trans()).  skb->mac.raw will still be correct.

Thanks.

...
>> +       if (h->verfl & AOEFL_ERR) {
>> +               n = h->err;
>> +               if (n > NECODES)
>> +                       n = 0;
>> +               printk(KERN_CRIT "aoe: aoenet_rcv: error packet from
> %d.%d; "
>> +                       "ecode=%d '%s'\n",
>> +                      __be16_to_cpu(*((u16 *) h->major)), h->minor,
>> +                       h->err, aoe_errlist[n]);
>> +               goto exit;
>> +       }
>
> Is there a better way to handle errors than flooding the log?

These errors haven't happened much, but if they did, I'd want
everybody to know.  Would you suggest a per-device counter to limit
how many times this message gets printed?  

>> +       dev_kfree_skb(skb);
>
> kfree_skb() should be enough.

Hmm.  It's just a macro for kfree_skb, but I thought that
dev_kfree_skb is the more correct one for us to call.  I mean, if
dev_kfree_skb isn't supposed to be called here, then what's it for?

-- 
  Ed L Cashin <ecashin@coraid.com>

