Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261395AbREMKyQ>; Sun, 13 May 2001 06:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261396AbREMKyG>; Sun, 13 May 2001 06:54:06 -0400
Received: from ns.suse.de ([213.95.15.193]:58890 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S261395AbREMKxz>;
	Sun, 13 May 2001 06:53:55 -0400
Date: Sun, 13 May 2001 12:53:29 +0200
From: Andi Kleen <ak@suse.de>
To: Oleg Makarenko <omakarenko@cyberplat.ru>
Cc: linux-kernel@vger.kernel.org, ipv4@mail.ru,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: netif_wake_queue wrong was Re: [PATCH] NFS Server performance and 8139too
Message-ID: <20010513125329.B10250@gruyere.muc.suse.de>
In-Reply-To: <3AFE3870.3BB1B69@cyberplat.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AFE3870.3BB1B69@cyberplat.ru>; from omakarenko@cyberplat.ru on Sun, May 13, 2001 at 11:32:00AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2001 at 11:32:00AM +0400, Oleg Makarenko wrote:
> Beware that I am not a kernel hacker so the patch can be completely 
> wrong. But I hope it still can provide some useful information to 
> somebody  who really knows what is going on here :)

The problem is that the netif_wake_queue() 2.4 compatibility macro that
was recently added to 2.2 was wrong. It should do a mark_bh(). 8139too
uses the 2.4 macros, and therefore the netbh was always scheduled for too
late and performance was bad.

This patch should fix all drivers that use the new framework.


--- linux/include/linux/kcomp.h	Tue Dec 19 17:57:30 2000
+++ linux-work/include/linux/kcomp.h	Sun May 13 13:01:11 2001
@@ -17,7 +17,7 @@
 
 #define	net_device			device
 #define dev_kfree_skb_irq(a)		dev_kfree_skb(a)
-#define netif_wake_queue(dev)		clear_bit(0, &dev->tbusy)
+#define netif_wake_queue(dev)		do { clear_bit(0, &dev->tbusy); mark_bh(NET_BH); } while(0)
 #define netif_stop_queue(dev)		set_bit(0, &dev->tbusy)
 #define netif_start_queue(dev)		do { dev->tbusy = 0; dev->interrupt = 0; dev->start = 1; } while (0)
 #define netif_queue_stopped(dev)	dev->tbusy



-Andi
