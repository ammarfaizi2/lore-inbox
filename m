Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285783AbSAUNIn>; Mon, 21 Jan 2002 08:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285850AbSAUNIe>; Mon, 21 Jan 2002 08:08:34 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:59962 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S285783AbSAUNIZ>; Mon, 21 Jan 2002 08:08:25 -0500
Date: Tue, 22 Jan 2002 00:33:50 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: linux-kernel@vger.kernel.org
cc: Hein Roehrig <hein@acm.org>, netdev@oss.sgi.com
Subject: Re: [PATCH][2.2] drivers/net/net_init.c - bounds checking etc
In-Reply-To: <Pine.LNX.4.05.10201201623240.31943-100000@marina.lowendale.com.au>
Message-ID: <Pine.LNX.4.05.10201220029140.8853-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jan 2002, Neale Banks wrote:

> Greetings,
> 
> Appended patch (against 2.2.21-pre2) addresses:
> 
> (1) lack of bounds checking of statically-dimensioned arrays
> such as *ethdev_index[MAX_ETH_CARDS]
> 
> (2) unnecessary initialisation if i in etherdev_get_index()

<sigh>Corrected and tested patch appended.

> I notice also that init_etherdev() can return a NULL pointer.  In earleir
> 2.2 I found a few ethernet drivers which do not contemplate this
> possibility.  Presumably this should be cleaned up too?

Separate patch for eepro100 to follow.

Regards,
Neale.

--- linux-2.2.21-pre2-pristine/drivers/net/net_init.c	Sat Nov  3 03:39:07 2001
+++ linux-2.2.21-pre2-ntb/drivers/net/net_init.c	Mon Jan 21 22:53:42 2002
@@ -103,7 +103,12 @@
 						if (dev->priv) memset(dev->priv, 0, sizeof_priv);
 						goto found;
 					}
+				break;	/* have found a non-initialised slot */
 			}
+		if (i>=MAX_ETH_CARDS) {
+			printk("init_etherdev: FATAL - too many eth devs.\n");
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
+			printk("init_hippi_dev: FATAL - too many hip devs.\n");
+			return NULL;
+		}
 
 		alloc_size &= ~3;		/* Round to dword boundary. */
 
@@ -269,6 +279,8 @@
 			break;
 		}
 	}
+	if (i>=MAX_HIP_CARDS)
+		printk("unregister_hipdev: WARNING - didn't find dev.\n");
 	rtnl_unlock();
 }
 
@@ -468,8 +480,7 @@
 
 static int etherdev_get_index(struct device *dev)
 {
-	int i=MAX_ETH_CARDS;
-
+	int i;
 	for (i = 0; i < MAX_ETH_CARDS; ++i)	{
 		if (ethdev_index[i] == NULL) {
 			sprintf(dev->name, "eth%d", i);
@@ -490,6 +501,8 @@
 			break;
 		}
 	}
+	if (i>=MAX_ETH_CARDS)
+		printk("etherdev_put_index: WARNING - didn't find dev.\n");
 }
 
 int register_netdev(struct device *dev)
@@ -552,7 +565,12 @@
 						if (dev->priv) memset(dev->priv, 0, sizeof_priv);
 						goto trfound;
 					}
+				break;	/* have found a non-initialised slot */
 			}
+		if (i>=MAX_TR_CARDS) {
+			printk("init_trdev: FATAL - too many tr devs.\n");
+			return NULL;
+		}
 
 		alloc_size &= ~3;		/* Round to dword boundary. */
 		dev = (struct device *)kmalloc(alloc_size, GFP_KERNEL);
@@ -624,6 +642,8 @@
 			break;
 		}
 	}
+	if (i>=MAX_TR_CARDS)
+		printk("tr_freedev: WARNING - didn't find dev.\n");
 }
 
 int register_trdev(struct device *dev)
@@ -711,7 +731,12 @@
                         if (dev->priv) memset(dev->priv, 0, sizeof_priv);
                         goto fcfound;
                      }
+		break;	/* have found a non-initialised slot */
                }
+		if (i>=MAX_FC_CARDS) {
+			printk("init_fcdev: FATAL - too many fc devs.\n");
+			return NULL;
+		}
 
         alloc_size &= ~3;               /* Round to dword boundary. */
         dev = (struct device *)kmalloc(alloc_size, GFP_KERNEL);
@@ -747,6 +772,8 @@
 			break;
 		}
 	}
+	if (i>=MAX_FC_CARDS)
+		printk("fc_freedev: WARNING - didn't find dev.\n");
 }
 
 

