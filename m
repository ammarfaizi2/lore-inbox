Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263033AbSJGMzg>; Mon, 7 Oct 2002 08:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263034AbSJGMzg>; Mon, 7 Oct 2002 08:55:36 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:39041 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263033AbSJGMza>;
	Mon, 7 Oct 2002 08:55:30 -0400
Date: Mon, 7 Oct 2002 15:00:52 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stian Jordet <liste@jordet.nu>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Mouse/Keyboard problems with 2.5.38
Message-ID: <20021007150052.A1380@ucw.cz>
References: <1032996672.11642.6.camel@chevrolet> <20020926105853.A168142@ucw.cz> <1033039991.708.6.camel@chevrolet> <20020926133725.A8851@ucw.cz> <1033054211.587.6.camel@chevrolet> <20020926185717.B27676@ucw.cz> <1033080648.593.12.camel@chevrolet> <20020927091040.B1715@ucw.cz> <1033127503.589.6.camel@chevrolet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1033127503.589.6.camel@chevrolet>; from liste@jordet.nu on Fri, Sep 27, 2002 at 01:51:43PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 27, 2002 at 01:51:43PM +0200, Stian Jordet wrote:
> fre, 2002-09-27 kl. 09:10 skrev Vojtech Pavlik:
> > Unfortunately the little bit of information I needed scrolled away
> > already. Can you try with the other shift (right?)? That won't
> > probably crash your machine, but will most likely generate an "Unknown
> > scancode" message. Again, send me the log lines. This time they should
> > make it in the syslog well.
> Ok, the combination which freezes the computer is right SHIFT, and
> pageup/down, etc. Left SHIFT works just like expected. This time I first
> wrote 'cp /var/log/syslog /tmp/syslog', then 'echo cut-here >
> /var/log/syslog' Left-SHIFT+PAGEUP, arrow up two times, to get the cp..,
> enter. Then I edited /tmp/syslog and copied only what was after
> "cut-here". So the keystrokes included here should be Left-SHIFT+PAGEUP,
> ARROW-UP, ARROW-UP, ENTER. If this works like I think it should. As you
> can see, it did not generate an "Unknown scancode"...

Can you test whether the attached patch helps?

-- 
Vojtech Pavlik
SuSE Labs

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=alt-alt

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.626, 2002-10-07 14:29:57+02:00, vojtech@suse.cz
  Fix LAlt-RAlt combination on AT keyboards (generated "unknown scancode" message).


 i8042.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Mon Oct  7 14:30:14 2002
+++ b/drivers/input/serio/i8042.c	Mon Oct  7 14:30:14 2002
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
+
## Wrapped with gzip_uu ##


begin 664 bkpatch491
M'XL(`%9^H3T``[64;6_3,!#'7\>?XK1)J-5H8CM/;5G1'AD3$YNZ[15"E>M<
MF]#6F6)G[2`?'C<911HPM,$2RXD3YW__N_LIVW"ML>@[M_D7@S(EV_`^UZ;O
MZ%*C*[_:]3#/[=I+\P5Z][N\\<S+U$UIB'U_(8Q,X18+W7>8ZV^>F+L;[#O#
MXY/KL_TA(8,!'*9"3?$2#0P&Q.3%K9@G>D^8=)XKUQ1"Z04:X<I\46VV5IQ2
M;L^0Q3X-HXI%-(@KR1+&1,`PH3SH1@$1"1:H9;HWT:XI%VZ"#R08I3'M,9_3
MB@=1-R1'P-R(1T"YQZA'8V!!G_?Z8;Q#>9]2N$]U[[X0L,.@0\D!_%_?AT3"
MNVP%9_MSTQG:":S*.%/"9+D"._:O8(9WXUP4B8;6%!46PF`"6Z6:J7RI0$NA
M9)[@%BQ0:S'%MDL^@,VQ%Y*+GR4GG2<>A%!!R=M-'<PRFV?3U+BE7-IZ5$F1
MK7O><.!9AK+<R[HTX*YL<H^ISW@8L:CR;?5Y%=-UVH))I`&;T.1AA?^JN&XA
MX[P7\HKWNEU:,_7(1VO*7LP]>89[QKH!8[$%L.<'-8`L_(4__B?^`N@$+\+?
ME9@AF!0!*=P4.+$X9LKD(*3,2V5@F:(">[,.-+=@JBG@RJ!*+(:635WS5C?D
M'#K%LAZ6GXO'>O,,'(^B"!@YK6=MK`]I3>ELJJP-6X@IU-*C4JVL21QI1/7)
M=A`\.#B]NAQ='`]'9^<?3SZ_(4<!HVNIYN(X3C:!ED%M1D(E(SE'48S&F6FU
M$F$$O`*ZBB=MJ*#51)@+N]/6:G<7XO;KWX1MM^';.HC?!/&;((ZCT?R;;FT]
D;E3C1O6'9BWY)*G-CUJF*&>Z7`RZ22S'%`7Y#N\0[,\5!@``
`
end

--82I3+IH0IqGh5yIs--
