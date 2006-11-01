Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752284AbWKAUGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbWKAUGk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 15:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752292AbWKAUGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 15:06:40 -0500
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:26634 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750936AbWKAUGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 15:06:40 -0500
Date: Wed, 01 Nov 2006 19:01:21 +0000
From: Darren Salt <linux@youmustbejoking.demon.co.uk>
To: g.liakhovetski@gmx.de, romieu@fr.zoreil.com
Cc: torvalds@osdl.org, bunk@stusta.de, akpm@osdl.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, tmattox@gmail.com, spiky.kiwi@gmail.com,
       r.bhatia@ipax.at, syed.azam@hp.com, buytenh@wantstofly.org
Subject: Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions)
Message-ID: <4E7F16C676%linux@youmustbejoking.demon.co.uk>
References: <20061029223410.GA15413@electric-eye.fr.zoreil.com> <Pine.LNX.4.60.0610300032190.1435@poirot.grange> 
 <20061030120158.GA28123@electric-eye.fr.zoreil.com> <Pine.LNX.4.60.0610302148560.9723@poirot.grange> <Pine.LNX.4.60.0610302214350.9723@poirot.grange> 
 <20061030234425.GB6038@electric-eye.fr.zoreil.com> <Pine.LNX.4.60.0610312000160.5223@poirot.grange> <20061031230538.GA4329@electric-eye.fr.zoreil.com>
In-Reply-To: <20061031230538.GA4329@electric-eye.fr.zoreil.com>
User-Agent: Messenger-Pro/4.14b2 (MsgServe/3.25) (RISC-OS/4.02) POPstar/2.06+cvs
X-Editor: Zap 1.47 (27 Apr 2006) [TEST], ZapEmail 0.28.3 (25 Mar 2005) (32)
X-SDate: Wed, 4810 Sep 1993 19:01:21 +0000
X-Message-Flag: Outlook Express is broken. Upgrade to mail(1).
X-SA-Exim-Connect-IP: 192.168.0.2
X-SA-Exim-Mail-From: linux@youmustbejoking.demon.co.uk
X-SA-Exim-Scanned: No (on pentagram.youmustbejoking.demon.co.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format which your mailer apparently does not support.
You either require a newer version of your software which supports MIME, or
a separate MIME decoding utility.  Alternatively, ask the sender of this
message to resend it in a different format.

--163681386--1739281754--1718250983
Content-Type: text/plain; charset=us-ascii

I demand that Francois Romieu may or may not have written...

[snip]
> o Darren and Syed, are your 0x8136 still happy with the patch
>   0001-r8169-perform-a-PHY-reset-before-any-other-operation-at-boot-time.txt
>   at http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.19-rc4/r8169
>   on top of 2.6.19-rc4 ?

It is.

I then tried 0002-r8169-more-magic.txt, mainly to see that it doesn't cause
any problems. Unfortunately, it did... however, a little reading showed that
you've stopped enabling transmit and receive for all but four of the chip
types supported by the driver.

An incremental fix is attached.

> o Darren, still ok to keep your S-o-b in it ?

Yes.

[snip]
-- 
| Darren Salt    | linux or ds at              | nr. Ashington, | Toon
| RISC OS, Linux | youmustbejoking,demon,co,uk | Northumberland | Army
| + Buy less and make it last longer.         INDUSTRY CAUSES GLOBAL WARMING.

Never have a drink when you are feeling sorry for yourself.

--163681386--1739281754--1718250983
Content-Type: text/plain; charset=iso-8859-1; name="0003-r8169-fix-more-magic.patch"
Content-Disposition: attachment; filename="0003-r8169-fix-more-magic.patch"

r8169: fix more magic so that 8101e etc. work again

r8169-more-magic killed transmit & receive on my laptop's RTL8101e. Turns out
to be that the enabling of these functions had been unitnentionally removed.

(This is one of two possible fixes, the other being the removal of the if()
guarding the other tx/rx-enable call. Both work here.)

Signed-off-by: Darren Salt <linux@youmustbejoking.demon.co.uk>

--- drivers/net/r8169.c~	2006-11-01 19:53:02.000000000 +0000
+++ drivers/net/r8169.c	2006-11-01 19:54:16.000000000 +0000
@@ -1921,7 +1921,10 @@
 	    (tp->mac_version != RTL_GIGA_MAC_VER_02) &&
 	    (tp->mac_version != RTL_GIGA_MAC_VER_03) &&
 	    (tp->mac_version != RTL_GIGA_MAC_VER_04))
+	{
 		rtl8169_set_rx_tx_config_registers(tp);
+		RTL_W8(ChipCmd, CmdTxEnb | CmdRxEnb);
+	}
 
 	RTL_W8(Cfg9346, Cfg9346_Lock);
 

--163681386--1739281754--1718250983--
