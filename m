Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265095AbTBOUnc>; Sat, 15 Feb 2003 15:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265126AbTBOUnb>; Sat, 15 Feb 2003 15:43:31 -0500
Received: from mail3.bluewin.ch ([195.186.1.75]:59867 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id <S265095AbTBOUn3>;
	Sat, 15 Feb 2003 15:43:29 -0500
Date: Sat, 15 Feb 2003 21:53:02 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [0/4][via-rhine] Improvements
Message-ID: <20030215205302.GB4627@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@digeo.com>
References: <20030215111705.GA11127@k3.hellgate.ch> <3E4E9028.3090601@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <3E4E9028.3090601@pobox.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.61 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, 15 Feb 2003 14:08:24 -0500, Jeff Garzik wrote:

> Looks good, all patches applied to 2.5.

Thx. Patch to bump the version number up attached.

> Should these apply to 2.4, too?

Yes. I'm trying to keep the drivers in both trees in sync.

> Just a general comment, the reset logic seems a bit too much like voodoo 
> magic ;-)

Look at the rest of the driver and you will find the reset voodoo magic is
a perfect fit. We'd be waving dead chickens if only tar could handle them.
Actually, the reset logic is slightly better because for every line I have
some reasoning and actual tests conducted. The underlying problem is that
the Rhine is only loosely documented and various revisions differ in
amazing ways from each other and from the documentation that supposedly
describes them.

I've named the magic register in the patch below, does that ease your
voodoo pain?

I've been considering for a while to document the driver somewhat better.
Are documentation patches welcome, or do you just want to have official
word from VIA that they agree with the reset code? And if I need a few
lines to explain some voodoo magic, is the prefered way to put it into the
source or would a freshly created Documentation/network/via-rhine.txt be
(my first choice but the directory typically contains user rather than
developer documentation) the better place?

> It would be nice long-term to get an official answer from Via 
> about the proper reset sequence and time limits.  [regardless, like I 

Heh. If I had a contact at VIA I'd have many and more important questions
than the reset sequence that actually works now, unlike lots of other
stuff. Yes, reliable information from within VIA -- official or not --
would be a big help.

Roger

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-rhine-1.16rc-05_changelog.diff"

--- 04_reset/drivers/net/via-rhine.c	Fri Feb 14 19:13:04 2003
+++ 05_changelog/drivers/net/via-rhine.c	Sat Feb 15 21:33:55 2003
@@ -101,11 +101,18 @@
 	LK1.1.15 (jgarzik):
 	- Use new MII lib helper generic_mii_ioctl
 
+	LK1.1.16 (Roger Luethi)
+	- Etherleak fix
+	- Handle Tx buffer underrun
+	- Fix bugs in full duplex handling
+	- New reset code uses "force reset" cmd on Rhine-II
+	- Various clean ups
+
 */
 
 #define DRV_NAME	"via-rhine"
-#define DRV_VERSION	"1.1.15"
-#define DRV_RELDATE	"November-22-2002"
+#define DRV_VERSION	"1.1.16"
+#define DRV_RELDATE	"February-15-2003"
 
 
 /* A few user-configurable values.
@@ -395,7 +402,7 @@ enum register_offsets {
 	MIIPhyAddr=0x6C, MIIStatus=0x6D, PCIBusConfig=0x6E,
 	MIICmd=0x70, MIIRegAddr=0x71, MIIData=0x72, MACRegEEcsr=0x74,
 	ConfigA=0x78, ConfigB=0x79, ConfigC=0x7A, ConfigD=0x7B,
-	RxMissed=0x7C, RxCRCErrs=0x7E,
+	RxMissed=0x7C, RxCRCErrs=0x7E, MiscCmd=0x81,
 	StickyHW=0x83, WOLcrClr=0xA4, WOLcgClr=0xA7, PwrcsrClr=0xAC,
 };
 
@@ -532,7 +539,7 @@ static void wait_for_reset(struct net_de
 
 		/* Rhine-II needs to be forced sometimes */
 		if (chip_id == VT6102)
-			writeb(0x40, ioaddr + 0x81);
+			writeb(0x40, ioaddr + MiscCmd);
 
 		/* VT86C100A may need long delay after reset (dlink) */
 		/* Seen on Rhine-II as well (rl) */

--G4iJoqBmSsgzjUCe--
