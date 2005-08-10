Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965126AbVHJOZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbVHJOZM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 10:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbVHJOZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 10:25:12 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:10651 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965126AbVHJOZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 10:25:11 -0400
Subject: Re: Skbuff problem - kernel BUG ???
From: Steven Rostedt <rostedt@goodmis.org>
To: Schaffer Roland <roland.schaffer@siemens.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <AE99B7B733E1BB49B019CAA0F806D7A7014BF9C8@nets13ka.ww300.siemens.net>
References: <AE99B7B733E1BB49B019CAA0F806D7A7014BF9C8@nets13ka.ww300.siemens.net>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 10 Aug 2005 10:24:48 -0400
Message-Id: <1123683888.5340.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roland,


On Wed, 2005-08-10 at 15:27 +0200, Schaffer Roland wrote:
> Hello all!
> 
> I write a kernel module (metadrv) to send a frame over the ethernet; I
> use sk_buff's to do this.
> Metadrv enslaves the NICs eth0 and eth1 and is something like the
> linux-bonding-driver.

Since you are writing your own driver, you will need to send more
information or the code of the drive itself. Since it is hard to debug
something that you can't see.

> 
> The skb I got has to be changed slightly. I want to send it out on a
> DIFFERENT NIC, thus I change the DEVICE of the skb and the MAC adresses
> of the frame.
> For test-purpose (due to not working;) I DROPPED the MAC-modification
> code temporarily: nothing changed at all!

So you wrote a driver that reads from one NIC and writes it out to the
other?

> 
> NOW WHATS GOING ON:
> The code below works a few times, but suddenly it crashes with:
> 
> kernel BUG at skbuff.c:329!

You also need to tell us which kernel version you are using, since
2.6.12.2 has skbuff.c:329 as such:

---
    325 struct sk_buff *skb_clone(struct sk_buff *skb, int gfp_mask)
    326 {
    327         struct sk_buff *n = kmem_cache_alloc(skbuff_head_cache, gfp_mask        );
    328
    329         if (!n)
    330                 return NULL;
    331
---

So I'm not seeing a bug on this kernel.


> 
> "it works a few times"  means: it does not report an error,
> dev_queue_xmit() returns 0, but the frames cannot be seen on copper by a
> sniffer running on a different host. This happen 4 or 5 times, then the
> kernel BUG appears. I am afraid that those 4 or 5 frames are NOT sent
> although claimed so by dev_queue_xmit().
> Ah: NO, there is NO firewall, NO traffic shaping and NO other
> packet/frame dumper stuff running.

It's been a little while since I had to deal with the network code, but
IIRC, the packets being received are not set up the same as packets
going out.  There may be some things that you need to look at in
dev_queue_xmit to see if things are looking good or not.

> 
> The frame carries an IP-Packet, payload: UDP-packet, ports 67 or 68
> 
> When I copy the skb using skb_copy() the kernel crashes immediately.
> When I do this with ARP-Packets skb_copy() works very well. 

Looking at skb_copy, it determines the size of the packet using
skb->end, skb->head and skb->data_len.  I'm not sure the driver updates
all these fields.  Where are you calling these functions? from the
driver?  The driver may need to touch up the skb before doing anything
else.  As the packet goes up higher in the stack, these fields may be
updated later on.

> 
> What else did I try?
> --------------------
> 1) skb_copy() -> kernel crash

skb probably not set up correctly.

> 2) making my own skb and sending it -> does not crash, dev_queue_xmit()
> claims to send but does not

Have you set up skb correctly? Look at all what dev_queue_xmit does,
right down to the wire, and see if there's something missing.

> 3) modifying the original skb -> kernel BUG happens

Where else is this skb being used, and how did you modify it? It will
get freed by the network stack code, but is it ready to do that?

> 
> If you have any idea how an skb can be sent over an other device or if
> you know what I do wrong, please let me know!!!
> 
> Technical Data:
> ---------------
> System: Linux sb1-1 2.4.20_mvlcge31-mpcbl0001_V2.0.8-omm #1 SMP Mi Aug 3
> 15:15:31 CEST 2005 i686 unknown
> Vendor/Version: MontaVista-Linux Carrier-Grade-Edition 3.1
> gcc: 3.2.3
> CPU: 2 x Xeon 1.6(HT)
> Networkdriver: e1000 (compiled into kernel)

OK, you did mention the kernel, but this is a MontaVista kernel and I
have no idea what they did to it.


-- Steve


