Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261567AbSI0LMT>; Fri, 27 Sep 2002 07:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261690AbSI0LMT>; Fri, 27 Sep 2002 07:12:19 -0400
Received: from gate.perex.cz ([194.212.165.105]:47881 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S261567AbSI0LMS>;
	Fri, 27 Sep 2002 07:12:18 -0400
Date: Fri, 27 Sep 2002 13:16:04 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>,
       Jens Thoms Toerring <Jens.Toerring@physik.fu-berlin.de>
Subject: [PATCH] ISA PnP
Message-ID: <Pine.LNX.4.33.0209271311430.503-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	the read port (RDP) of ISA PnP cards must be set only when card is 
in the isolation phase. Bellow is a patch to follow the ISA PnP 
specification. Please, apply.

						Jaroslav

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.606, 2002-09-27 13:13:08+02:00, perex@pnote.perex-int.cz
  ISA PnP change
    Jens Thoms Toerring <Jens.Toerring@physik.fu-berlin.de>
      - RDP must be reset only in isolation phase


 isapnp.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)


diff -Nru a/drivers/pnp/isapnp.c b/drivers/pnp/isapnp.c
--- a/drivers/pnp/isapnp.c	Fri Sep 27 13:13:51 2002
+++ b/drivers/pnp/isapnp.c	Fri Sep 27 13:13:51 2002
@@ -1048,11 +1048,19 @@
 	isapnp_wait();
 	isapnp_key();
 	isapnp_wake(csn);
-#if 1	/* to avoid malfunction when the isapnptools package is used */
-	isapnp_set_rdp();
-	udelay(1000);	/* delay 1000us */
-	write_address(0x01);
-	udelay(1000);	/* delay 1000us */
+#if 1
+	/* to avoid malfunction when the isapnptools package is used */
+	/* we must set RDP to our value again */
+	/* it is possible to set RDP only in the isolation phase */ 
+	/*   Jens Thoms Toerring <Jens.Toerring@physik.fu-berlin.de> */
+	isapnp_write_byte(0x02, 0x04);	/* clear CSN of card */
+	mdelay(2);			/* is this necessary? */
+	isapnp_wake(csn);		/* bring card into sleep state */
+	isapnp_wake(0);			/* bring card into isolation state */
+	isapnp_set_rdp();		/* reset the RDP port */
+	udelay(1000);			/* delay 1000us */
+	isapnp_write_byte(0x06, csn);	/* reset CSN to previous value */
+	udelay(250);			/* is this necessary? */
 #endif
 	if (logdev >= 0)
 		isapnp_device(logdev);

===================================================================


This BitKeeper patch contains the following changesets:
1.606
## Wrapped with gzip_uu ##


begin 664 bkpatch2383
M'XL(`&\]E#T``[55;6_;-A#^;/Z*`_(E:VN)I%[\LKESEQ1;NV$UDO9S0%-G
MB[`L"B25Q(5_?"FJ<9LE3="TLP4).MYS=\]S#^PC^&#13`<-&KPF1_"7MLZ_
MU=IA%&)#5;M(?O1'9UK[H[C46XS#45RINKV.]6JEI!(5\3D+X60)EVCL=,"B
MY!!QNP:G@[/7?W[XY]49(;,9G)2B7N,Y.IC-B-/F4E2%G0M75KJ.G!&UW:(3
MD=3;_2%USRGE_INQ44*S?,]RFH[VDA6,B91A07DZSE,B-LUV7J@UZOO@$Y[P
M).-IOD_':3HAI\"BG.9`>4PG,1\!2Z;^HN/GE$\IA4!U?E<1>,Y@2,D?\'.'
M/R$2WIR_@D6]`!FP/@#P%FL+[[WV_J[1&%6OX;<N&-V\SIMR9]4F6K7#)1J_
MFJC`EP$+,(2STP5L6^M@B6#0>MEU7>U`U:"LKH13NH:F%!;)WY!.^(B3Q9<5
MD>%W?@BA@I*7CTA3&-4Y)6[J)E96^$<DOU(II:Q3B=')GF6\F.1BE>5RM9R,
MO[V4!VIZ4HPQZO?.DY0FP83W93_NQZ?/31KQ<8-S;9;*"1:9]H%:"1NS<<9I
MOL^XKQ-\RI+;-J73-'_<I@D,L__%IS]BRN^S9+^R=S`T5^'R%EO<N[TG6/64
M>:Z0D3?^F7E9R9%:`2.#^)F7#,2E5@5L1;5J:QEFNBJQ!E<B]#V=UI6%1LB-
M6'<Q:"T6\"P.!:ZPI]BQZ_CZ@KHUX/?0(HBU\&0_9RK781MMK5I6V"7>8&Y4
MZ5O>4L:#(:"?_`,1VO=$+JZ,<GBQW#D\IM>4OP!_3W_YM:LO*Q0&3L[_!;T"
M*4Q/<%M@)7;'W.<,`@?KA_2W&B5:*\SN]UOEQ0:/I:V[;)^\#".&6MZIGFZ%
MV(!UPN$=%+WI\%_0%SWN`+U\%Z9HCC^WZQW6:=AIVFCC0G+;4V"4'GJ$"'21
MUGY;GOP%]%P.M3MU_$B-P4NE/;1?\E=->$8?5NKP=RE+E!O;;F<3OA3)*!7D
)$TWO1YNH!P``
`
end

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


