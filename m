Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbUCTW7L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 17:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbUCTW7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 17:59:10 -0500
Received: from lmail.actcom.co.il ([192.114.47.13]:33668 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S263567AbUCTW7B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 17:59:01 -0500
Date: Sun, 21 Mar 2004 00:58:54 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, rene.herman@keyaccess.nl,
       Muli Ben-Yehuda <mulix@mulix.org>
Subject: [PATCH] sb_mixer bounds checking, 2.6.5-rc2
Message-ID: <20040320225852.GW13042@mulix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy, 

This patch add proper bounds checking to the sb_mixer.c code, found by
the stanford checker[0]. It fixes bugzilla bugs 252[1], 253[2] and
254[3]. Patch is against 2.6.5-rc2. It was tested by Rene Herman on SN
AWE64 gold and sound still works. The issue was previously discussed
on lkml[4], but apparently no fix was applied.  

The patch is a bit more intrusive than I would've liked, but I don't
think it can be helped without really intrusive changes. sb_devc has a
pointer to an array (iomap) that is set at run time to point to arrays
of variable sizes. The patch adds an 'iomap_sz' member to sb_devc that
is set to the length of the array, and does bounds checking in
sb_common_mixer_set() and smw_mixer_set() agains that. 

Please apply? 

[0] http://marc.theaimsgroup.com/?l=linux-kernel&m=104155431311370&w=2
[1] http://bugzilla.kernel.org/show_bug.cgi?id=252
[2] http://bugzilla.kernel.org/show_bug.cgi?id=253
[3] http://bugzilla.kernel.org/show_bug.cgi?id=254
[4] http://marc.theaimsgroup.com/?l=linux-kernel&m=104260148409541&w=2

diff -Naurp -X /home/muli/w/dontdiff linux-2.5/sound/oss/sb_ess.c snd-trident/sound/oss/sb_ess.c
--- linux-2.5/sound/oss/sb_ess.c	2003-04-08 19:46:36.000000000 +0300
+++ snd-trident/sound/oss/sb_ess.c	2004-03-21 00:31:52.000000000 +0200
@@ -1638,8 +1638,10 @@ printk (KERN_INFO "FKS: ess_mixer_init d
 #endif
 		if (devc->duplex) {
 			devc->iomap				= &es1887_mix;
+			devc->iomap_sz                          = ARRAY_SIZE(es1887_mix);
 		} else {
 			devc->iomap				= &es_rec_mix;
+			devc->iomap_sz                          = ARRAY_SIZE(es_rec_mix);
 		}
 		break;
 	default:
@@ -1647,6 +1649,7 @@ printk (KERN_INFO "FKS: ess_mixer_init d
 			devc->supported_devices		= ES688_MIXER_DEVICES;
 			devc->supported_rec_devices	= ES688_RECORDING_DEVICES;
 			devc->iomap					= &es688_mix;
+			devc->iomap_sz                                  = ARRAY_SIZE(es688_mix);
 		} else {
 			/*
 			 * es1688 has 4 bits master vol.
@@ -1656,8 +1659,10 @@ printk (KERN_INFO "FKS: ess_mixer_init d
 			devc->supported_rec_devices	= ES1688_RECORDING_DEVICES;
 			if (devc->submodel < 0x10) {
 				devc->iomap				= &es1688_mix;
+				devc->iomap_sz                          = ARRAY_SIZE(es688_mix);
 			} else {
 				devc->iomap				= &es1688later_mix;
+				devc->iomap_sz                          = ARRAY_SIZE(es1688later_mix);
 			}
 		}
 	}
diff -Naurp -X /home/muli/w/dontdiff linux-2.5/sound/oss/sb.h snd-trident/sound/oss/sb.h
--- linux-2.5/sound/oss/sb.h	2002-02-13 21:56:50.000000000 +0200
+++ snd-trident/sound/oss/sb.h	2004-03-21 00:32:05.000000000 +0200
@@ -110,6 +110,7 @@ typedef struct sb_devc {
 	/* Mixer fields */
 	   int *levels;
 	   mixer_tab *iomap;
+	   size_t iomap_sz; /* number or records in the iomap table */
 	   int mixer_caps, recmask, outmask, supported_devices;
 	   int supported_rec_devices, supported_out_devices;
 	   int my_mixerdev;
diff -Naurp -X /home/muli/w/dontdiff linux-2.5/sound/oss/sb_mixer.c snd-trident/sound/oss/sb_mixer.c
--- linux-2.5/sound/oss/sb_mixer.c	2003-04-08 19:46:36.000000000 +0300
+++ snd-trident/sound/oss/sb_mixer.c	2004-03-21 00:32:46.000000000 +0200
@@ -278,6 +278,9 @@ int sb_common_mixer_set(sb_devc * devc, 
 	if (regoffs == 0)
 		return -EINVAL;
 
+	if ((dev < 0) || (dev >= devc->iomap_sz))
+	    return -EINVAL;
+
 	val = sb_getmixer(devc, regoffs);
 	change_bits(devc, &val, dev, LEFT_CHN, left);
 
@@ -333,6 +336,9 @@ static int smw_mixer_set(sb_devc * devc,
 			break;
 
 		default:
+			/* bounds check */
+			if (dev < 0 || dev >= ARRAY_SIZE(smw_mix_regs))
+				return -EINVAL;
 			reg = smw_mix_regs[dev];
 			if (reg == 0)
 				return -EINVAL;
@@ -355,7 +361,7 @@ static int sb_mixer_set(sb_devc * devc, 
 	if (right > 100)
 		right = 100;
 
-	if (dev > 31)
+	if ((dev < 0) || (dev > 31))
 		return -EINVAL;
 
 	if (!(devc->supported_devices & (1 << dev)))	/*
@@ -684,6 +690,7 @@ int sb_mixer_init(sb_devc * devc, struct
 			devc->supported_devices = SBPRO_MIXER_DEVICES;
 			devc->supported_rec_devices = SBPRO_RECORDING_DEVICES;
 			devc->iomap = &sbpro_mix;
+			devc->iomap_sz = ARRAY_SIZE(sbpro_mix);
 			break;
 
 		case MDL_ESS:
@@ -695,6 +702,7 @@ int sb_mixer_init(sb_devc * devc, struct
 			devc->supported_devices = 0;
 			devc->supported_rec_devices = 0;
 			devc->iomap = &sbpro_mix;
+			devc->iomap_sz = ARRAY_SIZE(sbpro_mix);
 			smw_mixer_init(devc);
 			break;
 
@@ -706,11 +714,13 @@ int sb_mixer_init(sb_devc * devc, struct
 			{
 				devc->supported_devices = SB16_MIXER_DEVICES;
 				devc->iomap = &sb16_mix;
+				devc->iomap_sz = ARRAY_SIZE(sb16_mix);
 			}
 			else
 			{
 				devc->supported_devices = ALS007_MIXER_DEVICES;
 				devc->iomap = &als007_mix;
+				devc->iomap_sz = ARRAY_SIZE(als007_mix);
 			}
 			break;

-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

