Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286935AbSATFGt>; Sun, 20 Jan 2002 00:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287948AbSATFGk>; Sun, 20 Jan 2002 00:06:40 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:17682 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S286935AbSATFGZ>; Sun, 20 Jan 2002 00:06:25 -0500
Date: Sun, 20 Jan 2002 16:31:39 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: linux-kernel@vger.kernel.org
cc: Hein Roehrig <hein@acm.org>, netdev@oss.sgi.com
Subject: [PATCH][2.2] drivers/net/net_init.c - bounds checking etc
Message-ID: <Pine.LNX.4.05.10201201623240.31943-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Appended patch (against 2.2.21-pre2) addresses:

(1) lack of bounds checking of statically-dimensioned arrays
such as *ethdev_index[MAX_ETH_CARDS]

(2) unnecessary initialisation if i in etherdev_get_index()

I notice also that init_etherdev() can return a NULL pointer.  In earleir
2.2 I found a few ethernet drivers which do not contemplate this
possibility.  Presumably this should be cleaned up too?

Regards,
Neale.


--- linux-2.2.21-pre2-pristine/drivers/net/net_init.c	Sat Nov  3 03:39:07 2001
+++ linux-2.2.21-pre2-ntb/drivers/net/net_init.c	Sun Jan 20 15:04:02 2002
@@ -104,6 +104,10 @@
 						goto found;
 					}
 			}
+		if (i>=MAX_ETH_CARDS) {
+			printk("init_etherdev: FATAL - too many eth devs.\n");
+			return NULL;
+		}
 
 		alloc_size &= ~3;		/* Round to dword boundary. */
 
@@ -224,6 +228,10 @@
 						goto hipfound;
 					}
 			}
+		if (i>=MAX_HIP_CARDS) {
+			printk("init_hippi_dev: FATAL - too many hip devs.\n");
+			return NULL;
+		}
 
 		alloc_size &= ~3;		/* Round to dword boundary. */
 
@@ -269,6 +277,8 @@
 			break;
 		}
 	}
+	if (i>=MAX_HIP_CARDS)
+		printk("unregister_hipdev: WARNING - didn't find dev.\n");
 	rtnl_unlock();
 }
 
@@ -468,8 +478,7 @@
 
 static int etherdev_get_index(struct device *dev)
 {
-	int i=MAX_ETH_CARDS;
-
+	int i;
 	for (i = 0; i < MAX_ETH_CARDS; ++i)	{
 		if (ethdev_index[i] == NULL) {
 			sprintf(dev->name, "eth%d", i);
@@ -490,6 +499,8 @@
 			break;
 		}
 	}
+	if (i>=MAX_ETH_CARDS)
+		printk("etherdev_put_index: WARNING - didn't find dev.\n");
 }
 
 int register_netdev(struct device *dev)
@@ -553,6 +564,10 @@
 						goto trfound;
 					}
 			}
+		if (i>=MAX_TR_CARDS) {
+			printk("init_trdev: FATAL - too many tr devs.\n");
+			return NULL;
+		}
 
 		alloc_size &= ~3;		/* Round to dword boundary. */
 		dev = (struct device *)kmalloc(alloc_size, GFP_KERNEL);
@@ -624,6 +639,8 @@
 			break;
 		}
 	}
+	if (i>=MAX_TR_CARDS)
+		printk("tr_freedev: WARNING - didn't find dev.\n");
 }
 
 int register_trdev(struct device *dev)
@@ -712,6 +729,10 @@
                         goto fcfound;
                      }
                }
+		if (i>=MAX_FC_CARDS) {
+			printk("init_fcdev: FATAL - too many fc devs.\n");
+			return NULL;
+		}
 
         alloc_size &= ~3;               /* Round to dword boundary. */
         dev = (struct device *)kmalloc(alloc_size, GFP_KERNEL);
@@ -747,6 +768,8 @@
 			break;
 		}
 	}
+	if (i>=MAX_FC_CARDS)
+		printk("fc_freedev: WARNING - didn't find dev.\n");
 }
 
 

