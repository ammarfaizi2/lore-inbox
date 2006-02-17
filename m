Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751580AbWBQTz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbWBQTz7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 14:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWBQTz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 14:55:59 -0500
Received: from mgw-ext03.nokia.com ([131.228.20.95]:20217 "EHLO
	mgw-ext03.nokia.com") by vger.kernel.org with ESMTP
	id S1750899AbWBQTz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 14:55:58 -0500
Message-ID: <43F629AF.5050309@indt.org.br>
Date: Fri, 17 Feb 2006 15:53:19 -0400
From: Carlos Aguiar <carlos.aguiar@indt.org.br>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Pierre Ossman <drzeus-list@drzeus.cx>, Tony Lindgren <tony@atomide.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/5] MMC OMAP driver
References: <43DF6750.1060505@indt.org.br> <20060201124434.GC3072@flint.arm.linux.org.uk> <20060201194724.GD15939@atomide.com> <20060202104022.GF5034@flint.arm.linux.org.uk> <43E1F0F3.3020801@drzeus.cx> <20060202122410.GA12508@flint.arm.linux.org.uk>
In-Reply-To: <20060202122410.GA12508@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2006 19:53:19.0709 (UTC) FILETIME=[CD1410D0:01C633FB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russel,

I was taking a look at your patch and I think you have to make the 
follwing change:

> 
>diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>--- a/include/linux/mmc/mmc.h
>+++ b/include/linux/mmc/mmc.h
>@@ -21,24 +21,35 @@ struct mmc_command {
> 	u32			arg;
> 	u32			resp[4];
> 	unsigned int		flags;		/* expected response type */
>-#define MMC_RSP_NONE	(0 << 0)
>-#define MMC_RSP_SHORT	(1 << 0)
>-#define MMC_RSP_LONG	(2 << 0)
>-#define MMC_RSP_MASK	(3 << 0)
>-#define MMC_RSP_CRC	(1 << 3)		/* expect valid crc */
>-#define MMC_RSP_BUSY	(1 << 4)		/* card may send busy */
>-#define MMC_RSP_OPCODE	(1 << 5)		/* response contains opcode */
>+#define MMC_RSP_PRESENT	(1 << 0)
>+#define MMC_RSP_136	(1 << 1)		/* 136 bit response */
>+#define MMC_RSP_CRC	(1 << 2)		/* expect valid crc */
>+#define MMC_RSP_BUSY	(1 << 3)		/* card may send busy */
>+#define MMC_RSP_OPCODE	(1 << 4)		/* response contains opcode */
>+#define MMC_CMD_MASK	(3 << 5)		/* command type */
>  
>
I think here you should put MMC_CMD_TYPE instead of MMC_CMD_MASK:

#define MMC_CMD_TYPE	(3 << 5)		/* command type */


>+#define MMC_CMD_AC	(0 << 5)
>+#define MMC_CMD_ADTC	(1 << 5)
>+#define MMC_CMD_BC	(2 << 5)
>+#define MMC_CMD_BCR	(3 << 5)
> 
> /*
>  * These are the response types, and correspond to valid bit
>  * patterns of the above flags.  One additional valid pattern
>  * is all zeros, which means we don't expect a response.
>  */
>-#define MMC_RSP_R1	(MMC_RSP_SHORT|MMC_RSP_CRC|MMC_RSP_OPCODE)
>-#define MMC_RSP_R1B	(MMC_RSP_SHORT|MMC_RSP_CRC|MMC_RSP_OPCODE|MMC_RSP_BUSY)
>-#define MMC_RSP_R2	(MMC_RSP_LONG|MMC_RSP_CRC)
>-#define MMC_RSP_R3	(MMC_RSP_SHORT)
>-#define MMC_RSP_R6	(MMC_RSP_SHORT|MMC_RSP_CRC)
>+#define MMC_RSP_NONE	(0)
>+#define MMC_RSP_R1	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
>+#define MMC_RSP_R1B	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE|MMC_RSP_BUSY)
>+#define MMC_RSP_R2	(MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC)
>+#define MMC_RSP_R3	(MMC_RSP_PRESENT)
>+#define MMC_RSP_R6	(MMC_RSP_PRESENT|MMC_RSP_CRC)
>+
>+#define mmc_resp_type(cmd)	((cmd)->flags & (MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC|MMC_RSP_BUSY|MMC_RSP_OPCODE))
>+
>+/*
>+ * These are the command types.
>+ */
>+#define mmc_cmd_type(cmd)	((cmd)->flags & MMC_CMD_TYPE)
>  
>
The change above is needed because MMC_CMD_TYPE is used here but not 
defined.

> 
> 	unsigned int		retries;	/* max number of retries */
> 	unsigned int		error;		/* command error */
>diff --git a/include/linux/mmc/protocol.h b/include/linux/mmc/protocol.h
>--- a/include/linux/mmc/protocol.h
>+++ b/include/linux/mmc/protocol.h
>@@ -79,7 +79,7 @@
> /* SD commands                           type  argument     response */
>   /* class 8 */
> /* This is basically the same command as for MMC with some quirks. */
>-#define SD_SEND_RELATIVE_ADDR     3   /* ac                      R6  */
>+#define SD_SEND_RELATIVE_ADDR     3   /* bcr                     R6  */
> 
>   /* Application commands */
> #define SD_APP_SET_BUS_WIDTH      6   /* ac   [1:0] bus width    R1  */
>
>
>  
>
BR,

Carlos.

-- 
Carlos Eduardo
Software Engineer
Nokia Institute of Technology - INdT
Embedded Linux Laboratory - 10LE
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br

