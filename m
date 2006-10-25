Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423021AbWJYFcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423021AbWJYFcj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 01:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423022AbWJYFcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 01:32:39 -0400
Received: from usul.saidi.cx ([204.11.33.34]:47327 "EHLO usul.overt.org")
	by vger.kernel.org with ESMTP id S1423021AbWJYFci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 01:32:38 -0400
Message-ID: <53707.67.169.45.37.1161754148.squirrel@overt.org>
In-Reply-To: <453E6410.4050002@drzeus.cx>
References: <21572.67.169.45.37.1160853308.squirrel@overt.org>
    <453E6410.4050002@drzeus.cx>
Date: Wed, 25 Oct 2006 01:29:08 -0400 (EDT)
Subject: Re: [PATCH 2.6.18 RFC] mmc: Add support for mmc v4 wide-bus modes
From: philipl@overt.org
To: "Pierre Ossman" <drzeus-mmc@drzeus.cx>
Cc: philipl@overt.org, linux-kernel@vger.kernel.org,
       "Jarkko Lavinen" <jarkko.lavinen@nokia.com>
User-Agent: SquirrelMail/1.4.8
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
Importance: Normal
X-Mime-Autoconverted: from 8bit to 7bit by courier 0.53
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
>>
>> 1) Bus testing:
>
> Problems aside, from what I can see in the application note (in
> particular the flow charts), this part is optional. So I'd like to see
> this as a separate feature.

Well, if your interpretation of Jarkko's comment is correct, we can't even
run the test successfully right now - and it would explain why I keep getting
those CRC errors.

>
> Actually, SDHCI controller state how much power they can supply at
> different voltages. So the information is there in that case. But I
> think we'll see how much of a problem it is in practice first.

Ok. As you say, let's see how this does in the wild before worrying about this.

>
>> +
>> +	cmd.opcode = MMC_BUSTEST_W;
>> +	cmd.arg = 0;
>> +	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
>> +
>
> The application note seemed to indicate that it's R1b here.

The documentation is contradictory. The App notes says R1b and the Samsung
datasheet says R1. Neither works - and as this code isn't in this diff, we
can avoid confronting that problem for a bit. :-)

>
>> @@ -1050,6 +1156,56 @@
>>  		}
>>
>>  		mmc_card_set_highspeed(card);
>> +
>> +		/* Check for host support for wide-bus modes. */
>> +		if (host->caps & MMC_CAP_8_BIT_DATA) {
>> +			host_bus_width = MMC_BUS_WIDTH_8;
>> +			card_bus_width = EXT_CSD_BUS_WIDTH_8;
>> +		} else if (host->caps & MMC_CAP_4_BIT_DATA) {
>> +			host_bus_width = MMC_BUS_WIDTH_4;
>> +			card_bus_width = EXT_CSD_BUS_WIDTH_4;
>> +		} else {
>> +			continue;
>> +		}
>> +
>
> A bit of premature optimisation. Do the if:s when needed instead. It
> keeps the code readable.

As you wish. I've simplified it to only handle 4bit.

>> +#if 0
>
> Never acceptable. Keep such stuff in your development tree.

That's why the Subject had 'RFC' in it. :-) Obviously now removed.

>> +
>> +		/*
>> +		 * MMC v4 cards can indicate they would like to draw more
>> +		 * than the default amount of current in wide-bus modes.
>> +		 * We currently don't have an infrastructure to query the host
>> +		 * as to whether these higher levels are safe - so we will
>> +		 * never switch the card into a higher draw mode.
>> +		 * Supposedly, allowing the card to draw more current will
>> +		 * let it perform better, but the specs seem to indicate that
>> +		 * the card will function correctly without the mode change.
>> +		 * Empirical testing supports this interpretation.
>> +		 */
>
> It's sufficient to have this in the commit message.

And so it shall be.

--phil

This change adds support for the mmc4 4-bit wide-bus mode.

The mmc4 spec defines 8-bit and 4-bit transfer modes. As we do not support
any 8-bit hardware, this patch only adds support for the 4-bit mode, but
it can easily be built upon when the time comes.

The 4-bit mode is electrically compatible with SD's 4-bit mode but the
procedure for turning it on is different. This patch implements only
the essential parts of the procedure as defined by the spec. Two additional
steps are recommended but not compulsory. I am documenting them here so
that there's a record.

1) A bus-test mechanism is implemented using dedicated mmc commands which allow
for testing the functionality of the data bus at the electrical level. This is
pretty paranoid and they way the commands work is not compatible with the mmc
subsystem (they don't set valid CRC values).

2) MMC v4 cards can indicate they would like to draw more than the default amount
of current in wide-bus modes. We currently will never switch the card into a higher
draw mode. Supposedly, allowing the card to draw more current will let it perform
better, but the specs seem to indicate that the card will function correctly
without the mode change. Empirical testing supports this interpretation.

Signed-off-by: Philip Langdale <philipl@overt.org>
---

 drivers/mmc/mmc.c            |   51 +++++++++++++++++++++++++++++++------------
 include/linux/mmc/protocol.h |    5 ++++
 2 files changed, 42 insertions(+), 14 deletions(-)

diff -ur /usr/src/linux-2.6.18/drivers/mmc/mmc.c linux-2.6.18-mmc4/drivers/mmc/mmc.c
--- /usr/src/linux-2.6.18/drivers/mmc/mmc.c	2006-10-14 09:50:32.000000000 -0700
+++ linux-2.6.18-mmc4/drivers/mmc/mmc.c	2006-10-24 22:08:32.000000000 -0700
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
@@ -1050,6 +1048,29 @@
 		}

 		mmc_card_set_highspeed(card);
+
+		/* Check for host support for wide-bus modes. */
+		if (!(host->caps & MMC_CAP_4_BIT_DATA)) {
+			continue;
+		}
+
+		/* Activate 4-bit support. */
+		cmd.opcode = MMC_SWITCH;
+		cmd.arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
+			  (EXT_CSD_BUS_WIDTH << 16) |
+			  (EXT_CSD_BUS_WIDTH_4 << 8) |
+			  EXT_CSD_CMD_SET_NORMAL;
+		cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
+
+		err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
+		if (err != MMC_ERR_NONE) {
+			printk("%s: failed to switch card to "
+			       "mmc v4 4-bit bus mode.\n",
+			       mmc_hostname(card->host));
+			continue;
+		}
+
+		host->ios.bus_width = MMC_BUS_WIDTH_4;
 	}

 	mmc_deselect_cards(host);
diff -ur /usr/src/linux-2.6.18/include/linux/mmc/protocol.h linux-2.6.18-mmc4/include/linux/mmc/protocol.h
--- /usr/src/linux-2.6.18/include/linux/mmc/protocol.h	2006-10-14 09:50:32.000000000 -0700
+++ linux-2.6.18-mmc4/include/linux/mmc/protocol.h	2006-10-24 22:04:01.000000000 -0700
@@ -255,6 +255,7 @@
  * EXT_CSD fields
  */

+#define EXT_CSD_BUS_WIDTH	183	/* R/W */
 #define EXT_CSD_HS_TIMING	185	/* R/W */
 #define EXT_CSD_CARD_TYPE	196	/* RO */

@@ -269,6 +270,10 @@
 #define EXT_CSD_CARD_TYPE_26	(1<<0)	/* Card can run at 26MHz */
 #define EXT_CSD_CARD_TYPE_52	(1<<1)	/* Card can run at 52MHz */

+#define EXT_CSD_BUS_WIDTH_1	0	/* Card is in 1 bit mode */
+#define EXT_CSD_BUS_WIDTH_4	1	/* Card is in 4 bit mode */
+#define EXT_CSD_BUS_WIDTH_8	2	/* Card is in 8 bit mode */
+
 /*
  * MMC_SWITCH access modes
  */


