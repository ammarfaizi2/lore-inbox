Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312332AbSCUBLE>; Wed, 20 Mar 2002 20:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312333AbSCUBKz>; Wed, 20 Mar 2002 20:10:55 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:5895 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S312332AbSCUBKg>; Wed, 20 Mar 2002 20:10:36 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 21 Mar 2002 01:27:08 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Eyal Lebedinsky <eyal@eyal.emu.id.au>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre4: zr36067.c needs update?
Message-ID: <20020321012708.A9177@bytesex.org>
In-Reply-To: <E16nq2a-0003l4-00@the-village.bc.nu> <Pine.LNX.4.21.0203201944010.9234-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 07:44:27PM -0300, Marcelo Tosatti wrote:
> 
> Geert, 
> 
> Is the new API really backwards compatible ? ;)
> 
> > > /data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h 
> > > -DKBUILD_BASENAME=zr36067  -c -o zr36067.o zr36067.c
> > > zr36067.c: In function `zoran_open':
> > > zr36067.c:3268: structure has no member named `busy'

The drivers shouldn't touch video_device->busy, videodev.c uses this
internally.  I have noticed too late that the zoran driver tampers with
that field (stradis too).  Driver fixes below.

  Gerd

==============================[ cut here ]==============================
ChangeSet
  1.222 02/03/20 10:30:03 kraxel@bytesex.org +1 -0
  fix compile error due to recent videodev changes
  use name-based initialization for struct video_device

  drivers/media/video/zr36067.c
    1.7 02/03/20 10:30:00 kraxel@bytesex.org +17 -17
    fix compile error due to recent videodev changes
    use name-based initialization for struct video_device

======================================================================
 zr36067.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff -Nru a/drivers/media/video/zr36067.c b/drivers/media/video/zr36067.c
--- a/drivers/media/video/zr36067.c	Wed Mar 20 10:42:19 2002
+++ b/drivers/media/video/zr36067.c	Wed Mar 20 10:42:19 2002
@@ -3265,7 +3265,10 @@
 
 			btwrite(IRQ_MASK, ZR36057_ISR);	// Clears interrupts
 			btor(ZR36057_ICR_IntPinEn, ZR36057_ICR);
-			dev->busy = 0;	/* Allow second open */
+			/* FIXME: Don't do it this way, use the
+			 * video_device->fops registration for a sane
+			 * implementation of multiple opens */
+			dev->users--;	/* Allow second open */
 		}
 
 		break;
@@ -3323,6 +3326,7 @@
 		}
 	}
 
+	dev->users++;
 	zr->user--;
 
 	MOD_DEC_USE_COUNT;
@@ -4397,22 +4401,18 @@
 }
 
 static struct video_device zoran_template = {
-	THIS_MODULE,
-	ZORAN_NAME,
-	VID_TYPE_CAPTURE | VID_TYPE_OVERLAY | VID_TYPE_CLIPPING |
-	    VID_TYPE_FRAMERAM | VID_TYPE_SCALES | VID_TYPE_SUBCAPTURE,
-	ZORAN_HARDWARE,
-	zoran_open,
-	zoran_close,
-	zoran_read,
-	zoran_write,
-	NULL,
-	zoran_ioctl,
-	zoran_mmap,
-	zoran_init_done,
-	NULL,
-	0,
-	0
+	owner:		THIS_MODULE,
+	name:		ZORAN_NAME,
+	type:		VID_TYPE_CAPTURE | VID_TYPE_OVERLAY | VID_TYPE_CLIPPING |
+			VID_TYPE_FRAMERAM | VID_TYPE_SCALES | VID_TYPE_SUBCAPTURE,
+	hardware:	ZORAN_HARDWARE,
+	open:		zoran_open,
+	close:		zoran_close,
+	read:		zoran_read,
+	write:		zoran_write,
+	ioctl:		zoran_ioctl,
+	mmap:		zoran_mmap,
+	initialize:	zoran_init_done,
 };
 
 /*
======================================================================
This BitKeeper patch contains the following changesets:
1.222
## Wrapped with gzip_uu ##


begin 664 bkpatch7937
M'XL(`'M9F#P``]5576_:2A!]]OZ*D?I0*:GQ[MI@2D54!VB#2A)$0GM[7]#&
M7L(JMA>M%T@B__B.3>JD'XIZ;WL?+F"C.3MS]NS,D?T"YH4T/>?&B%N9DA=P
MH@O;<Z[NK"SD;4N;:\1F6B/F[;2Y\8X_>-L@=7DK(+@R%39>P5::HN>PEM\@
M]FXM>\YL]'X^B6:$]/LP6(G\6EY("_T^L=IL19H4;X5=I3IO62/R(I-6M&*=
ME4UJR2GE^&VST*?M3LDZ-`C+F"6,B8#)A/*@VPG(7OO;)YJ_I_#Q_IJ'O%O2
M@'48&0)K<<Z!<H_Z'J?`:,^G/>H?4M:C%'YDA$,&+B7'\&>E#T@,2W4+6+M6
MJ01IC#:0;"3N`T;&,K>P58G4B=Q"7),76+(I).0BD^Z5*&0"*E=6B53="ZMT
M#DND**S9Q`^U"RQ6L20?P/>[C$P?9T'<?_@AA`I*CF!=3?GG+4B,JOS@93)1
MPJL%>/?&[]!.V(H?V_*:49^5`>_2L!1)EUZUV?)*^-V0A3]I_Z^PUD/V*:7(
MZK-V[;IGRRHG_J<'^7UVSOV0=4L><-:I71O^X%GZG&=#<%'&_]RU^W&>@VMV
M]0]M.'U^LO_"UT.?=[K`R+C^#XCC.-X!O!O_=3KJP5#G+RTD&I0%NU(%[,3=
MJ_H\=B6K5#CX1K1[M-3K`EMQK?!(C^<34(C\:X'*UJG,L%?[=;V$;)-:A2#H
MM<P+./"J3&1TCW`K4[CNFTI3E*9Z!X6,=9[4F57BV/=Y&^4_23\\?$.&08#6
M0.^,@X#A.B>.WN75`]^Y/!E?+$[/A_/)Z!5QJKD@^/?Y+#I;G$6G%;9_B#L?
MQ\/%Y>?I:#&(II?SV0A*:*#SCZ/9)/K\%!I,QM/I^.P]E)7Z!GXW0U*\GJ9>
M#*+)Z.(;9'[\L`ONOQ(FV0F#&O:R3J+9\%-4+U7'1FGW&GV\J`+$XE07L@'K
M"%$C1=*`58#8SBC[F%E'B"H=V[1!ZPC1+!/K!JR"*O.K<Y'D(1N11:)SY&G>
8@?%*QC?%)NMS&B=HJI!\`9O)!LEM!P``
`
end
==============================[ cut here ]==============================
ChangeSet
  1.221 02/03/20 10:27:28 kraxel@bytesex.org +1 -0
  fix compile error due to recent videodev changes

  drivers/media/video/stradis.c
    1.9 02/03/20 10:27:14 kraxel@bytesex.org +4 -2
    fix compile error due to recent videodev changes

======================================================================
 stradis.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -Nru a/drivers/media/video/stradis.c b/drivers/media/video/stradis.c
--- a/drivers/media/video/stradis.c	Wed Mar 20 10:42:05 2002
+++ b/drivers/media/video/stradis.c	Wed Mar 20 10:42:05 2002
@@ -1972,7 +1972,9 @@
 {
 	struct saa7146 *saa = (struct saa7146 *) dev;
 
-	saa->video_dev.busy = 0;
+	/* FIXME: Don't do it this way, use the video_device->fops
+	 * registration for a sane implementation of multiple opens */
+	saa->video_dev.users--;
 	saa->user++;
 	if (saa->user > 1)
 		return 0;	/* device open already, don't reset */
@@ -1984,7 +1986,7 @@
 {
 	struct saa7146 *saa = (struct saa7146 *) dev;
 	saa->user--;
-	saa->video_dev.busy = 0;
+	saa->video_dev.users++;
 	if (saa->user > 0)	/* still someone using device */
 		return;
 	saawrite(0x007f0000, SAA7146_MC1);	/* stop all overlay dma */
======================================================================
This BitKeeper patch contains the following changesets:
1.221
## Wrapped with gzip_uu ##


begin 664 bkpatch7802
M'XL(`&U9F#P``\U476O;,!1]MG[%A3X,FMG65^+8):7KQ[;2C86,PMZ&:M\T
MHK85)"5MP3]^B@-I*:7=1Q]F&\E<71V=<^]!>W#IT!;1C55W6),]^&R<+Z*K
M>X\.[Q)CKT-L9DR(I;?&WJ3'%^E:UC%/)`DK4^7+!:S1NB)BB=A%_/T2BVAV
M]NGRRX<9(9,)G"Q4>XW?T<-D0KRQ:U57[DCY16W:Q%O5N@:]2DK3=+O4CE/*
MPSMDF:##4<=&5&9=R2K&E&1842['(TF6:E6OW)%3S97:,'X*(%C.PP^5'94Y
MD^046,(Y`\I3*E).@=&"9P4?#R@K*(5M+8X>U0`&#&)*CN%MB9^0$N;Z#L+>
MI:X1T%ICH5IA.`<LEMAZ6.L*385K*'MP1RY`LA$CTX>*DO@/'T*HHN3P%365
MU9O&I@U66J4]C]2%E$J[I'RD4%*6=X*.AJ++<R[&\RQ30YJ-\VSX3"E_!U:$
M,><9DYT4.66]?U[<]KJGWD!,\%FP]K_`;P9&.R%HOG5A_M2#3+[@00DQ_V\\
MV#?F&\3VMO^"J:8O]^@O7'K*-AYBY+R?!8G2??AX_N/K60&GIGWGH3*@/?B%
M=G"K[M_#R@7:"]P2_AD8ZQ+CP[E9.A+!?I!SK3=\O#8MS(-,!4ZU"+I9UM@$
MI=L5,X=F57L=@F"6V#K83TGDE(H/=\!).,JZ.#[8D!QG6Y+]_&SB8'#P<%V6
6"RQOW*J9X%#Q7,X%^05"WR=AA@4`````
`
end
