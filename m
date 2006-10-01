Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWJAXbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWJAXbT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 19:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWJAXbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 19:31:19 -0400
Received: from usul.saidi.cx ([204.11.33.34]:3485 "EHLO usul.overt.org")
	by vger.kernel.org with ESMTP id S932474AbWJAXbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 19:31:18 -0400
Message-ID: <15151.67.169.45.37.1159744878.squirrel@overt.org>
Date: Sun, 1 Oct 2006 19:21:18 -0400 (EDT)
Subject: [PATCH 2.6.18 2/2] mmc: Read mmc v4 EXT_CSD
From: philipl@overt.org
To: "Pierre Ossman" <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.8
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
Importance: Normal
References: 
In-Reply-To: 
X-Mime-Autoconverted: from 8bit to 7bit by courier 0.53
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Read in the mmc v4 EXT_CSD and populate the mmc_ext_csd.

--phil

Signed-off-by: Philip Langdale <philipl@overt.org>
---

 mmc.c |   84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 84 insertions(+)

--- linux-old/drivers/mmc/mmc.c	2006-04-08 13:12:18.000000000 -0700 +++ linux/drivers/mmc/mmc.c	2006-04-08
13:12:25.000000000 -0700
@@ -953,6 +953,88 @@
 	}
 }

+static void mmc_read_ext_csds(struct mmc_host *host)
+{
+	int err;
+	struct mmc_card *card;
+
+	struct mmc_request mrq;
+	struct mmc_command cmd;
+	struct mmc_data data;
+
+	struct scatterlist sg;
+
+	/*
+	 * As the ext_csd is so large and mostly unused, we don't store the
+	 * raw block in mmc_card.
+	 */
+	u8 ext_csd[512];
+
+	list_for_each_entry(card, &host->cards, node) {
+		if (card->state & (MMC_STATE_DEAD|MMC_STATE_PRESENT))
+			continue;
+		if (card->csd.mmca_vsn < CSD_SPEC_VER_4)
+			continue;
+
+		err = mmc_select_card(host, card);
+		if (err != MMC_ERR_NONE) {
+			mmc_card_set_dead(card);
+			continue;
+		}
+
+		memset(&cmd, 0, sizeof(struct mmc_command));
+
+		cmd.opcode = MMC_SEND_EXT_CSD;
+		cmd.arg = 0;
+		cmd.flags = MMC_RSP_R1;
+
+		memset(&data, 0, sizeof(struct mmc_data));
+
+		data.timeout_ns = card->csd.tacc_ns * 10;
+		data.timeout_clks = card->csd.tacc_clks * 10;
+		data.blksz_bits = 9;
+		data.blocks = 1;
+		data.flags = MMC_DATA_READ;
+		data.sg = &sg;
+		data.sg_len = 1;
+
+		memset(&mrq, 0, sizeof(struct mmc_request));
+
+		mrq.cmd = &cmd;
+		mrq.data = &data;
+
+		sg_init_one(&sg, &ext_csd, 512);
+
+		mmc_wait_for_req(host, &mrq);
+
+		if (cmd.error != MMC_ERR_NONE || data.error != MMC_ERR_NONE) {
+			mmc_card_set_dead(card);
+			continue;
+		}
+
+		card->ext_csd.cmd_set_rev = ext_csd[EXT_CSD_CMD_SET_REV];
+		card->ext_csd.ext_csd_rev = ext_csd[EXT_CSD_EXT_CSD_REV];
+		card->ext_csd.csd_structure = ext_csd[EXT_CSD_CSD_STRUCTURE];
+		card->ext_csd.card_type = ext_csd[EXT_CSD_CARD_TYPE];
+
+		card->ext_csd.pwr_cl_52_195 = ext_csd[EXT_CSD_PWR_CL_52_195];
+		card->ext_csd.pwr_cl_26_195 = ext_csd[EXT_CSD_PWR_CL_26_195];
+		card->ext_csd.pwr_cl_52_360 = ext_csd[EXT_CSD_PWR_CL_52_360];
+		card->ext_csd.pwr_cl_26_360 = ext_csd[EXT_CSD_PWR_CL_26_360];
+
+		card->ext_csd.min_perf_r_4_26 = ext_csd[EXT_CSD_MIN_PERF_R_4_26];
+		card->ext_csd.min_perf_w_4_26 = ext_csd[EXT_CSD_MIN_PERF_W_4_26];
+		card->ext_csd.min_perf_r_8_26_4_52 = ext_csd[EXT_CSD_MIN_PERF_R_8_26_4_52];
+		card->ext_csd.min_perf_w_8_26_4_52 = ext_csd[EXT_CSD_MIN_PERF_W_8_26_4_52];
+		card->ext_csd.min_perf_r_8_52 = ext_csd[EXT_CSD_MIN_PERF_R_8_52];
+		card->ext_csd.min_perf_w_8_52 = ext_csd[EXT_CSD_MIN_PERF_W_8_52];
+
+		card->ext_csd.s_cmd_set = ext_csd[EXT_CSD_S_CMD_SET];
+	}
+
+	mmc_deselect_cards(host);
+}
+
 static void mmc_read_scrs(struct mmc_host *host)
 {
 	int err;
@@ -1153,6 +1420,8 @@

 	if (host->mode == MMC_MODE_SD)
 		mmc_read_scrs(host);
+	else
+		mmc_read_ext_csds(host);
 }








