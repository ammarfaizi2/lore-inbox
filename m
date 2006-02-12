Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWBLKUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWBLKUX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 05:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWBLKUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 05:20:23 -0500
Received: from [85.8.13.51] ([85.8.13.51]:54150 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932379AbWBLKUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 05:20:22 -0500
Message-ID: <43EF0BDD.1010309@drzeus.cx>
Date: Sun, 12 Feb 2006 11:20:13 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060119)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: rmk+lkml@arm.linux.org.uk, drzeus-list@drzeus.cx,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH 2/2] [MMC] Secure Digital Host Controller Interface driver
References: <20060211001523.10315.34499.stgit@poseidon.drzeus.cx>	<20060211001525.10315.30769.stgit@poseidon.drzeus.cx> <20060212020137.3d630a4c.akpm@osdl.org>
In-Reply-To: <20060212020137.3d630a4c.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Pierre Ossman <drzeus@drzeus.cx> wrote:
>> Driver for the Secure Digital Host Controller Interface specification.
>>
>> ...
>>
>> +static void sdhci_transfer_pio(struct sdhci_host *host)
>> +{
>> +	char *buffer;
>> +	u32 mask;
>> +	int bytes, size;
>> +	unsigned long max_jiffies;
>> +
>> +	BUG_ON(!host->data);
>> +
>> +	if (host->num_sg == 0)
>> +		return;
>> +
>> +	bytes = 0;
>> +	if (host->data->flags & MMC_DATA_READ)
>> +		mask = SDHCI_DATA_AVAILABLE;
>> +	else
>> +		mask = SDHCI_SPACE_AVAILABLE;
>> +
>> +	buffer = sdhci_kmap_sg(host) + host->offset;
>> +
>> +	/* Transfer shouldn't take more than 5 s */
>> +	max_jiffies = jiffies + HZ * 5;
>> +
>> +	while (host->size > 0) {
>> +		if (time_after(jiffies, max_jiffies)) {
>> +			printk(KERN_ERR "%s: PIO transfer stalled. "
>> +				"Please report this to "
>> +				BUGMAIL ".\n", mmc_hostname(host->mmc));
>> +			sdhci_dumpregs(host);
>> +			host->data->error = MMC_ERR_FAILED;
>> +			sdhci_finish_data(host);
>> +			return;
> 
> This returns with the atomic kmap still held.  Ugly things will happen.
> 

Ouch. Missed that. Thanks for pointing it out.

>> +static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>> +{
>> +	struct sdhci_host *host;
>> +	unsigned long flags;
>> +	u8 ctrl;
>> +
>> +	host = mmc_priv(mmc);
>> +
>> +	spin_lock_irqsave(&host->lock, flags);
>> +
>> +	DBG("clock %uHz busmode %u powermode %u cs %u Vdd %u width %u\n",
>> +	     ios->clock, ios->bus_mode, ios->power_mode, ios->chip_select,
>> +	     ios->vdd, ios->bus_width);
>> +
>> +	/*
>> +	 * Reset the chip on each power off.
>> +	 * Should clear out any weird states.
>> +	 */
>> +	if (ios->power_mode == MMC_POWER_OFF)
>> +		sdhci_init(host);
> 
> This can do a 50 millisecond busywait with interrupts disabled.  I'd
> suggest you pop the lock and do a schedule_timeout().
> 

I'll have to have an extra look at what can happen in interrupt land first.

Not sure we can use a scheduled wait though. set_ios could be reachable
from interrupt context.

>> +static int sdhci_get_ro(struct mmc_host *mmc)
>> +{
>> +	struct sdhci_host *host;
>> +	unsigned long flags;
>> +	int present;
>> +
>> +	host = mmc_priv(mmc);
>> +
>> +	spin_lock_irqsave(&host->lock, flags);
>> +
>> +	present = readl(host->ioaddr + SDHCI_PRESENT_STATE);
>> +
>> +	spin_unlock_irqrestore(&host->lock, flags);
> 
> Does a readl() need a lock?
> 

Probably not. It's more a consistency thing. :)

>> +	init_timer(&host->timer);
>> +	host->timer.data = (unsigned long)host;
>> +	host->timer.function = sdhci_timeout_timer;
> 
> setup_timer().
> 
>> +static void sdhci_remove_slot(struct pci_dev *pdev, int slot)
>> +{
>> +	struct sdhci_chip *chip;
>> +	struct mmc_host *mmc;
>> +	struct sdhci_host *host;
>> +
>> +	chip = pci_get_drvdata(pdev);
>> +	host = chip->hosts[slot];
>> +	mmc = host->mmc;
>> +
>> +	chip->hosts[slot] = NULL;
>> +
>> +	mmc_remove_host(mmc);
>> +
>> +	del_timer_sync(&host->timer);
>> +
>> +	sdhci_reset(host, SDHCI_RESET_ALL);
>> +
>> +	tasklet_kill(&host->card_tasklet);
>> +	tasklet_kill(&host->finish_tasklet);
>> +
>> +	iounmap(host->ioaddr);
>> +
>> +	pci_release_region(pdev, host->bar);
>> +
>> +	free_irq(host->irq, host);
> 
> The mmc_detect_change() callback could run right here.  Is everything which
> it touches still allocated and in an appropriate state?
> 

No, it's not. But the host should be left alone after mmc_remove_host().
Otherwise I don't see a way to deallocate structures in a safe order.

> 
>> +	mmc_free_host(mmc);
>> +}
> 

