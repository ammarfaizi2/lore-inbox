Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312983AbSDJMfS>; Wed, 10 Apr 2002 08:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312996AbSDJMfR>; Wed, 10 Apr 2002 08:35:17 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:1036 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S312983AbSDJMfN>; Wed, 10 Apr 2002 08:35:13 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 10 Apr 2002 12:58:21 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l zoltrix radio driver fix
Message-ID: <20020410125821.A26389@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch updates the zotrix radio driver to the videodev redesign
(2.5.7-preN), that one somehow didn't made it in (maybe I forgot to mail
it ...).

  Gerd

==============================[ cut here ]==============================
# ChangeSet
#   1.586 02/04/08 10:02:38 kraxel@bytesex.org +1 -0
#   adapt zotrix radio driver to pre 2.4.7 videodev redesign
# 
#   drivers/media/radio/radio-zoltrix.c
#     1.5 02/03/19 18:23:29 kraxel@bytesex.org +53 -72
#     adapt zotrix radio driver to pre 2.4.7 videodev redesign
# 
======================================================================
diff -Nru a/drivers/media/radio/radio-zoltrix.c b/drivers/media/radio/radio-zoltrix.c
--- a/drivers/media/radio/radio-zoltrix.c	Mon Apr  8 10:17:54 2002
+++ b/drivers/media/radio/radio-zoltrix.c	Mon Apr  8 10:17:54 2002
@@ -40,7 +40,6 @@
 
 static int io = CONFIG_RADIO_ZOLTRIX_PORT;
 static int radio_nr = -1;
-static int users = 0;
 
 struct zol_device {
 	int port;
@@ -216,106 +215,93 @@
 	return 0;
 }
 
-static int zol_ioctl(struct video_device *dev, unsigned int cmd, void *arg)
+static int zol_ioctl(struct inode *inode, struct file *file,
+		     unsigned int cmd, void *arg)
 {
+	struct video_device *dev = video_devdata(file);
 	struct zol_device *zol = dev->priv;
 
 	switch (cmd) {
 	case VIDIOCGCAP:
 		{
-			struct video_capability v;
-			v.type = VID_TYPE_TUNER;
-			v.channels = 1 + zol->stereo;
-			v.audios = 1;
-			/* No we don't do pictures */
-			v.maxwidth = 0;
-			v.maxheight = 0;
-			v.minwidth = 0;
-			v.minheight = 0;
-			strcpy(v.name, "Zoltrix Radio");
-			if (copy_to_user(arg, &v, sizeof(v)))
-				return -EFAULT;
+			struct video_capability *v = arg;
+
+			memset(v,0,sizeof(*v));
+			v->type = VID_TYPE_TUNER;
+			v->channels = 1 + zol->stereo;
+			v->audios = 1;
+			strcpy(v->name, "Zoltrix Radio");
 			return 0;
 		}
 	case VIDIOCGTUNER:
 		{
-			struct video_tuner v;
-			if (copy_from_user(&v, arg, sizeof(v)))
-				return -EFAULT;
-			if (v.tuner)	
+			struct video_tuner *v = arg;
+			if (v->tuner)	
 				return -EINVAL;
-			strcpy(v.name, "FM");
-			v.rangelow = (int) (88.0 * 16000);
-			v.rangehigh = (int) (108.0 * 16000);
-			v.flags = zol_is_stereo(zol)
+			strcpy(v->name, "FM");
+			v->rangelow = (int) (88.0 * 16000);
+			v->rangehigh = (int) (108.0 * 16000);
+			v->flags = zol_is_stereo(zol)
 					? VIDEO_TUNER_STEREO_ON : 0;
-			v.flags |= VIDEO_TUNER_LOW;
-			v.mode = VIDEO_MODE_AUTO;
-			v.signal = 0xFFFF * zol_getsigstr(zol);
-			if (copy_to_user(arg, &v, sizeof(v)))
-				return -EFAULT;
+			v->flags |= VIDEO_TUNER_LOW;
+			v->mode = VIDEO_MODE_AUTO;
+			v->signal = 0xFFFF * zol_getsigstr(zol);
 			return 0;
 		}
 	case VIDIOCSTUNER:
 		{
-			struct video_tuner v;
-			if (copy_from_user(&v, arg, sizeof(v)))
-				return -EFAULT;
-			if (v.tuner != 0)
+			struct video_tuner *v = arg;
+			if (v->tuner != 0)
 				return -EINVAL;
 			/* Only 1 tuner so no setting needed ! */
 			return 0;
 		}
 	case VIDIOCGFREQ:
-		if (copy_to_user(arg, &zol->curfreq, sizeof(zol->curfreq)))
-			return -EFAULT;
+	{
+		unsigned long *freq = arg;
+		*freq = zol->curfreq;
 		return 0;
+	}
 	case VIDIOCSFREQ:
-		if (copy_from_user(&zol->curfreq, arg, sizeof(zol->curfreq)))
-			return -EFAULT;
+	{
+		unsigned long *freq = arg;
+		zol->curfreq = *freq;
 		zol_setfreq(zol, zol->curfreq);
 		return 0;
+	}
 	case VIDIOCGAUDIO:
 		{
-			struct video_audio v;
-			memset(&v, 0, sizeof(v));
-			v.flags |= VIDEO_AUDIO_MUTABLE | VIDEO_AUDIO_VOLUME;
-			v.mode != zol_is_stereo(zol)
+			struct video_audio *v = arg;
+			memset(&v, 0, sizeof(*v));
+			v->flags |= VIDEO_AUDIO_MUTABLE | VIDEO_AUDIO_VOLUME;
+			v->mode != zol_is_stereo(zol)
 				? VIDEO_SOUND_STEREO : VIDEO_SOUND_MONO;
-			v.volume = zol->curvol * 4096;
-			v.step = 4096;
-			strcpy(v.name, "Zoltrix Radio");
-			if (copy_to_user(arg, &v, sizeof(v)))
-				return -EFAULT;
+			v->volume = zol->curvol * 4096;
+			v->step = 4096;
+			strcpy(v->name, "Zoltrix Radio");
 			return 0;
 		}
 	case VIDIOCSAUDIO:
 		{
-			struct video_audio v;
-			if (copy_from_user(&v, arg, sizeof(v)))
-				return -EFAULT;
-			if (v.audio)
+			struct video_audio *v = arg;
+			if (v->audio)
 				return -EINVAL;
 
-			if (v.flags & VIDEO_AUDIO_MUTE)
+			if (v->flags & VIDEO_AUDIO_MUTE)
 				zol_mute(zol);
-			else
-			{
+			else {
 				zol_unmute(zol);
-				zol_setvol(zol, v.volume / 4096);
+				zol_setvol(zol, v->volume / 4096);
 			}
 
-			if (v.mode & VIDEO_SOUND_STEREO)
-			{
+			if (v->mode & VIDEO_SOUND_STEREO) {
 				zol->stereo = 1;
 				zol_setfreq(zol, zol->curfreq);
 			}
-			if (v.mode & VIDEO_SOUND_MONO)
-			{
+			if (v->mode & VIDEO_SOUND_MONO) {
 				zol->stereo = 0;
 				zol_setfreq(zol, zol->curfreq);
 			}
-
 			return 0;
 		}
 	default:
@@ -323,20 +309,16 @@
 	}
 }
 
-static int zol_open(struct video_device *dev, int flags)
-{
-	if (users)
-		return -EBUSY;
-	users++;
-	return 0;
-}
+static struct zol_device zoltrix_unit;
 
-static void zol_close(struct video_device *dev)
+static struct file_operations zoltrix_fops =
 {
-	users--;
-}
-
-static struct zol_device zoltrix_unit;
+	owner:		THIS_MODULE,
+	open:           video_exclusive_open,
+	release:        video_exclusive_release,
+	ioctl:		video_generic_ioctl,
+	llseek:         no_llseek,
+};
 
 static struct video_device zoltrix_radio =
 {
@@ -344,9 +326,8 @@
 	name:		"Zoltrix Radio Plus",
 	type:		VID_TYPE_TUNER,
 	hardware:	VID_HARDWARE_ZOLTRIX,
-	open:		zol_open,
-	close:		zol_close,
-	ioctl:		zol_ioctl,
+	fops:           &zoltrix_fops,
+	kernel_ioctl:  	zol_ioctl,
 };
 
 static int __init zoltrix_init(void)
======================================================================
This BitKeeper patch contains the following changesets:
1.586
## Wrapped with gzip_uu ##


begin 664 bkpatch4782
M'XL(`#)2L3P``\U6ZV_:2!#_C/^*:2M5D/#8]:X?$*5J6N@UNJ1$2>CI3B>A
MC;T0"V-SMB&/TO_]9M8\0BY5T[M^.(-L,>_YS<^SO()!KK-.99*I6QU;K^!C
MFA>=RM5=H7-]VTRS,<K.TQ1EK9LTF[2N)BV[Z;1&T6TC4V&46J@_4T5P#0N=
MY9T*;XJ-I+B;Z4[EO/?+X.3HW+(.#^']M4K&^D(7<'AH%6FV4'&8OU7%=9PF
MS2)323[5A6H&Z72Y,5W:C-GX<;@GF.,NN<NDMPQXR+F27(?,EKXK+3693=_>
M1S-R;JKY8W_)7":D:[M+V9:^;76!-QW?!6:WF&PQ'SCK,+LC_'V\,P8E(&\?
M``'['!K,>@<_M^[W5@`J5+,"[M,BBV[!P`IA%B&@F`MFF0:[*9L>+*)0IZ%>
M0*9#G4?CQ/H5I.]):9UMD;4:/WA9%E/,>O.=MLIZ\M94AY%JF1K+>^,^C:GN
M9O"@8<EX>\E\Q^?+@'G,';F2>^IJ9`?B"62?'UPR'S\V\Y=">+YG./4,Y^^S
M[:>U9\V(^O\]"=TX6[I<>*PDJZ&J:/$V<+]CBX[=WF?\6U1U!#0\^_]%U@_`
MW;84O(VT+<?7AT9V8[Y(P[/G3/)?L+LK!7"K:Q-PUC$];"LO5!$%$"742#R,
MTJ"(JWF1S8,"A5@V[)E''5;"412CC.YUJU(!NN8)=:5#$R68AG58I%$(>RH;
MUS"/S3!=9>5NP!@B&E&`80B5PZTL5(6J4NC:`99IN\!M]!<>>)AJ-T*@9NHJ
MBJ/B#O8H!N8ZL/XDLZF>YKJH+NJLGD?W.AU5]Q8U#(BJ1>,-;6(T_WS<'5[^
M?M8;7@X^]<[7R@!)D.@X1P,.^P1(XTU>Z$RG:PLUQR$8_<&JI&!V5T5%HJ:(
MT<L_RO'`.0WKI6E#VB"Q"^D@VH^[*.8)LF7;`.JC$5`\HZE5R-\S_@[#QU,I
M/YR^W'27$8GC]`;C57$8-:CZ?I/!'O*-,;9K=AV-K[=VG#UE.(K5F+HUU,B'
M)195_%7#PAP;'"K,!;%COC3P]OHEML.3_F_K<%/BTUI[VN_VAD>#R_Y:2R12
M,>K9[0>\L!A*.]8%*K!KDY8`=;D!Q)4_#BB\P.A4N\>`J.5QJOT+FFTXC*MA
MC/S.]%_;&.N?AA#!/*.?!^1N$[._4CQ9QG.>%>]A')3N;>)YZW@^,SWZ8C/T
M;8^&@[L]KCC_>E$'AF_J/VG_:#)'@^XQ3F!P>?3NI`?+'>GG_LG@M+<SLA??
M8(#O&`;X[0T#%FD\G^H'4*$`!RE9V]V,N=`S--B(GO,.M:6!H^T],?(GX%B-
MW&BP3L%H`QV7CZVZQ.3U8TAZQL.F>0HF2@_<"1J^D-PI(SFEG"8Y1.2Q2\($
M%]\&@I;ID*H7^)_*!&OOI#?(KK-?]`>?NL.+R]YYKU\SF;@P3EQ^S^FT_VGM
MXM-Z%[@W/?041,[5>E\!1M6N5N_J'!G.DZB@&H4TC9G'KA/MXV$ZTQD*TR3?
M>([2&:X&<G5I.$*TP;4JZ4U"_Z(KEQ^/+^@5'YST\)Q`]Z0#VZN<G+X-XGF.
M)QV%3]`LT[%6N>Y\RVRE1TMS3F&:TF*L,6D4E*<7:F,<EYYL$R;IL!35K:_4
M+*Y4@15+.@`KU,?#VEX_;!"#372&9T(9&^TJFV.ROOW''USK8)+/IX>V(Z7G
,!*[U-X>E`_I/#```
`
end
