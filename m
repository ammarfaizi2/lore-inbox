Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWADB1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWADB1X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 20:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWADB1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 20:27:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38866 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751017AbWADB1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 20:27:22 -0500
Date: Tue, 3 Jan 2006 17:26:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net,
       mike@steroidmicros.com
Subject: Re: [patch 2.6.15-rc5-mm3] M25 series SPI flash
Message-Id: <20060103172635.17b641fa.akpm@osdl.org>
In-Reply-To: <200512192243.21889.david-b@pacbell.net>
References: <200512181037.39154.david-b@pacbell.net>
	<200512192243.21889.david-b@pacbell.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell <david-b@pacbell.net> wrote:
>
> Here's a driver for more traditional types of SPI flash, as found
> in the ST M25 series.  Contributed by Mike Lavender (thanks Mike!)
> and tested on some ColdFire boards.
> 

bah, attachments..

> This was originally a driver for the ST M25P80 SPI flash.   It's been
> updated slightly to handle other M25P series chips.
> 
> For many of these chips, the specific type could be probed, but for now
> this just requires static setup with flash_platform_data that lists the
> chip type (size, format) and any default partitioning to use.
> 
> From: Mike Lavender <mike@steroidmicros.com>
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 

Please put the From: at the very first line of the changelog.

Mike, please review section 11 of Documentation/SubmittingPatches and send
a Signed-off-by: for this work, thanks.


> +static int m25p80_write(struct mtd_info *mtd, loff_t to, size_t len,
> +	size_t *retlen, const u_char *buf)
> +{
> +	struct m25p *flash = mtd_to_m25p(mtd);
> +	u32 page_offset, page_size;
> +	struct spi_transfer t[2];
> +	struct spi_message m;
> +
> +	DEBUG(MTD_DEBUG_LEVEL2, "%s: %s %s 0x%08x, len %z\n", spi->dev.bus_id,
> +			__FUNCTION__, "to", (u32) to, len);
> +
> +	if (retlen)
> +		*retlen = 0;

If retlen can be NULL

> +	/* sanity checks */
> +	if (!len)
> +		return(0);
> +
> +	if (to + len > flash->mtd.size)
> +		return -EINVAL;
> +
> +  	down(&flash->lock);
> +
> +	/* Wait until finished previous write command. */
> +	if (wait_till_ready(flash))
> +		return 1;
> +
> +	write_enable(flash);
> +
> +	memset(t, 0, (sizeof t));
> +
> +	/* Set up the opcode in the write buffer. */
> +	flash->command[0] = OPCODE_PP;
> +	flash->command[1] = to >> 16;
> +	flash->command[2] = to >> 8;
> +	flash->command[3] = to;
> +
> +	t[0].tx_buf = flash->command;
> +	t[0].len = sizeof(flash->command);
> +
> +	m.transfers = t;
> +	m.n_transfer = 2;
> +
> +	/* what page do we start with? */
> +	page_offset = to % FLASH_PAGESIZE;
> +
> +	/* do all the bytes fit onto one page? */
> +	if (page_offset + len <= FLASH_PAGESIZE) {
> +		t[1].tx_buf = buf;
> +		t[1].len = len;
> +
> +		spi_sync(flash->spi, &m);
> +
> +		*retlen = m.actual_length - sizeof(flash->command);

this will oops.

