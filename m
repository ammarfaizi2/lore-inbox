Return-Path: <linux-kernel-owner+w=401wt.eu-S932265AbXADFZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbXADFZn (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 00:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbXADFZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 00:25:43 -0500
Received: from usul.saidi.cx ([204.11.33.34]:51096 "EHLO usul.overt.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932265AbXADFZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 00:25:42 -0500
Message-ID: <459C8FA4.7080709@overt.org>
Date: Wed, 03 Jan 2007 21:24:52 -0800
From: Philip Langdale <philipl@overt.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>, Alex Dubov <oakad@yahoo.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19] mmc: Add support for SDHC cards (Take 2)
References: <459928F3.9010804@overt.org> <20070103150620.ac733abb.akpm@osdl.org>
In-Reply-To: <20070103150620.ac733abb.akpm@osdl.org>
X-Enigmail-Version: 0.93.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 01 Jan 2007 07:29:55 -0800
> Philip Langdale <philipl@overt.org> wrote:
> 
>>  #define MMC_RSP_R1B	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE|MMC_RSP_BUSY)
>>  #define MMC_RSP_R2	(MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC)
>>  #define MMC_RSP_R3	(MMC_RSP_PRESENT)
>> -#define MMC_RSP_R6	(MMC_RSP_PRESENT|MMC_RSP_CRC)
>> +#define MMC_RSP_R6	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
>> +#define MMC_RSP_R7	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
> 
> This gives MMC_RSP_R1 and MMC_RSP_R6 the same value, so
> 
> drivers/mmc/tifm_sd.c: In function 'tifm_sd_op_flags':
> drivers/mmc/tifm_sd.c:190: error: duplicate case value
> drivers/mmc/tifm_sd.c:181: error: previously used here

This is a bug. The MMC_RSP_R? #defines do not fully characterise the
responses (specically, the way that the response is parsed is not
characterised) and consequently there is no guarantee of uniqueness.
Given this reality - the way that the tifm_sd driver works is unsafe.

If R6 had not been incorrectly defined (the missing RSP_OPCODE should
always have been there), then this code would not have worked. As things
currently stand, it is necessary to also check the command number to
decide on the correct response type - that's suboptimal and it's probably
good to uniquely identify the response in the mmc_command in some other
fashion.

I'm going to remove the R6 fix from my next diff to keep these things
distinct but this needs to be resolved.

--phil
