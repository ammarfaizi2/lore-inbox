Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264951AbUEKWh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264951AbUEKWh4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 18:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264988AbUEKWh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 18:37:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17073 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264951AbUEKWhr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 18:37:47 -0400
Message-ID: <40A155AC.5090009@pobox.com>
Date: Tue, 11 May 2004 18:37:32 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dsaxena@plexity.net
CC: Andrew Morton <akpm@osdl.org>, wim@iguana.be, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Watchdog timer for Intel IXP4xx CPUs
References: <20040511212235.GA7729@plexity.net> <20040511143352.096bc071.akpm@osdl.org> <20040511215008.GA8063@plexity.net>
In-Reply-To: <20040511215008.GA8063@plexity.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deepak Saxena wrote:
> On May 11 2004, at 14:33, Andrew Morton was caught saying:
> +#ifdef CONFIG_WATCHDOG_NOWAYOUT
> +static int nowayout = 1;
> +#else
> +static int nowayout = 0;
> +#endif
> +static int heartbeat = 60;	/* (secs) Default is 1 minute */
> +static unsigned long wdt_status = 0;	
> +static unsigned long boot_status = 0;

Wastes bss(?) space to explicitly zero statics.


> +#define WDT_TICK_RATE (IXP4XX_PERIPHERAL_BUS_CLOCK * 1000000UL)
> +
> +#define	WDT_IN_USE		0
> +#define	WDT_OK_TO_CLOSE		1
> +
> +static void
> +wdt_enable(void)
> +{
> +	*IXP4XX_OSWK = IXP4XX_WDT_KEY;
> +	*IXP4XX_OSWE = 0;
> +	*IXP4XX_OSWT = WDT_TICK_RATE * heartbeat;
> +	*IXP4XX_OSWE = IXP4XX_WDT_COUNT_ENABLE | IXP4XX_WDT_RESET_ENABLE;
> +	*IXP4XX_OSWK = 0;
> +}
> +
> +static void 
> +wdt_disable(void)
> +{
> +	*IXP4XX_OSWK = IXP4XX_WDT_KEY;
> +	*IXP4XX_OSWE = 0;
> +	*IXP4XX_OSWK = 0;
> +}

Are these magic CPU addresses you're writing to?  Normally one uses bus 
macros to read/write to devices.  But SoC and embedded stuff is often 
special...


> +static int
> +ixp4xx_wdt_open(struct inode *inode, struct file *file)
> +{
> +	if (test_and_set_bit(WDT_IN_USE, &wdt_status))
> +		return -EBUSY;
> +
> +	clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
> +
> +	wdt_enable();
> +
> +	return 0;
> +}

You typically want semaphores rather than bit tests.

And what about blocking on multiple openers?


> +static ssize_t 
> +ixp4xx_wdt_write(struct file *file, const char *data, size_t len, loff_t *ppos)
> +{
> +	/* Can't seek (pwrite) on this device  */
> +	if (ppos != &file->f_pos)
> +		return -ESPIPE;
> +
> +	if (len) {
> +		if (!nowayout) {
> +			size_t i;
> +
> +			clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
> +
> +			for (i = 0; i != len; i++) {
> +				char c;
> +
> +				if (get_user(c, data + i))
> +					return -EFAULT;
> +				if (c == 'V')
> +					set_bit(WDT_OK_TO_CLOSE, &wdt_status);
> +			}
> +		}
> +		wdt_enable();
> +	}

do other watchdog drivers really twiddle a bit like this on each write?

Otherwise looks OK.

	Jeff



