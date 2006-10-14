Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422826AbWJNTQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422826AbWJNTQy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 15:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422835AbWJNTQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 15:16:53 -0400
Received: from usul.saidi.cx ([204.11.33.34]:41371 "EHLO usul.overt.org")
	by vger.kernel.org with ESMTP id S1422826AbWJNTQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 15:16:52 -0400
Message-ID: <21572.67.169.45.37.1160853308.squirrel@overt.org>
Date: Sat, 14 Oct 2006 15:15:08 -0400 (EDT)
Subject: [PATCH 2.6.18 RFC] mmc: Add support for mmc v4 wide-bus modes
From: philipl@overt.org
To: "Pierre Ossman" <drzeus-mmc@drzeus.cx>, linux-kernel@vger.kernel.org
Cc: "Jarkko Lavinen" <jarkko.lavinen@nokia.com>
User-Agent: SquirrelMail/1.4.8
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
Importance: Normal
X-Mime-Autoconverted: from 8bit to 7bit by courier 0.53
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre, Jarkko,

Here's the next change to add support for switching into the wide-bus
modes. It obviously builds on top of the previous high-speed patch.

Wide-bus is a more confusing situation for two reasons that I've
mentioned in passing before, but which I now need to go into more
detail about:

1) Bus testing: The mmc v4 spec defines two new commands which are
used to test the width of the data bus at the lowest possible level -
by sending a fixed test pattern to the card and seeing what comes back.
This allows the code to know for sure that wide buses are supported
even if the host controller caps are lying through their teeth. This
seems incredibly paranoid (SD doesn't do this) but I wouldn't be
grumbling except that I cannot, for the life of me, get the damn test
to work. I keep getting a data CRC error back - for both the reads and
writes. I've included my implementation of the test algorithm that is
failing but I'm not calling it in this diff. On one card it just failed
with the error and on another card, it left the card in a completely
confused state after failing. To make matters worse, the specs I have
are ambiguous as to the resp type. In the command table, it says that
it's R1 but the sample code says NONE. I've stuck with R1 because when
I use NONE, the controller complains about unexpected data interrupts.

Jarkko, I've been using the MMCA appnote and it has the confusing
description of the algorithm, so it's highly likely that the official
spec also contains the same stuff, but it would be great if you could
compare them and let me know if there are differences.

Pragmatically, I think we can manage without the bus test - although I
suppose there are situations where a 4 or 8 bit controller are used
with the extra data lines unconnected (in fact - does the nokia 770 fall
into this category?), so it seems we really ought to run the test.

2) Power classes: The mmc v4 spec allows a card to indicate that it would
like to draw more current than normal when running in wide-bus modes. It
defines separate power classes for each combination of 26/52MHZ and 4/8bit.
We currently don't have the infrastructure to query whether a higher power
level is safe, and I suspect we don't even have that information for some
of the support controllers. eg: the SDHCI spec doesn't say anything about
current draw. By my reading of the spec, these higher power levels are
optional and allow the card to "optimize its performance" but the card will
still function at the default levels. I have one card that requests a higher
power level and one which does not and both seem to work fine. I've added
a comment noting this situation in my diff.

So, if we skip the bus test and ignore the power classes, things seem to work.
With this patch, I can get significantly higher transfer rates, although
the scaling is certainly not linear. My laptop has a TI SDHCI controller which
has an odd clock which maxes out at 24MHz and can't run at 20MHz, so regular
mmc is really slow. The following are all read tests.

1) mmc < v4. 1 bit transfers at 12MHz: 1.3MBps
2) mmc v4. 1 bit transfers at 24MHz: 2.3MBps
3) mmc v4. 4 bit transfers at 24MHz: 5.5MBps for one card and 5.8MBps for the other.
4) My SD cards range from 4.6MBps to 5.7MBps.

Theoretically, those numbers should be 1.5, 3 and 12 MBps respectively, so there's
some overhead in there growing faster than the theoretical transfer rate - but that's
a separate problem. :-)

--phil

Signed-off-by: Philip Langdale <philipl@overt.org>
---

 drivers/mmc/mmc.c            |  188 +++++++++++++++++++++++++++++++++++++++----
 include/linux/mmc/host.h     |    2
 include/linux/mmc/protocol.h |    7 +
 3 files changed, 181 insertions(+), 16 deletions(-)

diff -urN /usr/src/linux-2.6.18/drivers/mmc/mmc.c linux-2.6.18-mmc4/drivers/mmc/mmc.c
--- /usr/src/linux-2.6.18/drivers/mmc/mmc.c	2006-10-14 09:50:32.000000000 -0700
+++ linux-2.6.18-mmc4/drivers/mmc/mmc.c	2006-10-14 11:48:34.000000000 -0700
@@ -397,23 +397,23 @@
 		return err;

 	/*
-	 * Default bus width is 1 bit.
-	 */
-	host->ios.bus_width = MMC_BUS_WIDTH_1;
-
-	/*
-	 * We can only change the bus width of the selected
-	 * card so therefore we have to put the handling
+	 * We can only change the bus width of SD cards when
+	 * they are selected so we have to put the handling
 	 * here.
+	 *
+	 * The card is in 1 bit mode by default so
+	 * we only need to change if it supports the
+	 * wider version.
 	 */
-	if (host->caps & MMC_CAP_4_BIT_DATA) {
+	if (mmc_card_sd(card) &&
+		(card->scr.bus_widths & SD_SCR_BUS_WIDTH_4)) {
+
 		/*
-		 * The card is in 1 bit mode by default so
-		 * we only need to change if it supports the
-		 * wider version.
-		 */
-		if (mmc_card_sd(card) &&
-			(card->scr.bus_widths & SD_SCR_BUS_WIDTH_4)) {
+		* Default bus width is 1 bit.
+		*/
+		host->ios.bus_width = MMC_BUS_WIDTH_1;
+
+		if (host->caps & MMC_CAP_4_BIT_DATA) {
 			struct mmc_command cmd;
 			cmd.opcode = SD_APP_SET_BUS_WIDTH;
 			cmd.arg = SD_BUS_WIDTH_4;
@@ -954,6 +954,110 @@
 	}
 }

+static unsigned int mmc_test_bus_width(struct mmc_host *host, struct mmc_card *card, int bits)
+{
+	struct mmc_request mrq;
+	struct mmc_command cmd;
+	struct mmc_data data;
+
+	struct scatterlist sg;
+
+	u8 test_data[2] = { 0, 0 };
+
+        switch (bits) {
+        case 8:
+        	test_data[0] = 0x55;
+        	test_data[1] = 0xaa;
+        	break;
+        case 4:
+        	test_data[0] = 0x5a;
+        	break;
+        case 1:
+        	test_data[0] = 0x40;
+        	break;
+        default:
+        	return 0;
+        }
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
+	cmd.opcode = MMC_BUSTEST_W;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+
+	memset(&data, 0, sizeof(struct mmc_data));
+
+	mmc_set_data_timeout(&data, card, 1);
+
+	data.blksz_bits = 1;
+	data.blksz = 1 << 1;
+	data.blocks = 1;
+	data.flags = MMC_DATA_WRITE;
+	data.sg = &sg;
+	data.sg_len = 1;
+
+	memset(&mrq, 0, sizeof(struct mmc_request));
+
+	mrq.cmd = &cmd;
+	mrq.data = &data;
+
+	sg_init_one(&sg, &test_data, 2);
+
+	mmc_wait_for_req(host, &mrq);
+
+	if (cmd.error != MMC_ERR_NONE || data.error != MMC_ERR_NONE) {
+		printk("Failed to send cmd 19: %d %d\n", cmd.error, data.error);
+		return 0;
+	}
+
+        /* Now read back */
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
+	cmd.opcode = MMC_BUSTEST_R;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+
+	memset(&data, 0, sizeof(struct mmc_data));
+
+	mmc_set_data_timeout(&data, card, 0);
+
+	data.blksz_bits = 1;
+	data.blksz = 1 << 1;
+	data.blocks = 1;
+	data.flags = MMC_DATA_READ;
+	data.sg = &sg;
+	data.sg_len = 1;
+
+	memset(&mrq, 0, sizeof(struct mmc_request));
+
+	mrq.cmd = &cmd;
+	mrq.data = &data;
+
+	sg_init_one(&sg, &test_data, 2);
+
+	mmc_wait_for_req(host, &mrq);
+
+	if (cmd.error != MMC_ERR_NONE || data.error != MMC_ERR_NONE) {
+		printk("Failed to send cmd 14: %d %d\n", cmd.error, data.error);
+		return 0;
+	}
+
+	printk("Got data back: %x %x\n", test_data[0], test_data[1]);
+	switch (bits) {
+	case 8:
+		if (test_data[0] == 0xaa && test_data[1] == 0x55)
+			return 1;
+	case 4:
+		if (test_data[0] == 0xa5)
+			return 1;
+	case 1:
+		if ((test_data[0] & 0xc0) == 0x80)
+			return 1;
+	default:
+		return 0;
+	}
+}
+
 static void mmc_process_ext_csds(struct mmc_host *host)
 {
 	int err;
@@ -965,6 +1069,9 @@

 	struct scatterlist sg;

+	int host_bus_width;
+	int card_bus_width;
+
 	/*
 	 * As the ext_csd is so large and mostly unused, we don't store the
 	 * raw block in mmc_card.
@@ -1029,10 +1136,9 @@
 			       "any high-speed modes.\n",
 				mmc_hostname(card->host));
 			mmc_card_set_bad(card);
-			/* printk a warning */
 			continue;
 		}
-
+
 		/* Activate highspeed support. */
 		cmd.opcode = MMC_SWITCH;
 		cmd.arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
@@ -1050,6 +1156,56 @@
 		}

 		mmc_card_set_highspeed(card);
+
+		/* Check for host support for wide-bus modes. */
+		if (host->caps & MMC_CAP_8_BIT_DATA) {
+			host_bus_width = MMC_BUS_WIDTH_8;
+			card_bus_width = EXT_CSD_BUS_WIDTH_8;
+		} else if (host->caps & MMC_CAP_4_BIT_DATA) {
+			host_bus_width = MMC_BUS_WIDTH_4;
+			card_bus_width = EXT_CSD_BUS_WIDTH_4;
+		} else {
+			continue;
+		}
+
+		/* Test for widebus support. */
+#if 0
+		host->ios.bus_width = MMC_BUS_WIDTH_4;
+		mmc_set_ios(host);
+		mmc_test_bus_width(host, card, 4);
+		host->ios.bus_width = MMC_BUS_WIDTH_1;
+		mmc_set_ios(host);
+#endif
+
+		/* Activate widebus support. */
+		cmd.opcode = MMC_SWITCH;
+		cmd.arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
+			  (EXT_CSD_BUS_WIDTH << 16) |
+			  (card_bus_width << 8) |
+			  EXT_CSD_CMD_SET_NORMAL;
+		cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
+
+		err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
+		if (err != MMC_ERR_NONE) {
+			printk("%s: failed to switch card to "
+			       "mmc v4 wide-bus mode.\n",
+			       mmc_hostname(card->host));
+			continue;
+		}
+
+		host->ios.bus_width = host_bus_width;
+
+		/*
+		 * MMC v4 cards can indicate they would like to draw more
+		 * than the default amount of current in wide-bus modes.
+		 * We currently don't have an infrastructure to query the host
+		 * as to whether these higher levels are safe - so we will
+		 * never switch the card into a higher draw mode.
+		 * Supposedly, allowing the card to draw more current will
+		 * let it perform better, but the specs seem to indicate that
+		 * the card will function correctly without the mode change.
+		 * Empirical testing supports this interpretation.
+		 */
 	}

 	mmc_deselect_cards(host);
diff -urN /usr/src/linux-2.6.18/include/linux/mmc/host.h linux-2.6.18-mmc4/include/linux/mmc/host.h
--- /usr/src/linux-2.6.18/include/linux/mmc/host.h	2006-09-19 20:42:06.000000000 -0700
+++ linux-2.6.18-mmc4/include/linux/mmc/host.h	2006-10-14 09:54:39.000000000 -0700
@@ -62,6 +62,7 @@

 #define MMC_BUS_WIDTH_1		0
 #define MMC_BUS_WIDTH_4		2
+#define MMC_BUS_WIDTH_8		4
 };

 struct mmc_host_ops {
@@ -85,6 +86,7 @@
 	unsigned long		caps;		/* Host capabilities */

 #define MMC_CAP_4_BIT_DATA	(1 << 0)	/* Can the host do 4 bit transfers */
+#define MMC_CAP_8_BIT_DATA	(2 << 0)	/* Can the host do 8 bit transfers */

 	/* host specific block data */
 	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */
diff -urN /usr/src/linux-2.6.18/include/linux/mmc/protocol.h linux-2.6.18-mmc4/include/linux/mmc/protocol.h
--- /usr/src/linux-2.6.18/include/linux/mmc/protocol.h	2006-10-14 09:50:32.000000000 -0700
+++ linux-2.6.18-mmc4/include/linux/mmc/protocol.h	2006-10-14 09:59:00.000000000 -0700
@@ -40,7 +40,9 @@
 #define MMC_READ_DAT_UNTIL_STOP  11   /* adtc [31:0] dadr        R1  */
 #define MMC_STOP_TRANSMISSION    12   /* ac                      R1b */
 #define MMC_SEND_STATUS	         13   /* ac   [31:16] RCA        R1  */
+#define MMC_BUSTEST_R            14   /* adtc                    R1  */
 #define MMC_GO_INACTIVE_STATE    15   /* ac   [31:16] RCA            */
+#define MMC_BUSTEST_W            19   /* adtc                    R1  */

   /* class 2 */
 #define MMC_SET_BLOCKLEN         16   /* ac   [31:0] block len   R1  */
@@ -255,6 +257,7 @@
  * EXT_CSD fields
  */

+#define EXT_CSD_BUS_WIDTH	183	/* R/W */
 #define EXT_CSD_HS_TIMING	185	/* R/W */
 #define EXT_CSD_CARD_TYPE	196	/* RO */

@@ -269,6 +272,10 @@
 #define EXT_CSD_CARD_TYPE_26	(1<<0)	/* Card can run at 26MHz */
 #define EXT_CSD_CARD_TYPE_52	(1<<1)	/* Card can run at 52MHz */

+#define EXT_CSD_BUS_WIDTH_1	0	/* Card is in 1 bit mode */
+#define EXT_CSD_BUS_WIDTH_4	1	/* Card is in 4 bit mode */
+#define EXT_CSD_BUS_WIDTH_8	2	/* Card is in 8 bit mode */
+
 /*
  * MMC_SWITCH access modes
  */


