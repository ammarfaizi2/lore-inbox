Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265413AbSJaWSD>; Thu, 31 Oct 2002 17:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265415AbSJaWSC>; Thu, 31 Oct 2002 17:18:02 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:30691 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S265413AbSJaWSB>; Thu, 31 Oct 2002 17:18:01 -0500
Date: Thu, 31 Oct 2002 16:24:27 -0600 (CST)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Gregoire Favre <greg@ulima.unil.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.45 : kernel BUG at kernel/workqueue.c:69! (ISDN?)
In-Reply-To: <20021031215441.GD24890@ulima.unil.ch>
Message-ID: <Pine.LNX.4.44.0210311620470.27728-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Gregoire Favre wrote:

> On Thu, Oct 31, 2002 at 02:13:14PM -0600, Kai Germaschewski wrote:
> 
> > > kernel BUG at kernel/workqueue.c:69!
> 
> > Well, I thought I had all of these fixed...
> 
> Oops: sorry for reporting...

Well, since I obviously hadn't, thanks for reporting this ;)

These traces still have a lot of weird things in it, but I think I figured 
out what went wrong now. As a workaround, the following should do.

===== drivers/isdn/hisax/avm_pci.c 1.11 vs edited =====
--- 1.11/drivers/isdn/hisax/avm_pci.c	Tue Oct 29 19:50:48 2002
+++ edited/drivers/isdn/hisax/avm_pci.c	Thu Oct 31 16:19:26 2002
@@ -731,10 +731,10 @@
 			release_region(cs->hw.avm.cfg_reg, 32);
 			return(0);
 		case CARD_INIT:
-			clear_pending_isac_ints(cs);
 			initisac(cs);
-			clear_pending_hdlc_ints(cs);
+			clear_pending_isac_ints(cs);
 			inithdlc(cs);
+			clear_pending_hdlc_ints(cs);
 			outb(AVM_STATUS0_DIS_TIMER | AVM_STATUS0_RES_TIMER,
 				cs->hw.avm.cfg_reg + 2);
 			WriteISAC(cs, ISAC_MASK, 0);

Anyway, actually, this driver has been superseded by hisax_fcpcipnp, so 
I'd prefer if you used the new driver ("modprobe hisax_fcpcipnp", no 
parameters necessary), to find bugs there. Also, be advised that this is 
not the last bug you'll find in current 2.5 ISDN, but I'll be thankful for 
any reports and testing ;)

--Kai


