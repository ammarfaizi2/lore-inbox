Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261536AbSJIKzB>; Wed, 9 Oct 2002 06:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261541AbSJIKzB>; Wed, 9 Oct 2002 06:55:01 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:5760 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261536AbSJIKy6>;
	Wed, 9 Oct 2002 06:54:58 -0400
Date: Wed, 9 Oct 2002 13:00:35 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Input - Fix oops caused by cat /dev/uinput [1/3]
Message-ID: <20021009130035.A367@ucw.cz>
References: <20021009101256.A10748@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021009101256.A10748@ucw.cz>; from vojtech@suse.cz on Wed, Oct 09, 2002 at 10:12:56AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.718, 2002-10-09 12:12:55+02:00, vojtech@suse.cz
  Fix oops when 'cat /dev/uinput' is done. Used wait_event_interruptible().


 uinput.c |   38 ++++++++++----------------------------
 1 files changed, 10 insertions(+), 28 deletions(-)

===================================================================

diff -Nru a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
--- a/drivers/input/misc/uinput.c	Wed Oct  9 13:00:13 2002
+++ b/drivers/input/misc/uinput.c	Wed Oct  9 13:00:13 2002
@@ -218,43 +218,25 @@
 
 static ssize_t uinput_read(struct file *file, char *buffer, size_t count, loff_t *ppos)
 {
-	struct uinput_device	*udev;
+	struct uinput_device *udev = file->private_data;
 	int retval = 0;
-	DECLARE_WAITQUEUE(waitq, current);
 
-	udev = (struct uinput_device *)file->private_data;
+	if (udev->head == udev->tail && (udev->state & UIST_CREATED) && (file->f_flags & O_NONBLOCK))
+		return -EAGAIN;
 
-	if (udev->head == udev->tail) {
-		add_wait_queue(&udev->waitq, &waitq);
-		current->state = TASK_INTERRUPTIBLE;
-
-		while (udev->head == udev->tail) {
-			if (!(udev->state & UIST_CREATED)) {
-				retval = -ENODEV;
-				break;
-			}
-			if (file->f_flags & O_NONBLOCK) {
-				retval = -EAGAIN;
-				break;
-			}
-			if (signal_pending(current)) {
-				retval = -ERESTARTSYS;
-				break;
-			}
-			schedule();
-		}
-		current->state = TASK_RUNNING;
-		remove_wait_queue(&udev->waitq, &waitq);
-	}
+	retval = wait_event_interruptible(udev->waitq,
+		udev->head != udev->tail && (udev->state & UIST_CREATED));
 
 	if (retval)
 		return retval;
 
+	if (!(udev->state & UIST_CREATED))
+		return -ENODEV;
+
 	while (udev->head != udev->tail && retval + sizeof(struct uinput_device) <= count) {
 		if (copy_to_user(buffer + retval, &(udev->buff[udev->tail]),
-		    sizeof(struct input_event)))
-			return -EFAULT;
-		udev->tail = (udev->tail + 1)%(UINPUT_BUFFER_SIZE - 1);
+		    sizeof(struct input_event))) return -EFAULT;
+		udev->tail = (udev->tail + 1) % (UINPUT_BUFFER_SIZE - 1);
 		retval += sizeof(struct input_event);
 	}
 

===================================================================

This BitKeeper patch contains the following changesets:
1.718
## Wrapped with gzip_uu ##


begin 664 bkpatch453
M'XL(`#T,I#T``[65[T_:0!C'7_?^BL>8J9VCW%U[E!_!B(J.:(`@[,6RI#G;
MPW9"R]HK;*9__*XMHL/HXC)+D_9X[OD^GWN>+V$7)HF(F]HR^BZ%ZZ-=^!PE
MLJDE:2(,]UZM1U&DUE4_FHOJ>E?UYJX:A(M4(A4?<NGZL!1QTM2(86Z^D;\6
MHJF-NA>3J\X(H78;3GT>WHIK(:'=1C**EWSF)<=<^K,H-&3,PV0N)#?<:)YM
MMF848ZH^C-@F9K6,U+!E9R[Q".$6$1ZF5KUFH378\1I[*Y]@W,`V4:\9MED#
MHS,@ADWJ@&F5X"IN`*%-=3-VB&D38]B2@T,"%8Q.X/]"GR(7SH.?$$6+!%:^
M"&'?Y1*JGEA6TZ*_^Q`DX$6A,/(Q>;#B@73$4H32"4(IXCA=R.!F)@YT`UV"
MS>P&&CZV&57>>"&$.49'F^/+53`+;GUII.XJ[ZH7!_F<R]FO$0VW/*U-3$(L
M8M4RDUBVF7F<,8)YPW9YK4:9V.[IEM@\2-P_%?.A$4PH(QFCK&$6%GHE*3?5
M>X`_\];?P'%=,9N$49S5J-6P"[?5GGF-O.@U#!5:?U^W*9MM62TW4-GG`53B
M57$K1PQ?:_D_&.R,4@($]<J'EL@X=264@HZB"5P!'U/U`FV8!C-1.5JH^EP*
MQ^.2M_)\4R6J!RME&%"D!5,XR),J1[[@GG("E"O)@QGL[3T$$ZF$8`\FO>NQ
M<SKJ=L;=,[V(EZ6FSG3&;Q.U8^#T!_V3J\'II:XC38N%3.,0*MW.1:?7+RAL
MH%35M^IY?157DU+(+_Y`2X`\_..3$GP"N_,66+VE:C(*9GGFG5?W/@7O#\ZZ
M7UKHFT)G3*4K%3LGUT!=27`OHNG!>ACE+(I#Z+H.&XGSSN1JW-K`%[CM!]IB
M=0A$AP]P,.GUAY.Q<S(Y/^^.G.O>URY45*CU^'?A^L*]2])YVVQ8PK,X0[\!
()SK&`HD&````
`
end
