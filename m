Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273023AbRIOU1l>; Sat, 15 Sep 2001 16:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273029AbRIOU1W>; Sat, 15 Sep 2001 16:27:22 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:57105 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S273018AbRIOU1R>;
	Sat, 15 Sep 2001 16:27:17 -0400
Date: Sat, 15 Sep 2001 17:26:59 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "David S.Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH][RFC] spin_trylock_bh
Message-ID: <20010915172659.A1916@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David S.Miller <davem@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Please see if this is acceptable, I noticed this while working on
the locks for NetBEUI 8) Patch is against 2.4.9, but it should apply to
latest prepatch. It was being used in the ppp code for quite some time.

                        - Arnaldo

Index: include/linux/spinlock.h
===================================================================
RCS file: /home/cvs/kernel-acme/include/linux/spinlock.h,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 spinlock.h
--- include/linux/spinlock.h	2001/08/16 21:48:34	1.1.1.2
+++ include/linux/spinlock.h	2001/09/15 20:16:44
@@ -30,6 +30,10 @@
 #define write_unlock_irqrestore(lock, flags)	do { write_unlock(lock); local_irq_restore(flags); } while (0)
 #define write_unlock_irq(lock)			do { write_unlock(lock); local_irq_enable();       } while (0)
 #define write_unlock_bh(lock)			do { write_unlock(lock); local_bh_enable();        } while (0)
+#define spin_trylock_bh(lock)			({ int __r; local_bh_disable();\
+						__r = spin_trylock(lock);      \
+						if (!__r) local_bh_enable();   \
+						__r; })
 
 #ifdef CONFIG_SMP
 #include <asm/spinlock.h>
Index: drivers/net/ppp_synctty.c
===================================================================
RCS file: /home/cvs/kernel-acme/drivers/net/ppp_synctty.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 ppp_synctty.c
--- drivers/net/ppp_synctty.c	2001/08/16 21:45:05	1.1.1.2
+++ drivers/net/ppp_synctty.c	2001/09/15 20:16:47
@@ -44,13 +44,6 @@
 #include <linux/init.h>
 #include <asm/uaccess.h>
 
-#ifndef spin_trylock_bh
-#define spin_trylock_bh(lock)	({ int __r; local_bh_disable();	\
-				   __r = spin_trylock(lock);	\
-				   if (!__r) local_bh_enable();	\
-				   __r; })
-#endif
-
 #define PPP_VERSION	"2.4.1"
 
 /* Structure for storing local state. */
Index: net/ipv6/ip6_fib.c
===================================================================
RCS file: /home/cvs/kernel-acme/net/ipv6/ip6_fib.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 ip6_fib.c
--- net/ipv6/ip6_fib.c	2001/08/16 18:44:10	1.1.1.2
+++ net/ipv6/ip6_fib.c	2001/09/15 20:16:50
@@ -1192,10 +1192,8 @@
 		spin_lock_bh(&fib6_gc_lock);
 		gc_args.timeout = (int)dummy;
 	} else {
-		local_bh_disable();
-		if (!spin_trylock(&fib6_gc_lock)) {
+		if (!spin_trylock_bh(&fib6_gc_lock)) {
 			mod_timer(&ip6_fib_timer, jiffies + HZ);
-			local_bh_enable();
 			return;
 		}
 		gc_args.timeout = ip6_rt_gc_interval;
