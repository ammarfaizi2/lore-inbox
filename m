Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263178AbTC1Whe>; Fri, 28 Mar 2003 17:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263179AbTC1Whe>; Fri, 28 Mar 2003 17:37:34 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:31494 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S263178AbTC1Whc>;
	Fri, 28 Mar 2003 17:37:32 -0500
Date: Fri, 28 Mar 2003 23:48:43 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Cc: jgarzik@pobox.com, aeb@cwi.nl
Subject: Re: NICs trading places ?
Message-ID: <20030328224843.GA11980@win.tue.nl>
References: <20030328221037.GB25846@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030328221037.GB25846@suse.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 28, 2003 at 10:10:37PM +0000, Dave Jones wrote:

> I just upgraded a box with 2 NICs in it to 2.5.66, and found
> that what was eth0 in 2.4 is now eth1, and vice versa.
> Is this phenomenon intentional ? documented ?
> What caused it to do this ?
> 
> The box in question has a DEC Tulip and a 3com 3c905,
> but I imagine this would affect any system with >1 NIC
> of different vendors/drivers ?

Intentional? No.
Documented? I suppose you can find complaints from others
mentioning the same thing.
Cause? eth discovery order is not well-defined.

Once or twice I have submitted patches to rectify.
They help for a while and then someone breaks things again.
I am not quite sure, apologies in case I misremember, but
maybe the most recent breakage was caused by Marc Zyngier
with EISA bus changes.

Google turns up
http://www.uwsg.iu.edu/hypermail/linux/kernel/0301.2/1139.html

Let me add the patch referred to there. Maybe Jeff likes it this time.

 Andries


diff -u --recursive --new-file -X /linux/dontdiff a/drivers/net/3c59x.c b/drivers/net/3c59x.c
--- a/drivers/net/3c59x.c	Sat Jan 18 23:54:39 2003
+++ b/drivers/net/3c59x.c	Tue Jan 21 18:36:25 2003
@@ -1439,8 +1439,14 @@
  		acpi_set_WOL(dev);
 	}
 	retval = register_netdev(dev);
-	if (retval == 0)
+	if (retval == 0) {
+		int i;
+		printk("%s: 3c59x, address", dev->name);
+		for (i = 0; i < 6; i++)
+			printk("%c%2.2x", i ? ':' : ' ', dev->dev_addr[i]);
+		printk("\n");
 		return 0;
+	}
 
 free_ring:
 	pci_free_consistent(pdev,


