Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263190AbSJHNrZ>; Tue, 8 Oct 2002 09:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263162AbSJHNqA>; Tue, 8 Oct 2002 09:46:00 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:54164 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263178AbSJHNpP>;
	Tue, 8 Oct 2002 09:45:15 -0400
Date: Tue, 8 Oct 2002 15:50:45 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Fixes/cleanups after lists.h conversion [13/23]
Message-ID: <20021008155045.L18546@ucw.cz>
References: <20021008154029.B18546@ucw.cz> <20021008154132.C18546@ucw.cz> <20021008154246.D18546@ucw.cz> <20021008154415.E18546@ucw.cz> <20021008154549.F18546@ucw.cz> <20021008154631.G18546@ucw.cz> <20021008154733.H18546@ucw.cz> <20021008154824.I18546@ucw.cz> <20021008154904.J18546@ucw.cz> <20021008155003.K18546@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008155003.K18546@ucw.cz>; from vojtech@suse.cz on Tue, Oct 08, 2002 at 03:50:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.573.1.45, 2002-09-26 22:41:27+02:00, vojtech@suse.cz
  Fixes/cleanups after converting drivers to list.h lists.


 input.c          |    4 ++--
 keyboard/atkbd.c |    3 ++-
 mousedev.c       |   22 ++++++++++------------
 3 files changed, 14 insertions(+), 15 deletions(-)

===================================================================

diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Tue Oct  8 15:26:14 2002
+++ b/drivers/input/input.c	Tue Oct  8 15:26:14 2002
@@ -411,7 +411,7 @@
 	dev->rep[REP_PERIOD] = HZ/33;
 
 	INIT_LIST_HEAD(&dev->h_list);
-	list_add_tail(&dev->node,&input_dev_list);
+	list_add_tail(&dev->node, &input_dev_list);
 
 	list_for_each_entry(handler, &input_handler_list, node)
 		if ((id = input_match_device(handler->id_table, dev)))
@@ -471,7 +471,7 @@
 	if (handler->fops != NULL)
 		input_table[handler->minor >> 5] = handler;
 
-	list_add_tail(&handler->node,&input_handler_list);
+	list_add_tail(&handler->node, &input_handler_list);
 	
 	list_for_each_entry(dev, &input_dev_list, node)
 		if ((id = input_match_device(handler->id_table, dev)))
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Tue Oct  8 15:26:14 2002
+++ b/drivers/input/keyboard/atkbd.c	Tue Oct  8 15:26:14 2002
@@ -332,7 +332,8 @@
  * Try to set the set we want.
  */
 
-	if (atkbd_command(atkbd, &atkbd_set, ATKBD_CMD_SSCANSET))
+	param[0] = atkbd_set;
+	if (atkbd_command(atkbd, param, ATKBD_CMD_SSCANSET))
 		return 2;
 
 /*
diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	Tue Oct  8 15:26:14 2002
+++ b/drivers/input/mousedev.c	Tue Oct  8 15:26:14 2002
@@ -215,6 +215,8 @@
 static int mousedev_open(struct inode * inode, struct file * file)
 {
 	struct mousedev_list *list;
+	struct input_handle *handle;
+	struct mousedev *mousedev;
 	int i;
 
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
@@ -237,19 +239,14 @@
 
 	if (!list->mousedev->open++) {
 		if (list->mousedev->minor == MOUSEDEV_MIX) {
-			struct list_head * node;
-			list_for_each(node,&mousedev_handler.h_list) {
-				struct input_handle *handle = to_handle_h(node);
-				struct mousedev *mousedev = handle->private;
-				if (!mousedev->open)
-					if (mousedev->exist)	
-						input_open_device(handle);
+			list_for_each_entry(handle, &mousedev_handler.h_list, h_node) {
+				mousedev = handle->private;
+				if (!mousedev->open && mousedev->exist)	
+					input_open_device(handle);
 			}
-		} else {
-			if (!mousedev_mix.open)
-				if (list->mousedev->exist)	
-					input_open_device(&list->mousedev->handle);
-		}
+		} else 
+			if (!mousedev_mix.open && list->mousedev->exist)	
+				input_open_device(&list->mousedev->handle);
 	}
 
 	return 0;
@@ -496,6 +493,7 @@
 	input_register_handler(&mousedev_handler);
 
 	memset(&mousedev_mix, 0, sizeof(struct mousedev));
+	INIT_LIST_HEAD(&mousedev_mix.list);
 	init_waitqueue_head(&mousedev_mix.wait);
 	mousedev_table[MOUSEDEV_MIX] = &mousedev_mix;
 	mousedev_mix.exist = 1;

===================================================================

This BitKeeper patch contains the following changesets:
1.573.1.45
## Wrapped with gzip_uu ##


begin 664 bkpatch18125
M'XL(`/;<HCT``[56:7/;-A#]3/Z*[61&E1*+PL5+&7GB2$ZCR5&/[7SJ=#@0
M`9FL)5)#0CY2]K\'!'74\A6[-:41!&"Q^[!X;\%7\*V41=^ZR/]2,D[L5_`Q
M+U7?*I>E=.+ONG^<Y[K?2_*Y[*VL>I/S7IHMELK6\T=<Q0E<R*+L6]BAFQ%U
MO9!]Z_CPMV^?#XYM>S"`8<*S,WDB%0P&MLJ+"SX3Y3NNDEF>.:K@63F7BCMQ
M/J\VIA5!B.B/BWV*7*_"'F)^%6.!,6=8"D18X#%[!>S="O;N^I!XV,<N=2OD
MN6%@CP`[KD\=[#`7$.FAL$<\(*3/<)_X;Q#I(P0[/N$-A2ZRW\/_BWQHQ_`A
MO9)E+YY)GBT7)?"ID@7$>::3JM+L#$21UOG5D6&6ELI)3%,Z]B?P7"^PC[:I
MM;M/?&P;<63O;W:K+M-9>I8H9QE?UIE<Q6[.NW<NKR<Y+T2/J_.)<.)FDSZB
MF**`H0J'`<;59")"29`4F'JA3W<S^5,^]9$1Q#"A%='Y8QKAPWF_Z7.>ZU!"
M7JR]F6-@NJD\&C)2Q9Q..7$91]@EDPE_!.*NNRTXBG3GB>#,[QW(F!>Z%1$!
M)4),?1$@+*?X$60W?&UA(1+XGA'=G>:/"_`_(+XEQ@<1NQ@1BDF-&!,C3$)O
M29+>)TD"7?(BDCP0`LH%C^56CO,Y-Y(SJ?T=NL6E^6H)'=V=Y6=H<<0P`VR/
MF\:J91YQ(2+%TUF[I1G8W<]R(?>@96)$>B2JC3IO]5*_6>K?M52G0,QDL;-\
M-;IV<9LO6^(_E3)/5>`CK+FM0!>[B+E!14**?$,<'/P\<3""+GX9Z@R;.FYJ
M-*2:.URE>;8'^C!@GI9E7='3+%5\EGXW4Y!/MP6]*2@/TFN;BV<P;$RP#\2V
M2E4L8XWO7SR`UTW[=C.[C@2OU_\TSPA#X&L_S`-F6U;#M&E>1)+'220S55RW
M&T>:9^MU:ZHYB2';'B11S<0._%V[L#:!!M`8=O<7>L]<U6#TDTZA_<O:J+N?
M+V0&K19L1^1536'+&%O-IFJC6B!I+%=X.@9]`*Y&[Q*@VOH?D+-2@KT;(YJG
M5\XZ3(VXNW]WL-NQ6KOFF^!C%@:U-L=?QZ?1Y_'):?3Q\&#4;MT(>J\6=^_)
M6I$O>&L_(LC[;FV&/18PKR)NP,)&EMZ3ZCE^$5&.\NQ7!0M>ZGJ>:=8K:!O@
M42E5![@>A3CA!;07O.`ZDJ[X6I6-B2G]F6AW.J;\F]>1!P6ZFYOG7`24NG4U
MKQNM5H/J#_2GUL<&ME9&3=F;&$UO#XS]'AR<?GH_BH9?1M')R?#@Z\GA::>S
:?6>/$QF?E\OY8!(*%$X\8?\`D1_PQPX,````
`
end
