Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263299AbSJHN4Z>; Tue, 8 Oct 2002 09:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263241AbSJHNy5>; Tue, 8 Oct 2002 09:54:57 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:63380 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263232AbSJHNy2>;
	Tue, 8 Oct 2002 09:54:28 -0400
Date: Tue, 8 Oct 2002 16:00:01 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Fix LAlt-RAlt and similar combinations in atkbd.c [19/23]
Message-ID: <20021008160001.R18546@ucw.cz>
References: <20021008154733.H18546@ucw.cz> <20021008154824.I18546@ucw.cz> <20021008154904.J18546@ucw.cz> <20021008155003.K18546@ucw.cz> <20021008155045.L18546@ucw.cz> <20021008155125.M18546@ucw.cz> <20021008155236.N18546@ucw.cz> <20021008155651.O18546@ucw.cz> <20021008155825.P18546@ucw.cz> <20021008155915.Q18546@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008155915.Q18546@ucw.cz>; from vojtech@suse.cz on Tue, Oct 08, 2002 at 03:59:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.573.1.53, 2002-10-07 14:29:57+02:00, vojtech@suse.cz
  Fix LAlt-RAlt combination on AT keyboards (generated "unknown scancode" message).


 i8042.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Tue Oct  8 15:25:31 2002
+++ b/drivers/input/serio/i8042.c	Tue Oct  8 15:25:31 2002
@@ -63,7 +63,7 @@
 
 extern struct pt_regs *kbd_pt_regs;
 
-static unsigned long i8042_unxlate_seen[128 / BITS_PER_LONG];
+static unsigned long i8042_unxlate_seen[256 / BITS_PER_LONG];
 static unsigned char i8042_unxlate_table[128] = {
 	  0,118, 22, 30, 38, 37, 46, 54, 61, 62, 70, 69, 78, 85,102, 13,
 	 21, 29, 36, 45, 44, 53, 60, 67, 68, 77, 84, 91, 90, 20, 28, 27,
@@ -407,14 +407,14 @@
 		}
 
 		if (data > 0x7f) {
-			if (test_and_clear_bit(data & 0x7f, i8042_unxlate_seen)) {
+			if (test_and_clear_bit((data & 0x7f) | (i8042_last_e0 << 7), i8042_unxlate_seen)) {
 				serio_interrupt(&i8042_kbd_port, 0xf0, dfl);
 				if (i8042_last_e0 && (data == 0xaa || data == 0xb6))
-					set_bit(data & 0x7f, i8042_unxlate_seen);
+					set_bit((data & 0x7f) | (i8042_last_e0 << 7), i8042_unxlate_seen);
 				data = i8042_unxlate_table[data & 0x7f];
 			}
 		} else {
-			set_bit(data, i8042_unxlate_seen);
+			set_bit(data | (i8042_last_e0 << 7), i8042_unxlate_seen);
 			data = i8042_unxlate_table[data];
 		}
 

===================================================================

This BitKeeper patch contains the following changesets:
1.573.1.53
## Wrapped with gzip_uu ##


begin 664 bkpatch17951
M'XL(`,O<HCT``[64;6_3,!#'7\>?XK1)J-5H8CM/;5G1'AD3$YNZ[15"E>M<
MF]#6F6)G[2`?'C<911HPM,$2RXD3YW__N_LIVW"ML>@[M_D7@S(EV_`^UZ;O
MZ%*C*[_:]3#/[=I+\P5Z][N\\<S+U$UIB'U_(8Q,X18+W7>8ZV^>F+L;[#O#
MXY/KL_TA(8,!'*9"3?$2#0P&Q.3%K9@G>D^8=)XKUQ1"Z04:X<I\46VV5IQ2
M;L^0Q3X-HXI%-(@KR1+&1,`PH3SH1@$1"1:H9;HWT:XI%VZ"#R08I3'M,9_3
MB@=1-R1'P-PP]ET[^T"YQZA'8V!!G_?Z8;Q#>9]2N,]W[[X:L,.@0\D!_%_S
MAT3"NVP%9_MSTQG:":S*.%/"9+D"._:O8(9WXUP4B8;6%!46PF`"6Z6:J7RI
M0$NA9)[@%BQ0:S'%MDL^@$VT%Y*+GW4GG2<>A%!!R=M-'<PRFV?3U+BE7-IZ
M5$F1K1O?P.!9D++<R[HTX*YL<H^ISW@8L:CR;0MX%=-UVH))I`&;T.1AA?^J
MN.XCX[P7\HKWNEU:@_7(1VO47LP]>89[QKH!8[&EL.<'-84L_(4__B?^`N@$
M+\+?E9@AF!0!*=P4.+$X9LKD(*3,2V5@F:(">[,.-+=@JBG@RJ!*+(:635WS
M5C?D'#K%LAZ6GXO'>O,,'(^B"!@YK6=MK`]I3>ELJJP-6X@IU-*C4JVL21QI
M1/7)=A`\.#B]NAQ='`]'9^<?3SZ_(4<!HVNIYN(X3C:!ED%M1D(E(SE'48S&
MF6FU$F$$O`*ZBB=MJ*#51)@+N]/6:G<7XO;KWX1MM^';.HC?!/&;((ZCT?R;
G;FT];E3C1O6'9BWY)*G-WUJF*&>Z7`SB\3@<,Z3D.TE1K!X:!@``
`
end
