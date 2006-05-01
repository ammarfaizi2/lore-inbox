Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWEALcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWEALcq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 07:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWEALcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 07:32:46 -0400
Received: from heisenberg.zen.co.uk ([212.23.3.141]:40428 "EHLO
	heisenberg.zen.co.uk") by vger.kernel.org with ESMTP
	id S932067AbWEALcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 07:32:45 -0400
Message-ID: <4455F1D8.5030102@cantab.net>
Date: Mon, 01 May 2006 12:32:40 +0100
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: David Vrabel <dvrabel@cantab.net>
CC: Pekka Enberg <penberg@cs.helsinki.fi>, romieu@fr.zoreil.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       david@pleyades.net
Subject: Re: IP1000 gigabit nic driver
References: <20060427142939.GA31473@fargo>	 <20060427185627.GA30871@electric-eye.fr.zoreil.com>	 <445144FF.4070703@cantab.net> <20060428075725.GA18957@fargo>	 <84144f020604280358ie9990c7h399f4a5588e575f8@mail.gmail.com>	 <20060428113755.GA7419@fargo>	 <Pine.LNX.4.58.0604281458110.19801@sbz-30.cs.Helsinki.FI>	 <1146306567.1642.3.camel@localhost>  <20060429122119.GA22160@fargo>	 <1146342905.11271.3.camel@localhost> <1146389171.11524.1.camel@localhost> <44554ADE.8030200@cantab.net>
In-Reply-To: <44554ADE.8030200@cantab.net>
Content-Type: multipart/mixed;
 boundary="------------070402040805090704080609"
X-Originating-Heisenberg-IP: [82.70.146.41]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070402040805090704080609
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

David Vrabel wrote:
> 
>     - something (PHY reset/auto negotiation?) takes 2-3 seconds and
>       appears to be done with interrupts disabled.

It was clocking the MII management interface (MDC) at 500 Hz so each PHY
register access took some 130 ms, and many registers accesses were being
done on initialization. According to the datasheet, the maximum
frequency for MDC is 2.5 MHz.  Delays have been adjusted accordingly.

David Vrabel

--------------070402040805090704080609
Content-Type: text/plain;
 name="drivers-net-ipg-speed-up-phy-access"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drivers-net-ipg-speed-up-phy-access"

Reduce delays when reading/writing the PHY registers so we clock the
MII management interface at 2.5 MHz (the maximum according to the
datasheet) instead of 500 Hz.

Signed-off-by: David Vrabel <dvrabel@cantab.net>

Index: linux-source-2.6.16/drivers/net/ipg.c
===================================================================
--- linux-source-2.6.16.orig/drivers/net/ipg.c	2006-05-01 11:52:32.555800238 +0100
+++ linux-source-2.6.16/drivers/net/ipg.c	2006-05-01 12:08:45.316188064 +0100
@@ -176,13 +176,13 @@
 		 (IPG_PC_MGMTCLK_LO | (IPG_PC_MGMTDATA & 0) | IPG_PC_MGMTDIR |
 		  phyctrlpolarity), ioaddr + IPG_PHYCTRL);
 
-	mdelay(IPG_PC_PHYCTRLWAIT);
+	ndelay(IPG_PC_PHYCTRLWAIT_NS);
 
 	iowrite8(IPG_PC_RSVD_MASK &
 		 (IPG_PC_MGMTCLK_HI | (IPG_PC_MGMTDATA & 0) | IPG_PC_MGMTDIR |
 		  phyctrlpolarity), ioaddr + IPG_PHYCTRL);
 
-	mdelay(IPG_PC_PHYCTRLWAIT);
+	ndelay(IPG_PC_PHYCTRLWAIT_NS);
 }
 
 static void send_end(void __iomem * ioaddr, u8 phyctrlpolarity)
@@ -198,7 +198,7 @@
 	iowrite8(IPG_PC_RSVD_MASK & (IPG_PC_MGMTCLK_LO | phyctrlpolarity),
 		 ioaddr + IPG_PHYCTRL);
 
-	mdelay(IPG_PC_PHYCTRLWAIT);
+	ndelay(IPG_PC_PHYCTRLWAIT_NS);
 
 	bit_data =
 	    ((ioread8(ioaddr + IPG_PHYCTRL) & IPG_PC_MGMTDATA) >> 1) & 1;
@@ -206,7 +206,7 @@
 	iowrite8(IPG_PC_RSVD_MASK & (IPG_PC_MGMTCLK_HI | phyctrlpolarity),
 		 ioaddr + IPG_PHYCTRL);
 
-	mdelay(IPG_PC_PHYCTRLWAIT);
+	ndelay(IPG_PC_PHYCTRLWAIT_NS);
 	return bit_data;
 }
 
@@ -290,14 +290,14 @@
 				  (IPG_PC_MGMTDATA & databit) | IPG_PC_MGMTDIR |
 				  phyctrlpolarity), ioaddr + IPG_PHYCTRL);
 
-			mdelay(IPG_PC_PHYCTRLWAIT);
+			ndelay(IPG_PC_PHYCTRLWAIT_NS);
 
 			iowrite8(IPG_PC_RSVD_MASK &
 				 (IPG_PC_MGMTCLK_HI |
 				  (IPG_PC_MGMTDATA & databit) | IPG_PC_MGMTDIR |
 				  phyctrlpolarity), ioaddr + IPG_PHYCTRL);
 
-			mdelay(IPG_PC_PHYCTRLWAIT);
+			ndelay(IPG_PC_PHYCTRLWAIT_NS);
 		}
 
 	send_three_state(ioaddr, phyctrlpolarity);
@@ -403,14 +403,14 @@
 				  (IPG_PC_MGMTDATA & databit) | IPG_PC_MGMTDIR |
 				  phyctrlpolarity), ioaddr + IPG_PHYCTRL);
 
-			mdelay(IPG_PC_PHYCTRLWAIT);
+			ndelay(IPG_PC_PHYCTRLWAIT_NS);
 
 			iowrite8(IPG_PC_RSVD_MASK &
 				 (IPG_PC_MGMTCLK_HI |
 				  (IPG_PC_MGMTDATA & databit) | IPG_PC_MGMTDIR |
 				  phyctrlpolarity), ioaddr + IPG_PHYCTRL);
 
-			mdelay(IPG_PC_PHYCTRLWAIT);
+			ndelay(IPG_PC_PHYCTRLWAIT_NS);
 		}
 
 	/* The last cycle is a tri-state, so read from the PHY.
@@ -421,7 +421,7 @@
 				 (IPG_PC_MGMTCLK_LO | phyctrlpolarity),
 				 ioaddr + IPG_PHYCTRL);
 
-			mdelay(IPG_PC_PHYCTRLWAIT);
+			ndelay(IPG_PC_PHYCTRLWAIT_NS);
 
 			field[j] |= ((ioread8(ioaddr + IPG_PHYCTRL) &
 				      IPG_PC_MGMTDATA) >> 1)
@@ -431,7 +431,7 @@
 				 (IPG_PC_MGMTCLK_HI | phyctrlpolarity),
 				 ioaddr + IPG_PHYCTRL);
 
-			mdelay(IPG_PC_PHYCTRLWAIT);
+			ndelay(IPG_PC_PHYCTRLWAIT_NS);
 
 		}
 }
Index: linux-source-2.6.16/drivers/net/ipg.h
===================================================================
--- linux-source-2.6.16.orig/drivers/net/ipg.h	2006-05-01 12:08:58.343035854 +0100
+++ linux-source-2.6.16/drivers/net/ipg.h	2006-05-01 12:09:37.282602113 +0100
@@ -672,10 +672,10 @@
 /* Number of IPG_AC_RESETWAIT timeperiods before declaring timeout. */
 #define         IPG_AC_RESET_TIMEOUT         0x0A
 
-/* Minimum number of miliseconds used to toggle MDC clock during
+/* Minimum number of nanoseconds used to toggle MDC clock during
  * MII/GMII register access.
  */
-#define         IPG_PC_PHYCTRLWAIT           0x01
+#define		IPG_PC_PHYCTRLWAIT_NS		200
 
 #define		IPG_TFDLIST_LENGTH		0x100
 

--------------070402040805090704080609--
