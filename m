Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753250AbWKCOwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbWKCOwv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 09:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753260AbWKCOwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 09:52:51 -0500
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:34226 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S1753250AbWKCOwu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 09:52:50 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions)
Date: Fri, 3 Nov 2006 08:52:44 -0600
Message-ID: <4C62E596C0F58148BAAFE8CEA438D09E0854BE19@cceexc15.americas.cpqcorp.net>
In-Reply-To: <4E7F16C676%linux@youmustbejoking.demon.co.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions)
Thread-Index: Acb/Ry2z8knKTwnyQ0ycqOPHu/uM+AAEHOQQ
From: "Azam, Syed S" <Syed.Azam@hp.com>
To: "Darren Salt" <linux@youmustbejoking.demon.co.uk>, <g.liakhovetski@gmx.de>,
       <romieu@fr.zoreil.com>
Cc: <torvalds@osdl.org>, <bunk@stusta.de>, <akpm@osdl.org>,
       <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>,
       <tmattox@gmail.com>, <spiky.kiwi@gmail.com>, <r.bhatia@ipax.at>,
       <buytenh@wantstofly.org>
X-OriginalArrivalTime: 03 Nov 2006 14:52:45.0654 (UTC) FILETIME=[B8EEE760:01C6FF57]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, It is still working.


Syed Azam
System Software Engineer
Hewlett-Packard Company
 
-----Original Message-----
From: Darren Salt [mailto:linux@youmustbejoking.demon.co.uk] 
Sent: Wednesday, November 01, 2006 1:01 PM
To: g.liakhovetski@gmx.de; romieu@fr.zoreil.com
Cc: torvalds@osdl.org; bunk@stusta.de; akpm@osdl.org; jgarzik@pobox.com;
linux-kernel@vger.kernel.org; tmattox@gmail.com; spiky.kiwi@gmail.com;
r.bhatia@ipax.at; Azam, Syed S; buytenh@wantstofly.org
Subject: Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known
regressions)

This message is in MIME format which your mailer apparently does not
support.
You either require a newer version of your software which supports MIME,
or
a separate MIME decoding utility.  Alternatively, ask the sender of this
message to resend it in a different format.

--163681386--1739281754--1718250983
Content-Type: text/plain; charset=us-ascii

I demand that Francois Romieu may or may not have written...

[snip]
> o Darren and Syed, are your 0x8136 still happy with the patch
>
0001-r8169-perform-a-PHY-reset-before-any-other-operation-at-boot-time.t
xt
>   at http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.19-rc4/r8169
>   on top of 2.6.19-rc4 ?

It is.

I then tried 0002-r8169-more-magic.txt, mainly to see that it doesn't
cause
any problems. Unfortunately, it did... however, a little reading showed
that
you've stopped enabling transmit and receive for all but four of the
chip
types supported by the driver.

An incremental fix is attached.

> o Darren, still ok to keep your S-o-b in it ?

Yes.

[snip]
-- 
| Darren Salt    | linux or ds at              | nr. Ashington, | Toon
| RISC OS, Linux | youmustbejoking,demon,co,uk | Northumberland | Army
| + Buy less and make it last longer.         INDUSTRY CAUSES GLOBAL
WARMING.

Never have a drink when you are feeling sorry for yourself.

--163681386--1739281754--1718250983
Content-Type: text/plain; charset=iso-8859-1;
name="0003-r8169-fix-more-magic.patch"
Content-Disposition: attachment;
filename="0003-r8169-fix-more-magic.patch"

r8169: fix more magic so that 8101e etc. work again

r8169-more-magic killed transmit & receive on my laptop's RTL8101e.
Turns out
to be that the enabling of these functions had been unitnentionally
removed.

(This is one of two possible fixes, the other being the removal of the
if()
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
