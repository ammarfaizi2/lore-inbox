Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310150AbSCAXBO>; Fri, 1 Mar 2002 18:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310151AbSCAXBE>; Fri, 1 Mar 2002 18:01:04 -0500
Received: from ns.suse.de ([213.95.15.193]:4101 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310150AbSCAXA6>;
	Fri, 1 Mar 2002 18:00:58 -0500
To: Julian Anastasov <ja@ssi.bg>
Cc: linux-kernel@vger.kernel.org, kain@kain.org
Subject: Re: OOPS: Multipath routing 2.4.17
In-Reply-To: <Pine.LNX.4.44.0203012316120.1420-100000@u.domain.uli.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 02 Mar 2002 00:00:56 +0100
In-Reply-To: Julian Anastasov's message of "1 Mar 2002 23:30:20 +0100"
Message-ID: <p73pu2nki53.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I wrote:

>In theory yes, but the
>
>#if 1
>		if (power <= 0) {
>			printk(KERN_CRIT "impossible 777\n");
>			return;
>		}
>#endif
>
>should stop it; making it just not work, but not crash.
>If he still gets a division by zero then something else is fishy.

Ignore the objection. The division is using fi->fib_power not power,
so it is definitely racy and possible. Sorry for the brain fart.

Short term fix would be just to add a spinlock like this (untested).
I think using a new algorithm would be too risky at least for 2.4.

--- linux-work/net/ipv4/fib_semantics.c-FIBLOCK	Tue Jan 15 11:05:17 2002
+++ linux-work/net/ipv4/fib_semantics.c	Fri Mar  1 23:58:45 2002
@@ -35,6 +35,7 @@
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
 #include <linux/init.h>
+#include <linux/spinlock.h>
 
 #include <net/ip.h>
 #include <net/protocol.h>
@@ -45,6 +46,8 @@
 
 #define FSprintk(a...)
 
+static spinlock_t fib_nh_lock = SPIN_LOCK_UNLOCKED; 
+
 static struct fib_info 	*fib_info_list;
 static rwlock_t fib_info_lock = RW_LOCK_UNLOCKED;
 int fib_info_cnt;
@@ -859,6 +862,8 @@
 	if (force)
 		scope = -1;
 
+	spin_lock_bh(&fib_nh_lock); 
+
 	for_fib_info() {
 		if (local && fi->fib_prefsrc == local) {
 			fi->fib_flags |= RTNH_F_DEAD;
@@ -885,6 +890,7 @@
 			}
 		}
 	} endfor_fib_info();
+	spin_unlock_bh(&fib_nh_lock); 
 	return ret;
 }
 
@@ -902,6 +908,7 @@
 	if (!(dev->flags&IFF_UP))
 		return 0;
 
+	spin_lock_bh(&fib_nh_lock); 
 	for_fib_info() {
 		int alive = 0;
 
@@ -924,6 +931,7 @@
 			ret++;
 		}
 	} endfor_fib_info();
+	spin_unlock_bh(&fib_nh_lock); 
 	return ret;
 }
 
@@ -937,6 +945,7 @@
 	struct fib_info *fi = res->fi;
 	int w;
 
+	spin_lock_bh(&fib_nh_lock);
 	if (fi->fib_power <= 0) {
 		int power = 0;
 		change_nexthops(fi) {
@@ -949,6 +958,7 @@
 #if 1
 		if (power <= 0) {
 			printk(KERN_CRIT "impossible 777\n");
+			spin_unlock_bh(&fib_nh_lock);
 			return;
 		}
 #endif
@@ -967,10 +977,13 @@
 				nh->nh_power--;
 				fi->fib_power--;
 				res->nh_sel = nhsel;
+				spin_unlock_bh(&fib_nh_lock);
 				return;
 			}
 		}
 	} endfor_nexthops(fi);
+
+	spin_unlock_bh(&fib_nh_lock); 
 
 #if 1
 	printk(KERN_CRIT "impossible 888\n");



-Andi
