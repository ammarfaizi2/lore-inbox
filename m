Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262773AbVAKAqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262773AbVAKAqo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 19:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbVAKAmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 19:42:51 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:23516 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262541AbVAKAjL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 19:39:11 -0500
Date: Mon, 10 Jan 2005 16:39:08 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [UPDATE PATCH] net/sb1000: replace nicedelay() with ssleep()
Message-ID: <20050111003908.GJ9186@us.ibm.com>
References: <20050110164703.GD14307@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110164703.GD14307@nd47.coderock.org>
X-Operating-System: Linux 2.6.10 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 05:47:03PM +0100, Domen Puncer wrote:
> Patchset of 171 patches is at http://coderock.org/kj/2.6.10-bk13-kj/
> 
> Quick patch summary: about 30 new, 30 merged, 30 dropped.
> Seems like most external trees are merged in -linus, so i'll start
> (re)sending old patches.

<snip>

> msleep_interruptible-drivers_net_sb1000.patch

Please consider replacing with the following:

Description: Use ssleep() instead of nicedelay()
to guarantee the task delays as expected. Remove the prototype and
definition of nicedelay(). This is a very weird function, because it is
called to sleep in terms of usecs, but always sleeps for 1 second,
completely ignoring the parameter. I have gone ahead and followed suit,
just sleeping for a second in all cases, but maybe someone with the
hardware could tell me if perhaps the paramter *should* matter. Additionally,
nicedelay() is called in TASK_INTERRUPTIBLE state, but doesn't deal with signals
in case these longer delays do not complete, so I believe ssleep() is more
appropriate.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.10-v/drivers/net/sb1000.c	2004-12-24 13:33:51.000000000 -0800
+++ 2.6.10/drivers/net/sb1000.c	2005-01-05 14:23:05.000000000 -0800
@@ -90,7 +90,6 @@ static int sb1000_close(struct net_devic
 
 
 /* SB1000 hardware routines to be used during open/configuration phases */
-static inline void nicedelay(unsigned long usecs);
 static inline int card_wait_for_busy_clear(const int ioaddr[],
 	const char* name);
 static inline int card_wait_for_ready(const int ioaddr[], const char* name,
@@ -254,13 +253,6 @@ static struct pnp_driver sb1000_driver =
 
 const int TimeOutJiffies = (875 * HZ) / 100;
 
-static inline void nicedelay(unsigned long usecs)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(HZ);
-	return;
-}
-
 /* Card Wait For Busy Clear (cannot be used during an interrupt) */
 static inline int
 card_wait_for_busy_clear(const int ioaddr[], const char* name)
@@ -475,7 +467,7 @@ sb1000_reset(const int ioaddr[], const c
 	udelay(1000);
 	outb(0x0, port);
 	inb(port);
-	nicedelay(60000);
+	ssleep(1);
 	outb(0x4, port);
 	inb(port);
 	udelay(1000);
@@ -537,7 +529,7 @@ sb1000_activate(const int ioaddr[], cons
 	const unsigned char Command0[6] = {0x80, 0x11, 0x00, 0x00, 0x00, 0x00};
 	const unsigned char Command1[6] = {0x80, 0x16, 0x00, 0x00, 0x00, 0x00};
 
-	nicedelay(50000);
+	ssleep(1);
 	if ((status = card_send_command(ioaddr, name, Command0, st)))
 		return status;
 	if ((status = card_send_command(ioaddr, name, Command1, st)))
@@ -944,7 +936,7 @@ sb1000_open(struct net_device *dev)
 	/* initialize sb1000 */
 	if ((status = sb1000_reset(ioaddr, name)))
 		return status;
-	nicedelay(200000);
+	ssleep(1);
 	if ((status = sb1000_check_CRC(ioaddr, name)))
 		return status;
 
