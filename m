Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317450AbSHHL1Y>; Thu, 8 Aug 2002 07:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317457AbSHHL1Y>; Thu, 8 Aug 2002 07:27:24 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:38922 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S317450AbSHHL1W>; Thu, 8 Aug 2002 07:27:22 -0400
Date: Thu, 8 Aug 2002 15:30:42 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Grant Grundler <grundler@dsl2.external.hp.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: PCI<->PCI bridges, transparent resource fix
Message-ID: <20020808153042.B14158@jurassic.park.msu.ru>
References: <20020807055456.61265482A@dsl2.external.hp.com> <20020806210220.24665@192.168.4.1> <benh@kernel.crashing.org> <20020807183025.BCB65482A@dsl2.external.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020807183025.BCB65482A@dsl2.external.hp.com>; from grundler@dsl2.external.hp.com on Wed, Aug 07, 2002 at 12:30:25PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 12:30:25PM -0600, Grant Grundler wrote:
> Send me a patch for 2.4.19 and I'll try it on the laptop.

Appended - please do.

> Ivan wrote:
> | ...subtractive decoding bridge _MUST_ have bit 0 in the ProgIf set to 1.
> 
> It sounds easy to check at the top and in that case DTRT.
> The "else" parts of later resource checks can go away.

Exactly.

> What you suggest implies the bridge waits for someone else to "claim"
> the transaction and I'm not convinced PCI spec would allow that.

It allows that as a matter of fact.

> Performance would certainly suffer if that were the case.

Sure, performance sucks, and there are other bad side effects,
like impossibility of the peer-to-peer DMA behind such bridge.

Ivan.

--- linux/drivers/pci/pci.c~	Fri Jun 28 14:46:21 2002
+++ linux/drivers/pci/pci.c	Thu Aug  8 14:57:25 2002
@@ -1073,6 +1073,14 @@ void __devinit pci_read_bridge_bases(str
 	if (!dev)		/* It's a host bus, nothing to read */
 		return;
 
+	if (dev->class & 1) {
+		printk("Subtractive decoding bridge %s -"
+			" assuming transparent\n", dev->name);
+		for(i = 0; i < 3; i++)
+			child->resource[i] = child->parent->resource[i];
+		return;
+	}
+
 	for(i=0; i<3; i++)
 		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
 
@@ -1095,13 +1103,6 @@ void __devinit pci_read_bridge_bases(str
 		res->start = base;
 		res->end = limit + 0xfff;
 		res->name = child->name;
-	} else {
-		/*
-		 * Ugh. We don't know enough about this bridge. Just assume
-		 * that it's entirely transparent.
-		 */
-		printk(KERN_ERR "Unknown bridge resource %d: assuming transparent\n", 0);
-		child->resource[0] = child->parent->resource[0];
 	}
 
 	res = child->resource[1];
@@ -1114,10 +1115,6 @@ void __devinit pci_read_bridge_bases(str
 		res->start = base;
 		res->end = limit + 0xfffff;
 		res->name = child->name;
-	} else {
-		/* See comment above. Same thing */
-		printk(KERN_ERR "Unknown bridge resource %d: assuming transparent\n", 1);
-		child->resource[1] = child->parent->resource[1];
 	}
 
 	res = child->resource[2];
@@ -1145,10 +1142,6 @@ void __devinit pci_read_bridge_bases(str
 		res->start = base;
 		res->end = limit + 0xfffff;
 		res->name = child->name;
-	} else {
-		/* See comments above */
-		printk(KERN_ERR "Unknown bridge resource %d: assuming transparent\n", 2);
-		child->resource[2] = child->parent->resource[2];
 	}
 }
 
