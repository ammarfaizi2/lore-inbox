Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267038AbSKWPFW>; Sat, 23 Nov 2002 10:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267039AbSKWPFW>; Sat, 23 Nov 2002 10:05:22 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:36526 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267038AbSKWPFV>; Sat, 23 Nov 2002 10:05:21 -0500
Date: Sat, 23 Nov 2002 09:12:21 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: Hard Lockup with 2.4.20-rc3 and ISDN (ippp)
In-Reply-To: <20021123123322.3e6ef7c2.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.44.0211230908590.23257-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Nov 2002, Stephan von Krawczynski wrote:

> On Fri, 22 Nov 2002 15:21:28 -0200 (BRST)
> Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
> 
> > 
> > Hi,
> > 
> > Finally, here goes -rc3.
> > [...]
> > Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
> >   o ISDN: Fix error path in isdn_ppp.c
> 
> Something must be wrong with this one, I experience an immediate hard lockup
> when trying to use a ippp-connection. No way around it, always happens. And no
> panic message or anything, just complete immediate lockup. This is with hisax +
> AVM Fritz PCI 2.0 + SMP + SuSE 8.1 distro installation.
> Anybody else with the same problem?
> rc2 works for _some_ connections (after a while I have to reload the drivers to
> work again). All 20pre version work without any problem at all.

Yup, my bad. Could you confirm that the attached patch which I sent to 
Marcelo already fixes it?

Also, please send me the details (privately) about the occasional driver 
going defunct, let's try to figure that one out.

--Kai


-----------------------------------------------------------------------------
ChangeSet@1.795.1.2, 2002-11-22 15:24:43-06:00, kai@tp1.ruhr-uni-bochum.de
  ISDN: Fix the fix
  
  Argh, I must have been asleep or something. The original patch by Herbert
  Xu was right, I extended it to cover more error paths and broke it in 
  doing so. Now fixed again.

  
---------------------------------------------------------------------------

diff -Nru a/drivers/isdn/isdn_ppp.c b/drivers/isdn/isdn_ppp.c
--- a/drivers/isdn/isdn_ppp.c	Fri Nov 22 15:29:42 2002
+++ b/drivers/isdn/isdn_ppp.c	Fri Nov 22 15:29:42 2002
@@ -1147,7 +1147,7 @@
 		printk(KERN_ERR "isdn_ppp_xmit: lp->ppp_slot(%d)\n",
 			mlp->ppp_slot);
 		kfree_skb(skb);
-		goto unlock;
+		goto out;
 	}
 	ipts = ippp_table[slot];
 
@@ -1155,7 +1155,7 @@
 		if (ipts->debug & 0x1)
 			printk(KERN_INFO "%s: IP frame delayed.\n", netdev->name);
 		retval = 1;
-		goto unlock;
+		goto out;
 	}
 
 	switch (ntohs(skb->protocol)) {
@@ -1169,7 +1169,7 @@
 			printk(KERN_ERR "isdn_ppp: skipped unsupported protocol: %#x.\n", 
 			       skb->protocol);
 			dev_kfree_skb(skb);
-			goto unlock;
+			goto out;
 	}
 
 	lp = isdn_net_get_locked_lp(nd);
@@ -1336,6 +1336,7 @@
 
  unlock:
 	spin_unlock_bh(&lp->xmit_lock);
+ out:
 	return retval;
 }
 





