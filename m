Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267374AbUIJMff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267374AbUIJMff (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 08:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267381AbUIJMff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 08:35:35 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:46806 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S267374AbUIJMfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 08:35:17 -0400
Message-ID: <41419F82.10109@sun.com>
Date: Fri, 10 Sep 2004 13:35:14 +0100
From: Brian Somers <brian.somers@sun.com>
Organization: Sun Microsystems
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.4) Gecko/20040414
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Michael.Waychison@sun.com, linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>	<200408162049.FFF09413.8592816B@anet.ne.jp>	<20040816143824.15238e42.davem@redhat.com>	<412CD101.4050406@sun.com>	<20040825120831.55a20c57.davem@redhat.com>	<412CF0E9.2010903@sun.com>	<20040825175805.6807014c.davem@redhat.com>	<412DC055.4070401@sun.com> <20040826123730.375ce5d2.davem@redhat.com>
In-Reply-To: <20040826123730.375ce5d2.davem@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------070401040809010209020802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070401040809010209020802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David S. Miller wrote:
> On Thu, 26 Aug 2004 11:49:57 +0100
> Brian Somers <brian.somers@sun.com> wrote:
> 
> 
>>Can we get this guy to try running an older version of tg3 to see
>>what change introduce the issue?
> 
> 
> Brian, we already narrowed it down to exactly the hw autoneg
> changes Sun wrote.  It breaks the IBM blades onboard 5704
> fibre chips.  Reverting your change or disabling hw autoneg
> in the new code both fix the problem.

The problem seems to be that autoneg is disabled on the IBM switches.
After disabling autoneg on the Sun shelf switches, I see the problem.
This patch fixes things by reverting to sw autoneg which defaults to
a 1000Mbps/full-duplex link but with no flow control when it fails
(IBM should really have autoneg enabled!) - I'd appreciate it if
someone could test this against an IBM blade.

The patch is against the 2.6.8-1.521 version of tg3.c but should
hopefully apply to other recent versions.  If there are problems,
because tw32_f() isn't defined, change

     tw32_f(x, y);

to

     tw32(x, y);
     tr32(x);

Cheers.

-- 
Brian Somers                                            Sun Microsystems
                                             Sparc House, Guillemont Park
Software Engineer - LSE                          Minley Road, Blackwater
Tel: +44 1252 421 263   Ext: 21263                    Camberley GU17 9QG

--------------070401040809010209020802
Content-Type: text/plain;
 name="tg3.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tg3.c.patch"

--- tg3.c.orig	2004-09-10 13:24:28.000000000 +0100
+++ tg3.c	2004-09-10 13:24:14.000000000 +0100
@@ -2051,9 +2051,25 @@
 				break;
 			udelay(1);
 		}
-		if (tick >= 195000)
-			printk(KERN_INFO PFX "%s: HW autoneg failed !\n",
+		if (tick >= 195000) {
+			u32 digctrl, txctrl;
+
+			printk(KERN_INFO PFX
+			    "%s: HW autoneg failed - disabled\n",
 			    tp->dev->name);
+
+			digctrl = tr32(SG_DIG_CTRL);
+			digctrl &= ~SG_DIG_USING_HW_AUTONEG;
+
+			txctrl = tr32(MAC_SERDES_CFG);
+			txctrl &= ~MAC_SERDES_CFG_EDGE_SELECT;
+			tw32_f(MAC_SERDES_CFG, txctrl);
+			tw32_f(SG_DIG_CTRL, digctrl | SG_DIG_SOFT_RESET);
+			udelay(5);
+			tw32_f(SG_DIG_CTRL, digctrl);
+
+			tp->tg3_flags2 &= ~TG3_FLG2_HW_AUTONEG;
+		}
 	}
 
 	/* Reset when initting first time or we have a link. */
@@ -5280,7 +5296,6 @@
 		txctrl = tr32(MAC_SERDES_CFG);
 		tw32_f(MAC_SERDES_CFG, txctrl | MAC_SERDES_CFG_EDGE_SELECT);
 		tw32_f(SG_DIG_CTRL, digctrl | SG_DIG_SOFT_RESET);
-		tr32(SG_DIG_CTRL);
 		udelay(5);
 		tw32_f(SG_DIG_CTRL, digctrl);
 

--------------070401040809010209020802--

