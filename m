Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbTAJJWL>; Fri, 10 Jan 2003 04:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264842AbTAJJWL>; Fri, 10 Jan 2003 04:22:11 -0500
Received: from fmr05.intel.com ([134.134.136.6]:12029 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S264838AbTAJJWJ>; Fri, 10 Jan 2003 04:22:09 -0500
Message-ID: <32860.172.16.219.159.1042191045.squirrel@linux.intel.com>
Date: Fri, 10 Jan 2003 01:30:45 -0800 (PST)
Subject: [Bug fix] delete kobject from list when kobject_add() fail
From: <louis.zhuang@linux.co.intel.com>
To: <mochel@osdl.org>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mochel,
	I found there were still issues in failed kobject_add(). For example,
if you try to register two kobjects with the same name into
subsystem, the second registration will fail but the second will keep in
the list of subsystem. Below patch might fix the bug. Please  apply.

Yours truly,
Louis Zhuang
---------------
Fault Injection Test Harness Project
BK tree: http://fault-injection.bkbits.net/linux-2.5
Home Page: http://sf.net/projects/fault-injection

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.944, 2003-01-10 16:45:01+08:00, louis@hawk.sh.intel.com
  delete kobject from list when kobject_add() fail.
    caller have no way to clean the list, so
    kobjec_add() should remove kobject from list.


 kobject.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)


diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	Fri Jan 10 16:48:01 2003
+++ b/lib/kobject.c	Fri Jan 10 16:48:01 2003
@@ -66,6 +66,18 @@
 	return container_of(entry,struct kobject,entry);
 }

+static inline void __kobject_del(struct kobject * kobj)
+{
+	if (kobj->kset) {
+		down_write(&kobj->kset->subsys->rwsem);
+		list_del_init(&kobj->entry);
+		up_write(&kobj->kset->subsys->rwsem);
+	}
+	if (kobj->parent)
+		kobject_put(kobj->parent);
+	kobject_put(kobj);
+}
+

 /**
  *	kobject_init - initialize object.
@@ -109,8 +121,8 @@
 		up_write(&kobj->kset->subsys->rwsem);
 	}
 	error = create_dir(kobj);
-	if (error && parent)
-		kobject_put(parent);
+	if (error)
+		__kobject_del(kobj);
 	return error;
 }

@@ -132,6 +144,7 @@
 	return error;
 }

+
 /**
  *	kobject_del - unlink kobject from hierarchy.
  * 	@kobj:	object.
@@ -140,14 +153,7 @@
 void kobject_del(struct kobject * kobj)
 {
 	sysfs_remove_dir(kobj);
-	if (kobj->kset) {
-		down_write(&kobj->kset->subsys->rwsem);
-		list_del_init(&kobj->entry);
-		up_write(&kobj->kset->subsys->rwsem);
-	}
-	if (kobj->parent)
-		kobject_put(kobj->parent);
-	kobject_put(kobj);
+	__kobject_del(kobj);
 }

 /**

===================================================================


This BitKeeper patch contains the following changesets:
1.944
## Wrapped with gzip_uu ##


begin 664 bkpatch20054
M'XL(`,&('CX``^5576_3,!1]KG_%E2:AEI'T.H[;-%.KP89@`HEI:&](E9<X
M2V@:5[;3JB+[[[CINE$V&*"]D41*['ONN5\GR0%<&JGC3JGJPI`#>*^,C3NY
M6,U\D_M%967I)VKN+!=*.4L_5W/9;]']P.>>69O,$&<^%S;)82FUB3O49W<[
M=KV0<>?B[;O+CZ\O"!F/X207U;7\+"V,Q\0JO11E:HZ%S4M5^5:+RLRE%9NH
MS1VT"1`#=W(Z9,@'#1U@.&P2FE(J0BI3#,)H$-ZS+61U71>_I6-(<10P&@78
MA!PQ(J=`_5$8`K(^TCY%H(,XY#'20XQB1&BK/G[0&SBDX"%Y`\];RPE)()6E
MM!)FZNJK3"QDVD4K"V-AE<MJMST5:=KM02:*TG<^`(DH2ZDA%TL)E8*56+O4
M("FEJ,#FLF5X!49!B]ZRW)*87-5E"EK.U?*1N#X`^0`A'[K\SN\'2;R_/`A!
M@60"<Y7DLCQ6)BU]I:^;LKCJWP;UD[9/U,T)*1UAV"`?<=:P(,MH@$)@%&'*
MLU]-Y2&7&SAU8PX9QX;3$0];->[!-HI\AIR>YMB(;X@L0#9RXF,CUHJ/\GWM
ML9CCD]H;@$?_)_5M1_<)/+UJ+Z>F\_TI_H,<SP81T(`8*VR10%&5125AJ8H4
MIM-=H:X=76-U[5+:I?:R?>J1;Z139-#=++S)S$C;`[?52=6JFJYT867WQ;W-
MFYCZRGTWO8E>&3GO'3GDIKQ-@&E1%78'EI75Z]9<+_Z(YN;'-!9".X(>./==
M!8O:[AN=S\^VWE&'W)`OY)32``)R1BESMY97:JUTS_'M]V3KY9`L!-IZA@PB
AM^9.Q>1Q\-WOP;TGR<S4\[$(Y"#-$D:^`R/H1DJ2!@``
`
end



