Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315595AbSGFQCV>; Sat, 6 Jul 2002 12:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315599AbSGFQCU>; Sat, 6 Jul 2002 12:02:20 -0400
Received: from antares.kiyaviakrym.com.ua ([212.109.36.226]:14260 "EHLO
	antares.kiyavia.crimea.ua") by vger.kernel.org with ESMTP
	id <S315595AbSGFQCT>; Sat, 6 Jul 2002 12:02:19 -0400
Date: Sat, 6 Jul 2002 19:04:57 +0300
From: Sergey Kononenko <sergk@kiyavia.crimea.ua>
To: linux-kernel@vger.kernel.org
Subject: kernel freeze with Digiboard PC/X driver
Message-ID: <20020706160457.GA15588@kiyavia.crimea.ua>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Hi, All.

Then I try to upgrade server (Dual PII-233), working on 2.2.20 kerel to 2.4.18.
And after loading driver for Digiboard PC/X serial multiport card (pcxx.o)
kernel imediatly freeze. I try 2.4.19-rc1 try compile this driver in 
the kernel, but it is not solve the problem. Also I noticed that dirver
freeze kernel even in UP machine _wihtout_ digiboard card, but in 2.2.x it
correctly report that device not found.
I spent some time to explore this problem, and discover, that freeze happen
in pcxe_init() while calling function pcxxdelay() in this code (pcxx.c):

        for(crd=0; crd < numcards; crd++) {
                bd = &boards[crd];
                outb(FEPRST, bd->port);
                pcxxdelay(1);

                for(i=0; (inb(bd->port) & FEPMASK) != FEPRST; i++) {

But pcxxdelay is only wrapper for mdelay:

static void pcxxdelay(int msec)
{
        mdelay(msec);
}

I simply replace all calls of pcxxdelay by mdelay in pcxx.c and this solve
the problem! After that dirver work perfectly without any freezes. I can't
explain why calling mdelay in wrapper cause the problem an why this trivial 
change fix freezing. May be this is bug in compiler optimizations, but I
compile kernel with standart gcc 2.95.3 and default optimization flags.

So I attach my patch in a hope, that somebody test it and this or more
correct patch will be included in official kernel.

P.S. Sorry for my bad English.

SergK.

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pcxx.c.patch"

--- pcxx.c.orig	2002-07-02 13:41:47.000000000 +0300
+++ pcxx.c	2002-07-02 13:42:39.000000000 +0300
@@ -153,7 +153,6 @@
 DECLARE_TASK_QUEUE(tq_pcxx);
 
 static void pcxxpoll(unsigned long dummy);
-static void pcxxdelay(int);
 static void fepcmd(struct channel *, int, int, int, int, int);
 static void pcxe_put_char(struct tty_struct *, unsigned char);
 static void pcxe_flush_chars(struct tty_struct *);
@@ -1271,7 +1270,7 @@
 	for(crd=0; crd < numcards; crd++) {
 		bd = &boards[crd];
 		outb(FEPRST, bd->port);
-		pcxxdelay(1);
+		mdelay(1);
 
 		for(i=0; (inb(bd->port) & FEPMASK) != FEPRST; i++) {
 			if(i > 100) {
@@ -1283,7 +1282,7 @@
 #ifdef MODULE
 			schedule();
 #endif
-			pcxxdelay(10);
+			mdelay(10);
 		}
 		if(bd->status == DISABLED)
 			continue;
@@ -1362,7 +1361,7 @@
 #ifdef MODULE
 			schedule();
 #endif
-			pcxxdelay(1);
+			mdelay(1);
 		}
 		if(bd->status == DISABLED)
 			continue;
@@ -1413,7 +1412,7 @@
 #ifdef MODULE
 				schedule();
 #endif
-				pcxxdelay(50);
+				mdelay(50);
 			}
 
 			printk("\nPC/Xx: BIOS download failed for board at 0x%x(addr=%lx-%lx)!\n",
@@ -1443,7 +1442,7 @@
 #ifdef MODULE
 				schedule();
 #endif
-				pcxxdelay(10);
+				mdelay(10);
 			}
 
 			printk("\nPC/Xx: BIOS download failed on the %s at 0x%x!\n",
@@ -1487,7 +1486,7 @@
 #ifdef MODULE
 			schedule();
 #endif
-			pcxxdelay(1);
+			mdelay(1);
 		}
 
 		if(bd->status == DISABLED)
@@ -1520,7 +1519,7 @@
 #ifdef MODULE
 			schedule();
 #endif
-			pcxxdelay(1);
+			mdelay(1);
 		}
 		if(bd->status == DISABLED)
 			continue;
@@ -1825,15 +1824,6 @@
 }
 
 
-/*
- * pcxxdelay - delays a specified number of milliseconds
- */
-static void pcxxdelay(int msec)
-{
-	mdelay(msec);
-}
-
-
 static void 
 fepcmd(struct channel *ch, int cmd, int word_or_byte, int byte2, int ncmds,
 						int bytecmd)

--yrj/dFKFPuw6o+aM--
