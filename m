Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131100AbQKIOoQ>; Thu, 9 Nov 2000 09:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131149AbQKIOoG>; Thu, 9 Nov 2000 09:44:06 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:40709 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S131100AbQKIOny>; Thu, 9 Nov 2000 09:43:54 -0500
Date: Thu, 9 Nov 2000 17:41:02 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: PCI-PCI bridges mess in 2.4.x
Message-ID: <20001109174102.B3205@jurassic.park.msu.ru>
In-Reply-To: <20001101153420.A2823@jurassic.park.msu.ru> <20001101093319.A18144@twiddle.net> <20001103111647.A8079@jurassic.park.msu.ru> <20001103011640.A20494@twiddle.net> <20001106192930.A837@jurassic.park.msu.ru> <20001108013931.A26972@twiddle.net> <20001108142513.A5244@jurassic.park.msu.ru> <20001108093744.D27324@twiddle.net> <20001109010336.A1367@jurassic.park.msu.ru> <3A09D72A.C2730D0@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A09D72A.C2730D0@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Nov 08, 2000 at 05:43:54PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2000 at 05:43:54PM -0500, Jeff Garzik wrote:
> I am still worried that the conditions which generate the following
> message indicate a problem still exists.  (this message exists w/out
> your patch..)
> Unknown bridge resource 0: assuming transparent

Well, I believe that transparent bridge must use subtractive decoding.
Specification allows such thing, but the bridge with subtractive
decoding enabled _must_ have programming interface code == 01h.
If you're curious try this patch (not for applying, just for
testing).

Ivan.

--- 2.4.0t11p1/drivers/pci/pci.c	Fri Oct 27 02:16:46 2000
+++ linux/drivers/pci/pci.c	Thu Nov  9 17:08:16 2000
@@ -574,6 +574,14 @@ void __init pci_read_bridge_bases(struct
 	if (!dev)		/* It's a host bus, nothing to read */
 		return;
 
+	if (dev->class & 1) {
+		printk("Subtractive decoding bridge %s\nAssuming transparent\n",
+					dev->name);
+		for(i=0; i<3; i++)
+			child->resource[i] = child->parent->resource[i];
+		return;
+	}
+
 	for(i=0; i<3; i++)
 		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
