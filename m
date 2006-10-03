Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbWJCRka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbWJCRka (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 13:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbWJCRka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 13:40:30 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:25231 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1030366AbWJCRk3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 13:40:29 -0400
Message-ID: <4522A08A.7000107@drzeus.cx>
Date: Tue, 03 Oct 2006 19:40:26 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: philipl@overt.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18 1/2] mmc: Add structure definition for mmc v4 EXT_CSD
References: <45200340.9080306@overt.org> <45201116.2080601@drzeus.cx> <15141.67.169.45.37.1159744412.squirrel@overt.org>
In-Reply-To: <15141.67.169.45.37.1159744412.squirrel@overt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, I just want to note that these patches are not ready for merging
until they are part of a bigger set that actually uses these new features.

philipl@overt.org wrote:
> +struct mmc_ext_csd {
> +	unsigned char		cmd_set_rev;
> +	unsigned char		ext_csd_rev;
> +	unsigned char		csd_structure;
> +
> +	unsigned char		card_type;
> +
> +	/*
> +	 * Each power class defines MAX RMS Current
> +	 * and Max Peak Current in mA.
> +	 * Each category is of the form:
> +	 *   pwr_cl_<speed/MHz>_<voltage/V>
> +	 *
> +	 * Each category encodes the power class for 4
> +	 * bit transfers in [3:0] and 8 bit transfers
> +	 * in [7:4]. Use mmc_get_4bit_pwr_cl() and
> +	 * mmc_get_8bit_pwr_cl() to decode these.
> +	 */
> +	unsigned char		pwr_cl_52_195;
> +	unsigned char		pwr_cl_26_195;
> +
> +	unsigned char		pwr_cl_52_360;
> +	unsigned char		pwr_cl_26_360;
> +
> +	/*
> +	 * Performance classes describe the minimum
> +	 * transfer speed the card claims to support
> +	 * for the given bus widths and speeds.
> +	 */
> +	unsigned char		min_perf_r_4_26;
> +	unsigned char		min_perf_w_4_26;
> +	unsigned char		min_perf_r_8_26_4_52;
> +	unsigned char		min_perf_w_8_26_4_52;
> +	unsigned char		min_perf_r_8_52;
> +	unsigned char		min_perf_w_8_52;
> +
> +	unsigned char		s_cmd_set;
> +};
>   

Do we need all of these? As this structure is present in all cards, we
shouldn't keep more stuff in it than we actually need.

> @@ -62,11 +106,13 @@
>  #define MMC_STATE_BAD		(1<<2)		/* unrecognised device */
>  #define MMC_STATE_SDCARD	(1<<3)		/* is an SD card */
>  #define MMC_STATE_READONLY	(1<<4)		/* card is read-only */
> +#define MMC_STATE_HIGHSPEED	(1<<5)		/* card is in mmc4 highspeed mode */
>   

Please add this in the patch that actually needs the flag.

> +/*
> + * EXT_CSD fields
> + */
> +#define EXT_CSD_BUS_WIDTH		183	/* WO  */
> +#define EXT_CSD_HS_TIMING		185	/* R/W */
> +#define EXT_CSD_POWER_CLASS		187	/* R/W */
> +#define EXT_CSD_CMD_SET_REV		189	/* RO  */
> +#define EXT_CSD_CMD_SET		191	/* R/W */
> +#define EXT_CSD_EXT_CSD_REV		192	/* RO  */
> +#define EXT_CSD_CSD_STRUCTURE		194	/* RO  */
> +#define EXT_CSD_CARD_TYPE		196	/* RO  */
> +#define EXT_CSD_PWR_CL_52_195		200	/* RO  */
> +#define EXT_CSD_PWR_CL_26_195		201	/* RO  */
> +#define EXT_CSD_PWR_CL_52_360		202	/* RO  */
> +#define EXT_CSD_PWR_CL_26_360		203	/* RO  */
> +#define EXT_CSD_MIN_PERF_R_4_26	205	/* RO  */
> +#define EXT_CSD_MIN_PERF_W_4_26	206	/* RO  */
> +#define EXT_CSD_MIN_PERF_R_8_26_4_52	207	/* RO  */
> +#define EXT_CSD_MIN_PERF_W_8_26_4_52	208	/* RO  */
> +#define EXT_CSD_MIN_PERF_R_8_52	209	/* RO  */
> +#define EXT_CSD_MIN_PERF_W_8_52	210	/* RO  */
> +#define EXT_CSD_S_CMD_SET		504	/* RO  */
> +
>   

Please remove these and used fixed values in the decoding routine.
That's the way we do it for CID and CSD today.

Rgds
Pierre

