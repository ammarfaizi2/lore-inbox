Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266010AbSL3W7j>; Mon, 30 Dec 2002 17:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266959AbSL3W7i>; Mon, 30 Dec 2002 17:59:38 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:38160 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id <S266010AbSL3W7h>;
	Mon, 30 Dec 2002 17:59:37 -0500
Date: Tue, 31 Dec 2002 00:07:56 +0100
From: romieu@fr.zoreil.com
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.53 : net/atm/lec.c
Message-ID: <20021231000756.A17128@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.44.0212282007210.952-100000@linux-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0212282007210.952-100000@linux-dev>; from fdavis@si.rr.com on Sat, Dec 28, 2002 at 08:17:19PM -0500
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Frank Davis <fdavis@si.rr.com> :
[locking in net/atm/lec.c]

net/atm/lec.c::lec_arp_destroy()
-> spin_lock_irqsave(&lec_lock, flags);         
-> lec_arp_remove(priv->lec_arp_tables, entry);  
   -> spin_lock_irqsave(&lec_lock, flags); 
      -> good bye Charlie !

Both lec_arp_check_expire() (timer function) and lec_arp_destroy() are
walking the lec_arp_table from the 'lec_priv' they were attached to and if
the intent of lec_arp_{lock/unlock} is to protect the timer function
lec_arp_check_expire() by virtue of refcounting, it seems slightly racy.
If you are wondering who the callers of lec_arp_remove() are:
lec_arp_remove
<- lec_atm_send
   <- lecdev_ops.send = lec_atm_send
<- lec_arp_destroy
   <- lec_atm_close
      <- lecdev_ops.close = lec_atm_close
<- lec_arp_check_expire
   <- priv->lec_arp_timer.function = lec_arp_check_expire;
<- lec_addr_delete
   <- lec_atm_send
<- lec_vcc_close
   <- lec_push
      <- vcc->push = lec_push;
<- lec_arp_check_empties
   <- lec_push

Removing the lock from lec_arp_remove() and asking callers to do themselves
the locking (liek lec_arp_destroy) doesn't seem too unsane.

Btw, del_timer_sync() in lec_arp_destroy() shouldn't hurt imho.

--
Ueimor
