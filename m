Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265874AbTL3Rno (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 12:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265879AbTL3Rno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 12:43:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63923 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265874AbTL3Rnl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 12:43:41 -0500
Message-ID: <3FF1B939.1090108@pobox.com>
Date: Tue, 30 Dec 2003 12:43:21 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       Netdev <netdev@oss.sgi.com>
Subject: Re: Problem with dev_kfree_skb_any() in 2.6.0
References: <1072567054.4112.14.camel@gaston>	<20031227170755.4990419b.davem@redhat.com>	<3FF0FA6A.8000904@pobox.com>	<20031229205157.4c631f28.davem@redhat.com>	<20031230051519.GA6916@gtf.org>	<20031229220122.30078657.davem@redhat.com>	<3FF11745.4060705@pobox.com> <20031229221345.31c8c763.davem@redhat.com>
In-Reply-To: <20031229221345.31c8c763.davem@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------080408000905000004060405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080408000905000004060405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David S. Miller wrote:
> On Tue, 30 Dec 2003 01:12:21 -0500
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> 
>>Think about the name of this function:  dev_kfree_skb_any()
>>
>>If this function cannot be used -anywhere-, then the concept (and the 
>>net stack) is fundamentally broken for this function.  We must _remove_ 
>>the function, and thus _I_ have a lot of driver work to do.
> 
> 
> If it makes you happy, change the suffix of the name, I am
> not emotionally attached to the name.


It's not about the name itself.  _Think_ about the name:  what is the 
purpose of the function?  what does it imply?  How have kernel hackers 
used it in practice?  I think you're focusing too closely on 
implementation, rather than purpose.

I humbly request that we expend some brain CPU cycles to think about the 
API here.

To review:
* The base requirement is that __kfree_skb shall not call the skb's 
destructor in hard IRQ context.
* To that end, dev_kfree_skb_irq was created to queue skb's for 
__kfree_skb'ing, when that requirement is not immediately satisfied.
* dev_kfree_skb_any was created for situations that either don't know, 
or don't care, about the context in which skb's are freed.  The function 
name and implementation are less relevant than _purpose_.

As it stands now, dev_kfree_skb_any() does not serve the purpose for 
which it is used in many drivers (not just the short list found in this 
thread).

Luckily, I feel there is an easy solution, as shown in the attached 
patch.  We _already_ queue skbs in dev_kfree_skb_irq().  Therefore, 
dev_kfree_skb_any() can simply use precisely that same solution.  The 
raise-softirq code will immediately proceed to action if we are not in 
hard IRQ context, otherwise it will follow the expected path.

As an aside (tangent warning), we will need to consider further 
queueing, if we are to follow the rest of the kernel:  skb destructor 
should really be in purely task context, i.e. make sure __kfree_skb does 
its work in kernel thread context.  But that's a discussion for another 
day ;-)

	Jeff


--------------080408000905000004060405
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== include/linux/netdevice.h 1.66 vs edited =====
--- 1.66/include/linux/netdevice.h	Sat Nov  1 17:11:04 2003
+++ edited/include/linux/netdevice.h	Tue Dec 30 12:29:40 2003
@@ -634,10 +634,7 @@
  */
 static inline void dev_kfree_skb_any(struct sk_buff *skb)
 {
-	if (in_irq())
-		dev_kfree_skb_irq(skb);
-	else
-		dev_kfree_skb(skb);
+	dev_kfree_skb_irq(skb);
 }
 
 #define HAVE_NETIF_RX 1

--------------080408000905000004060405--

