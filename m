Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTELRoi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 13:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbTELRoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 13:44:38 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:64405 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262373AbTELRmY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 13:42:24 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 12 May 2003 19:14:17 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: #3 - bttv driver update
Message-ID: <20030512171417.GA23913@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch is a update for the bttv driver.  It is a big one because
alot of changes accumulated over time -- partly because submitting
updates in the past didn't work and partly because of some extra
work with merging the changes due to the i2c cleanups back into my
tree.

Changes:
 * splitted some code which can be shared with another driver into
   the btcx-risc module.
 * some new features (field rate capture support for example).
 * tv card list updates.
 * various bugfixes.
 * merged i2c changes back into my tree, there are some no-op
   changes due to this.

Please apply,

  Gerd

diff -u linux-2.5.69/drivers/media/video/Makefile linux/drivers/media/video/Makefile
--- linux-2.5.69/drivers/media/video/Makefile	2003-05-08 13:30:31.000000000 +0200
+++ linux/drivers/media/video/Makefile	2003-05-08 13:55:11.000000000 +0200
@@ -36,4 +36,5 @@
 
 obj-$(CONFIG_VIDEO_TUNER) += tuner.o tda9887.o
 obj-$(CONFIG_VIDEO_BUF)   += video-buf.o
+obj-$(CONFIG_VIDEO_BTCX)  += btcx-risc.o
 
diff -u linux-2.5.69/drivers/media/video/bt848.h linux/drivers/media/video/bt848.h
--- linux-2.5.69/drivers/media/video/bt848.h	2003-05-08 13:30:20.000000000 +0200
+++ linux/drivers/media/video/bt848.h	2003-05-08 13:55:11.000000000 +0200
@@ -204,6 +204,9 @@
 #define BT848_COLOR_FMT_YCrCb411    0x99
 #define BT848_COLOR_FMT_RAW         0xee
 
+#define BT848_VTOTAL_LO             0xB0
+#define BT848_VTOTAL_HI             0xB4
+
 #define BT848_COLOR_CTL                0x0D8
 #define BT848_COLOR_CTL_EXT_FRMRATE    (1<<7)
 #define BT848_COLOR_CTL_COLOR_BARS     (1<<6)
@@ -311,29 +314,28 @@
 
 /* WRITE and SKIP */
 /* disable which bytes of each DWORD */
-#define BT848_RISC_BYTE0       (1<<12)
-#define BT848_RISC_BYTE1       (1<<13)
-#define BT848_RISC_BYTE2       (1<<14)
-#define BT848_RISC_BYTE3       (1<<15)
-#define BT848_RISC_BYTE_ALL    (0x0f<<12)
+#define BT848_RISC_BYTE0       (1U<<12)
+#define BT848_RISC_BYTE1       (1U<<13)
+#define BT848_RISC_BYTE2       (1U<<14)
+#define BT848_RISC_BYTE3       (1U<<15)
+#define BT848_RISC_BYTE_ALL    (0x0fU<<12)
 #define BT848_RISC_BYTE_NONE   0
 /* cause RISCI */
-#define BT848_RISC_IRQ         (1<<24)
+#define BT848_RISC_IRQ         (1U<<24)
 /* RISC command is last one in this line */
-#define BT848_RISC_EOL         (1<<26)
+#define BT848_RISC_EOL         (1U<<26)
 /* RISC command is first one in this line */
-#define BT848_RISC_SOL         (1<<27)
-
-#define BT848_RISC_WRITE       (0x01<<28)
-#define BT848_RISC_SKIP        (0x02<<28)
-#define BT848_RISC_WRITEC      (0x05<<28)
-#define BT848_RISC_JUMP        (0x07<<28)
-#define BT848_RISC_SYNC        (0x08<<28)
-
-#define BT848_RISC_WRITE123    (0x09<<28)
-#define BT848_RISC_SKIP123     (0x0a<<28)
-#define BT848_RISC_WRITE1S23   (0x0b<<28)
+#define BT848_RISC_SOL         (1U<<27)
 
+#define BT848_RISC_WRITE       (0x01U<<28)
+#define BT848_RISC_SKIP        (0x02U<<28)
+#define BT848_RISC_WRITEC      (0x05U<<28)
+#define BT848_RISC_JUMP        (0x07U<<28)
+#define BT848_RISC_SYNC        (0x08U<<28)
+
+#define BT848_RISC_WRITE123    (0x09U<<28)
+#define BT848_RISC_SKIP123     (0x0aU<<28)
+#define BT848_RISC_WRITE1S23   (0x0bU<<28)
 
 
 /* Bt848A and higher only !! */
diff -u linux-2.5.69/drivers/media/video/btcx-risc.c linux/drivers/media/video/btcx-risc.c
--- linux-2.5.69/drivers/media/video/btcx-risc.c	2003-05-08 13:55:11.000000000 +0200
+++ linux/drivers/media/video/btcx-risc.c	2003-05-08 13:55:11.000000000 +0200
@@ -0,0 +1,266 @@
+/*
+    btcx-risc.c
+
+    bt848/bt878/cx2388x risc code generator.
+
+    (c) 2000-03 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+*/
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/videodev2.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+#include "btcx-risc.h"
+
+MODULE_DESCRIPTION("some code shared by bttv and cx88xx drivers");
+MODULE_AUTHOR("Gerd Knorr");
+MODULE_LICENSE("GPL");
+
+static unsigned int debug = 0;
+MODULE_PARM(debug,"i");
+MODULE_PARM_DESC(debug,"debug messages, default is 0 (no)");
+
+/* ---------------------------------------------------------- */
+/* allocate/free risc memory                                  */
+
+static int memcnt;
+
+int btcx_riscmem_alloc(struct pci_dev *pci,
+		       struct btcx_riscmem *risc,
+		       unsigned int size)
+{
+	u32 *cpu;
+	dma_addr_t dma;
+	
+	cpu = pci_alloc_consistent(pci, size, &dma);
+	if (NULL == cpu)
+		return -ENOMEM;
+	memset(cpu,0,size);
+
+#if 0
+	if (risc->cpu && risc->size < size) {
+		/* realloc (enlarge buffer) -- copy old stuff */
+		memcpy(cpu,risc->cpu,risc->size);
+		btcx_riscmem_free(pci,risc);
+	}
+#else
+	BUG_ON(NULL != risc->cpu);
+#endif
+	risc->cpu  = cpu;
+	risc->dma  = dma;
+	risc->size = size;
+
+	if (debug) {
+		memcnt++;
+		printk("btcx: riscmem alloc size=%d [%d]\n",size,memcnt);
+	}
+
+	return 0;
+}
+
+void btcx_riscmem_free(struct pci_dev *pci,
+		       struct btcx_riscmem *risc)
+{
+	if (NULL == risc->cpu)
+		return;
+	pci_free_consistent(pci, risc->size, risc->cpu, risc->dma);
+	memset(risc,0,sizeof(*risc));
+	if (debug) {
+		memcnt--;
+		printk("btcx: riscmem free [%d]\n",memcnt);
+	}
+}
+
+/* ---------------------------------------------------------- */
+/* screen overlay helpers                                     */
+
+int
+btcx_screen_clips(int swidth, int sheight, struct v4l2_rect *win,
+		  struct v4l2_clip *clips, unsigned int n)
+{
+	if (win->left < 0) {
+		/* left */
+		clips[n].c.left = 0;
+		clips[n].c.top = 0;
+		clips[n].c.width  = -win->left;
+		clips[n].c.height = win->height;
+		n++;
+	}
+	if (win->left + win->width > swidth) {
+		/* right */
+		clips[n].c.left   = swidth - win->left;
+		clips[n].c.top    = 0;
+		clips[n].c.width  = win->width - clips[n].c.left;
+		clips[n].c.height = win->height;
+		n++;
+	}
+	if (win->top < 0) {
+		/* top */
+		clips[n].c.left = 0;
+		clips[n].c.top = 0;
+		clips[n].c.width  = win->width;
+		clips[n].c.height = -win->top;
+		n++;
+	}
+	if (win->top + win->height > sheight) {
+		/* bottom */
+		clips[n].c.left = 0;
+		clips[n].c.top = sheight - win->top;
+		clips[n].c.width  = win->width;
+		clips[n].c.height = win->height - clips[n].c.top;
+		n++;
+	}
+	return n;
+}
+
+int
+btcx_align(struct v4l2_rect *win, struct v4l2_clip *clips, unsigned int n, int mask)
+{
+	s32 nx,nw,dx;
+	unsigned int i;
+
+	/* fixup window */
+	nx = (win->left + mask) & ~mask;
+	nw = (win->width) & ~mask;
+	if (nx + nw > win->left + win->width)
+		nw -= mask+1;
+	dx = nx - win->left;
+	win->left  = nx;
+	win->width = nw;
+	if (debug)
+		printk(KERN_DEBUG "btcx: window align %dx%d+%d+%d [dx=%d]\n",
+		       win->width, win->height, win->left, win->top, dx);
+
+	/* fixup clips */
+	for (i = 0; i < n; i++) {
+		nx = (clips[i].c.left-dx) & ~mask;
+		nw = (clips[i].c.width) & ~mask;
+		if (nx + nw < clips[i].c.left-dx + clips[i].c.width)
+			nw += mask+1;
+		clips[i].c.left  = nx;
+		clips[i].c.width = nw;
+		if (debug)
+			printk(KERN_DEBUG "btcx:   clip align %dx%d+%d+%d\n",
+			       clips[i].c.width, clips[i].c.height,
+			       clips[i].c.left, clips[i].c.top);
+	}
+	return 0;
+}
+
+void
+btcx_sort_clips(struct v4l2_clip *clips, unsigned int nclips)
+{
+	struct v4l2_clip swap;
+	int i,j,n;
+
+	if (nclips < 2)
+		return;
+	for (i = nclips-2; i >= 0; i--) {
+		for (n = 0, j = 0; j <= i; j++) {
+			if (clips[j].c.left > clips[j+1].c.left) {
+				swap = clips[j];
+				clips[j] = clips[j+1];
+				clips[j+1] = swap;
+				n++;
+			}
+		}
+		if (0 == n)
+			break;
+	}
+}
+
+void
+btcx_calc_skips(int line, int width, unsigned int *maxy,
+		struct btcx_skiplist *skips, unsigned int *nskips,
+		const struct v4l2_clip *clips, unsigned int nclips)
+{
+	unsigned int clip,skip;
+	int end,maxline;
+	
+	skip=0;
+	maxline = 9999;
+	for (clip = 0; clip < nclips; clip++) {
+
+		/* sanity checks */
+		if (clips[clip].c.left + clips[clip].c.width <= 0)
+			continue;
+		if (clips[clip].c.left > (signed)width)
+			break;
+		
+		/* vertical range */
+		if (line > clips[clip].c.top+clips[clip].c.height-1)
+			continue;
+		if (line < clips[clip].c.top) {
+			if (maxline > clips[clip].c.top-1)
+				maxline = clips[clip].c.top-1;
+			continue;
+		}
+		if (maxline > clips[clip].c.top+clips[clip].c.height-1)
+			maxline = clips[clip].c.top+clips[clip].c.height-1;
+
+		/* horizontal range */
+		if (0 == skip || clips[clip].c.left > skips[skip-1].end) {
+			/* new one */
+			skips[skip].start = clips[clip].c.left;
+			if (skips[skip].start < 0)
+				skips[skip].start = 0;
+			skips[skip].end = clips[clip].c.left + clips[clip].c.width;
+			if (skips[skip].end > width)
+				skips[skip].end = width;
+			skip++;
+		} else {
+			/* overlaps -- expand last one */
+			end = clips[clip].c.left + clips[clip].c.width;
+			if (skips[skip-1].end < end)
+				skips[skip-1].end = end;
+			if (skips[skip-1].end > width)
+				skips[skip-1].end = width;
+		}
+	}
+	*nskips = skip;
+	*maxy = maxline;
+
+	if (debug) {
+		printk(KERN_DEBUG "btcx: skips line %d-%d:",line,maxline);
+		for (skip = 0; skip < *nskips; skip++) {
+			printk(" %d-%d",skips[skip].start,skips[skip].end);
+		}
+		printk("\n");
+	}
+}
+
+/* ---------------------------------------------------------- */
+
+EXPORT_SYMBOL(btcx_riscmem_alloc);
+EXPORT_SYMBOL(btcx_riscmem_free);
+
+EXPORT_SYMBOL(btcx_screen_clips);
+EXPORT_SYMBOL(btcx_align);
+EXPORT_SYMBOL(btcx_sort_clips);
+EXPORT_SYMBOL(btcx_calc_skips);
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
diff -u linux-2.5.69/drivers/media/video/btcx-risc.h linux/drivers/media/video/btcx-risc.h
--- linux-2.5.69/drivers/media/video/btcx-risc.h	2003-05-08 13:55:11.000000000 +0200
+++ linux/drivers/media/video/btcx-risc.h	2003-05-08 13:55:11.000000000 +0200
@@ -0,0 +1,33 @@
+
+struct btcx_riscmem {
+	unsigned int   size;
+	u32            *cpu;
+	u32            *jmp;
+	dma_addr_t     dma;
+};
+
+struct btcx_skiplist {
+	int start;
+	int end;
+};
+
+int  btcx_riscmem_alloc(struct pci_dev *pci,
+			struct btcx_riscmem *risc,
+			unsigned int size);
+void btcx_riscmem_free(struct pci_dev *pci,
+		       struct btcx_riscmem *risc);
+
+int btcx_screen_clips(int swidth, int sheight, struct v4l2_rect *win,
+		      struct v4l2_clip *clips, unsigned int n);
+int btcx_align(struct v4l2_rect *win, struct v4l2_clip *clips,
+	       unsigned int n, int mask);
+void btcx_sort_clips(struct v4l2_clip *clips, unsigned int nclips);
+void btcx_calc_skips(int line, int width, unsigned int *maxy,
+		     struct btcx_skiplist *skips, unsigned int *nskips,
+		     const struct v4l2_clip *clips, unsigned int nclips);
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
diff -u linux-2.5.69/drivers/media/video/bttv-cards.c linux/drivers/media/video/bttv-cards.c
--- linux-2.5.69/drivers/media/video/bttv-cards.c	2003-05-08 13:30:55.000000000 +0200
+++ linux/drivers/media/video/bttv-cards.c	2003-05-08 13:55:11.000000000 +0200
@@ -21,7 +21,7 @@
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-    
+
 */
 
 #include <linux/version.h>
@@ -30,6 +30,7 @@
 #include <linux/kmod.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/vmalloc.h>
 
 #include <asm/io.h>
 
@@ -55,32 +56,34 @@
 static void pvbt878p9b_audio(struct bttv *btv, struct video_audio *v, int set);
 static void fv2000s_audio(struct bttv *btv, struct video_audio *v, int set);
 static void windvr_audio(struct bttv *btv, struct video_audio *v, int set);
+static void adtvk503_audio(struct bttv *btv, struct video_audio *v, int set);
 static void rv605_muxsel(struct bttv *btv, unsigned int input);
 static void eagle_muxsel(struct bttv *btv, unsigned int input);
+static void xguard_muxsel(struct bttv *btv, unsigned int input);
 
 static int terratec_active_radio_upgrade(struct bttv *btv);
 static int tea5757_read(struct bttv *btv);
 static int tea5757_write(struct bttv *btv, int value);
-int is_MM20xPCTV(unsigned char eeprom_data[256]);
-
+static void identify_by_eeprom(struct bttv *btv,
+			       unsigned char eeprom_data[256]);
 
 /* config variables */
-static int triton1=0;
-static int vsfx=0;
-static int no_overlay=-1;
-static int latency = -1;
-
-static unsigned int card[BTTV_MAX]  = { [ 0 ... (BTTV_MAX-1) ] = -1};
-static unsigned int pll[BTTV_MAX]   = { [ 0 ... (BTTV_MAX-1) ] = -1};
-static unsigned int tuner[BTTV_MAX] = { [ 0 ... (BTTV_MAX-1) ] = -1};
+static unsigned int triton1=0;
+static unsigned int vsfx=0;
+static unsigned int latency = UNSET;
+unsigned int no_overlay=-1;
+
+static unsigned int card[BTTV_MAX]  = { [ 0 ... (BTTV_MAX-1) ] = UNSET};
+static unsigned int pll[BTTV_MAX]   = { [ 0 ... (BTTV_MAX-1) ] = UNSET};
+static unsigned int tuner[BTTV_MAX] = { [ 0 ... (BTTV_MAX-1) ] = UNSET};
 #ifdef MODULE
 static unsigned int autoload = 1;
 #else
 static unsigned int autoload = 0;
 #endif
-static unsigned int gpiomask = -1;
-static unsigned int audioall = -1;
-static unsigned int audiomux[5] = { -1, -1, -1, -1, -1 };
+static unsigned int gpiomask = UNSET;
+static unsigned int audioall = UNSET;
+static unsigned int audiomux[5] = { [ 0 ... 4 ] = UNSET };
 
 /* insmod options */
 MODULE_PARM(triton1,"i");
@@ -153,9 +156,11 @@
 	{ 0x405010fc, BTTV_GVBCTV4PCI,    "I-O Data Co. GV-BCTV4/PCI" },
 	{ 0x407010fc, BTTV_GVBCTV5PCI,    "I-O Data Co. GV-BCTV5/PCI" },
 
-	{ 0x1200bd11, BTTV_PINNACLE,      "Pinnacle PCTV" },
 	{ 0x001211bd, BTTV_PINNACLE,      "Pinnacle PCTV" },
 	{ 0x001c11bd, BTTV_PINNACLESAT,   "Pinnacle PCTV Sat" },
+	// some cards ship with byteswapped IDs ...
+	{ 0x1200bd11, BTTV_PINNACLE,      "Pinnacle PCTV [bswap]" },
+	{ 0xff00bd11, BTTV_PINNACLE,      "Pinnacle PCTV [bswap]" },
 
 	{ 0x3000121a, BTTV_VOODOOTV_FM,   "3Dfx VoodooTV FM/ VoodooTV 200" },
 	{ 0x3060121a, BTTV_STB2,	  "3Dfx VoodooTV 100/ STB OEM" },
@@ -163,6 +168,7 @@
 	{ 0x3000144f, BTTV_MAGICTVIEW063, "(Askey Magic/others) TView99 CPH06x" },
 	{ 0x3002144f, BTTV_MAGICTVIEW061, "(Askey Magic/others) TView99 CPH05x" },
 	{ 0x3005144f, BTTV_MAGICTVIEW061, "(Askey Magic/others) TView99 CPH061/06L (T1/LC)" },
+	{ 0x5000144f, BTTV_MAGICTVIEW061, "Askey CPH050" },
 	
 	{ 0x00011461, BTTV_AVPHONE98,     "AVerMedia TVPhone98" },
 	{ 0x00021461, BTTV_AVERMEDIA98,   "AVermedia TVCapture 98" },
@@ -192,6 +198,23 @@
 	{ 0x401015b0, BTTV_ZOLTRIX_GENIE, "Zoltrix Genie TV / Radio" },
 	{ 0x401615b0, BTTV_ZOLTRIX_GENIE, "Zoltrix Genie TV / Radio" },
 
+	{ 0x1460aa00, BTTV_PV150,         "Provideo PV150A-1" },
+	{ 0x1461aa01, BTTV_PV150,         "Provideo PV150A-2" },
+	{ 0x1462aa02, BTTV_PV150,         "Provideo PV150A-3" },
+	{ 0x1463aa03, BTTV_PV150,         "Provideo PV150A-4" },
+	{ 0x1464aa04, BTTV_PV150,         "Provideo PV150B-1" },
+	{ 0x1465aa05, BTTV_PV150,         "Provideo PV150B-2" },
+	{ 0x1466aa06, BTTV_PV150,         "Provideo PV150B-3" },
+	{ 0x1467aa07, BTTV_PV150,         "Provideo PV150B-4" },
+
+	{ 0xa1550000, BTTV_IVC200,        "IVC-200" },
+	{ 0xa1550001, BTTV_IVC200,        "IVC-200" },
+	{ 0xa1550002, BTTV_IVC200,        "IVC-200" },
+	{ 0xa1550003, BTTV_IVC200,        "IVC-200" },	
+
+	{ 0x41424344, BTTV_GRANDTEC,      "GrandTec Multi Capture" },
+	{ 0x01020304, BTTV_XGUARD,        "Grandtec Grand X-Guard" },
+	
     	{ 0x010115cb, BTTV_GMV1,          "AG GMV1" },
 	{ 0x010114c7, BTTV_MODTEC_205,    "Modular Technology MM201/MM202/MM205/MM210/MM215 PCTV" },
 	{ 0x18501851, BTTV_CHRONOS_VS2,   "FlyVideo 98 (LR50)/ Chronos Video Shuttle II" },
@@ -202,8 +225,11 @@
 	{ 0x03116000, BTTV_SENSORAY311,   "Sensoray 311" },
 	{ 0x00790e11, BTTV_WINDVR,        "Canopus WinDVR PCI" },
 	{ 0xa0fca1a0, BTTV_ZOLTRIX,       "Face to Face Tvmax" },
-	{ 0xa0fca04f, BTTV_MAGICTVIEW063, "Guillemot Maxi TV Video 3" },
+	{ 0x01010071, BTTV_NEBULA_DIGITV, "Nebula Electronics DigiTV" },
 
+	// likely broken, vendor id doesn't match the other magic views ...
+	//{ 0xa0fca04f, BTTV_MAGICTVIEW063, "Guillemot Maxi TV Video 3" },
+	
 	{ 0, -1, NULL }
 };
 
@@ -376,6 +402,7 @@
 	.muxsel		= { 2, 3, 1, 1},
 	.audiomux	= { 13, 14, 11, 7, 0, 0},
 	.needs_tvaudio	= 1,
+	.msp34xx_alt    = 1,
 	.pll		= PLL_28,
 	.tuner_type	= TUNER_PHILIPS_PAL,
 },{
@@ -613,7 +640,7 @@
 	.pll            = PLL_28,
 	.tuner_type	= -1,
 },{
-	.name		= "Formac iProTV",
+	.name		= "Formac iProTV, Formac ProTV I (bt848)",
 	.video_inputs	= 4,
 	.audio_inputs	= 1,
 	.tuner		= 0,
@@ -763,6 +790,7 @@
 	.pll		= PLL_28,
 	.tuner_type	= -1,
 	.has_radio	= 1,
+	.audio_hook	= avermedia_tvphone_audio,
 },{
 	.name		= "ProVideo PV951", /* pic16c54 */
 	.video_inputs	= 3,
@@ -904,10 +932,10 @@
 /* ---- card 0x34 ---------------------------------- */
 	/* David Härdeman <david@2gen.com> */
 	.name           = "Pinnacle PCTV Studio Pro",
-	.video_inputs   = 3,
+	.video_inputs   = 4,
 	.audio_inputs   = 1,
 	.tuner          = 0,
-	.svhs           = 2,
+	.svhs           = 3,
 	.gpiomask       = 0x03000F,
 	.muxsel		= { 2, 3, 1, 1},
 	.audiomux	= { 1, 0xd0001, 0, 0, 10},
@@ -1535,7 +1563,7 @@
 	.needs_tvaudio  = 0, 
 	.pll            = PLL_28,
 },{
-        .name           = "Formac ProTV II",
+        .name           = "Formac ProTV II (bt878)",
         .video_inputs   = 4,
         .audio_inputs   = 1,
         .tuner          = 0,
@@ -1554,8 +1582,8 @@
 	 not soldered here, though unknown wiring.
          Card lacks: external audio in, pci subsystem id.
        */
-
 },{
+
 	/* ---- card 0x60 ---------------------------------- */
 	.name           = "MachTV",
         .video_inputs   = 3,
@@ -1580,9 +1608,119 @@
 	.no_tda7432     = 1,
 	.muxsel         = { 2, 0, 1},
 	.pll            = PLL_28,
+},{
+	/* Luc Van Hoeylandt <luc@e-magic.be> */
+	.name           = "ProVideo PV150", /* 0x4f */
+	.video_inputs   = 2,
+	.audio_inputs   = 0,
+	.tuner          = -1,
+	.svhs           = -1,
+	.gpiomask       = 0,
+	.muxsel         = { 2, 3 },
+	.audiomux       = { 0 },
+	.needs_tvaudio  = 0,
+	.no_msp34xx     = 1,
+	.pll            = PLL_28,
+	.tuner_type     = -1,
+},{
+	/* Hiroshi Takekawa <sian@big.or.jp> */
+	/* This card lacks subsystem ID */
+	.name           = "AD-TVK503", /* 0x63 */
+	.video_inputs   = 4,
+	.audio_inputs   = 1,
+	.tuner          = 0,
+	.svhs           = 2,
+	.gpiomask       = 0x001e8007,
+	.muxsel         = { 2, 3, 1, 0 },
+                         /* Tuner,      Radio, external, internal, mute, stereo */
+	.audiomux       = { 0x00060000, 0x000, 0x000000, 0x000000, 0x07, 0x0000 }, /* Sub: 0x00180000 */
+	.needs_tvaudio  = 0,
+	.no_msp34xx     = 1,
+	.pll            = PLL_28,
+	.tuner_type     = 2,
+	.audio_hook	= adtvk503_audio,
+},{
+
+	/* ---- card 0x64 ---------------------------------- */
+        .name           = "Hercules Smart TV Stereo",
+        .video_inputs   = 4,
+        .audio_inputs   = 1,
+        .tuner          = 0,
+        .svhs           = 2,
+        .gpiomask       = 0x00,
+        .muxsel         = { 2, 3, 1, 1 },
+        .needs_tvaudio  = 1,
+        .no_msp34xx     = 1,
+        .pll            = PLL_28,
+        .tuner_type     = 5,
+	/* Notes:
+	   - card lacks subsystem ID
+	   - stereo variant w/ daughter board with tda9874a @0xb0
+	   - Audio Routing: 
+		always from tda9874 independent of GPIO (?)
+		external line in: unknown
+	   - Other chips: em78p156elp @ 0x96 (probably IR remote control)
+	              hef4053 (instead 4052) for unknown function
+	*/
+},{
+        .name           = "Pace TV & Radio Card",
+        .video_inputs   = 4,
+        .audio_inputs   = 1,
+        .tuner          = 0,
+        .svhs           = 2,
+        .muxsel         = { 2, 3, 1, 1}, // Tuner, CVid, SVid, CVid over SVid connector
+        .gpiomask       = 0,
+        .no_tda9875     = 1,
+        .no_tda7432     = 1,
+        .tuner_type     = 1,
+        .has_radio      = 1,
+        .pll            = PLL_28,
+        /* Bt878, Bt832, FI1246 tuner; no pci subsystem id
+           only internal line out: (4pin header) RGGL
+           Radio must be decoded by msp3410d (not routed through)*/
+        //         .digital_mode   = DIGITAL_MODE_CAMERA, // todo!
+},{
+        /* Chris Willing <chris@vislab.usyd.edu.au> */
+        .name           = "IVC-200",
+        .video_inputs   = 1,
+        .audio_inputs   = 0,
+        .tuner          = -1,
+        .tuner_type     = -1,
+        .svhs           = -1,
+        .gpiomask       = 0xdf,
+        .muxsel         = { 2 },
+        .pll            = PLL_28,
+},{
+	.name           = "Grand X-Guard / Trust 814PCI",
+	.video_inputs   = 16,
+        .audio_inputs   = 0,
+        .tuner          = -1,
+        .svhs           = -1,
+	.tuner_type     = 4,
+        .gpiomask2      = 0xff,
+	.muxsel         = { 2,2,2,2, 3,3,3,3, 1,1,1,1, 0,0,0,0 },
+	.muxsel_hook    = xguard_muxsel,
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+        .no_tda7432     = 1,
+	.pll            = PLL_28,
+},{
+
+	/* ---- card 0x68 ---------------------------------- */
+	.name           = "Nebula Electronics DigiTV",
+	.video_inputs   = 0,
+	.audio_inputs   = 0,
+	.svhs           = -1,
+	.muxsel         = { 2, 3, 1, 0},
+	.needs_tvaudio  = 0,
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,
+	.pll            = PLL_28,
+	.tuner_type     = -1,
 }};
 
-const int bttv_num_tvcards = (sizeof(bttv_tvcards)/sizeof(struct tvcard));
+const unsigned int bttv_num_tvcards = ARRAY_SIZE(bttv_tvcards);
 
 /* ----------------------------------------------------------------------- */
 
@@ -1614,19 +1752,21 @@
 			printk(KERN_INFO "bttv%d: detected: %s [card=%d], "
 			       "PCI subsystem ID is %04x:%04x\n",
 			       btv->nr,cards[type].name,cards[type].cardnr,
-			       btv->cardid & 0xffff, btv->cardid >> 16);
+			       btv->cardid & 0xffff,
+			       (btv->cardid >> 16) & 0xffff);
 			btv->type = cards[type].cardnr;
 		} else {
 			/* 404 */
 			printk(KERN_INFO "bttv%d: subsystem: %04x:%04x (UNKNOWN)\n",
-			       btv->nr, btv->cardid&0xffff, btv->cardid>>16);
+			       btv->nr, btv->cardid & 0xffff,
+			       (btv->cardid >> 16) & 0xffff);
 			printk(KERN_DEBUG "please mail id, board name and "
 			       "the correct card= insmod option to kraxel@bytesex.org\n");
 		}
 	} 
 
 	/* let the user override the autodetected type */
-	if (card[btv->nr] >= 0 && card[btv->nr] < bttv_num_tvcards)
+	if (card[btv->nr] < bttv_num_tvcards)
 		btv->type=card[btv->nr];
 	
 	/* print which card config we are using */
@@ -1636,14 +1776,14 @@
 		bttv_tvcards[btv->type].name);
 	printk(KERN_INFO "bttv%d: using: %s [card=%d,%s]\n",btv->nr,
 	       btv->video_dev.name,btv->type,
-	       (card[btv->nr] >= 0 && card[btv->nr] < bttv_num_tvcards) ?
-	       "insmod option" : "autodetected");
+	       card[btv->nr] < bttv_num_tvcards
+	       ? "insmod option" : "autodetected");
 
 	/* overwrite gpio stuff ?? */
-	if (-1 == audioall && -1 == audiomux[0])
+	if (UNSET == audioall && UNSET == audiomux[0])
 		return;
 
-	if (-1 != audiomux[0]) {
+	if (UNSET != audiomux[0]) {
 		gpiobits = 0;
 		for (i = 0; i < 5; i++) {
 			bttv_tvcards[btv->type].audiomux[i] = audiomux[i];
@@ -1655,7 +1795,7 @@
 			bttv_tvcards[btv->type].audiomux[i] = audioall;
 		}
 	}
-	bttv_tvcards[btv->type].gpiomask = (-1 != gpiomask) ? gpiomask : gpiobits;
+	bttv_tvcards[btv->type].gpiomask = (UNSET != gpiomask) ? gpiomask : gpiobits;
 	printk(KERN_INFO "bttv%d: gpio config override: mask=0x%x, mux=",
 	       btv->nr,bttv_tvcards[btv->type].gpiomask);
 	for (i = 0; i < 5; i++) {
@@ -1669,13 +1809,22 @@
  */
 
 /* Some Modular Technology cards have an eeprom, but no subsystem ID */
-int is_MM20xPCTV(unsigned char eeprom_data[256])
+void identify_by_eeprom(struct bttv *btv, unsigned char eeprom_data[256])
 {
-	if (0 == strncmp(eeprom_data,"GET.MM20xPCTV",13)) {
-		printk("bttv: GET.MM20xPCTV found\n");
-		return 1; // found
+	int type = -1;
+	
+	if (0 == strncmp(eeprom_data,"GET.MM20xPCTV",13))
+		type = BTTV_MODTEC_205;
+	else if (0 == strncmp(eeprom_data+20,"Picolo",7))
+		type = BTTV_EURESYS_PICOLO;
+	else if (eeprom_data[0] == 0x84 && eeprom_data[2]== 0)
+                type = BTTV_HAUPPAUGE; /* old bt848 */
+
+	if (-1 != type) {
+		btv->type = type;
+		printk("bttv%d: detected by eeprom: %s [card=%d]\n",
+		       btv->nr, bttv_tvcards[btv->type].name, btv->type);
 	}
-	return 0;
 }
 
 static void flyvideo_gpio(struct bttv *btv)
@@ -1779,7 +1928,8 @@
 			if (btv->type == BTTV_PINNACLE)
 				btv->type = BTTV_PINNACLEPRO;
 		}
-		printk(KERN_INFO "bttv%d: miro: id=%d tuner=%d radio=%s stereo=%s\n",
+		printk(KERN_INFO
+		       "bttv%d: miro: id=%d tuner=%d radio=%s stereo=%s\n",
 		       btv->nr, id+1, btv->tuner_type,
 		       !btv->has_radio ? "no" :
 		       (btv->has_matchbox ? "matchbox" : "fmtuner"),
@@ -1813,13 +1963,13 @@
 			info = "oops: unknown card";
 			break;
 		}
+		if (-1 != msp)
+			btv->type = BTTV_PINNACLEPRO;
 		printk(KERN_INFO
 		       "bttv%d: pinnacle/mt: id=%d info=\"%s\" radio=%s\n",
 		       btv->nr, id, info, btv->has_radio ? "yes" : "no");
-		btv->tuner_type = 33;
-		if (autoload)
-			request_module("tda9887");
-		bttv_call_i2c_clients(btv,AUDC_CONFIG_PINNACLE,&id);
+		btv->tuner_type  = 33;
+		btv->pinnacle_id = id;
 	}
 }
 
@@ -1885,6 +2035,9 @@
 	case BTTV_VOODOOTV_FM:
                 boot_msp34xx(btv,20);
 		break;
+	case BTTV_AVERMEDIA98:
+		boot_msp34xx(btv,11);
+		break;
 	case BTTV_HAUPPAUGEPVR:
 		pvr_boot(btv);
 		break;
@@ -1897,13 +2050,8 @@
         btv->tuner_type = -1;
 
 	if (BTTV_UNKNOWN == btv->type) {
-		printk("bttv%d: Looking for eeprom\n",btv->nr);
 		bttv_readee(btv,eeprom_data,0xa0);
-                if(is_MM20xPCTV(eeprom_data)) {
-                        btv->type = BTTV_MODTEC_205;
-			printk("bttv%d: Autodetect by eeprom:(%s) [card=%d]\n",
-			       btv->nr, bttv_tvcards[btv->type].name, btv->type);
-		}
+		identify_by_eeprom(btv,eeprom_data);
 	}
 
 	switch (btv->type) {
@@ -2027,18 +2175,20 @@
 	btv->pll.pll_current = -1;
 
 	/* tuner configuration (from card list / autodetect / insmod option) */
- 	if (-1 != bttv_tvcards[btv->type].tuner_type)
-		if( -1 == btv->tuner_type) 
+ 	if (UNSET != bttv_tvcards[btv->type].tuner_type)
+		if(UNSET == btv->tuner_type) 
                 	btv->tuner_type = bttv_tvcards[btv->type].tuner_type;
-	if (-1 != tuner[btv->nr])
+	if (UNSET != tuner[btv->nr])
 		btv->tuner_type = tuner[btv->nr];
-	if (btv->tuner_type != -1)
-		bttv_call_i2c_clients(btv,TUNER_SET_TYPE,&btv->tuner_type);
 	printk("bttv%d: using tuner=%d\n",btv->nr,btv->tuner_type);
+	if (btv->pinnacle_id != UNSET)
+		bttv_call_i2c_clients(btv,AUDC_CONFIG_PINNACLE,
+				      &btv->pinnacle_id);
+	if (btv->tuner_type != UNSET)
+		bttv_call_i2c_clients(btv,TUNER_SET_TYPE,&btv->tuner_type);
 
 	if (bttv_tvcards[btv->type].has_radio)
 		btv->has_radio=1;
-
 	if (bttv_tvcards[btv->type].audio_hook)
 		btv->audio_hook=bttv_tvcards[btv->type].audio_hook;
 
@@ -2056,6 +2206,12 @@
 			request_module("msp3400");
 	}
 
+	if (bttv_tvcards[btv->type].msp34xx_alt &&
+	    bttv_I2CRead(btv, I2C_MSP3400_ALT, "MSP34xx (alternate address)") >=0) {
+		if (autoload)
+			request_module("msp3400");
+	}
+
 	if (!bttv_tvcards[btv->type].no_tda9875 &&
 	    bttv_I2CRead(btv, I2C_TDA9875, "TDA9875") >=0) {
 		if (autoload)
@@ -2073,7 +2229,12 @@
 			request_module("tvaudio");
 	}
 
-	if (bttv_tvcards[btv->type].tuner != -1) {
+	/* tuner modules */
+	if (btv->pinnacle_id != UNSET) {
+		if (autoload)
+			request_module("tda9887");
+	}
+	if (btv->tuner_type != UNSET) {
 		if (autoload)
 			request_module("tuner");
 	}
@@ -2136,9 +2297,9 @@
         { TUNER_TEMIC_4046FM5,     "Temic 4046FM5" },
 	{ TUNER_TEMIC_4009FN5_MULTI_PAL_FM, "Temic 4009FN5" },
 	{ TUNER_ABSENT,        "Philips TD1536D_FH_44"},
-	{ TUNER_LG_NTSC_FM,    "LG TP18NSR01F"},
-	{ TUNER_LG_PAL_FM,     "LG TP18PSB01D"},
-	{ TUNER_LG_PAL,        "LG TP18PSB11D"},	
+	{ TUNER_LG_NTSC_FM,    "LG TPI8NSR01F"},
+	{ TUNER_LG_PAL_FM,     "LG TPI8PSB01D"},
+	{ TUNER_LG_PAL,        "LG TPI8PSB11D"},	
 	{ TUNER_LG_PAL_I_FM,   "LG TAPC-I001D"},
 	{ TUNER_LG_PAL_I,      "LG TAPC-I701D"}
 };
@@ -2147,15 +2308,17 @@
 {
 	if( strncmp(&(eeprom_data[0x1e]),"Temic 4066 FY5",14) ==0) {
 		btv->tuner_type=TUNER_TEMIC_4066FY5_PAL_I;
-		printk("bttv Modtec: Tuner autodetected %s\n",&eeprom_data[0x1e]);
+		printk("bttv Modtec: Tuner autodetected %s\n",
+		       &eeprom_data[0x1e]);
+	} else {
+		printk("bttv Modtec: Unknown TunerString:%s\n",
+		       &eeprom_data[0x1e]);
 	}
-	else
-		printk("bttv Modtec: Unknown TunerString:%s\n",&eeprom_data[0x1e]);
 }
 
 static void __devinit hauppauge_eeprom(struct bttv *btv)
 {
-	int blk2,tuner,radio,model;
+	unsigned int blk2,tuner,radio,model;
 
 	if (eeprom_data[0] != 0x84 || eeprom_data[2] != 0)
 		printk(KERN_WARNING "bttv%d: Hauppauge eeprom: invalid\n",
@@ -2169,9 +2332,8 @@
 	tuner = eeprom_data[9];
 	radio = eeprom_data[blk2-1] & 0x01;
 	
-        if (tuner >= ARRAY_SIZE(hauppauge_tuner))
-		tuner = 0;
-	btv->tuner_type = hauppauge_tuner[tuner].id;
+        if (tuner < ARRAY_SIZE(hauppauge_tuner))
+                btv->tuner_type = hauppauge_tuner[tuner].id;
 	if (radio)
 		btv->has_radio = 1;
 	
@@ -2540,7 +2702,8 @@
 	static int vals[] __devinitdata = { 0x08, 0x09, 0x0a, 0x0b, 0x0d, 0x0d,
 					    0x01, 0x02, 0x03, 0x04, 0x05, 0x06,
 					    0x00 };
-	int i,tmp;
+	unsigned int i;
+	int tmp;
 
 	/* Initialise GPIO-connevted stuff */
 	btwrite(1<<13,BT848_GPIO_OUT_EN); /* Reset pin only */
@@ -2573,7 +2736,7 @@
 	
 	printk(KERN_INFO "Initialising 12C508 PIC chip ...\n");
 
-	for (i = 0; i < sizeof(vals)/sizeof(int); i++) {
+	for (i = 0; i < ARRAY_SIZE(vals); i++) {
 		tmp=bttv_I2CWrite(btv,0x1E,vals[i],0,1);
 		printk(KERN_INFO "I2C Write(0x08) = %i\nI2C Read () = %x\n\n",
 		       tmp,bttv_I2CRead(btv,0x1F,NULL));
@@ -2670,8 +2833,8 @@
 /* Low-level stuff */
 static int tea5757_read(struct bttv *btv)
 {
+	unsigned long timeout;
 	int value = 0;
-	long timeout;
 	int i;
 	
 	/* better safe than sorry */
@@ -2754,12 +2917,13 @@
 
 void tea5757_set_freq(struct bttv *btv, unsigned short freq)
 {
-	int value;
-	
 	dprintk("tea5757_set_freq %d\n",freq);
 	tea5757_write(btv, 5 * freq + 0x358); /* add 10.7MHz (see docs) */
+#if 0
+	/* breaks Miro PCTV */
 	value = tea5757_read(btv);
-	dprintk("bttv%d: tea5757 readback =0x%x\n",btv->nr,value);
+	dprintk("bttv%d: tea5757 readback=0x%x\n",btv->nr,value);
+#endif
 }
 
 
@@ -3051,6 +3215,38 @@
         }
 }
 
+/*
+ * sound control for AD-TVK503
+ * Hiroshi Takekawa <sian@big.or.jp>
+ */
+static void
+adtvk503_audio(struct bttv *btv, struct video_audio *v, int set)
+{
+	unsigned int con = 0xffffff;
+
+	//btaor(0x1e0000, ~0x1e0000, BT848_GPIO_OUT_EN);
+
+	if (set) {
+		//btor(***, BT848_GPIO_OUT_EN);
+		if (v->mode & VIDEO_SOUND_LANG1)
+			con = 0x00000000;
+		if (v->mode & VIDEO_SOUND_LANG2)
+			con = 0x00180000;
+		if (v->mode & VIDEO_SOUND_STEREO)
+			con = 0x00000000;
+		if (v->mode & VIDEO_SOUND_MONO)
+			con = 0x00060000;
+		if (con != 0xffffff) {
+			btaor(con, ~0x1e0000, BT848_GPIO_DATA);
+			if (bttv_gpio)
+				bttv_gpio_tracking(btv, "adtvk503");
+		}
+	} else {
+		v->mode = VIDEO_SOUND_MONO | VIDEO_SOUND_STEREO |
+			  VIDEO_SOUND_LANG1  | VIDEO_SOUND_LANG2;
+	}
+}
+
 /* RemoteVision MX (rv605) muxsel helper [Miguel Freitas]
  *
  * This is needed because rv605 don't use a normal multiplex, but a crosspoint
@@ -3091,6 +3287,34 @@
 	mdelay(1);
 }
 
+// The Grandtec X-Guard framegrabber card uses two Dual 4-channel
+// video multiplexers to provide up to 16 video inputs. These
+// multiplexers are controlled by the lower 8 GPIO pins of the
+// bt878. The multiplexers probably Pericom PI5V331Q or similar.
+
+// xxx0 is pin xxx of multiplexer U5,
+// yyy1 is pin yyy of multiplexer U2
+
+#define ENA0    0x01
+#define ENB0    0x02
+#define ENA1    0x04
+#define ENB1    0x08
+
+#define IN10    0x10
+#define IN00    0x20
+#define IN11    0x40
+#define IN01    0x80
+
+static void xguard_muxsel(struct bttv *btv, unsigned int input)
+{
+	static const int masks[] = {
+                ENB0, ENB0|IN00, ENB0|IN10, ENB0|IN00|IN10,
+                ENA0, ENA0|IN00, ENA0|IN10, ENA0|IN00|IN10,
+                ENB1, ENB1|IN01, ENB1|IN11, ENB1|IN01|IN11,
+                ENA1, ENA1|IN01, ENA1|IN11, ENA1|IN01|IN11,
+	};
+        btwrite(masks[input%16], BT848_GPIO_DATA);
+}
 
 /* ----------------------------------------------------------------------- */
 /* motherboard chipset specific stuff                                      */
@@ -3122,12 +3346,12 @@
 		printk(KERN_INFO "bttv: Host bridge needs VSFX enabled.\n");
 	if (pcipci_fail) {
 		printk(KERN_WARNING "bttv: BT848 and your chipset may not work together.\n");
-		if (-1 == no_overlay) {
+		if (UNSET == no_overlay) {
 			printk(KERN_WARNING "bttv: going to disable overlay.\n");
 			no_overlay = 1;
 		}
 	}
-	if (-1 != latency)
+	if (UNSET != latency)
 		printk(KERN_INFO "bttv: pci latency fixup [%d]\n",latency);
 
 	while ((dev = pci_find_device(PCI_VENDOR_ID_INTEL,
@@ -3144,7 +3368,7 @@
 {
  	unsigned char command;
 
-	if (!triton1 && !vsfx && -1 == latency)
+	if (!triton1 && !vsfx && UNSET == latency)
 		return 0;
 
 	if (bttv_verbose) {
@@ -3152,7 +3376,7 @@
 			printk(KERN_INFO "bttv%d: enabling ETBF (430FX/VP3 compatibilty)\n",btv->nr);
 		if (vsfx && btv->id >= 878)
 			printk(KERN_INFO "bttv%d: enabling VSFX\n",btv->nr);
-		if (-1 != latency)
+		if (UNSET != latency)
 			printk(KERN_INFO "bttv%d: setting pci timer to %d\n",
 			       btv->nr,latency);
 	}
@@ -3170,7 +3394,7 @@
 			command |= BT878_EN_VSFX;
                 pci_write_config_byte(btv->dev, BT878_DEVCTRL, command);
         }
-	if (-1 != latency)
+	if (UNSET != latency)
 		pci_write_config_byte(btv->dev, PCI_LATENCY_TIMER, latency);
 	return 0;
 }
diff -u linux-2.5.69/drivers/media/video/bttv-driver.c linux/drivers/media/video/bttv-driver.c
--- linux-2.5.69/drivers/media/video/bttv-driver.c	2003-05-08 13:31:37.000000000 +0200
+++ linux/drivers/media/video/bttv-driver.c	2003-05-08 13:55:11.000000000 +0200
@@ -35,10 +35,11 @@
 #include <linux/kdev_t.h>
 
 #include <asm/io.h>
+#include <asm/byteorder.h>
 
 #include "bttvp.h"
 
-int bttv_num;			/* number of Bt848s in use */
+unsigned int bttv_num;			/* number of Bt848s in use */
 struct bttv bttvs[BTTV_MAX];
 
 unsigned int bttv_debug = 0;
@@ -46,7 +47,7 @@
 unsigned int bttv_gpio = 0;
 
 /* config variables */
-#if defined(__sparc__) || defined(__powerpc__) || defined(__hppa__)
+#ifdef __BIG_ENDIAN
 static unsigned int bigendian=1;
 #else
 static unsigned int bigendian=0;
@@ -275,9 +276,29 @@
 		.vdelay         = 0x16,
 		.vbipack        = 144,
 		.sram           = -1,
+	},{
+		/* that one hopefully works with the strange timing
+		 * which video recorders produce when playing a NTSC
+		 * tape on a PAL TV ... */
+		.v4l2_id        = V4L2_STD_PAL_60,
+		.name           = "PAL-60",
+		.Fsc            = 35468950,
+		.swidth         = 924,
+		.sheight        = 480,
+		.totalwidth     = 1135,
+		.adelay         = 0x7f,
+		.bdelay         = 0x72,
+		.iform          = (BT848_IFORM_PAL_BDGHI|BT848_IFORM_XT1),
+		.scaledtwidth   = 1135,
+		.hdelayx1       = 186,
+		.hactivex1      = 924,
+		.vdelay         = 0x1a,
+		.vbipack        = 255,
+		.vtotal         = 524,
+		.sram           = -1,
 	}
 };
-const int BTTV_TVNORMS = (sizeof(bttv_tvnorms)/sizeof(struct bttv_tvnorm));
+const unsigned int BTTV_TVNORMS = ARRAY_SIZE(bttv_tvnorms);
 
 /* ----------------------------------------------------------------------- */
 /* bttv format list
@@ -434,7 +455,7 @@
 		.flags    = FORMAT_FLAGS_RAW,
 	}
 };
-const int BTTV_FORMATS = (sizeof(bttv_formats)/sizeof(struct bttv_format));
+const unsigned int BTTV_FORMATS = ARRAY_SIZE(bttv_formats);
 
 /* ----------------------------------------------------------------------- */
 
@@ -557,7 +578,7 @@
 		.type          = V4L2_CTRL_TYPE_BOOLEAN,
 	}
 };
-const int BTTV_CTLS = (sizeof(bttv_ctls)/sizeof(struct v4l2_queryctrl));
+const int BTTV_CTLS = ARRAY_SIZE(bttv_ctls);
 
 /* ----------------------------------------------------------------------- */
 /* resource management                                                     */
@@ -1159,7 +1180,7 @@
 static const struct bttv_format*
 format_by_palette(int palette)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < BTTV_FORMATS; i++) {
 		if (-1 == bttv_formats[i].palette)
@@ -1173,7 +1194,7 @@
 static const struct bttv_format*
 format_by_fourcc(int fourcc)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < BTTV_FORMATS; i++) {
 		if (-1 == bttv_formats[i].fourcc)
@@ -1195,6 +1216,7 @@
 	unsigned long flags;
 	int retval = 0;
 
+	dprintk("switch_overlay: enter [new=%p]\n",new);
 	if (new)
 		new->vb.state = STATE_DONE;
 	spin_lock_irqsave(&btv->s_lock,flags);
@@ -1204,8 +1226,12 @@
 	spin_unlock_irqrestore(&btv->s_lock,flags);
 	if (NULL == new)
 		free_btres(btv,fh,RESOURCE_OVERLAY);
-	if (NULL != old)
+	if (NULL != old) {
+		dprintk("switch_overlay: old=%p state is %d\n",old,old->vb.state);
 		bttv_dma_free(btv, old);
+		kfree(old);
+	}
+	dprintk("switch_overlay: done\n");
 	return retval;
 }
 
@@ -1214,7 +1240,7 @@
 
 static int bttv_prepare_buffer(struct bttv *btv, struct bttv_buffer *buf,
  			       const struct bttv_format *fmt,
-			       int width, int height,
+			       unsigned int width, unsigned int height,
 			       enum v4l2_field field)
 {
 	int redo_dma_risc = 0;
@@ -1252,13 +1278,6 @@
 		redo_dma_risc = 1;
 	}
 
-#if 0
-	if (STATE_NEEDS_INIT == buf->vb.state) {
-		if (redo_dma_risc)
-			bttv_dma_free(btv,buf);
-	}
-#endif
-
 	/* alloc risc memory */
 	if (STATE_NEEDS_INIT == buf->vb.state) {
 		redo_dma_risc = 1;
@@ -1334,7 +1353,7 @@
 	"SFREQ", "GAUDIO", "SAUDIO", "SYNC", "MCAPTURE", "GMBUF", "GUNIT",
 	"GCAPTURE", "SCAPTURE", "SPLAYMODE", "SWRITEMODE", "GPLAYINFO",
 	"SMICROCODE", "GVBIFMT", "SVBIFMT" };
-#define V4L1_IOCTLS (sizeof(v4l1_ioctls)/sizeof(char*))
+#define V4L1_IOCTLS ARRAY_SIZE(v4l1_ioctls)
 
 int bttv_common_ioctls(struct bttv *btv, unsigned int cmd, void *arg)
 {
@@ -1365,7 +1384,7 @@
 	{
 		struct video_tuner *v = arg;
 		
-		if (-1 == bttv_tvcards[btv->type].tuner)
+		if (UNSET == bttv_tvcards[btv->type].tuner)
 			return -EINVAL;
 		if (v->tuner) /* Only tuner 0 */
 			return -EINVAL;
@@ -1397,38 +1416,39 @@
         case VIDIOCGCHAN:
         {
                 struct video_channel *v = arg;
+		unsigned int channel = v->channel;
 
-                if (v->channel >= bttv_tvcards[btv->type].video_inputs)
+                if (channel >= bttv_tvcards[btv->type].video_inputs)
                         return -EINVAL;
                 v->tuners=0;
                 v->flags = VIDEO_VC_AUDIO;
                 v->type = VIDEO_TYPE_CAMERA;
                 v->norm = btv->tvnorm;
-                if(v->channel == bttv_tvcards[btv->type].tuner)  {
+		if (channel == bttv_tvcards[btv->type].tuner)  {
                         strcpy(v->name,"Television");
                         v->flags|=VIDEO_VC_TUNER;
                         v->type=VIDEO_TYPE_TV;
                         v->tuners=1;
-                } else if (v->channel == bttv_tvcards[btv->type].svhs) {
+                } else if (channel == bttv_tvcards[btv->type].svhs) {
                         strcpy(v->name,"S-Video");
                 } else {
-                        sprintf(v->name,"Composite%d",v->channel);
+                        sprintf(v->name,"Composite%d",channel);
 		}
 		return 0;
         }
         case VIDIOCSCHAN:
         {
                 struct video_channel *v = arg;
+		unsigned int channel = v->channel;
 
-		if (v->channel <  0 ||
-		    v->channel >= bttv_tvcards[btv->type].video_inputs)
+		if (channel >= bttv_tvcards[btv->type].video_inputs)
 			return -EINVAL;
 		if (v->norm >= BTTV_TVNORMS)
 			return -EINVAL;
 
 		down(&btv->lock);
-		if (v->channel == btv->input &&
-		    v->norm    == btv->tvnorm) {
+		if (channel == btv->input &&
+		    v->norm == btv->tvnorm) {
 			/* nothing to do */
 			up(&btv->lock);
 			return 0;
@@ -1462,9 +1482,9 @@
 	case VIDIOCSAUDIO:
 	{
 		struct video_audio *v = arg;
+		unsigned int audio = v->audio;
 
-		if(v->audio <  0 ||
-		   v->audio >= bttv_tvcards[btv->type].audio_inputs)
+		if (audio >= bttv_tvcards[btv->type].audio_inputs)
 			return -EINVAL;
 
 		down(&btv->lock);
@@ -1483,11 +1503,13 @@
 	case VIDIOC_ENUMSTD:
 	{
 		struct v4l2_standard *e = arg;
+		unsigned int index = e->index;
 		
-		if (e->index < 0 || e->index >= BTTV_TVNORMS)
+		if (index >= BTTV_TVNORMS)
 			return -EINVAL;
 		v4l2_video_std_construct(e, bttv_tvnorms[e->index].v4l2_id,
 					 bttv_tvnorms[e->index].name);
+		e->index = index;
 		return 0;
 	}
 	case VIDIOC_G_STD:
@@ -1499,7 +1521,7 @@
 	case VIDIOC_S_STD:
 	{
 		v4l2_std_id *id = arg;
-		int i;
+		unsigned int i;
 
 		for (i = 0; i < BTTV_TVNORMS; i++)
 			if (*id & bttv_tvnorms[i].v4l2_id)
@@ -1527,7 +1549,7 @@
 	case VIDIOC_ENUMINPUT:
 	{
 		struct v4l2_input *i = arg;
-		int n;
+		unsigned int n;
 		
 		n = i->index;
 		if (n >= bttv_tvcards[btv->type].video_inputs)
@@ -1564,9 +1586,9 @@
 	}
 	case VIDIOC_S_INPUT:
 	{
-		int *i = arg;
+		unsigned int *i = arg;
 		
-		if (*i < 0 || *i > bttv_tvcards[btv->type].video_inputs)
+		if (*i > bttv_tvcards[btv->type].video_inputs)
 			return -EINVAL;
 		down(&btv->lock);
 		set_input(btv,*i);
@@ -1579,7 +1601,7 @@
 	{
 		struct v4l2_tuner *t = arg;
 
-		if (-1 == bttv_tvcards[btv->type].tuner)
+		if (UNSET == bttv_tvcards[btv->type].tuner)
 			return -EINVAL;
 		if (0 != t->index)
 			return -EINVAL;
@@ -1587,8 +1609,8 @@
 		memset(t,0,sizeof(*t));
 		strcpy(t->name, "Television");
 		t->type       = V4L2_TUNER_ANALOG_TV;
-		t->capability = V4L2_TUNER_CAP_NORM;
 		t->rangehigh  = 0xffffffffUL;
+		t->capability = V4L2_TUNER_CAP_NORM;
 		t->rxsubchans = V4L2_TUNER_SUB_MONO;
 		if (btread(BT848_DSTATUS)&BT848_DSTATUS_HLOC)
 			t->signal = 0xffff;
@@ -1599,12 +1621,15 @@
 			bttv_call_i2c_clients(btv, VIDIOCGAUDIO, &va);
 			if (btv->audio_hook)
 				btv->audio_hook(btv,&va,0);
-			if(va.mode & VIDEO_SOUND_STEREO)
+			if(va.mode & VIDEO_SOUND_STEREO) {
+				t->audmode     = V4L2_TUNER_MODE_STEREO;
 				t->rxsubchans |= V4L2_TUNER_SUB_STEREO;
-			if(va.mode & VIDEO_SOUND_LANG1)
-				t->rxsubchans |= V4L2_TUNER_SUB_LANG1;
-			if(va.mode & VIDEO_SOUND_LANG2)
-				t->rxsubchans |= V4L2_TUNER_SUB_LANG2;
+			}
+			if(va.mode & VIDEO_SOUND_LANG1) {
+				t->audmode    = V4L2_TUNER_MODE_LANG1;
+				t->rxsubchans = V4L2_TUNER_SUB_LANG1
+					| V4L2_TUNER_SUB_LANG2;
+			}
 		}
 		/* FIXME: fill capability+audmode */
 		up(&btv->lock);
@@ -1614,7 +1639,7 @@
 	{
 		struct v4l2_tuner *t = arg;
 
-		if (-1 == bttv_tvcards[btv->type].tuner)
+		if (UNSET == bttv_tvcards[btv->type].tuner)
 			return -EINVAL;
 		if (0 != t->index)
 			return -EINVAL;
@@ -1622,6 +1647,7 @@
 		{
 			struct video_audio va;
 			memset(&va, 0, sizeof(struct video_audio));
+			bttv_call_i2c_clients(btv, VIDIOCGAUDIO, &va);
 			if (t->audmode == V4L2_TUNER_MODE_MONO)
 				va.mode = VIDEO_SOUND_MONO;
 			else if (t->audmode == V4L2_TUNER_MODE_STEREO)
@@ -1676,7 +1702,7 @@
 {
 	enum v4l2_field field;
 	int maxw, maxh;
-	
+
 	if (win->w.width  < 48 || win->w.height < 32)
 		return -EINVAL;
 	if (win->clipcount > 2048)
@@ -1705,15 +1731,6 @@
 	if (!fixup && (win->w.width > maxw || win->w.height > maxh))
 		return -EINVAL;
 
-	if (1 /* depth < 4bpp */) {
-		/* adjust and align writes */
-		int left     = (win->w.left + 3) & ~3;
-		int width    = win->w.width & ~3;
-		while (left + width > win->w.left + win->w.width)
-			width -= 4;
-		win->w.left  = left;
-		win->w.width = width;
-	}
 	if (win->w.width > maxw)
 		win->w.width = maxw;
 	if (win->w.height > maxh)
@@ -1728,6 +1745,8 @@
 	struct v4l2_clip *clips = NULL;
 	int n,size,retval = 0;
 
+	if (NULL == fh->ovfmt)
+		return -EINVAL;
 	retval = verify_window(&bttv_tvnorms[btv->tvnorm],win,fixup);
 	if (0 != retval)
 		return retval;
@@ -1735,33 +1754,50 @@
 	/* copy clips  --  luckily v4l1 + v4l2 are binary
 	   compatible here ...*/
 	n = win->clipcount;
-	size = sizeof(struct video_clip)*(n+4);
+	size = sizeof(*clips)*(n+4);
 	clips = kmalloc(size,GFP_KERNEL);
 	if (NULL == clips)
 		return -ENOMEM;
 	if (n > 0) {
-		if (copy_from_user(clips,win->clips,
-				   sizeof(struct v4l2_clip)*win->clipcount)) {
+		if (copy_from_user(clips,win->clips,sizeof(struct v4l2_clip)*n)) {
 			kfree(clips);
 			return -EFAULT;
 		}
 	}
 	/* clip against screen */
 	if (NULL != btv->fbuf.base)
-		n = bttv_screen_clips(btv->fbuf.width, btv->fbuf.width,
+		n = btcx_screen_clips(btv->fbuf.width, btv->fbuf.width,
 				      &win->w, clips, n);
-	bttv_sort_clips(clips,n);
+	btcx_sort_clips(clips,n);
+
+	/* 4-byte alignments */
+	switch (fh->ovfmt->depth) {
+	case 8:
+	case 24:
+		btcx_align(&win->w, clips, n, 3);
+		break;
+	case 16:
+		btcx_align(&win->w, clips, n, 1);
+		break;
+	case 32:
+		/* no alignment fixups needed */
+		break;
+	default:
+		BUG();
+	}
 	
 	down(&fh->cap.lock);
 	if (fh->ov.clips)
 		kfree(fh->ov.clips);
-	fh->ov.clips   = clips;
-	fh->ov.nclips  = n;
+	fh->ov.clips    = clips;
+	fh->ov.nclips   = n;
 	
-	fh->ov.w       = win->w;
-	fh->ov.field   = win->field;
+	fh->ov.w        = win->w;
+	fh->ov.field    = win->field;
+	fh->ov.setup_ok = 1;
 	btv->init.ov.w.width   = win->w.width;
 	btv->init.ov.w.height  = win->w.height;
+	btv->init.ov.field     = win->field;
 	
 	/* update overlay if needed */
 	retval = 0;
@@ -1834,8 +1870,10 @@
 		f->fmt.pix.height       = fh->height;
 		f->fmt.pix.field        = fh->cap.field;
 		f->fmt.pix.pixelformat  = fh->fmt->fourcc;
-		f->fmt.pix.sizeimage    =
-			(fh->width * fh->height * fh->fmt->depth)/8;
+		f->fmt.pix.bytesperline =
+			(f->fmt.pix.width * fh->fmt->depth) >> 3;
+		f->fmt.pix.sizeimage =
+			f->fmt.pix.height * f->fmt.pix.bytesperline;
 		return 0;
 	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
 		memset(&f->fmt.win,0,sizeof(struct v4l2_window));
@@ -1843,7 +1881,7 @@
 		f->fmt.win.field = fh->ov.field;
 		return 0;
 	case V4L2_BUF_TYPE_VBI_CAPTURE:
-		bttv_vbi_fmt(fh,f);
+		bttv_vbi_get_fmt(fh,f);
 		return 0;
 	default:
 		return -EINVAL;
@@ -1858,14 +1896,11 @@
 	{
 		const struct bttv_format *fmt;
 		enum v4l2_field field;
-		int maxw,maxh;
+		unsigned int maxw,maxh;
 
 		fmt = format_by_fourcc(f->fmt.pix.pixelformat);
 		if (NULL == fmt)
 			return -EINVAL;
-		if (0 != f->fmt.pix.bytesperline)
-			/* FIXME -- not implemented yet */
-			return -EINVAL;
 
 		/* fixup format */
 		maxw  = bttv_tvnorms[btv->tvnorm].swidth;
@@ -1880,6 +1915,7 @@
 		switch (field) {
 		case V4L2_FIELD_TOP:
 		case V4L2_FIELD_BOTTOM:
+		case V4L2_FIELD_ALTERNATE:
 			maxh = maxh/2;
 			break;
 		case V4L2_FIELD_INTERLACED:
@@ -1887,6 +1923,7 @@
 		case V4L2_FIELD_SEQ_TB:
 			if (fmt->flags & FORMAT_FLAGS_PLANAR)
 				return -EINVAL;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -1901,25 +1938,19 @@
 			f->fmt.pix.width = maxw;
 		if (f->fmt.pix.height > maxh)
 			f->fmt.pix.height = maxh;
+		f->fmt.pix.bytesperline =
+			(f->fmt.pix.width * fmt->depth) >> 3;
 		f->fmt.pix.sizeimage =
-			(fh->width * fh->height * fmt->depth)/8;
+			f->fmt.pix.height * f->fmt.pix.bytesperline;
 		
 		return 0;
 	}
 	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
 		return verify_window(&bttv_tvnorms[btv->tvnorm],
 				     &f->fmt.win, 1);
-#if 0
 	case V4L2_BUF_TYPE_VBI_CAPTURE:
-		retval = bttv_switch_type(fh,f->type);
-		if (0 != retval)
-			return retval;
-		if (fh->vbi.reading || fh->vbi.streaming)
-			return -EBUSY;
-		bttv_vbi_setlines(fh,btv,f->fmt.vbi.count[0]);
-		bttv_vbi_fmt(fh,f);
+		bttv_vbi_try_fmt(fh,f);
 		return 0;
-#endif
 	default:
 		return -EINVAL;
 	}
@@ -1947,6 +1978,7 @@
 		down(&fh->cap.lock);
 		fh->fmt              = fmt;
 		fh->cap.field        = f->fmt.pix.field;
+		fh->cap.last         = V4L2_FIELD_NONE;
 		fh->width            = f->fmt.pix.width;
 		fh->height           = f->fmt.pix.height;
 		btv->init.fmt        = fmt;
@@ -1962,10 +1994,11 @@
 		retval = bttv_switch_type(fh,f->type);
 		if (0 != retval)
 			return retval;
-		if (fh->vbi.reading || fh->vbi.streaming)
-			return -EBUSY;
+		if (locked_btres(fh->btv, RESOURCE_VBI))
+                        return -EBUSY;
+		bttv_vbi_try_fmt(fh,f);
 		bttv_vbi_setlines(fh,btv,f->fmt.vbi.count[0]);
-		bttv_vbi_fmt(fh,f);
+		bttv_vbi_get_fmt(fh,f);
 		return 0;
 	default:
 		return -EINVAL;
@@ -1978,7 +2011,7 @@
 	struct bttv_fh *fh  = file->private_data;
 	struct bttv    *btv = fh->btv;
 	unsigned long flags;
-	int retval;
+	int retval = 0;
 
 	if (bttv_debug > 1) {
 		switch (_IOC_TYPE(cmd)) {
@@ -2092,7 +2125,7 @@
 		struct video_window *win = arg;
 		struct v4l2_window w2;
 
-		w2.field     = V4L2_FIELD_ANY;
+		w2.field = V4L2_FIELD_ANY;
 		w2.w.left    = win->x;
 		w2.w.top     = win->y;
 		w2.w.width   = win->width;
@@ -2181,11 +2214,7 @@
 			/* verify args */
 			if (NULL == btv->fbuf.base)
 				return -EINVAL;
-			if (fh->ov.w.width <48 ||
-			    fh->ov.w.height<32 ||
-			    fh->ov.w.width >bttv_tvnorms[btv->tvnorm].swidth ||
-			    fh->ov.w.height>bttv_tvnorms[btv->tvnorm].sheight||
-			    NULL == fh->ovfmt)
+			if (!fh->ov.setup_ok)
 				return -EINVAL;
 		}
 
@@ -2210,7 +2239,7 @@
 	case VIDIOCGMBUF:
 	{
 		struct video_mbuf *mbuf = arg;
-		int i;
+		unsigned int i;
 
 		down(&fh->cap.lock);
 		retval = videobuf_mmap_setup(file,&fh->cap,gbuffers,gbufsize);
@@ -2290,6 +2319,53 @@
 		return retval;
 	}
 
+	case VIDIOCGVBIFMT:
+	{
+		struct vbi_format *fmt = (void *) arg;
+		struct v4l2_format fmt2;
+		
+		retval = bttv_switch_type(fh,V4L2_BUF_TYPE_VBI_CAPTURE);
+		if (0 != retval)
+			return retval;
+		bttv_vbi_get_fmt(fh, &fmt2);
+		
+		fmt->sampling_rate    = fmt2.fmt.vbi.sampling_rate;
+		fmt->samples_per_line = fmt2.fmt.vbi.samples_per_line;
+		fmt->sample_format    = VIDEO_PALETTE_RAW;
+		fmt->start[0]         = fmt2.fmt.vbi.start[0];
+		fmt->count[0]         = fmt2.fmt.vbi.count[0];
+		fmt->start[1]         = fmt2.fmt.vbi.start[1];
+		fmt->count[1]         = fmt2.fmt.vbi.count[1];
+		if (fmt2.fmt.vbi.flags & VBI_UNSYNC)
+			fmt->flags   |= V4L2_VBI_UNSYNC;
+		if (fmt2.fmt.vbi.flags & VBI_INTERLACED)
+			fmt->flags   |= V4L2_VBI_INTERLACED;
+		return 0;
+	}
+	case VIDIOCSVBIFMT:
+	{
+		struct vbi_format *fmt = (void *) arg;
+		struct v4l2_format fmt2;
+
+		retval = bttv_switch_type(fh,V4L2_BUF_TYPE_VBI_CAPTURE);
+		if (0 != retval)
+			return retval;
+		bttv_vbi_get_fmt(fh, &fmt2);
+
+		if (fmt->sampling_rate    != fmt2.fmt.vbi.sampling_rate     ||
+		    fmt->samples_per_line != fmt2.fmt.vbi.samples_per_line  ||
+		    fmt->sample_format    != VIDEO_PALETTE_RAW              ||
+		    fmt->start[0]         != fmt2.fmt.vbi.start[0]          ||
+		    fmt->start[1]         != fmt2.fmt.vbi.start[1]          ||
+		    fmt->count[0]         != fmt->count[1]                  ||
+		    fmt->count[0]         <  1                              ||
+		    fmt->count[0]         >  32 /* VBI_MAXLINES */)
+			return -EINVAL;
+
+		bttv_vbi_setlines(fh,btv,fmt->count[0]);
+		return 0;
+	}
+
         case BTTV_VERSION:
         case VIDIOCGFREQ:
         case VIDIOCSFREQ:
@@ -2326,7 +2402,8 @@
 	{
 		struct v4l2_fmtdesc *f = arg;
 		enum v4l2_buf_type type;
-		int i, index;
+		unsigned int i;
+		int index;
 
 		type  = f->type;
 		if (V4L2_BUF_TYPE_VBI_CAPTURE == type) {
@@ -2347,7 +2424,7 @@
 		for (i = 0; i < BTTV_FORMATS; i++) {
 			if (bttv_formats[i].fourcc != -1)
 				index++;
-			if (index == f->index)
+			if ((unsigned int)index == f->index)
 				break;
 		}
 		if (BTTV_FORMATS == i)
@@ -2604,8 +2681,8 @@
 
 	if (fh->btv->errors)
 		bttv_reinit_bt848(fh->btv);
-	dprintk("read count=%d type=%s\n",
-		(int)count,v4l2_type_names[fh->type]);
+	dprintk("bttv%d: read count=%d type=%s\n",
+		fh->btv->nr,(int)count,v4l2_type_names[fh->type]);
 
 	switch (fh->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
@@ -2628,6 +2705,7 @@
 {
 	struct bttv_fh *fh = file->private_data;
 	struct bttv_buffer *buf;
+	enum v4l2_field field;
 
 	if (V4L2_BUF_TYPE_VBI_CAPTURE == fh->type) {
 		if (!check_alloc_btres(fh->btv,fh,RESOURCE_VBI))
@@ -2654,7 +2732,8 @@
 				up(&fh->cap.lock);
 				return POLLERR;
 			}
-			if (0 != fh->cap.ops->buf_prepare(file,fh->cap.read_buf,fh->cap.field)) {
+			field = videobuf_next_field(&fh->cap);
+			if (0 != fh->cap.ops->buf_prepare(file,fh->cap.read_buf,field)) {
 				up(&fh->cap.lock);
 				return POLLERR;
 			}
@@ -2674,11 +2753,11 @@
 
 static int bttv_open(struct inode *inode, struct file *file)
 {
-	unsigned int minor = minor(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct bttv *btv = NULL;
 	struct bttv_fh *fh;
 	enum v4l2_buf_type type = 0;
-	int i;
+	unsigned int i;
 
 	dprintk(KERN_DEBUG "bttv: open minor=%d\n",minor);
 
@@ -2707,6 +2786,7 @@
 	file->private_data = fh;
 	*fh = btv->init;
 	fh->type = type;
+	fh->ov.setup_ok = 0;
 	videobuf_queue_init(&fh->cap, &bttv_video_qops,
 			    btv->dev, &btv->s_lock,
 			    V4L2_BUF_TYPE_VIDEO_CAPTURE,
@@ -2720,6 +2800,8 @@
 	i2c_vidiocschan(btv);
 
 	btv->users++;
+	if (V4L2_BUF_TYPE_VBI_CAPTURE == fh->type)
+		bttv_vbi_setlines(fh,btv,16);
 	bttv_field_count(btv);
 	return 0;
 }
@@ -2807,10 +2889,10 @@
 
 static int radio_open(struct inode *inode, struct file *file)
 {
-	unsigned int minor = minor(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct bttv *btv = NULL;
-	unsigned long v = 400*16;
-	int i;
+	u32 v = 400*16;
+	unsigned int i;
 
 	dprintk("bttv: open minor=%d\n",minor);
 
@@ -2934,10 +3016,10 @@
 
 static void bttv_print_irqbits(u32 print, u32 mark)
 {
-	int i;
+	unsigned int i;
 	
 	printk("bits:");
-	for (i = 0; i < (sizeof(irq_name)/sizeof(char*)); i++) {
+	for (i = 0; i < ARRAY_SIZE(irq_name); i++) {
 		if (print & (1 << i))
 			printk(" %s",irq_name[i]);
 		if (mark & (1 << i))
@@ -2950,22 +3032,132 @@
 	printk("  main: %08Lx\n",
 	       (u64)btv->main.dma);
 	printk("  vbi : o=%08Lx e=%08Lx\n",
-	       btv->vcurr ? (u64)btv->vcurr->top.dma : 0,
-	       btv->vcurr ? (u64)btv->vcurr->bottom.dma : 0);
+	       btv->curr.vbi ? (u64)btv->curr.vbi->top.dma : 0,
+	       btv->curr.vbi ? (u64)btv->curr.vbi->bottom.dma : 0);
 	printk("  cap : o=%08Lx e=%08Lx\n",
-	       btv->top    ? (u64)btv->top->top.dma : 0,
-	       btv->bottom ? (u64)btv->bottom->bottom.dma : 0);
+	       btv->curr.top    ? (u64)btv->curr.top->top.dma : 0,
+	       btv->curr.bottom ? (u64)btv->curr.bottom->bottom.dma : 0);
 	printk("  scr : o=%08Lx e=%08Lx\n",
 	       btv->screen ? (u64)btv->screen->top.dma  : 0,
 	       btv->screen ? (u64)btv->screen->bottom.dma : 0);
 }
 
+static int
+bttv_irq_next_set(struct bttv *btv, struct bttv_buffer_set *set)
+{
+	struct bttv_buffer *item;
+
+	memset(set,0,sizeof(*set));
+
+	/* vbi request ? */
+	if (!list_empty(&btv->vcapture)) {
+		set->irqflags = 1;
+		set->vbi = list_entry(btv->vcapture.next, struct bttv_buffer, vb.queue);
+	}
+
+	/* capture request ? */
+	if (!list_empty(&btv->capture)) {
+		set->irqflags = 1;
+		item = list_entry(btv->capture.next, struct bttv_buffer, vb.queue);
+		if (V4L2_FIELD_HAS_TOP(item->vb.field))
+			set->top    = item;
+		if (V4L2_FIELD_HAS_BOTTOM(item->vb.field))
+			set->bottom = item;
+
+		/* capture request for other field ? */
+		if (!V4L2_FIELD_HAS_BOTH(item->vb.field) &&
+		    (item->vb.queue.next != &btv->capture)) {
+			item = list_entry(item->vb.queue.next, struct bttv_buffer, vb.queue);
+			if (!V4L2_FIELD_HAS_BOTH(item->vb.field)) {
+				if (NULL == set->top &&
+				    V4L2_FIELD_TOP == item->vb.field) {
+					set->top = item;
+				}
+				if (NULL == set->bottom &&
+				    V4L2_FIELD_BOTTOM == item->vb.field) {
+					set->bottom = item;
+				}
+				if (NULL != set->top  &&  NULL != set->bottom)
+					set->topirq = 2;
+			}
+		}
+	}
+
+	/* screen overlay ? */
+	if (NULL != btv->screen) {
+		if (V4L2_FIELD_HAS_BOTH(btv->screen->vb.field)) {
+			if (NULL == set->top && NULL == set->bottom) {
+				set->top    = btv->screen;
+				set->bottom = btv->screen;
+			}
+		} else {
+			if (V4L2_FIELD_TOP == btv->screen->vb.field &&
+			    NULL == set->top) {
+				set->top = btv->screen;
+			}
+			if (V4L2_FIELD_BOTTOM == btv->screen->vb.field &&
+			    NULL == set->bottom) {
+				set->bottom = btv->screen;
+			}
+		}
+	}
+
+	dprintk("bttv%d: next set: top=%p bottom=%p vbi=%p "
+		"[screen=%p,irq=%d,%d]\n",
+		btv->nr,set->top, set->bottom, set->vbi,
+		btv->screen,set->irqflags,set->topirq);
+	return 0;
+}
+
+static void
+bttv_irq_wakeup_set(struct bttv *btv, struct bttv_buffer_set *wakeup,
+		    struct bttv_buffer_set *curr, unsigned int state)
+{
+	struct timeval ts;
+
+	do_gettimeofday(&ts);
+
+	if (NULL != wakeup->vbi) {
+		wakeup->vbi->vb.ts = ts;
+		wakeup->vbi->vb.field_count = btv->field_count;
+		wakeup->vbi->vb.state = state;
+		wake_up(&wakeup->vbi->vb.done);
+	}
+	if (wakeup->top == wakeup->bottom) {
+		if (NULL != wakeup->top && curr->top != wakeup->top) {
+			if (irq_debug)
+				printk("bttv%d: wakeup: both=%p\n",btv->nr,wakeup->top);
+			wakeup->top->vb.ts = ts;
+			wakeup->top->vb.field_count = btv->field_count;
+			wakeup->top->vb.state = state;
+			wake_up(&wakeup->top->vb.done);
+		}
+	} else {
+		if (NULL != wakeup->top && curr->top != wakeup->top) {
+			if (irq_debug)
+				printk("bttv%d: wakeup: top=%p\n",btv->nr,wakeup->top);
+			wakeup->top->vb.ts = ts;
+			wakeup->top->vb.field_count = btv->field_count;
+			wakeup->top->vb.state = state;
+			wake_up(&wakeup->top->vb.done);
+		}
+		if (NULL != wakeup->bottom && curr->bottom != wakeup->bottom) {
+			if (irq_debug)
+				printk("bttv%d: wakeup: bottom=%p\n",btv->nr,wakeup->bottom);
+			wakeup->bottom->vb.ts = ts;
+			wakeup->bottom->vb.field_count = btv->field_count;
+			wakeup->bottom->vb.state = state;
+			wake_up(&wakeup->bottom->vb.done);
+		}
+	}
+}
+
 static void bttv_irq_timeout(unsigned long data)
 {
 	struct bttv *btv = (struct bttv *)data;
-	struct bttv_buffer *o_bottom,*o_top,*o_vcurr;
-	struct bttv_buffer *capture;
-
+	struct bttv_buffer_set old,new;
+	struct bttv_buffer *item;
+	
 	if (bttv_verbose) {
 		printk(KERN_INFO "bttv%d: timeout: risc=%08x, ",
 		       btv->nr,btread(BT848_RISC_COUNT));
@@ -2974,53 +3166,29 @@
 	}
 
 	spin_lock(&btv->s_lock);
-	o_top    = btv->top;
-	o_bottom = btv->bottom;
-	o_vcurr  = btv->vcurr;
-	btv->top    = NULL;
-	btv->bottom = NULL;
-	btv->vcurr  = NULL;
 	
 	/* deactivate stuff */
-	bttv_risc_hook(btv, RISC_SLOT_O_FIELD, NULL, 0);
-	bttv_risc_hook(btv, RISC_SLOT_E_FIELD, NULL, 0);
-	bttv_risc_hook(btv, RISC_SLOT_O_VBI, NULL, 0);
-	bttv_risc_hook(btv, RISC_SLOT_E_VBI, NULL, 0);
+	memset(&new,0,sizeof(new));
+	old = btv->curr;
+	btv->curr = new;
+	bttv_buffer_set_activate(btv, &new);
 	bttv_set_dma(btv, 0, 0);
 
-	/* wake up + free */
-	if (o_top == o_bottom) {
-		if (NULL != o_top) {
-			o_top->vb.state = STATE_ERROR;
-			wake_up(&o_top->vb.done);
-		}
-	} else {
-		if (NULL != o_top) {
-			o_top->vb.state = STATE_ERROR;
-			wake_up(&o_top->vb.done);
-		}
-		if (NULL != o_bottom) {
-			o_bottom->vb.state = STATE_ERROR;
-			wake_up(&o_bottom->vb.done);
-		}
-	}
-	if (NULL != o_vcurr) {
-		o_vcurr->vb.state = STATE_ERROR;
-		wake_up(&o_vcurr->vb.done);
-	}
+	/* wake up */
+	bttv_irq_wakeup_set(btv, &old, &new, STATE_ERROR);
 
 	/* cancel all outstanding capture / vbi requests */
 	while (!list_empty(&btv->capture)) {
-		capture = list_entry(btv->capture.next, struct bttv_buffer, vb.queue);
-		list_del(&capture->vb.queue);
-		capture->vb.state = STATE_ERROR;
-		wake_up(&capture->vb.done);
+		item = list_entry(btv->capture.next, struct bttv_buffer, vb.queue);
+		list_del(&item->vb.queue);
+		item->vb.state = STATE_ERROR;
+		wake_up(&item->vb.done);
 	}
 	while (!list_empty(&btv->vcapture)) {
-		capture = list_entry(btv->vcapture.next, struct bttv_buffer, vb.queue);
-		list_del(&capture->vb.queue);
-		capture->vb.state = STATE_ERROR;
-		wake_up(&capture->vb.done);
+		item = list_entry(btv->vcapture.next, struct bttv_buffer, vb.queue);
+		list_del(&item->vb.queue);
+		item->vb.state = STATE_ERROR;
+		wake_up(&item->vb.done);
 	}
 	
 	btv->errors++;
@@ -3028,131 +3196,53 @@
 }
 
 static void
-bttv_irq_switch_fields(struct bttv *btv)
+bttv_irq_wakeup_top(struct bttv *btv)
 {
-	struct bttv_buffer *o_bottom,*o_top,*o_vcurr;
-	struct bttv_buffer *capture;
-	dma_addr_t rc;
-	int irqflags = 0;
-	struct timeval ts;
+	struct bttv_buffer *wakeup = btv->curr.top;
 
-	spin_lock(&btv->s_lock);
-	o_top    = btv->top;
-	o_bottom = btv->bottom;
-	o_vcurr  = btv->vcurr;
-	btv->top    = NULL;
-	btv->bottom = NULL;
-	btv->vcurr  = NULL;
+	if (NULL == wakeup)
+		return;
 
-	/* vbi request ? */
-	if (!list_empty(&btv->vcapture)) {
-		irqflags = 1;
-		btv->vcurr = list_entry(btv->vcapture.next, struct bttv_buffer, vb.queue);
-		list_del(&btv->vcurr->vb.queue);
-	}
-
-	/* capture request ? */
-	if (!list_empty(&btv->capture)) {
-		irqflags = 1;
-		capture = list_entry(btv->capture.next, struct bttv_buffer, vb.queue);
-		list_del(&capture->vb.queue);
-		if (V4L2_FIELD_HAS_TOP(capture->vb.field))
-			btv->top = capture;
-		if (V4L2_FIELD_HAS_BOTTOM(capture->vb.field))
-			btv->bottom = capture;
+	spin_lock(&btv->s_lock);
+	btv->curr.topirq = 0;
+	btv->curr.top = NULL;
+	bttv_risc_hook(btv, RISC_SLOT_O_FIELD, NULL, 0);
 
-		/* capture request for other field ? */
-		if (!V4L2_FIELD_HAS_BOTH(capture->vb.field) &&
-		    !list_empty(&btv->capture)) {
-			capture = list_entry(btv->capture.next, struct bttv_buffer, vb.queue);
-			if (!V4L2_FIELD_HAS_BOTH(capture->vb.field)) {
-				if (NULL == btv->top &&
-				     V4L2_FIELD_TOP == capture->vb.field) {
-					btv->top = capture;
-					list_del(&capture->vb.queue);
-				}
-				if (NULL == btv->bottom &&
-				    V4L2_FIELD_BOTTOM == capture->vb.field) {
-					btv->bottom = capture;
-					list_del(&capture->vb.queue);
-				}
-			}
-		}
-	}
+	do_gettimeofday(&wakeup->vb.ts);
+	wakeup->vb.field_count = btv->field_count;
+	wakeup->vb.state = STATE_DONE;
+	wake_up(&wakeup->vb.done);
+	spin_unlock(&btv->s_lock);
+}
 
-	/* screen overlay ? */
-	if (NULL != btv->screen) {
-		if (V4L2_FIELD_HAS_BOTH(btv->screen->vb.field)) {
-			if (NULL == btv->top && NULL == btv->bottom) {
-				btv->top  = btv->screen;
-				btv->bottom = btv->screen;
-			}
-		} else {
-			if (V4L2_FIELD_TOP == btv->screen->vb.field &&
-			    NULL == btv->top) {
-				btv->top = btv->screen;
-			}
-			if (V4L2_FIELD_BOTTOM == btv->screen->vb.field &&
-			    NULL == btv->bottom) {
-				btv->bottom = btv->screen;
-			}
-		}
-	}
+static void
+bttv_irq_switch_fields(struct bttv *btv)
+{
+	struct bttv_buffer_set new;
+	struct bttv_buffer_set old;
+	dma_addr_t rc;
 
-	if (irq_debug)
-		printk(KERN_DEBUG "bttv%d: irq top=0x%08x bottom=0x%08x"
-		       " vbi=0x%08x/0x%08x\n", btv->nr,
-		       btv->top    ? btv->top->top.dma       : 0,
-		       btv->bottom ? btv->bottom->bottom.dma : 0,
-		       btv->vcurr  ? btv->vcurr->top.dma     : 0,
-		       btv->vcurr  ? btv->vcurr->bottom.dma  : 0);
+	spin_lock(&btv->s_lock);
 
+	/* new buffer set */
+	bttv_irq_next_set(btv, &new);
 	rc = btread(BT848_RISC_COUNT);
-	if (rc < btv->main.dma || rc > btv->main.dma + 0x100)
-		printk("bttv%d: Huh? IRQ latency? main=0x%x rc=0x%x\n",
-		       btv->nr,btv->main.dma,rc);
-	
-	/* activate new fields */
-	bttv_buffer_activate(btv,btv->top,btv->bottom);
-	if (btv->vcurr) {
-		btv->vcurr->vb.state = STATE_ACTIVE;
-		bttv_risc_hook(btv, RISC_SLOT_O_VBI, &btv->vcurr->top, 0);
-		bttv_risc_hook(btv, RISC_SLOT_E_VBI, &btv->vcurr->bottom, 0);
-	} else {
-		bttv_risc_hook(btv, RISC_SLOT_O_VBI, NULL, 0);
-		bttv_risc_hook(btv, RISC_SLOT_E_VBI, NULL, 0);
-	}
-	bttv_set_dma(btv, 0, irqflags);
-	
-	/* wake up + free */
-	do_gettimeofday(&ts);
-	if (o_top == o_bottom) {
-		if (NULL != o_top && btv->top != o_top) {
-			o_top->vb.ts = ts;
-			o_top->vb.field_count = btv->field_count;
-			o_top->vb.state = STATE_DONE;
-			wake_up(&o_top->vb.done);
-		}
-	} else {
-		if (NULL != o_top && btv->top != o_top) {
-			o_top->vb.ts = ts;
-			o_top->vb.field_count = btv->field_count;
-			o_top->vb.state = STATE_DONE;
-			wake_up(&o_top->vb.done);
-		}
-		if (NULL != o_bottom && btv->bottom != o_bottom) {
-			o_bottom->vb.ts = ts;
-			o_bottom->vb.field_count = btv->field_count;
-			o_bottom->vb.state = STATE_DONE;
-			wake_up(&o_bottom->vb.done);
-		}
-	}
-	if (NULL != o_vcurr) {
-		o_vcurr->vb.ts = ts;
-		o_vcurr->vb.field_count = btv->field_count;
-		o_vcurr->vb.state = STATE_DONE;
-		wake_up(&o_vcurr->vb.done);
-	}
+	if (rc < btv->main.dma || rc > btv->main.dma + 0x100) {
+		if (1 /* irq_debug */)
+			printk("bttv%d: skipped frame. no signal? high irq latency?\n",
+			       btv->nr);
+		spin_unlock(&btv->s_lock);
+		return;
+	}
+	
+	/* switch over */
+	old = btv->curr;
+	btv->curr = new;
+	bttv_buffer_set_activate(btv, &new);
+	bttv_set_dma(btv, 0, new.irqflags);
+
+	/* wake up finished buffers */
+	bttv_irq_wakeup_set(btv, &old, &new, STATE_DONE);
 	spin_unlock(&btv->s_lock);
 }
 
@@ -3178,7 +3268,7 @@
 		/* get device status bits */
 		dstat=btread(BT848_DSTATUS);
 
-		if (irq_debug) {
+		if (0 /*irq_debug*/) {
 			printk(KERN_DEBUG "bttv%d: irq loop=%d fc=%d "
 			       "riscs=%x, riscc=%08x, ",
 			       btv->nr, count, btv->field_count,
@@ -3201,7 +3291,10 @@
 
 		if (astat & BT848_INT_GPINT)
 			wake_up(&btv->gpioq);
-		
+
+                if ((astat & BT848_INT_RISCI)  &&  (stat & (2<<28)))
+			bttv_irq_wakeup_top(btv);
+
                 if ((astat & BT848_INT_RISCI)  &&  (stat & (1<<28)))
 			bttv_irq_switch_fields(btv);
 
@@ -3308,7 +3401,8 @@
 	btv->timeout.data     = (unsigned long)btv;
 	
         btv->i2c_rc = -1;
-        btv->tuner_type = -1;
+        btv->tuner_type  = UNSET;
+        btv->pinnacle_id = UNSET;
 
 	memcpy(&btv->video_dev, &bttv_video_template, sizeof(bttv_video_template));
 	memcpy(&btv->radio_dev, &radio_template,      sizeof(radio_template));
@@ -3485,7 +3579,7 @@
                 video_unregister_device(&btv->vbi_dev);
 
 	/* free allocated memory */
-	bttv_riscmem_free(btv->dev,&btv->main);
+	btcx_riscmem_free(btv->dev,&btv->main);
 
 	/* free ressources */
         free_irq(btv->dev->irq,btv);
@@ -3519,6 +3613,7 @@
 
 static int bttv_init_module(void)
 {
+	int rc;
 	bttv_num = 0;
 
 	printk(KERN_INFO "bttv: driver version %d.%d.%d loaded\n",
@@ -3536,7 +3631,13 @@
 
 	bttv_check_chipset();
 
-	return pci_module_init(&bttv_pci_driver);
+	rc = pci_module_init(&bttv_pci_driver);
+	if (-ENODEV == rc) {
+		/* plenty of people trying to use bttv for the cx2388x ... */
+		if (NULL != pci_find_device(0x14f1, 0x8800, NULL))
+			printk("bttv doesn't support your Conexant 2388x card.\n");
+	}
+	return rc;
 }
 
 static void bttv_cleanup_module(void)
diff -u linux-2.5.69/drivers/media/video/bttv-if.c linux/drivers/media/video/bttv-if.c
--- linux-2.5.69/drivers/media/video/bttv-if.c	2003-05-08 13:29:56.000000000 +0200
+++ linux/drivers/media/video/bttv-if.c	2003-05-08 13:55:11.000000000 +0200
@@ -198,6 +198,9 @@
 
 	if (btv->tuner_type != UNSET)
 		bttv_call_i2c_clients(btv,TUNER_SET_TYPE,&btv->tuner_type);
+	if (btv->pinnacle_id != UNSET)
+		bttv_call_i2c_clients(btv,AUDC_CONFIG_PINNACLE,
+				      &btv->pinnacle_id);
 
         if (bttv_debug)
 		printk("bttv%d: i2c attach [client=%s]\n",
@@ -231,9 +234,9 @@
 
 static struct i2c_adapter bttv_i2c_adap_template = {
 	.owner             = THIS_MODULE,
+	.class             = I2C_ADAP_CLASS_TV_ANALOG,
 	I2C_DEVNAME("bt848"),
 	.id                = I2C_HW_B_BT848,
-	.class             = I2C_ADAP_CLASS_TV_ANALOG,
 	.client_register   = attach_inform,
 };
 
diff -u linux-2.5.69/drivers/media/video/bttv-risc.c linux/drivers/media/video/bttv-risc.c
--- linux-2.5.69/drivers/media/video/bttv-risc.c	2003-05-08 13:30:56.000000000 +0200
+++ linux/drivers/media/video/bttv-risc.c	2003-05-08 13:55:11.000000000 +0200
@@ -35,58 +35,24 @@
 #include "bttvp.h"
 
 /* ---------------------------------------------------------- */
-/* allocate/free risc memory                                  */
-
-int  bttv_riscmem_alloc(struct pci_dev *pci,
-			struct bttv_riscmem *risc,
-			unsigned int size)
-{
-	u32 *cpu;
-	dma_addr_t dma;
-	
-	cpu = pci_alloc_consistent(pci, size, &dma);
-	if (NULL == cpu)
-		return -ENOMEM;
-	memset(cpu,0,size);
-
-	if (risc->cpu && risc->size < size) {
-		/* realloc (enlarge buffer) -- copy old stuff */
-		memcpy(cpu,risc->cpu,risc->size);
-		bttv_riscmem_free(pci,risc);
-	}
-	risc->cpu  = cpu;
-	risc->dma  = dma;
-	risc->size = size;
-
-	return 0;
-}
-
-void bttv_riscmem_free(struct pci_dev *pci,
-		       struct bttv_riscmem *risc)
-{
-	if (NULL == risc->cpu)
-		return;
-	pci_free_consistent(pci, risc->size, risc->cpu, risc->dma);
-	memset(risc,0,sizeof(*risc));
-}
-
-/* ---------------------------------------------------------- */
 /* risc code generators                                       */
 
 int
-bttv_risc_packed(struct bttv *btv, struct bttv_riscmem *risc,
+bttv_risc_packed(struct bttv *btv, struct btcx_riscmem *risc,
 		 struct scatterlist *sglist,
-		 int offset, int bpl, int padding, int lines)
+		 unsigned int offset, unsigned int bpl,
+		 unsigned int padding, unsigned int lines)
 {
-	int instructions,rc,line,todo;
+	u32 instructions,line,todo;
 	struct scatterlist *sg;
 	u32 *rp;
+	int rc;
 
 	/* estimate risc mem: worst case is one write per page border +
 	   one write per scan line + sync + jump (all 2 dwords) */
 	instructions  = (bpl * lines) / PAGE_SIZE + lines;
 	instructions += 2;
-	if ((rc = bttv_riscmem_alloc(btv->dev,risc,instructions*8)) < 0)
+	if ((rc = btcx_riscmem_alloc(btv->dev,risc,instructions*8)) < 0)
 		return rc;
 
 	/* sync instruction */
@@ -130,6 +96,7 @@
 		}
 		offset += padding;
 	}
+	dprintk("bttv%d: risc planar: %d sglist elems\n", btv->nr, (int)(sg-sglist));
 
 	/* save pointer to jmp instruction address */
 	risc->jmp = rp;
@@ -137,24 +104,27 @@
 }
 
 int
-bttv_risc_planar(struct bttv *btv, struct bttv_riscmem *risc,
+bttv_risc_planar(struct bttv *btv, struct btcx_riscmem *risc,
 		 struct scatterlist *sglist,
-		 int yoffset, int ybpl, int ypadding, int ylines,
-		 int uoffset, int voffset, int hshift, int vshift,
-		 int cpadding)
+		 unsigned int yoffset,  unsigned int ybpl,
+		 unsigned int ypadding, unsigned int ylines,
+		 unsigned int uoffset,  unsigned int voffset,
+		 unsigned int hshift,   unsigned int vshift,
+		 unsigned int cpadding)
 {
-	int instructions,rc,line,todo,ylen,chroma;
+	unsigned int instructions,line,todo,ylen,chroma;
 	u32 *rp,ri;
 	struct scatterlist *ysg;
 	struct scatterlist *usg;
 	struct scatterlist *vsg;
+	int rc;
 
 	/* estimate risc mem: worst case is one write per page border +
 	   one write per scan line (5 dwords)
 	   plus sync + jump (2 dwords) */
 	instructions  = (ybpl * ylines * 2) / PAGE_SIZE + ylines;
 	instructions += 2;
-	if ((rc = bttv_riscmem_alloc(btv->dev,risc,instructions*4*5)) < 0)
+	if ((rc = btcx_riscmem_alloc(btv->dev,risc,instructions*4*5)) < 0)
 		return rc;
 
 	/* sync instruction */
@@ -231,138 +201,13 @@
 	return 0;
 }
 
-/* ---------------------------------------------------------- */
-
-struct SKIPLIST {
-	int start;
-	int end;
-};
-
 int
-bttv_screen_clips(int swidth, int sheight, struct v4l2_rect *win,
-		  struct v4l2_clip *clips, int n)
-{
-	if (win->left < 0) {
-		/* left */
-		clips[n].c.left = 0;
-		clips[n].c.top = 0;
-		clips[n].c.width  = -win->left;
-		clips[n].c.height = win->height;
-		n++;
-	}
-	if (win->left + win->width > swidth) {
-		/* right */
-		clips[n].c.left   = swidth - win->left;
-		clips[n].c.top    = 0;
-		clips[n].c.width  = win->width - clips[n].c.left;
-		clips[n].c.height = win->height;
-		n++;
-	}
-	if (win->top < 0) {
-		/* top */
-		clips[n].c.left = 0;
-		clips[n].c.top = 0;
-		clips[n].c.width  = win->width;
-		clips[n].c.height = -win->top;
-		n++;
-	}
-	if (win->top + win->height > sheight) {
-		/* bottom */
-		clips[n].c.left = 0;
-		clips[n].c.top = sheight - win->top;
-		clips[n].c.width  = win->width;
-		clips[n].c.height = win->height - clips[n].c.top;
-		n++;
-	}
-	return n;
-}
-
-void
-bttv_sort_clips(struct v4l2_clip *clips, int nclips)
-{
-	struct v4l2_clip swap;
-	int i,j,n;
-
-	for (i = nclips-2; i >= 0; i--) {
-		for (n = 0, j = 0; j <= i; j++) {
-			if (clips[j].c.left > clips[j+1].c.left) {
-				swap = clips[j];
-				clips[j] = clips[j+1];
-				clips[j+1] = swap;
-				n++;
-			}
-		}
-		if (0 == n)
-			break;
-	}
-}
-
-static void
-calc_skips(int line, int width, int *maxy,
-	   struct SKIPLIST *skips, int *nskips,
-	   const struct v4l2_clip *clips, int nclips)
-{
-	int clip,skip,maxline,end;
-
-	skip=0;
-	maxline = 9999;
-	for (clip = 0; clip < nclips; clip++) {
-
-		/* sanity checks */
-		if (clips[clip].c.left + clips[clip].c.width <= 0)
-			continue;
-		if (clips[clip].c.left > width)
-			break;
-		
-		/* vertical range */
-		if (line > clips[clip].c.top+clips[clip].c.height-1)
-			continue;
-		if (line < clips[clip].c.top) {
-			if (maxline > clips[clip].c.top-1)
-				maxline = clips[clip].c.top-1;
-			continue;
-		}
-		if (maxline > clips[clip].c.top+clips[clip].c.height-1)
-			maxline = clips[clip].c.top+clips[clip].c.height-1;
-
-		/* horizontal range */
-		if (0 == skip || clips[clip].c.left > skips[skip-1].end) {
-			/* new one */
-			skips[skip].start = clips[clip].c.left;
-			if (skips[skip].start < 0)
-				skips[skip].start = 0;
-			skips[skip].end = clips[clip].c.left + clips[clip].c.width;
-			if (skips[skip].end > width)
-				skips[skip].end = width;
-			skip++;
-		} else {
-			/* overlaps -- expand last one */
-			end = clips[clip].c.left + clips[clip].c.width;
-			if (skips[skip-1].end < end)
-				skips[skip-1].end = end;
-			if (skips[skip-1].end > width)
-				skips[skip-1].end = width;
-		}
-	}
-	*nskips = skip;
-	*maxy = maxline;
-
-	if (bttv_debug) {
-		printk(KERN_DEBUG "bttv: skips line %d-%d:",line,maxline);
-		for (skip = 0; skip < *nskips; skip++) {
-			printk(" %d-%d",skips[skip].start,skips[skip].end);
-		}
-		printk("\n");
-	}
-}
-
-int
-bttv_risc_overlay(struct bttv *btv, struct bttv_riscmem *risc,
+bttv_risc_overlay(struct bttv *btv, struct btcx_riscmem *risc,
 		  const struct bttv_format *fmt, struct bttv_overlay *ov,
 		  int skip_even, int skip_odd)
 {
 	int instructions,rc,line,maxy,start,end,skip,nskips;
-	struct SKIPLIST *skips;
+	struct btcx_skiplist *skips;
 	u32 *rp,ri,ra;
 	u32 addr;
 
@@ -375,7 +220,7 @@
 	instructions  = (ov->nclips + 1) *
 		((skip_even || skip_odd) ? ov->w.height>>1 :  ov->w.height);
 	instructions += 2;
-	if ((rc = bttv_riscmem_alloc(btv->dev,risc,instructions*8)) < 0)
+	if ((rc = btcx_riscmem_alloc(btv->dev,risc,instructions*8)) < 0)
 		return rc;
 
 	/* sync instruction */
@@ -397,8 +242,8 @@
 
 		/* calculate clipping */
 		if (line > maxy)
-			calc_skips(line, ov->w.width, &maxy,
-				   skips, &nskips, ov->clips, ov->nclips);
+			btcx_calc_skips(line, ov->w.width, &maxy,
+					skips, &nskips, ov->clips, ov->nclips);
 
 		/* write out risc code */
 		for (start = 0, skip = 0; start < ov->w.width; start = end) {
@@ -432,7 +277,6 @@
 
 	/* save pointer to jmp instruction address */
 	risc->jmp = rp;
-
 	kfree(skips);
 	return 0;
 }
@@ -476,6 +320,7 @@
         geo->vdelay  =  vdelay;
         geo->width   =  width;
         geo->sheight =  tvnorm->sheight;
+	geo->vtotal  =  tvnorm->vtotal;
 
         if (btv->opt_combfilter) {
                 geo->vtc  = (width < 193) ? 2 : ((width < 385) ? 1 : 0);
@@ -506,6 +351,8 @@
         btwrite(geo->sheight & 0xff,  BT848_E_VACTIVE_LO+off);
         btwrite(geo->vdelay & 0xff,   BT848_E_VDELAY_LO+off);
         btwrite(geo->crop,            BT848_E_CROP+off);
+	btwrite(geo->vtotal>>8,       BT848_VTOTAL_HI);
+        btwrite(geo->vtotal & 0xff,   BT848_VTOTAL_LO);
 }
 
 /* ---------------------------------------------------------- */
@@ -518,9 +365,9 @@
 	int capctl;
 
 	btv->cap_ctl = 0;
-	if (NULL != btv->top)      btv->cap_ctl |= 0x02;
-	if (NULL != btv->bottom)   btv->cap_ctl |= 0x01;
-	if (NULL != btv->vcurr)    btv->cap_ctl |= 0x0c;
+	if (NULL != btv->curr.top)      btv->cap_ctl |= 0x02;
+	if (NULL != btv->curr.bottom)   btv->cap_ctl |= 0x01;
+	if (NULL != btv->curr.vbi)      btv->cap_ctl |= 0x0c;
 
 	capctl  = 0;
 	capctl |= (btv->cap_ctl & 0x03) ? 0x03 : 0x00;  /* capture  */
@@ -530,14 +377,16 @@
 	d2printk(KERN_DEBUG
 		 "bttv%d: capctl=%x irq=%d top=%08Lx/%08Lx even=%08Lx/%08Lx\n",
 		 btv->nr,capctl,irqflags,
-		 btv->vcurr   ? (u64)btv->vcurr->top.dma      : 0,
-		 btv->top     ? (u64)btv->top->top.dma        : 0,
-		 btv->vcurr   ? (u64)btv->vcurr->bottom.dma   : 0,
-		 btv->bottom  ? (u64)btv->bottom->bottom.dma  : 0);
+		 btv->curr.vbi     ? (u64)btv->curr.vbi->top.dma        : 0,
+		 btv->curr.top     ? (u64)btv->curr.top->top.dma        : 0,
+		 btv->curr.vbi     ? (u64)btv->curr.vbi->bottom.dma     : 0,
+		 btv->curr.bottom  ? (u64)btv->curr.bottom->bottom.dma  : 0);
 	
 	cmd = BT848_RISC_JUMP;
 	if (irqflags) {
-		cmd |= BT848_RISC_IRQ | (irqflags << 16);
+		cmd |= BT848_RISC_IRQ;
+		cmd |= (irqflags  & 0x0f) << 16;
+		cmd |= (~irqflags & 0x0f) << 20;
 		mod_timer(&btv->timeout, jiffies+BTTV_TIMEOUT);
 	} else {
 		del_timer(&btv->timeout);
@@ -565,7 +414,7 @@
 {
 	int rc;
 	
-	if ((rc = bttv_riscmem_alloc(btv->dev,&btv->main,PAGE_SIZE)) < 0)
+	if ((rc = btcx_riscmem_alloc(btv->dev,&btv->main,PAGE_SIZE)) < 0)
 		return rc;
 	dprintk(KERN_DEBUG "bttv%d: risc main @ %08Lx\n",
 		btv->nr,(u64)btv->main.dma);
@@ -600,7 +449,7 @@
 }
 
 int
-bttv_risc_hook(struct bttv *btv, int slot, struct bttv_riscmem *risc,
+bttv_risc_hook(struct bttv *btv, int slot, struct btcx_riscmem *risc,
 	       int irqflags)
 {
 	unsigned long cmd;
@@ -614,8 +463,11 @@
 		d2printk(KERN_DEBUG "bttv%d: risc=%p slot[%d]=%08Lx irq=%d\n",
 			 btv->nr,risc,slot,(u64)risc->dma,irqflags);
 		cmd = BT848_RISC_JUMP;
-		if (irqflags)
-			cmd |= BT848_RISC_IRQ | (irqflags << 16);
+		if (irqflags) {
+			cmd |= BT848_RISC_IRQ;
+			cmd |= (irqflags  & 0x0f) << 16;
+			cmd |= (~irqflags & 0x0f) << 20;
+		}
 		risc->jmp[0] = cpu_to_le32(cmd);
 		risc->jmp[1] = cpu_to_le32(next);
 		btv->main.cpu[slot+1] = cpu_to_le32(risc->dma);
@@ -631,43 +483,68 @@
 	videobuf_waiton(&buf->vb,0,0);
 	videobuf_dma_pci_unmap(btv->dev, &buf->vb.dma);
 	videobuf_dma_free(&buf->vb.dma);
-	bttv_riscmem_free(btv->dev,&buf->bottom);
-	bttv_riscmem_free(btv->dev,&buf->top);
+	btcx_riscmem_free(btv->dev,&buf->bottom);
+	btcx_riscmem_free(btv->dev,&buf->top);
 	buf->vb.state = STATE_NEEDS_INIT;
 }
 
 int
-bttv_buffer_activate(struct bttv *btv,
-		     struct bttv_buffer *top,
-		     struct bttv_buffer *bottom)
-{
-	if (NULL != top  &&  NULL != bottom) {
-		top->vb.state  = STATE_ACTIVE;
-		bottom->vb.state = STATE_ACTIVE;
-		bttv_apply_geo(btv, &top->geo, 1);
-		bttv_apply_geo(btv, &bottom->geo,0);
-		bttv_risc_hook(btv, RISC_SLOT_O_FIELD, &top->top,       0);
-		bttv_risc_hook(btv, RISC_SLOT_E_FIELD, &bottom->bottom, 0);
-		btaor((top->btformat & 0xf0) | (bottom->btformat & 0x0f),
+bttv_buffer_set_activate(struct bttv *btv,
+			 struct bttv_buffer_set *set)
+{
+	/* vbi capture */
+	if (set->vbi) {
+		set->vbi->vb.state = STATE_ACTIVE;
+		list_del(&set->vbi->vb.queue);
+		bttv_risc_hook(btv, RISC_SLOT_O_VBI, &set->vbi->top,    0);
+		bttv_risc_hook(btv, RISC_SLOT_E_VBI, &set->vbi->bottom, 0);
+	} else {
+		bttv_risc_hook(btv, RISC_SLOT_O_VBI, NULL, 0);
+		bttv_risc_hook(btv, RISC_SLOT_E_VBI, NULL, 0);
+	}
+
+	/* video capture */
+	if (NULL != set->top  &&  NULL != set->bottom) {
+		if (set->top == set->bottom) {
+			set->top->vb.state    = STATE_ACTIVE;
+			if (set->top->vb.queue.next)
+				list_del(&set->top->vb.queue);
+		} else {
+			set->top->vb.state    = STATE_ACTIVE;
+			set->bottom->vb.state = STATE_ACTIVE;
+			if (set->top->vb.queue.next)
+				list_del(&set->top->vb.queue);
+			if (set->bottom->vb.queue.next)
+				list_del(&set->bottom->vb.queue);
+		}
+		bttv_apply_geo(btv, &set->top->geo, 1);
+		bttv_apply_geo(btv, &set->bottom->geo,0);
+		bttv_risc_hook(btv, RISC_SLOT_O_FIELD, &set->top->top, set->topirq);
+		bttv_risc_hook(btv, RISC_SLOT_E_FIELD, &set->bottom->bottom, 0);
+		btaor((set->top->btformat & 0xf0) | (set->bottom->btformat & 0x0f),
 		      ~0xff, BT848_COLOR_FMT);
-		btaor((top->btswap & 0x0a) | (bottom->btswap & 0x05),
+		btaor((set->top->btswap & 0x0a) | (set->bottom->btswap & 0x05),
 		      ~0x0f, BT848_COLOR_CTL);
-	} else if (NULL != top) {
-		top->vb.state  = STATE_ACTIVE;
-		bttv_apply_geo(btv, &top->geo,1);
-		bttv_apply_geo(btv, &top->geo,0);
-		bttv_risc_hook(btv, RISC_SLOT_O_FIELD, &top->top, 0);
-		bttv_risc_hook(btv, RISC_SLOT_E_FIELD, NULL,      0);
-		btaor(top->btformat & 0xff, ~0xff, BT848_COLOR_FMT);
-		btaor(top->btswap & 0x0f,   ~0x0f, BT848_COLOR_CTL);
-	} else if (NULL != bottom) {
-		bottom->vb.state = STATE_ACTIVE;
-		bttv_apply_geo(btv, &bottom->geo,1);
-		bttv_apply_geo(btv, &bottom->geo,0);
-		bttv_risc_hook(btv, RISC_SLOT_O_FIELD, NULL,            0);
-		bttv_risc_hook(btv, RISC_SLOT_E_FIELD, &bottom->bottom, 0);
-		btaor(bottom->btformat & 0xff, ~0xff, BT848_COLOR_FMT);
-		btaor(bottom->btswap & 0x0f,   ~0x0f, BT848_COLOR_CTL);
+	} else if (NULL != set->top) {
+		set->top->vb.state  = STATE_ACTIVE;
+		if (set->top->vb.queue.next)
+			list_del(&set->top->vb.queue);
+		bttv_apply_geo(btv, &set->top->geo,1);
+		bttv_apply_geo(btv, &set->top->geo,0);
+		bttv_risc_hook(btv, RISC_SLOT_O_FIELD, &set->top->top, 0);
+		bttv_risc_hook(btv, RISC_SLOT_E_FIELD, NULL,           0);
+		btaor(set->top->btformat & 0xff, ~0xff, BT848_COLOR_FMT);
+		btaor(set->top->btswap & 0x0f,   ~0x0f, BT848_COLOR_CTL);
+	} else if (NULL != set->bottom) {
+		set->bottom->vb.state = STATE_ACTIVE;
+		if (set->bottom->vb.queue.next)
+			list_del(&set->bottom->vb.queue);
+		bttv_apply_geo(btv, &set->bottom->geo,1);
+		bttv_apply_geo(btv, &set->bottom->geo,0);
+		bttv_risc_hook(btv, RISC_SLOT_O_FIELD, NULL,                 0);
+		bttv_risc_hook(btv, RISC_SLOT_E_FIELD, &set->bottom->bottom, 0);
+		btaor(set->bottom->btformat & 0xff, ~0xff, BT848_COLOR_FMT);
+		btaor(set->bottom->btswap & 0x0f,   ~0x0f, BT848_COLOR_CTL);
 	} else {
 		bttv_risc_hook(btv, RISC_SLOT_O_FIELD, NULL, 0);
 		bttv_risc_hook(btv, RISC_SLOT_E_FIELD, NULL, 0);
@@ -734,12 +611,12 @@
 			/* Y-Cr-Cb plane order */
 			uoffset >>= buf->fmt->hshift;
 			uoffset >>= buf->fmt->vshift;
-			uoffset += voffset;
+			uoffset  += voffset;
 		} else {
 			/* Y-Cb-Cr plane order */
 			voffset >>= buf->fmt->hshift;
 			voffset >>= buf->fmt->vshift;
-			voffset += uoffset;
+			voffset  += uoffset;
 		}
 
 		switch (buf->vb.field) {
@@ -781,6 +658,29 @@
 					 buf->fmt->vshift,
 					 cpadding);
 			break;
+		case V4L2_FIELD_SEQ_TB:
+			bttv_calc_geo(btv,&buf->geo,buf->vb.width,
+				      buf->vb.height,1,buf->tvnorm);
+			lines    = buf->vb.height >> 1;
+			ypadding = buf->vb.width;
+			cpadding = buf->vb.width >> buf->fmt->hshift;
+			bttv_risc_planar(btv,&buf->top,
+					 buf->vb.dma.sglist,
+					 0,buf->vb.width,0,lines,
+					 uoffset >> 1,
+					 voffset >> 1,
+					 buf->fmt->hshift,
+					 buf->fmt->vshift,
+					 0);
+			bttv_risc_planar(btv,&buf->bottom,
+					 buf->vb.dma.sglist,
+					 lines * ypadding,buf->vb.width,0,lines,
+					 lines * ypadding + (uoffset >> 1),
+					 lines * ypadding + (voffset >> 1),
+					 buf->fmt->hshift,
+					 buf->fmt->vshift,
+					 0);
+			break;
 		default:
 			BUG();
 		}
diff -u linux-2.5.69/drivers/media/video/bttv-vbi.c linux/drivers/media/video/bttv-vbi.c
--- linux-2.5.69/drivers/media/video/bttv-vbi.c	2003-05-08 13:31:15.000000000 +0200
+++ linux/drivers/media/video/bttv-vbi.c	2003-05-08 13:55:11.000000000 +0200
@@ -63,7 +63,7 @@
 }
 
 static int vbi_buffer_setup(struct file *file,
-			unsigned int *count, unsigned int *size)
+			    unsigned int *count, unsigned int *size)
 {
 	struct bttv_fh *fh = file->private_data;
 	struct bttv *btv = fh->btv;
@@ -155,7 +155,43 @@
 	}
 }
 
-void bttv_vbi_fmt(struct bttv_fh *fh, struct v4l2_format *f)
+void bttv_vbi_try_fmt(struct bttv_fh *fh, struct v4l2_format *f)
+{
+	u32 start0,start1,count0,count1,count;
+	
+	f->type = V4L2_BUF_TYPE_VBI_CAPTURE;
+	f->fmt.vbi.sampling_rate    = 35468950;
+	f->fmt.vbi.samples_per_line = 2048;
+	f->fmt.vbi.sample_format    = V4L2_PIX_FMT_GREY;
+	f->fmt.vbi.offset           = 244;
+	f->fmt.vbi.flags            = 0;
+	switch (fh->btv->tvnorm) {
+	case 1: /* NTSC */
+		start0 = 10;
+		start1 = 273;
+		break;
+	case 0: /* PAL */
+	case 2: /* SECAM */
+	default:
+		start0 = 7;
+		start1 = 319;
+	}
+
+	count0 = (f->fmt.vbi.start[0] + f->fmt.vbi.count[0]) - start0;
+	count1 = (f->fmt.vbi.start[1] + f->fmt.vbi.count[1]) - start1;
+	count  = max(count0,count1);
+	if (count > VBI_MAXLINES)
+		count = VBI_MAXLINES;
+	if (count < 1)
+		count = 1;
+
+	f->fmt.vbi.start[0] = start0;
+	f->fmt.vbi.start[1] = start1;
+	f->fmt.vbi.count[0] = count;
+	f->fmt.vbi.count[1] = count;
+}
+
+void bttv_vbi_get_fmt(struct bttv_fh *fh, struct v4l2_format *f)
 {
 	memset(f,0,sizeof(*f));
 	f->type = V4L2_BUF_TYPE_VBI_CAPTURE;
diff -u linux-2.5.69/drivers/media/video/bttv.h linux/drivers/media/video/bttv.h
--- linux-2.5.69/drivers/media/video/bttv.h	2003-05-08 13:29:56.000000000 +0200
+++ linux/drivers/media/video/bttv.h	2003-05-08 13:55:11.000000000 +0200
@@ -90,6 +90,7 @@
 #define BTTV_SENSORAY311    0x49
 #define BTTV_RV605          0x4a
 #define BTTV_WINDVR         0x4c
+#define BTTV_GRANDTEC       0x4d
 #define BTTV_KWORLD         0x4e
 #define BTTV_HAUPPAUGEPVR   0x50
 #define BTTV_GVBCTV5PCI     0x51
@@ -108,6 +109,11 @@
 #define BTTV_PINNACLESAT    0x5e
 #define BTTV_FORMAC_PROTV   0x5f
 #define BTTV_EURESYS_PICOLO 0x61
+#define BTTV_PV150          0x62
+#define BTTV_AD_TVK503      0x63
+#define BTTV_IVC200         0x66
+#define BTTV_XGUARD         0x67
+#define BTTV_NEBULA_DIGITV  0x68
 
 /* i2c address list */
 #define I2C_TSA5522        0xc2
@@ -123,6 +129,7 @@
 #define I2C_STBEE          0xae
 #define I2C_VHX            0xc0
 #define I2C_MSP3400        0x80
+#define I2C_MSP3400_ALT    0x88
 #define I2C_TEA6300        0x80
 #define I2C_DPL3518	   0x84
 #define I2C_TDA9887	   0x86
@@ -145,36 +152,37 @@
 struct tvcard
 {
         char *name;
-        int video_inputs;
-        int audio_inputs;
-        int tuner;
-        int svhs;
-	int digital_mode; // DIGITAL_MODE_CAMERA or DIGITAL_MODE_VIDEO
+        unsigned int video_inputs;
+        unsigned int audio_inputs;
+        unsigned int tuner;
+        unsigned int svhs;
+	unsigned int digital_mode; // DIGITAL_MODE_CAMERA or DIGITAL_MODE_VIDEO
         u32 gpiomask;
         u32 muxsel[16];
         u32 audiomux[6]; /* Tuner, Radio, external, internal, mute, stereo */
         u32 gpiomask2;   /* GPIO MUX mask */
 
 	/* i2c audio flags */
-	int no_msp34xx:1;
-	int no_tda9875:1;
-	int no_tda7432:1;
-	int needs_tvaudio:1;
+	unsigned int no_msp34xx:1;
+	unsigned int no_tda9875:1;
+	unsigned int no_tda7432:1;
+	unsigned int needs_tvaudio:1;
+	unsigned int msp34xx_alt:1;
 
 	/* other settings */
-	int pll;
+	unsigned int pll;
 #define PLL_NONE 0
 #define PLL_28   1
 #define PLL_35   2
 
-	int tuner_type;
-	int has_radio;
+	unsigned int tuner_type;
+	unsigned int has_radio;
 	void (*audio_hook)(struct bttv *btv, struct video_audio *v, int set);
 	void (*muxsel_hook)(struct bttv *btv, unsigned int input);
 };
 
 extern struct tvcard bttv_tvcards[];
-extern const int bttv_num_tvcards;
+extern const unsigned int bttv_num_tvcards;
 
 /* identification / initialization of the card */
 extern void bttv_idcard(struct bttv *btv);
diff -u linux-2.5.69/drivers/media/video/bttvp.h linux/drivers/media/video/bttvp.h
--- linux-2.5.69/drivers/media/video/bttvp.h	2003-05-08 13:30:32.000000000 +0200
+++ linux/drivers/media/video/bttvp.h	2003-05-08 13:55:11.000000000 +0200
@@ -24,7 +24,7 @@
 #ifndef _BTTVP_H_
 #define _BTTVP_H_
 
-#define BTTV_VERSION_CODE KERNEL_VERSION(0,9,4)
+#define BTTV_VERSION_CODE KERNEL_VERSION(0,9,11)
 
 #include <linux/types.h>
 #include <linux/wait.h>
@@ -40,6 +40,7 @@
 
 #include "bt848.h"
 #include "bttv.h"
+#include "btcx-risc.h"
 
 #ifdef __KERNEL__
 
@@ -66,8 +67,7 @@
 
 /* ---------------------------------------------------------- */
 
-struct bttv_tvnorm 
-{
+struct bttv_tvnorm {
 	int   v4l2_id;
 	char  *name;
         u32   Fsc;
@@ -78,10 +78,11 @@
 	u16   hdelayx1, hactivex1;
 	u16   vdelay;
         u8    vbipack;
+	u16   vtotal;
 	int   sram;
 };
 extern const struct bttv_tvnorm bttv_tvnorms[];
-extern const int BTTV_TVNORMS;
+extern const unsigned int BTTV_TVNORMS;
 
 struct bttv_format {
 	char *name;
@@ -94,21 +95,14 @@
 	int  hshift,vshift;   /* for planar modes   */
 };
 extern const struct bttv_format bttv_formats[];
-extern const int BTTV_FORMATS;
+extern const unsigned int BTTV_FORMATS;
 
 /* ---------------------------------------------------------- */
 
 struct bttv_geometry {
 	u8  vtc,crop,comb;
 	u16 width,hscale,hdelay;
-	u16 sheight,vscale,vdelay;
-};
-
-struct bttv_riscmem {
-	unsigned int   size;
-	u32            *cpu;
-	u32            *jmp;
-	dma_addr_t     dma;
+	u16 sheight,vscale,vdelay,vtotal;
 };
 
 struct bttv_buffer {
@@ -121,16 +115,25 @@
 	int                        btformat;
 	int                        btswap;
 	struct bttv_geometry       geo;
-	struct bttv_riscmem        top;
-	struct bttv_riscmem        bottom;
+	struct btcx_riscmem        top;
+	struct btcx_riscmem        bottom;
+};
+
+struct bttv_buffer_set {
+	struct bttv_buffer     *top;       /* top field buffer    */
+	struct bttv_buffer     *bottom;    /* bottom field buffer */
+	struct bttv_buffer     *vbi;       /* vbi buffer */
+	unsigned int           irqflags;
+	unsigned int           topirq;
 };
 
 struct bttv_overlay {
-	int tvnorm;
+	int                    tvnorm;
 	struct v4l2_rect       w;
 	enum v4l2_field        field;
 	struct v4l2_clip       *clips;
 	int                    nclips;
+	int                    setup_ok;
 };
 
 struct bttv_fh {
@@ -140,7 +143,6 @@
 
 	/* video capture */
 	struct videobuf_queue    cap;
-	/* struct bttv_buffer       buf; */
 	const struct bttv_format *fmt;
 	int                      width;
 	int                      height;
@@ -157,28 +159,19 @@
 /* ---------------------------------------------------------- */
 /* bttv-risc.c                                                */
 
-/* alloc/free memory */
-int  bttv_riscmem_alloc(struct pci_dev *pci,
-			struct bttv_riscmem *risc,
-			unsigned int size);
-void bttv_riscmem_free(struct pci_dev *pci,
-		       struct bttv_riscmem *risc);
-
 /* risc code generators - capture */
-int bttv_risc_packed(struct bttv *btv, struct bttv_riscmem *risc,
+int bttv_risc_packed(struct bttv *btv, struct btcx_riscmem *risc,
 		     struct scatterlist *sglist,
-		     int offset, int bpl, int pitch, int lines);
-int bttv_risc_planar(struct bttv *btv, struct bttv_riscmem *risc,
+		     unsigned int offset, unsigned int bpl,
+		     unsigned int pitch, unsigned int lines);
+int bttv_risc_planar(struct bttv *btv, struct btcx_riscmem *risc,
 		     struct scatterlist *sglist,
-		     int yoffset, int ybpl, int ypadding, int ylines,
-		     int uoffset, int voffset, int hshift, int vshift,
-		     int cpadding);
-
-/* risc code generator + helpers - screen overlay */
-int bttv_screen_clips(int swidth, int sheight, struct v4l2_rect *win,
-		      struct v4l2_clip *clips, int n);
-void bttv_sort_clips(struct v4l2_clip *clips, int nclips);
-int bttv_risc_overlay(struct bttv *btv, struct bttv_riscmem *risc,
+		     unsigned int yoffset,  unsigned int ybpl,
+		     unsigned int ypadding, unsigned int ylines,
+		     unsigned int uoffset,  unsigned int voffset,
+		     unsigned int hshift,   unsigned int vshift,
+		     unsigned int cpadding);
+int bttv_risc_overlay(struct bttv *btv, struct btcx_riscmem *risc,
 		      const struct bttv_format *fmt,
 		      struct bttv_overlay *ov,
 		      int skip_top, int skip_bottom);
@@ -191,13 +184,13 @@
 /* control dma register + risc main loop */
 void bttv_set_dma(struct bttv *btv, int override, int irqflags);
 int bttv_risc_init_main(struct bttv *btv);
-int bttv_risc_hook(struct bttv *btv, int slot, struct bttv_riscmem *risc,
+int bttv_risc_hook(struct bttv *btv, int slot, struct btcx_riscmem *risc,
 		   int irqflags);
 
 /* capture buffer handling */
 int bttv_buffer_risc(struct bttv *btv, struct bttv_buffer *buf);
-int bttv_buffer_activate(struct bttv *btv, struct bttv_buffer *top,
-			 struct bttv_buffer *bottom);
+int bttv_buffer_set_activate(struct bttv *btv,
+			     struct bttv_buffer_set *set);
 void bttv_dma_free(struct bttv *btv, struct bttv_buffer *buf);
 
 /* overlay handling */
@@ -209,7 +202,8 @@
 /* ---------------------------------------------------------- */
 /* bttv-vbi.c                                                 */
 
-void bttv_vbi_fmt(struct bttv_fh *fh, struct v4l2_format *f);
+void bttv_vbi_try_fmt(struct bttv_fh *fh, struct v4l2_format *f);
+void bttv_vbi_get_fmt(struct bttv_fh *fh, struct v4l2_format *f);
 void bttv_vbi_setlines(struct bttv_fh *fh, struct bttv *btv, int lines);
 
 extern struct videobuf_queue_ops bttv_vbi_qops;
@@ -236,7 +230,7 @@
 
 /* our devices */
 #define BTTV_MAX 4
-extern int bttv_num;
+extern unsigned int bttv_num;
 extern struct bttv bttvs[BTTV_MAX];
 
 #define BTTV_MAX_FBUF   0x208000
@@ -263,8 +257,9 @@
         unsigned int nr;       /* dev nr (for printk("bttv%d: ...");  */
 	char name[8];          /* dev name */
 	unsigned int cardid;   /* pci subsystem id (bt878 based ones) */
-	int type;              /* card type (pointer into tvcards[])  */
-        int tuner_type;        /* tuner chip type */
+	unsigned int type;     /* card type (pointer into tvcards[])  */
+        unsigned int tuner_type;  /* tuner chip type */
+        unsigned int pinnacle_id;
 	struct bttv_pll_info pll;
 	int triton1;
 
@@ -291,12 +286,12 @@
         struct semaphore reslock;
 
 	/* video state */
-	int input;
-	int audio;
+	unsigned int input;
+	unsigned int audio;
 	unsigned long freq;
 	int tvnorm,hue,contrast,bright,saturation;
 	struct video_buffer fbuf;
-	int field_count;
+	unsigned int field_count;
 
 	/* various options */
 	int opt_combfilter;
@@ -325,21 +320,19 @@
 
 	/* risc memory management data
 	   - must aquire s_lock before changing these
-	   - only the irq handler is supported to touch odd + even */
-	struct bttv_riscmem    main;
-	struct bttv_buffer     *top;       /* current active top field    */
-	struct bttv_buffer     *bottom;    /* current active bottom field */
-	struct bttv_buffer     *screen;    /* overlay                     */
-	struct list_head       capture;    /* capture buffer queue        */
-	struct bttv_buffer     *vcurr;
-	struct list_head       vcapture;
+	   - only the irq handler is supported to touch top + bottom + vcurr */
+	struct btcx_riscmem     main;
+	struct bttv_buffer      *screen;    /* overlay             */
+	struct list_head        capture;    /* video capture queue */
+	struct list_head        vcapture;   /* vbi capture queue   */
+	struct bttv_buffer_set  curr;       /* active buffers      */
 
 	unsigned long cap_ctl;
 	unsigned long dma_on;
 	struct timer_list timeout;
-	int errors;
+	unsigned int errors;
 
-	int users;
+	unsigned int users;
 	struct bttv_fh init;
 };
 

-- 
sigfault
