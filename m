Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269059AbUIQWB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269059AbUIQWB7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 18:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269060AbUIQWB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 18:01:59 -0400
Received: from mail43-s.fg.online.no ([148.122.161.43]:14568 "EHLO
	mail43-s.fg.online.no") by vger.kernel.org with ESMTP
	id S269059AbUIQWBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 18:01:51 -0400
From: Kenneth =?iso-8859-1?q?Aafl=F8y?= <lists@kenneth.aafloy.net>
To: Roger Luethi <rl@hellgate.ch>
Subject: Re: [BUG] Via-Rhine WOL vs PXE Boot
Date: Sat, 18 Sep 2004 00:01:42 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200409172154.36550.lists@kenneth.aafloy.net> <20040917203458.GA12779@k3.hellgate.ch>
In-Reply-To: <20040917203458.GA12779@k3.hellgate.ch>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_G71SBx75DJTFI5h"
Message-Id: <200409180001.42332.lists@kenneth.aafloy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_G71SBx75DJTFI5h
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 17 September 2004 22:34, Roger Luethi wrote:
> On Fri, 17 Sep 2004 21:54:36 +0200, Kenneth Aafl=F8y wrote:
> > In recent kernels I have been having trouble booting from a LAN with the
> > built in PXE firmware in my Via Epia M10k board.
[...]

> The patch you are referring to contains very little code that affects chip
> programming without user intervention (e.g. calling ethtool ioctls). There
> is one notable exception: The patch introduces rhine_shutdown which is
> called at shutdown (well, duh!). I suppose you can make the problem go aw=
ay
> if you comment out parts of said function. I'd start at the bottom with t=
he
> D3 call.

Indeed it was that last call to change the power state, as I too figured. N=
ow=20
I wonder if there is some other power state that could be set that would=20
benefit powersaving, but not prevent the pxe boot rom from beeing confused?

Or should this rather be reported as a bug to Via, so that they can impleme=
nt=20
restoring the adapter from the D3 state in the pxe boot rom?

I've attached what I belive to be a bk patch (kinda new to that) which=20
comments out this power-state change, untill something better is found. I=20
have not tested WOL with this, but I can't think of any reason why it shoul=
d=20
not work.

Kenneth

--Boundary-00=_G71SBx75DJTFI5h
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="via-rhine.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="via-rhine.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/17 23:44:56+02:00 lists@kenneth.aafloy.net(none) 
#   via-rhine.c:
#     [via-rhine] Disable the D3 power state in _shutdown.
# 
# drivers/net/via-rhine.c
#   2004/09/17 23:29:58+02:00 lists@kenneth.aafloy.net(none) +3 -1
#   [via-rhine] Disable the D3 power state in _shutdown.
# 
diff -Nru a/drivers/net/via-rhine.c b/drivers/net/via-rhine.c
--- a/drivers/net/via-rhine.c	2004-09-17 23:49:38 +02:00
+++ b/drivers/net/via-rhine.c	2004-09-17 23:49:38 +02:00
@@ -1934,7 +1934,9 @@
 	writeb(readb(ioaddr + StickyHW) | 0x04, ioaddr + StickyHW);
 
 	/* Hit power state D3 (sleep) */
-	writeb(readb(ioaddr + StickyHW) | 0x03, ioaddr + StickyHW);
+	/* Disabled for now, because it will confuse the PXE boot rom
+	 * of some Via Epia boards. */
+	//writeb(readb(ioaddr + StickyHW) | 0x03, ioaddr + StickyHW);
 
 	/* TODO: Check use of pci_enable_wake() */
 

--Boundary-00=_G71SBx75DJTFI5h--
