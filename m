Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbSJ3TvQ>; Wed, 30 Oct 2002 14:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264881AbSJ3TvI>; Wed, 30 Oct 2002 14:51:08 -0500
Received: from smtp2.us.dell.com ([143.166.85.133]:22760 "EHLO
	smtp2.us.dell.com") by vger.kernel.org with ESMTP
	id <S264838AbSJ3TuJ>; Wed, 30 Oct 2002 14:50:09 -0500
Date: Wed, 30 Oct 2002 13:56:33 -0600 (CST)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH 2.5.44] EDD updates 3/4
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D68BC03E6@AUSXMPC122.aus.amer.dell.com>
Message-ID: <Pine.LNX.4.44.0210301356050.27031-100000@humbolt.us.dell.com>
X-GPG-Fingerprint: 17A4 17D0 81F5 4B5F DB1C  AEF8 21AB EEF7 92F0 FC09
X-GPG-Key: http://domsch.com/mdomsch_pub.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.812, 2002-10-24 16:22:00-05:00, Matt_Domsch@dell.com
  EDD: moved attr_test to edd_attribute ->test(), comments


 edd.c |   85 ++++++++++++++++++++++++++++--------------------------------------
 1 files changed, 37 insertions, 48 deletions


diff -Nru a/arch/i386/kernel/edd.c b/arch/i386/kernel/edd.c
--- a/arch/i386/kernel/edd.c	Thu Oct 24 16:22:38 2002
+++ b/arch/i386/kernel/edd.c	Thu Oct 24 16:22:38 2002
@@ -26,9 +26,6 @@
 
 /*
  * Known issues:
- * - module unload leaves directories around if a symlink was
- *   created in that directory.  Confirmed is a driverfs bug, not
- *   ours.  Seen on kernel 2.5.41.
  * - refcounting of struct device objects could be improved.
  *
  * TODO:
@@ -60,7 +57,7 @@
 MODULE_DESCRIPTION("driverfs interface to BIOS EDD information");
 MODULE_LICENSE("GPL");
 
-#define EDD_VERSION "0.06 2002-Oct-09"
+#define EDD_VERSION "0.07 2002-Oct-24"
 #define EDD_DEVICE_NAME_SIZE 16
 #define REPORT_URL "http://domsch.com/linux/edd30/results.html"
 
@@ -86,6 +83,7 @@
 	struct attribute attr;
 	ssize_t(*show) (struct edd_device * edev, char *buf, size_t count,
 			loff_t off);
+	int (*test) (struct edd_device * edev);
 };
 
 /* forward declarations */
@@ -95,10 +93,11 @@
 
 static struct edd_device *edd_devices[EDDMAXNR];
 
-#define EDD_DEVICE_ATTR(_name,_mode,_show) \
+#define EDD_DEVICE_ATTR(_name,_mode,_show,_test) \
 struct edd_attribute edd_attr_##_name = { 	\
 	.attr = {.name = __stringify(_name), .mode = _mode },	\
 	.show	= _show,				\
+	.test	= _test,				\
 };
 
 static inline struct edd_info *
@@ -505,17 +504,6 @@
 	return (p - buf);
 }
 
-static EDD_DEVICE_ATTR(raw_data, 0444, edd_show_raw_data);
-static EDD_DEVICE_ATTR(version, 0444, edd_show_version);
-static EDD_DEVICE_ATTR(extensions, 0444, edd_show_extensions);
-static EDD_DEVICE_ATTR(info_flags, 0444, edd_show_info_flags);
-static EDD_DEVICE_ATTR(default_cylinders, 0444, edd_show_default_cylinders);
-static EDD_DEVICE_ATTR(default_heads, 0444, edd_show_default_heads);
-static EDD_DEVICE_ATTR(default_sectors_per_track, 0444,
-		       edd_show_default_sectors_per_track);
-static EDD_DEVICE_ATTR(sectors, 0444, edd_show_sectors);
-static EDD_DEVICE_ATTR(interface, 0444, edd_show_interface);
-static EDD_DEVICE_ATTR(host_bus, 0444, edd_show_host_bus);
 
 /*
  * Some device instances may not have all the above attributes,
@@ -525,16 +513,7 @@
  * if the default_{cylinders,heads,sectors_per_track} values
  * are zero, the BIOS doesn't provide sane values, don't bother
  * creating files for them either.
- *
- * struct attr_test pairs an attribute and a test,
- * (the default NULL test being true - the attribute exists)
- * and individual existence tests may be written for each
- * attribute.
  */
-struct attr_test {
-	struct edd_attribute *attr;
-	int (*test) (struct edd_device * edev);
-};
 
 static int
 edd_has_default_cylinders(struct edd_device *edev)
@@ -591,23 +570,34 @@
 	return 0;
 }
 
-static struct attr_test def_attrs[] = {
-	{.attr = &edd_attr_raw_data},
-	{.attr = &edd_attr_version},
-	{.attr = &edd_attr_extensions},
-	{.attr = &edd_attr_info_flags},
-	{.attr = &edd_attr_sectors},
-	{.attr = &edd_attr_default_cylinders,
-	 .test = &edd_has_default_cylinders},
-	{.attr = &edd_attr_default_heads,
-	 .test = &edd_has_default_heads},
-	{.attr = &edd_attr_default_sectors_per_track,
-	 .test = &edd_has_default_sectors_per_track},
-	{.attr = &edd_attr_interface,
-	 .test = &edd_has_edd30},
-	{.attr = &edd_attr_host_bus,
-	 .test = &edd_has_edd30},
-	{.attr = NULL,.test = NULL},
+static EDD_DEVICE_ATTR(raw_data, 0444, edd_show_raw_data, NULL);
+static EDD_DEVICE_ATTR(version, 0444, edd_show_version, NULL);
+static EDD_DEVICE_ATTR(extensions, 0444, edd_show_extensions, NULL);
+static EDD_DEVICE_ATTR(info_flags, 0444, edd_show_info_flags, NULL);
+static EDD_DEVICE_ATTR(sectors, 0444, edd_show_sectors, NULL);
+static EDD_DEVICE_ATTR(default_cylinders, 0444, edd_show_default_cylinders,
+		       edd_has_default_cylinders);
+static EDD_DEVICE_ATTR(default_heads, 0444, edd_show_default_heads,
+		       edd_has_default_heads);
+static EDD_DEVICE_ATTR(default_sectors_per_track, 0444,
+		       edd_show_default_sectors_per_track,
+		       edd_has_default_sectors_per_track);
+static EDD_DEVICE_ATTR(interface, 0444, edd_show_interface, edd_has_edd30);
+static EDD_DEVICE_ATTR(host_bus, 0444, edd_show_host_bus, edd_has_edd30);
+
+
+static struct edd_attribute * def_attrs[] = {
+	&edd_attr_raw_data,
+	&edd_attr_version,
+	&edd_attr_extensions,
+	&edd_attr_info_flags,
+	&edd_attr_sectors,
+	&edd_attr_default_cylinders,
+	&edd_attr_default_heads,
+	&edd_attr_default_sectors_per_track,
+	&edd_attr_interface,
+	&edd_attr_host_bus,
+	NULL,
 };
 
 /* edd_get_devpath_length(), edd_fill_devpath(), and edd_device_link()
@@ -864,14 +854,13 @@
 static int
 edd_populate_dir(struct edd_device *edev)
 {
-	struct attr_test *s;
+	struct edd_attribute *attr;
 	int i;
 	int error = 0;
 
-	for (i = 0; def_attrs[i].attr; i++) {
-		s = &def_attrs[i];
-		if (!s->test || (s->test && !s->test(edev))) {
-			if ((error = edd_create_file(edev, s->attr))) {
+	for (i = 0; (attr=def_attrs[i]); i++) {
+		if (!attr->test || (attr->test && !attr->test(edev))) {
+			if ((error = edd_create_file(edev, attr))) {
 				break;
 			}
 		}
@@ -926,7 +915,7 @@
 edd_init(void)
 {
 	unsigned int i;
-	int rc;
+	int rc=0;
 	struct edd_device *edev;
 
 	printk(KERN_INFO "BIOS EDD facility v%s, %d devices found\n",

===================================================================


This BitKeeper patch contains the following changesets:
1.812
## Wrapped with gzip_uu ##


begin 664 bkpatch21214
M'XL(`)]DN#T``[56VV[;.!!]%K]BM@$"._&%I*YVX*)M%.P:FVV"M.G+IA!H
MB;:$Z!)(5-)@]?%+RC<ELEULT)4,TIP9GN$,#X<Z@MN"YV/M+R:$YV9)X8?H
M"/[("C'6`A['`S]+I.`FRZ1@&&8)'R9!;3:<W0_C*"U_].G`[/,@0-+NF@D_
MA$>>%V.-#/2-1#P_\+%V<_'[[>7'&X0F$S@/6;K@7[B`R02)+']D<5!\8"*,
MLW0@<I86"1=,N:\VIA7%F,K7)+:.3:LB%C;LRB<!(<P@/,#4<"P#-6+YL([A
M%0C!5"<6-:E34=VA)G*!#!Q"`=,AP4-J`+'&E(XQ[F-3MK`+$TX)]#'Z!+]V
M^>?(APO7'4.2/?(`I./<$[P0T@W(-'M*$,U*P:'_7LD[W1Y(/PE/18'^!!6/
MA:ZW"4;]__@@A!E&[W?&7+%<;GVD.];PGN<ICX=R20-_E50\HICHIE$1D]I&
M-;*LD3V?VS,6Z'.;^6]`I`8EE)AF1<AH9-3,V6VO:/3+%_P&Q!6O],HT;6S4
MO#)?LHJ,3?,@JW0;^H;SO_`JR8(RYE"F<<8">,KR^P+8@D6IU,W*Y$'R31W>
M*%."G"\96"[BYR8-PRA=]."A%!L"0I2^HN93R',N,0`B`3,N5[\HY%#R<[F1
M5]#/G^J?Y-OUGCU]`W-=.@(=N98.!$WK]BC@\RCEZDAYWRYNODRO/L,[/,`V
MJ+3UKWS1I\8[-'4<::Q%J8#.B8JJ"YU"Y*4OZL@"_ACY'$[D@#]VSY`[4N;3
MNFUZ<"^^3<\OO(]?O]YTO)0EO.?)G,NV"+.GGK<$OD-3@HER-U`";0*UHJ?)
MYPZY)I:H1/;4`5F93-T`221S).ECRZ`(!NJ@0C`1^2V?.7OR`B98#[!A&+UZ
M[<JUMU5\OKV\E!'L`5AM?VO^1GYX.O\A>*H,BQ9"4W48)$KGF3>/V:(-TE0=
M!BFX+\]/&V$C/SQ=[BDK8^'YS_*2"_@.H+8%TC18/LHH9$7;YN<.0\Z"_<Z6
MVOV.:OW/G:R2X#UP>:ASYM^O'+X$?N&Y/67_*EJVA_9:\'S.?+YCJS>:-;[L
M=;P?*Y2?+=ZL;&=OJWB-="??%5KCM&_KV`G(F.IQ\?=WF,`_2#M>6VS/5%.X
M/BA-68/Z37&#S$WQFJ%-V2ZRM;5K=K0UNW:ON9!UJIO23=:0ILY*#[F.9:NJ
MM^RTW0E3?V5]=&PBJ];4L0U9C[5YED,GDOG#9]!1%I-M6J/OW3.(3D^[*KE:
M-(?.;TJQO%N@JI835L/C8VAH.W4U[BYGUE,[/,^EKTF]*C_G3'!O'L6\MNS5
KM]C2WAW)FT)5\+JKZW[N3_#9]BO6#[E_7Y3)A'`2F#JWT+^*==<$+0L`````
`
end

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


