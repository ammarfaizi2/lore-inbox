Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265188AbTFEVVK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 17:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265192AbTFEVVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 17:21:09 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:39620 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265188AbTFEVUh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 17:20:37 -0400
Date: Thu, 5 Jun 2003 16:34:01 -0500
Subject: [CHECKER][PATCH] awe_wave.c user pointer dereference
Content-Type: multipart/mixed; boundary=Apple-Mail-15--767769295
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@transmeta.com>
From: Hollis Blanchard <hollisb@us.ibm.com>
Message-Id: <6CB1C41B-979D-11D7-8338-000A95A0560C@us.ibm.com>
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-15--767769295
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Two ioctl functions in sound/oss/awe_wave.c were directly dereferencing 
a user-supplied pointer in a few places. Please apply.

-- 
Hollis Blanchard
IBM Linux Technology Center


--Apple-Mail-15--767769295
Content-Disposition: attachment;
	filename=awe-userptr.txt
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	x-unix-mode=0644;
	name="awe-userptr.txt"

===== sound/oss/awe_wave.c 1.12 vs edited =====
--- 1.12/sound/oss/awe_wave.c	Thu Apr  3 16:35:48 2003
+++ edited/sound/oss/awe_wave.c	Thu Jun  5 16:16:53 2003
@@ -2046,7 +2046,8 @@
 			awe_info.nr_voices = awe_max_voices;
 		else
 			awe_info.nr_voices = AWE_MAX_CHANNELS;
-		memcpy((char*)arg, &awe_info, sizeof(awe_info));
+		if (copy_to_user((char*)arg, &awe_info, sizeof(awe_info)))
+			return -EFAULT;
 		return 0;
 		break;
 
@@ -2063,10 +2064,12 @@
 
 	case SNDCTL_SYNTH_MEMAVL:
 		return memsize - awe_free_mem_ptr() * 2;
+		break;
 
 	default:
 		printk(KERN_WARNING "AWE32: unsupported ioctl %d\n", cmd);
 		return -EINVAL;
+		break;
 	}
 }
 
@@ -4314,7 +4317,8 @@
 	if (((cmd >> 8) & 0xff) != 'M')
 		return -EINVAL;
 
-	level = *(int*)arg;
+	if (get_user(level, (int *)arg))
+		return -EFAULT;
 	level = ((level & 0xff) + (level >> 8)) / 2;
 	DEBUG(0,printk("AWEMix: cmd=%x val=%d\n", cmd & 0xff, level));
 
@@ -4370,7 +4374,9 @@
 		level = 0;
 		break;
 	}
-	return *(int*)arg = level;
+	if (put_user(level, (int *)arg))
+		return -EFAULT;
+	return level;
 }
 #endif /* CONFIG_AWE32_MIXER */
 

--Apple-Mail-15--767769295--

