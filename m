Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbTCKEh6>; Mon, 10 Mar 2003 23:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262814AbTCKEh6>; Mon, 10 Mar 2003 23:37:58 -0500
Received: from phobos.planet.net.au ([203.15.90.5]:18694 "HELO
	phobos.planet.net.au") by vger.kernel.org with SMTP
	id <S262812AbTCKEh4>; Mon, 10 Mar 2003 23:37:56 -0500
Date: Tue, 11 Mar 2003 15:33:37 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.2] drivers/net/net_init.c array bounds
In-Reply-To: <200303102214.h2AMEEf31534@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.05.10303111525440.5706-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

As discussed, appended patch against 2.2.24 addresses a potential array
bounds overflow of *ethdev_index[MAX_ETH_CARDS] (and similar) in
drivers/net/net_init.c

It also cleans up the declaration of i in etherdev_get_index (hopefully
only doing what the optimiser does anyway ;-).

The bit I'm cautious about are lines like:

	break;	/* have found a non-initialised slot */

I can't see why they weren't originally included - but that doesn't mean
there's some subtle but good reason for their absence (and consequent
subtle breakage by including them).  OTOH, I've been running with this
patch for many months and haven't noticed any side-effects.  And yes,
this patch is definitely broken without these lines.

FWIW, this doesn't appear to be an issue in 2.4 as things are done
differently there.

One thing this patch does NOT do is to clean up the various printk()s
which do not have a KERN_* - most of these appear to be fairly dramatic
(e.g. "this shouldn't happen" (er, "this shouldnt happen"? ;-)) so
probably should be KERN_ERR.

Thanks,
Neale.

--- linux-2.2.24-orig/drivers/net/net_init.c	Sat Nov  3 03:39:07 2001
+++ linux-2.2.24-ntb0/drivers/net/net_init.c	Tue Mar 11 11:59:51 2003
@@ -103,7 +103,12 @@
 						if (dev->priv) memset(dev->priv, 0, sizeof_priv);
 						goto found;
 					}
+				break;	/* have found a non-initialised slot */
 			}
+		if (i>=MAX_ETH_CARDS) {
+			printk(KERN_ERR "init_etherdev: FATAL - too many eth devs.\n");
+			return NULL;
+		}
 
 		alloc_size &= ~3;		/* Round to dword boundary. */
 
@@ -223,7 +228,12 @@
 						if (dev->priv) memset(dev->priv, 0, sizeof_priv);
 						goto hipfound;
 					}
+				break;	/* have found a non-initialised slot */
 			}
+		if (i>=MAX_HIP_CARDS) {
+			printk(KERN_ERR "init_hippi_dev: FATAL - too many hip devs.\n");
+			return NULL;
+		}
 
 		alloc_size &= ~3;		/* Round to dword boundary. */
 
@@ -468,8 +478,7 @@
 
 static int etherdev_get_index(struct device *dev)
 {
-	int i=MAX_ETH_CARDS;
-
+	int i;
 	for (i = 0; i < MAX_ETH_CARDS; ++i)	{
 		if (ethdev_index[i] == NULL) {
 			sprintf(dev->name, "eth%d", i);
@@ -552,7 +561,12 @@
 						if (dev->priv) memset(dev->priv, 0, sizeof_priv);
 						goto trfound;
 					}
+				break;	/* have found a non-initialised slot */
 			}
+		if (i>=MAX_TR_CARDS) {
+			printk(KERN_ERR "init_trdev: FATAL - too many tr devs.\n");
+			return NULL;
+		}
 
 		alloc_size &= ~3;		/* Round to dword boundary. */
 		dev = (struct device *)kmalloc(alloc_size, GFP_KERNEL);
@@ -711,7 +725,12 @@
                         if (dev->priv) memset(dev->priv, 0, sizeof_priv);
                         goto fcfound;
                      }
+		break;	/* have found a non-initialised slot */
                }
+		if (i>=MAX_FC_CARDS) {
+			printk(KERN_ERR "init_fcdev: FATAL - too many fc devs.\n");
+			return NULL;
+		}
 
         alloc_size &= ~3;               /* Round to dword boundary. */
         dev = (struct device *)kmalloc(alloc_size, GFP_KERNEL);


