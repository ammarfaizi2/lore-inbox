Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265714AbTFXGCj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 02:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265715AbTFXGCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 02:02:39 -0400
Received: from Mail1.kontent.de ([81.88.34.36]:12979 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S265714AbTFXGCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 02:02:35 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH]fix read only handling in hfs
Date: Tue, 24 Jun 2003 08:15:53 +0200
User-Agent: KMail/1.5.1
Cc: Ethan Benson <erbenson@alaska.net>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306240815.54023.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

this patch fixes two bugs in handling read only flags in hfs
- don't dirty the superblock
- refuse remount rw
Credit goes to Ethan Benson.
Please apply.

	Regards
		Oliver

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1103, 2003-06-24 07:59:49+02:00, oliver@vermuden.neukum.org
  hfs-readonly-fix.diff


 fs/hfs/mdb.c           |    2 -
 fs/hfs/super.c         |   58 ++++++++++++++++++++++++++++++++++---------------
 include/linux/hfs_fs.h |    1 
 3 files changed, 43 insertions(+), 18 deletions(-)


diff -Nru a/fs/hfs/mdb.c b/fs/hfs/mdb.c
--- a/fs/hfs/mdb.c	Tue Jun 24 08:10:11 2003
+++ b/fs/hfs/mdb.c	Tue Jun 24 08:10:11 2003
@@ -197,7 +197,7 @@
 
 	if (!(mdb->attrib & htons(HFS_SB_ATTRIB_CLEAN))) {
 		hfs_warn("hfs_fs: WARNING: mounting unclean filesystem.\n");
-	} else if (!readonly) {
+	} else if (!readonly && !(mdb->attrib & (HFS_SB_ATTRIB_HLOCK | HFS_SB_ATTRIB_SLOCK))) {
 		/* Mark the volume uncleanly unmounted in case we crash */
 		hfs_put_ns(mdb->attrib & htons(~HFS_SB_ATTRIB_CLEAN),
 			   raw->drAtrb);
diff -Nru a/fs/hfs/super.c b/fs/hfs/super.c
--- a/fs/hfs/super.c	Tue Jun 24 08:10:11 2003
+++ b/fs/hfs/super.c	Tue Jun 24 08:10:11 2003
@@ -49,6 +49,7 @@
 	put_super:	hfs_put_super,
 	write_super:	hfs_write_super,
 	statfs:		hfs_statfs,
+	remount_fs:     hfs_remount,
 };
 
 /*================ File-local variables ================*/
@@ -162,23 +163,24 @@
 	char *this_char, *value;
 	char names, fork;
 
-	/* initialize the sb with defaults */
-	memset(hsb, 0, sizeof(*hsb));
-	hsb->magic = HFS_SB_MAGIC;
-	hsb->s_uid   = current->uid;
-	hsb->s_gid   = current->gid;
-	hsb->s_umask = current->fs->umask;
-	hsb->s_type    = 0x3f3f3f3f;	/* == '????' */
-	hsb->s_creator = 0x3f3f3f3f;	/* == '????' */
-	hsb->s_lowercase = 0;
-	hsb->s_quiet     = 0;
-	hsb->s_afpd      = 0;
-        /* default version. 0 just selects the defaults */
-	hsb->s_version   = 0; 
-	hsb->s_conv = 'b';
-	names = '?';
-	fork = '?';
-	*part = 0;
+	if (hsb->magic != HFS_SB_MAGIC) {
+		/* initialize the sb with defaults */
+		hsb->magic = HFS_SB_MAGIC;
+		hsb->s_uid   = current->uid;
+		hsb->s_gid   = current->gid;
+		hsb->s_umask = current->fs->umask;
+		hsb->s_type    = 0x3f3f3f3f;	/* == '????' */
+		hsb->s_creator = 0x3f3f3f3f;	/* == '????' */
+		hsb->s_lowercase = 0;
+		hsb->s_quiet     = 0;
+		hsb->s_afpd      = 0;
+		/* default version. 0 just selects the defaults */
+		hsb->s_version   = 0; 
+		hsb->s_conv = 'b';
+		names = '?';
+		fork = '?';
+		*part = 0;
+	}
 
 	if (!options) {
 		goto done;
@@ -397,6 +399,7 @@
 	struct inode *root_inode;
 	int part;
 
+	memset(HFS_SB(s), 0, sizeof(*(HFS_SB(s))));	
 	if (!parse_options((char *)data, HFS_SB(s), &part)) {
 		hfs_warn("hfs_fs: unable to parse mount options.\n");
 		goto bail3;
@@ -472,6 +475,27 @@
 	set_blocksize(dev, BLOCK_SIZE);
 bail3:
 	return NULL;	
+}
+
+int hfs_remount(struct super_block *s, int *flags, char *data)
+{
+        int part; /* ignored */
+
+        if (!parse_options(data, HFS_SB(s), &part)) {
+                hfs_warn("hfs_fs: unable to parse mount options.\n");
+                return -EINVAL;
+	}
+
+        if ((*flags & MS_RDONLY) == (s->s_flags & MS_RDONLY))
+                return 0;
+	if (!(*flags & MS_RDONLY)) {
+                if (HFS_SB(s)->s_mdb->attrib & (HFS_SB_ATTRIB_HLOCK | HFS_SB_ATTRIB_SLOCK)) {
+                        hfs_warn("hfs_fs: Filesystem is marked locked, leaving it read-only.\n");
+		        s->s_flags |= MS_RDONLY;
+			*flags |= MS_RDONLY;
+	        }
+        }
+	return 0;
 }
 
 static int __init init_hfs_fs(void)
diff -Nru a/include/linux/hfs_fs.h b/include/linux/hfs_fs.h
--- a/include/linux/hfs_fs.h	Tue Jun 24 08:10:11 2003
+++ b/include/linux/hfs_fs.h	Tue Jun 24 08:10:11 2003
@@ -302,6 +302,7 @@
 
 /* super.c */
 extern struct super_block *hfs_read_super(struct super_block *,void *,int);
+extern int hfs_remount(struct super_block *, int *, char *);
 
 /* trans.c */
 extern void hfs_colon2mac(struct hfs_name *, const char *, int);

===================================================================


This BitKeeper patch contains the following changesets:
1.1103
## Wrapped with gzip_uu ##


begin 664 bkpatch2799
M'XL(`$3K]SX``\57:6_;.!#];/Z*:0LDMAO;I*C3@;--DQY&TP-)N\`"!0Q:
MHFRM=7A%*L?6^>]+RDHLMTZ=9+=8.D!D<O0X\_AF.'X&7P3/^XTLCLYYCI[!
MVTS(?D,])T7`TV[*BUF1=+-\HM9.LTRM]:99PGO+%WJ?<\Y%;QH*PT3*XA.3
M_A34@N@W2)?>SLBK.>\W3E^]^7)R>(K08`!'4Y9.^!F7,!@@F>7G+`[$"R:G
M<99V9<Y2D7#)NGZ6+&Y-%P;&AOI8Q*'8LA?$QJ:S\$E`"#,)#[!ANK:)4A[%
MXQ>^X-TB%1=='A1=5JRC4$R)9U"34G=!+(M:Z!A(EQ!,`=,>MGN&"=CI6U[?
M])YCHX\Q+`-^L8$9>$ZA@]%+^&_#.$(^*&([.6=!EL97G3"Z[`91&*)W0$R/
MFNC3BD74>>!`"#.,#K;X')9GVTN"<=>ON^V5O#D$+RC%KLLLV\">9V%JPEP?
M^"::?@"CV#9,;%F>@L$:_+[NB&+.\PT.*3(5CZ9EN2QT0L<AW'&"[0[5X.HN
MV81:WE:7HM2/%6XOCM+B4L.-0M&=KKOF+0S/MMR%1SP>F"X/+9]XMOTSU^Z&
MK;MHNAZE93K5N=V>40\_5K1T]2%HRD-S81NNXY;)M<PLJV?8@'$?NWV35)EU
M)POPG$"'_)+$&B;S+)?+K>_(LM=@6*H^&)[*MU*='Z&37Y1_*GT^K5'^B/0[
M5IA`T'#YKW$-/!8<HA":3VY\@9T=>-)4&W0.F)1Y-(8=:+Y]?38Z>SDZ_/SY
M=/AR]/;DX]$[6,#Z[)F>;;5:\*TNCDKG]Y;'@]*L$L@\+OS9E2)0R#Q38"GW
M973.-D)20@U*"?$6V"/V4B7.FDJ(*L'F=I686B;._ZL3P[&53I8U8[-0JM@?
M(96A1;1$<IYD12I5)>B#'KHJ5'-[Z)C8%B@2AL15QBYJ:"5-A9).PB:1#T\&
M-QIY?_AF>*2ET6CTVA"ED8Q8'/W-04XYB#%<1'(*`0]9$4L![9ZRJ^&LP^S?
M+(I1$07*IP'X19[S5'8.U$1M>?+]\F1MN4B8F-67%=4'Y63-2'<14*+@2QHN
M/_LZ"*7QW=_4V*VY*T:^.BNEB/N:Q]D%SWVFDE"]4-OUKR)274JU;VV>A?,`
MZO,*N:*M[(`B)4#`\&<A)`@>JT00)<4;J!6CZH4*#&I!9.FYFML=[^HM4I9P
MH;_^5GX-LWRV^M:>,R75I3/7:$@]3ZLFX8G@LBH;3=':`[P'0IUW%C;;JVDU
M]AMH:#HF&`1=HZ\H2F5=8DV5T86O0M$R'HWCS)]!6^R!-FN',9NH9W_*<F@'
M3+(6^H:@&MI"N[8/6F^3-,MYH(/_NK+054^9"#[*YE+Q()H:9`]J7N]HB+*D
MP7=#.WG!\K3Y='E/]J%(V3A6@LZ@!(4R`*B@NU_3IZW]'U!R+HL\A<ZKX8??
M#T]*"M<=;"ZC5#7X_=GH]/CCAY,_6EI*3:'/Z<>UUEU;Z/,I(]Z$N"E`;7S+
MA-[L\5?"!O2[:7P=Q5Q<"<D3B`0D+)^I@],'SX,]B#D[C]()1!)T3>SHHEA1
MVVC<8-:H60Q646J31GOC_,V;UVCUU%@1IZ^SS;W1]FOMW[1J/^M_MN*J3LA:
MF-0RG/5.R`*#]G4S9-RK$_HU/S'N>\,YGNFJ&V[9<GYWPVUFX#$W'<6F*EK\
H4G)UWO>I0%4!NJD]2GVW/SK]*?=GHD@&A#F8>CY%_P!0PO:F[@X`````
`
end

