Return-Path: <linux-kernel-owner+w=401wt.eu-S1753292AbWLOTha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbWLOTha (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 14:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753295AbWLOTha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 14:37:30 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2655 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbWLOTh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 14:37:29 -0500
Date: Fri, 15 Dec 2006 19:37:17 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       Tony Lindgren <tony@atomide.com>,
       ext David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 4/4] Add MMC Password Protection (lock/unlock) support V8: mmc_sysfs.diff
Message-ID: <20061215193717.GA10367@flint.arm.linux.org.uk>
Mail-Followup-To: Anderson Briglia <anderson.briglia@indt.org.br>,
	"Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
	Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org,
	"Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
	Tony Lindgren <tony@atomide.com>,
	ext David Brownell <david-b@pacbell.net>
References: <45748173.2050008@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45748173.2050008@indt.org.br>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 04:13:39PM -0400, Anderson Briglia wrote:
> Implement MMC password force erase, remove password, change password,
> unlock card and assign password operations. It uses the sysfs mechanism
> to send commands to the MMC subsystem. 

Sorry, this is still unsuitable for mainline.

> Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>
> Signed-off-by: Anderson Lizardo <anderson.lizardo <at> indt.org.br>
> Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>

Please use the standard format, do not obfuscate these.  The kernel
community utterly abhors this.

> +/*
> + * implement MMC password functions: force erase, remove password, change
> + * password, unlock card and assign password.
> + */
> +static ssize_t
> +mmc_lockable_store(struct device *dev, struct device_attribute *att,
> +	const char *data, size_t len)
> +{
> +	struct mmc_card *card = dev_to_mmc_card(dev);
> +	int err = 0;

Where is the check that the host can do byte-wise data transfers?

> +
> +	err = mmc_card_claim_host(card);
> +	if (err != MMC_ERR_NONE)
> +		return -EINVAL;
> +
> +	if (!mmc_card_lockable(card))
> +		return -EINVAL;

So writing to this file with a card which is not lockable results in
deadlocking the host.  Suggest you do as other subsystems do and have
one exit path, and use gotos, setting the appropriate return code in a
variable.  If everything goes via that it forces you to think about
where you want to jump to in each case.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
