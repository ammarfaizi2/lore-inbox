Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317459AbSFHW3y>; Sat, 8 Jun 2002 18:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317467AbSFHW3x>; Sat, 8 Jun 2002 18:29:53 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:43999 "EHLO gin")
	by vger.kernel.org with ESMTP id <S317459AbSFHW3u>;
	Sat, 8 Jun 2002 18:29:50 -0400
Date: Sun, 9 Jun 2002 00:26:28 +0200
To: Svetoslav Slavtchev <galia@st-peter.stw.uni-erlangen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.20]newbee call for help getting lvm working
Message-ID: <20020608222628.GA10981@h55p111.delphi.afb.lu.se>
In-Reply-To: <3CFF9590.5030504@st-peter.stw.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Anders Gustafsson <andersg@0x63.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2002 at 07:02:08PM +0200, Svetoslav Slavtchev wrote:
> Hi ,
> i was trying to get the patch from Anders Gustafsson working in 2.5.20,
> but i'm getting  by compilation:
> ....
> lvm.c: In function `__update_hardsectsize':
> lvm.c:2021: warning: implicit declaration of function `get_hardsect_size'


[.. snip ..]

>    /* only perform this operation on active snapshots */
>    if ((lv->lv_access & LV_SNAPSHOT) &&
>        (lv->lv_status & LV_ACTIVE)) {
>        for (e = 0; e < lv->lv_remap_end; e++) {
>            hardsectsize =  get_hardsect_size( 
> lv->lv_block_exception[e].rdev_new);

snapshotting doesn't work anyhow, so this block could be removed 'til
its unbroked.

below is a patch that does this. it is rater untested though as i
havn't be able to run it for more than a few minutes because my
cardbus networkcard doesn't work in 2.5.20

-- 

//anders/g

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.405, 2002-06-03 00:44:52+02:00, andersg@heineken.0x63.nu
  forwardport of my lvm sanitation work to 2.5.19


 drivers/md/lvm.c    |   36 +++++++++++++++++++++++++++++-------
 include/linux/lvm.h |    2 +-
 2 files changed, 30 insertions(+), 8 deletions(-)


diff -Nru a/drivers/md/lvm.c b/drivers/md/lvm.c
--- a/drivers/md/lvm.c	Sun Jun  9 00:17:40 2002
+++ b/drivers/md/lvm.c	Sun Jun  9 00:17:40 2002
@@ -214,7 +214,8 @@
 
 #include <linux/hdreg.h>
 #include <linux/stat.h>
-#include <linux/fs.h>
+
+#include <linux/buffer_head.h>
 #include <linux/proc_fs.h>
 #include <linux/blkdev.h>
 #include <linux/genhd.h>
@@ -904,7 +905,7 @@
 		P_IOCTL("BLKFLSBUF\n");
 
 		fsync_bdev(inode->i_bdev);
-		invalidate_buffers(inode->i_rdev);
+		invalidate_bdev(inode->i_bdev,0);
 		break;
 
 	case HDIO_GETGEO:
@@ -2003,7 +2004,7 @@
 
 
 static void __update_hardsectsize(kern_lv_t *lv) {
-	int le, e;
+	int le; /*, e;*/
 	int max_hardsectsize = 0, hardsectsize;
 
 	for (le = 0; le < lv->lv_allocated_le; le++) {
@@ -2014,6 +2015,7 @@
 			max_hardsectsize = hardsectsize;
 	}
 
+#ifdef BROKEN /* snapshotting broken */
 	/* only perform this operation on active snapshots */
 	if ((lv->lv_access & LV_SNAPSHOT) &&
 	    (lv->lv_status & LV_ACTIVE)) {
@@ -2025,6 +2027,7 @@
 				max_hardsectsize = hardsectsize;
 		}
 	}
+#endif
 }
 
 /*
@@ -2371,8 +2374,14 @@
 
 	lv_ptr->lv_status &= ~LV_ACTIVE;
 
-	/* invalidate the buffers */
-	invalidate_buffers(lv_ptr->lv_kdev);
+	/* invalidate the buffers - FIXME! we might want the bdev in the lv */
+	{
+		struct block_device *bdev = bdget(kdev_t_to_nr(lv_ptr->lv_kdev));
+		if (bdev) {
+			invalidate_bdev(bdev,0);
+			bdput(bdev);
+		}
+	}
 
 	/* reset generic hd */
 	lvm_gendisk.part[minor(lv_ptr->lv_kdev)].start_sect = -1;
@@ -2946,9 +2955,22 @@
        if (copy_from_user(&pv_flush_req, arg,
                           sizeof(pv_flush_req)) != 0)
                return -EFAULT;
-       /* FIXME! find kern__pv and use that? */
+
+       /* FIXME! should we really be allowed to flush any device here? */
+
        fsync_dev(to_kdev_t(pv_flush_req.pv_dev)); 
-       invalidate_buffers(to_kdev_t(pv_flush_req.pv_dev));
+       
+       /* invalidate the buffers */
+       {
+	       struct block_device *bdev = bdget(pv_flush_req.pv_dev);
+	       if (bdev) {
+		       invalidate_bdev(bdev,0);
+		       bdput(bdev);
+	       }
+       }
+       
+//       fsync_dev(to_kdev_t(pv_flush_req.pv_dev)); 
+//       invalidate_buffers(to_kdev_t(pv_flush_req.pv_dev));
 
        return 0;
 }
diff -Nru a/include/linux/lvm.h b/include/linux/lvm.h
--- a/include/linux/lvm.h	Sun Jun  9 00:17:40 2002
+++ b/include/linux/lvm.h	Sun Jun  9 00:17:40 2002
@@ -405,7 +405,7 @@
 	uint pe_allocated;
 	uint pe_stale;		/* for future use */
 	pe_disk_t *pe;		/* HM */
-	struct block_device *bd;
+	void *bd; /* a struct block_device has nothing to do in userspace */
 	char pv_uuid[UUID_LEN+1];
 	uint32_t pe_start;	/* in sectors */
 } user_pv_t;

===================================================================


This BitKeeper patch contains the following changesets:
1.405
## Wrapped with gzip_uu ##


begin 664 bkpatch860
M'XL(`(2"`CT``[5676_;-A1]-G_%'?*2I+5$4A^6G#GKVF1;T&TM,A380P&#
M%JE(L"RZ$FTGF/K?=RFIB>O:,!:LLH$KB??CW,.C*YW`AUI5XX$HI:KJ.W("
MO^G:C`>9RDLU5Z5#[T//*5>X<*LU+KB97BBW=W?GJBI5X<[F[JS0FR%W`H*>
M[X5),EBCQWC`'._QCGE8JO'@]OK7#[__?$O(9`)O,E'>J;^4@<F$&%VM12'K
M5\)DA2X=4XFR7B@CG$0OFD?7AE/*\1>PD4>#L&$A]4=-PB1CPF=*4NY'H4]Z
MB*]V.]E-%%+&&?5HW#`61!ZY`N;X-`#*71JZU`-*Q[X_#O@+RL>4PJ&\\(+#
MD)+7\/^V\88DD.IJ(RJYU)4!G<+B`8KU`FI1YD:87)>PT=4<ZP+R[["8O`6&
MV3AY_\0O&?['@Q`J*+D\THVL<KO-[D*Z",E)MIKRT30T#L-1$RDA>1"H4>C+
MR&/!00X/Y,->./?Q:'P_#OE15'F9%"NIW"(O5_=MHFR;[=CW&LP81TVL5,I#
M01E+Z2P*U&%@!U,^86,1#;U6U;M='!?W\W@\K/']^0+N4>I%+&KH:.2Q5NH\
MWE6Z[Q]7>@S#T7>1>J46>JT@$4516T7G)1;(I3`*9JLT13P.RKN3P3L85IOV
MCW)]_PWKSY#\%6<C8.3&&DX^DI-^V^'';M\["-,,]\')+LE53%OWS@P&3V"G
M,ZG6IWFII1I>YNW52WIV@04H#=L*G<40`X6Z`/?\):B+<]>N,+MRDJ=2I?#Z
M]MW;ZS]Q&>I2+.M,&Y.7=S"K-&X(=/[<5C]1I<Q3+."-?,1^@S:`B`PP<HM#
MDSWR"$/XY>;O/ZY_@(V"17Z7&=@(1-.Z(%X,:\^+M2TS^`?[JTVU2@S@J$_F
M4W3)$P7GK>\$0^Z4.9WCQ=1,C9Z6U6FQGBY--;Q$:^^?8?_(40JG-N0,;,9O
M*'MD"M=F<KDRG;.]_DSP?\5C/VX)M-;#/8+NP#[[=I"D52%M5Y5"&3W`#)_K
M`E]/2EI%I<6JSE#;#]!WD*E*_61[_&BS!ZS+;BW_DGRKR`$R,;SWP;;ZL^-T
M+=?3%LZT4I\<O.A;[>._INK+S<.$]1Y?T];?_$QV3XCK]F=I_5`FMO8I[ENW
M@WN1G5UL!6WCZ#@X&MW.QCV#]/AX?/9`/SPA#Z9LAR3';X*&^9X7M$.2\6<,
M209#]EUFI-10:@/JOOT@V*<RG"H:5OAA5R]%HNS$[%Y..Q-S#P?/&9H^C>PS
MTYG!6N?2RMS.-!![X66BMAUD=I(A4&G'_!-<^RP]?C(FF4KF]6HQ2640TR@,
*R+\DG'SPL@H`````
`
end
