Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWHAWJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWHAWJW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 18:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWHAWJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 18:09:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47048 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751225AbWHAWJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 18:09:22 -0400
Subject: Re: [WATCHDOG] v2.6.18-rc3 patches
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060801200931.GA3758@infomag.infomag.iguana.be>
References: <20060801200931.GA3758@infomag.infomag.iguana.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Aug 2006 23:28:35 +0100
Message-Id: <1154471315.15540.104.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-01 am 22:09 +0200, ysgrifennodd Wim Van Sebroeck:
> If there are problems with these patches, please let me know.
> If not I will sent them to Linus on sunday.

NAK


> +
> +static void wdt_enable(void)

Open, fork and write from both processes. This needs a semaphore
> +{
> +	if (wdt_clk)
> +		clk_set_rate(wdt_clk, 1);
> +
> +	/* stop counter, initiate counter reset */
> +	__raw_writel(RESET_COUNT, WDTIM_CTRL(wdt_base));
> +	/*wait for reset to complete. 100% guarantee event */
> +	while (__raw_readl(WDTIM_COUNTER(wdt_base)));

Should have cpu_relax() and really ought to have a timeout in case it
fails. In fact it needs one or a barrier as you are using __raw and that
may not reload if the compiler is overclever.


> +static void wdt_disable(void)
> +{

Ditto - open, fork write the close sequence in parallel on both ?

> +		wdt_disable();		/*disable for now */
> +		set_bit(WDT_DEVICE_INITED, &wdt_status);
> +	}

Races an open occuring when misc_register is done and before we hit
wdt_disable.


