Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277918AbRJVGoC>; Mon, 22 Oct 2001 02:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277938AbRJVGnx>; Mon, 22 Oct 2001 02:43:53 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:11505 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S277918AbRJVGnu>; Mon, 22 Oct 2001 02:43:50 -0400
Date: Mon, 22 Oct 2001 02:44:25 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Patch for ymfpci & Civ:CTP
Message-ID: <20011022024425.B22466@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch fixes "Civilization: Call To Power" and appears not to
harm mpg123, xmms, Doom. I think that Civ:CTP port code interprets
OSS manual in somewhat obscure way, but since it can be fixed
without disturbing other applications, I do not mind.

This should apply without rejects to both main and -ac tree.

-- Pete

--- linux-2.4.9/drivers/sound/ymfpci.c	Sun Aug 12 10:51:42 2001
+++ linux-2.4.9-niph/drivers/sound/ymfpci.c	Sun Oct 21 23:13:41 2001
@@ -66,10 +66,13 @@
  * I do not believe in debug levels as I never can guess what
  * part of the code is going to be problematic in the future.
  * Don't forget to run your klogd with -c 8.
+ *
+ * Example (do not remove):
+ * #define YMFDBG(fmt, arg...)  do{ printk(KERN_DEBUG fmt, ##arg); }while(0)
  */
-/* #define YMFDBG(fmt, arg...)  do{ printk(KERN_DEBUG fmt, ##arg); }while(0) */
-#define YMFDBGW(fmt, arg...)  /* */
-#define YMFDBGI(fmt, arg...)  /* */
+#define YMFDBGW(fmt, arg...)  /* */	/* write counts */
+#define YMFDBGI(fmt, arg...)  /* */	/* interrupts */
+#define YMFDBGX(fmt, arg...)  /* */	/* ioctl */
 
 static int ymf_playback_trigger(ymfpci_t *unit, struct ymf_pcm *ypcm, int cmd);
 static void ymf_capture_trigger(ymfpci_t *unit, struct ymf_pcm *ypcm, int cmd);
@@ -330,7 +333,7 @@
 	int w_16;
 	unsigned bufsize;
 	unsigned long flags;
-	int redzone;
+	int redzone, redfrags;
 	int ret;
 
 	w_16 = ymf_pcm_format_width(state->format.format) == 16;
@@ -352,36 +355,27 @@
 	 * Import what Doom might have set with SNDCTL_DSP_SETFRAGMENT.
 	 */
 	bufsize = PAGE_SIZE << dmabuf->buforder;
-	/* lets hand out reasonable big ass buffers by default */
-	dmabuf->fragshift = (dmabuf->buforder + PAGE_SHIFT -2);
+	/* By default we give 4 big buffers. */
+	dmabuf->fragshift = (dmabuf->buforder + PAGE_SHIFT - 2);
 	if (dmabuf->ossfragshift > 3 &&
 	    dmabuf->ossfragshift < dmabuf->fragshift) {
+		/* If OSS set smaller fragments, give more smaller buffers. */
 		dmabuf->fragshift = dmabuf->ossfragshift;
 	}
-	dmabuf->numfrag = bufsize >> dmabuf->fragshift;
-	while (dmabuf->numfrag < 4 && dmabuf->fragshift > 3) {
-		dmabuf->fragshift--;
-		dmabuf->numfrag = bufsize >> dmabuf->fragshift;
-	}
 	dmabuf->fragsize = 1 << dmabuf->fragshift;
-	dmabuf->dmasize = dmabuf->numfrag << dmabuf->fragshift;
 
-	if (dmabuf->ossmaxfrags >= 2 && dmabuf->ossmaxfrags < dmabuf->numfrag) {
-		dmabuf->numfrag = dmabuf->ossmaxfrags;
-		dmabuf->dmasize = dmabuf->numfrag << dmabuf->fragshift;
+	dmabuf->numfrag = bufsize >> dmabuf->fragshift;
+	dmabuf->dmasize = dmabuf->numfrag << dmabuf->fragshift;
 
+	if (dmabuf->ossmaxfrags >= 2) {
 		redzone = ymf_calc_lend(state->format.rate);
-		redzone <<= (state->format.shift + 1);
-		if (dmabuf->dmasize < redzone*3) {
-			/*
-			 * The driver works correctly with minimum dmasize
-			 * of redzone*2, but it produces stoppage and clicks.
-			 * So, make it little larger for smoother sound.
-			 * XXX Make dmasize a wholy divisible by fragsize.
-			 */
-//			printk(KERN_ERR "ymfpci: dmasize=%d < redzone=%d * 3\n",
-//			    dmabuf->dmasize, redzone);
-			dmabuf->dmasize = redzone*3;
+		redzone <<= state->format.shift;
+		redzone *= 3;
+		redfrags = (redzone + dmabuf->fragsize-1) >> dmabuf->fragshift;
+
+		if (dmabuf->ossmaxfrags + redfrags < dmabuf->numfrag) {
+			dmabuf->numfrag = dmabuf->ossmaxfrags + redfrags;
+			dmabuf->dmasize = dmabuf->numfrag << dmabuf->fragshift;
 		}
 	}
 
@@ -1437,7 +1434,7 @@
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&dmabuf->wait, &waita);
 
-	YMFDBGW("ymf_write: dmabuf.count %d\n", dmabuf->count);
+	YMFDBGW("ymf_write: ret %d dmabuf.count %d\n", ret, dmabuf->count);
 	return ret;
 }
 
@@ -1791,6 +1820,7 @@
 	case SNDCTL_DSP_SETSYNCRO:
 	case SOUND_PCM_WRITE_FILTER:
 	case SOUND_PCM_READ_FILTER:
+		YMFDBGX("ymf_ioctl: cmd 0x%x unsupported\n", cmd);
 		return -ENOTTY;
 
 	default:
@@ -1799,7 +1829,8 @@
 		 * or perhaps they expect "universal" ioctls,
 		 * for instance we get SNDCTL_TMR_CONTINUE here.
 		 */
-		 break;
+		YMFDBGX("ymf_ioctl: cmd 0x%x unknown\n", cmd);
+		break;
 	}
 	return -ENOTTY;
 }
