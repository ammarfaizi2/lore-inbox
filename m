Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWDHVN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWDHVN5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 17:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWDHVN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 17:13:57 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:52569 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751433AbWDHVN5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 17:13:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oCuIZn73+pFiMqEHsAABJjoowbrz2c5GkHH50rXYKCniE/NKVR+zm8jNP0cNOUjjuvrsLn+nnS33GOlZ1lWQSx6eT3g6RgKrM+p21JU04D0F8o5qK4TqJX+bMVrG/yGylJ7+U3goTj7XBcHGDAWUAScr9a/DOd6s0wGi4KIQFLs=
Message-ID: <4a7f4910604081413r7dc50f7ejb8ccd59333dce7a@mail.gmail.com>
Date: Sat, 8 Apr 2006 14:13:53 -0700
From: "Philip Langdale" <langdalepl@gmail.com>
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.16] mmc: Read and parse mmc v4 ext_csd structure
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've recently being investigating adding support for the mmc v4 high speed
and wide bus features, based on some documents I found online (A couple of
samsung ones and the freely available mmc v4.1 application note).

For reference, these are:

v4.1 app note: http://www.mmca.org/compliance/buy_spec/AN_MMCA050419.pdf
samsung datsheet:
http://www.samsung.com/Products/Semiconductor/FlashCard/MMC/HighSpeedMMC/Fu=llSize_MMCplus/MC4GH02GNMCA/ds_HS_MMC_rev03.pdf
samsung app note:
http://www.samsung.com/Products/Semiconductor/Memory/appnote/hs_mmc_applica=tion_note_050111.pdf

I have successfully turned high speed and 4 bit transfers on in conjunction
with an sdhci controller and observed the expected speed increase - to be
about equivalent to an SD card on the same hardware. mmc v4 can go faster
but as you'd expect, the sdhci controller doesn't have an 8 bit bus and
can't run faster than SD speeds.

This proof of concept patch is available here for the curious:
http://intr.overt.org/diff.cgi/diffs/mmcv4.diff

However, turning that into a real mergable patch requires a lot more work;
there is an elaborate dance required to verify that any particular feature
is safe to turn on that includes special commands that spend test patterns
to the card and read them back (to verify 4/8bit suport at the electrical
level!) and a table of current draws at different speeds/bus widths which
have to be confirmed against the specific host controller; I don't have an
example of card that populates this table - my card apparently conforms to
mmc <= v4 power levels at all times, but this is obviously not something
one can presume.

As a tentative first step, this patch simply retrieves and parses the
EXT_CSD structure for v4 cards.

The EXT_CSD is a 512byte block that is transferred as a regular data block
(like the SD SCR). Most of it is unused, so it seems wasteful to cache the
raw block - instead I just pull out the relevant values and store
them explicitly. The EXT_CSD is read using CMD8.

Some fields are writable, but writing is done using a separate command (CMD=6
- not the same as the SD version) as is demonstrated in my proof of
concept patch.

In following changes, which I will develop as time allows, I will use the
EXT_CSD information and the test commands (14 and 19) to properly verify that
high speed and wide bus modes can be activated, and then actually activate them.

This is my first kernel patch in a long time, so I can only hope I get the
format right. Russell, if you have specific preferences on where the many
definitions should live, just let me know - I have merely attempted
to follow the pattern used for the base CSD.

Thanks,

--phil

Signed-off-by: Philip Langdale <philipl@mail.utexas.edu>
---

card.h     |   46 +++++++++++++++++++++++
protocol.h |   99 +++++++++++++++++++++++++++++++++++++++++++++++++--
2 files changed, 143 insertions(+), 2 deletions(-)

diff -ur /usr/src/linux/include/linux/mmc/card.h new/include/linux/mmc/card.h
--- /usr/src/linux/include/linux/mmc/card.h	2005-10-30 16:32:45.000000000 -0800
+++ new/include/linux/mmc/card.h	2006-02-12 12:03:17.000000000 -0800
@@ -33,6 +33,48 @@
 	unsigned int		capacity;
 };

+struct mmc_ext_csd {
+	unsigned char		cmd_set_rev;
+	unsigned char		ext_csd_rev;
+	unsigned char		csd_structure;
+
+	unsigned char		card_type;
+
+	/*
+	 * Each power class defines MAX RMS Current
+	 * and Max Peak Current in mA.
+	 * Each category is of the form:
+	 *   pwr_cl_<speed/MHz>_<voltage/V>
+	 *
+	 * Each category encodes the power class for 4
+	 * bit transfers in [3:0] and 8 bit transfers
+	 * in [7:4]. Use mmc_get_4bit_pwr_cl() and
+	 * mmc_get_8bit_pwr_cl() to decode these.
+	 */
+	unsigned char		pwr_cl_52_195;
+	unsigned char		pwr_cl_26_195;
+
+	unsigned char		pwr_cl_52_360;
+	unsigned char		pwr_cl_26_360;
+
+	/*
+	 * Performance classes describe the minimum
+	 * transfer speed the card claims to support
+	 * for the given bus widths and speeds.
+	 */
+	unsigned char		min_perf_r_4_26;
+	unsigned char		min_perf_w_4_26;
+	unsigned char		min_perf_r_8_26_4_52;
+	unsigned char		min_perf_w_8_26_4_52;
+	unsigned char		min_perf_r_8_52;
+	unsigned char		min_perf_w_8_52;
+
+	unsigned char		s_cmd_set;
+};
+
+#define mmc_get_4bit_pwr_cl(p)	(p & 0x0F)
+#define mmc_get_8bit_pwr_cl(p)	(p >> 4)
+
 struct sd_scr {
 	unsigned char		sda_vsn;
 	unsigned char		bus_widths;
@@ -56,11 +98,13 @@
 #define MMC_STATE_BAD		(1<<2)		/* unrecognised device */
 #define MMC_STATE_SDCARD	(1<<3)		/* is an SD card */
 #define MMC_STATE_READONLY	(1<<4)		/* card is read-only */
+#define MMC_STATE_HIGHSPEED	(1<<5)		/* card is in mmc4 highspeed mode */
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
 	u32			raw_scr[2];	/* raw card SCR */
 	struct mmc_cid		cid;		/* card identification */
 	struct mmc_csd		csd;		/* card specific */
+	struct mmc_ext_csd	ext_csd;	/* mmc v4 extended card specific */
 	struct sd_scr		scr;		/* extra SD information */
 };

@@ -69,12 +113,14 @@
 #define mmc_card_bad(c)		((c)->state & MMC_STATE_BAD)
 #define mmc_card_sd(c)		((c)->state & MMC_STATE_SDCARD)
 #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
+#define mmc_card_highspeed(c)	((c)->state & MMC_STATE_HIGHSPEED)

 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_dead(c)	((c)->state |= MMC_STATE_DEAD)
 #define mmc_card_set_bad(c)	((c)->state |= MMC_STATE_BAD)
 #define mmc_card_set_sd(c)	((c)->state |= MMC_STATE_SDCARD)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
+#define mmc_card_set_highspeed(c) ((c)->state |= MMC_STATE_HIGHSPEED)

 #define mmc_card_name(c)	((c)->cid.prod_name)
 #define mmc_card_id(c)		((c)->dev.bus_id)
diff -ur /usr/src/linux/include/linux/mmc/protocol.h
new/include/linux/mmc/protocol.h
--- /usr/src/linux/include/linux/mmc/protocol.h	2006-01-03
23:48:23.000000000 -0800
+++ new/include/linux/mmc/protocol.h	2006-02-12 12:12:45.000000000 -0800
@@ -33,6 +33,7 @@
 #define MMC_SET_RELATIVE_ADDR     3   /* ac   [31:16] RCA        R1  */
 #define MMC_SET_DSR               4   /* bc   [31:16] RCA            */
 #define MMC_SELECT_CARD           7   /* ac   [31:16] RCA        R1  */
+#define MMC_SEND_EXT_CSD          8   /* adtc                    R1  */
 #define MMC_SEND_CSD              9   /* ac   [31:16] RCA        R2  */
 #define MMC_SEND_CID             10   /* ac   [31:16] RCA        R2  */
 #define MMC_READ_DAT_UNTIL_STOP  11   /* adtc [31:0] dadr        R1  */
@@ -229,13 +230,107 @@

 #define CSD_STRUCT_VER_1_0  0           /* Valid for system
specification 1.0 - 1.2 */
 #define CSD_STRUCT_VER_1_1  1           /* Valid for system
specification 1.4 - 2.2 */
-#define CSD_STRUCT_VER_1_2  2           /* Valid for system
specification 3.1       */
+#define CSD_STRUCT_VER_1_2  2           /* Valid for system
specification 3.1 - 4.1 */
+#define CSD_STRUCT_EXT_CSD  3           /* Version is in
CSD_STRUCTURE in EXT_CSD */

 #define CSD_SPEC_VER_0      0           /* Implements system
specification 1.0 - 1.2 */
 #define CSD_SPEC_VER_1      1           /* Implements system
specification 1.4 */
 #define CSD_SPEC_VER_2      2           /* Implements system
specification 2.0 - 2.2 */
-#define CSD_SPEC_VER_3      3           /* Implements system
specification 3.1 */
+#define CSD_SPEC_VER_3      3           /* Implements system
specification 3.1 - 3.2 - 3.31 */
+#define CSD_SPEC_VER_4      4           /* Implements system
specification 4.0 - 4.1 */

+/*
+ * EXT_CSD fields
+ */
+#define EXT_CSD_BUS_WIDTH		183	/* WO  */
+#define EXT_CSD_HS_TIMING		185	/* R/W */
+#define EXT_CSD_POWER_CLASS		187	/* R/W */
+#define EXT_CSD_CMD_SET_REV		189	/* RO  */
+#define EXT_CSD_CMD_SET		191	/* R/W */
+#define EXT_CSD_EXT_CSD_REV		192	/* RO  */
+#define EXT_CSD_CSD_STRUCTURE		194	/* RO  */
+#define EXT_CSD_CARD_TYPE		196	/* RO  */
+#define EXT_CSD_PWR_CL_52_195		200	/* RO  */
+#define EXT_CSD_PWR_CL_26_195		201	/* RO  */
+#define EXT_CSD_PWR_CL_52_360		202	/* RO  */
+#define EXT_CSD_PWR_CL_26_360		203	/* RO  */
+#define EXT_CSD_MIN_PERF_R_4_26	205	/* RO  */
+#define EXT_CSD_MIN_PERF_W_4_26	206	/* RO  */
+#define EXT_CSD_MIN_PERF_R_8_26_4_52	207	/* RO  */
+#define EXT_CSD_MIN_PERF_W_8_26_4_52	208	/* RO  */
+#define EXT_CSD_MIN_PERF_R_8_52	209	/* RO  */
+#define EXT_CSD_MIN_PERF_W_8_52	210	/* RO  */
+#define EXT_CSD_S_CMD_SET		504	/* RO  */
+
+/*
+ * EXT_CSD field definitions
+ */
+
+#define EXT_CSD_BUS_WIDTH_1     0
+#define EXT_CSD_BUS_WIDTH_4     1
+#define EXT_CSD_BUS_WIDTH_8     2
+
+#define EXT_CSD_HS_TIMING_LEGACY	0	/* <= 20MHz */
+#define EXT_CSD_HS_TIMING_FAST		1	/* > 20Mhz */
+
+#define EXT_CSD_CMD_SET_REV_4	0
+
+#define EXT_CSD_CMD_SET_NORMAL		(1<<0)
+#define EXT_CSD_CMD_SET_SECURE		(1<<1)
+#define EXT_CSD_CMD_SET_CPSECURE	(1<<2)
+
+#define EXT_CSD_EXT_CSD_REV_1_0	0
+#define EXT_CSD_EXT_CSD_REV_1_1	1
+
+#define EXT_CSD_CARD_TYPE_26	(1<<0)	/* Card can run at 26MHz */
+#define EXT_CSD_CARD_TYPE_52	(1<<1)	/* Card can run at 52MHz */
+
+/*
+ * Power classes
+ *
+ * Each class is of the form:
+ *   <voltage>_<max RMS current/mA>_<max Peak Current/mA>
+ *
+ */
+#define EXT_CSD_PWR_CL_195_065_130	0
+#define EXT_CSD_PWR_CL_195_070_140	1
+#define EXT_CSD_PWR_CL_195_080_160	2
+#define EXT_CSD_PWR_CL_195_090_180	3
+#define EXT_CSD_PWR_CL_195_100_200	4
+#define EXT_CSD_PWR_CL_195_120_220	5
+#define EXT_CSD_PWR_CL_195_140_240	6
+#define EXT_CSD_PWR_CL_195_160_260	7
+#define EXT_CSD_PWR_CL_195_180_280	8
+#define EXT_CSD_PWR_CL_195_200_300	9
+#define EXT_CSD_PWR_CL_195_250_350	10
+
+#define EXT_CSD_PWR_CL_360_100_200	0
+#define EXT_CSD_PWR_CL_360_120_220	1
+#define EXT_CSD_PWR_CL_360_150_250	2
+#define EXT_CSD_PWR_CL_360_180_280	3
+#define EXT_CSD_PWR_CL_360_200_300	4
+#define EXT_CSD_PWR_CL_360_220_320	5
+#define EXT_CSD_PWR_CL_360_250_350	6
+#define EXT_CSD_PWR_CL_360_300_400	7
+#define EXT_CSD_PWR_CL_360_350_450	8
+#define EXT_CSD_PWR_CL_360_400_500	9
+#define EXT_CSD_PWR_CL_360_450_550	10
+
+#define EXT_CSD_MIN_PERF_CLASS_LEGACY	0x00 /* < 2.4 MB/s */
+#define EXT_CSD_MIN_PERF_CLASS_A	0x08 /* 2.4 MB/s */
+#define EXT_CSD_MIN_PERF_CLASS_B	0x0A /* 3 MB/s */
+#define EXT_CSD_MIN_PERF_CLASS_C	0x0F /* 4.5 MB/s */
+#define EXT_CSD_MIN_PERF_CLASS_D	0x14 /* 6 MB/s */
+#define EXT_CSD_MIN_PERF_CLASS_E	0x1E /* 9 MB/s */
+#define EXT_CSD_MIN_PERF_CLASS_F	0x28 /* 12 MB/s */
+#define EXT_CSD_MIN_PERF_CLASS_G	0x32 /* 15 MB/s */
+#define EXT_CSD_MIN_PERF_CLASS_H	0x3C /* 18 MB/s */
+#define EXT_CSD_MIN_PERF_CLASS_J	0x46 /* 21 MB/s */
+#define EXT_CSD_MIN_PERF_CLASS_K	0x50 /* 24 MB/s */
+#define EXT_CSD_MIN_PERF_CLASS_M	0x64 /* 30 MB/s */
+#define EXT_CSD_MIN_PERF_CLASS_O	0x78 /* 36 MB/s */
+#define EXT_CSD_MIN_PERF_CLASS_R	0x8C /* 42 MB/s */
+#define EXT_CSD_MIN_PERF_CLASS_T	0xA0 /* 48 MB/s */

 /*
  * SD bus widths
