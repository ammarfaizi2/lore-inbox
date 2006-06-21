Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751872AbWFUAPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbWFUAPw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 20:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWFUAPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 20:15:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20352 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751175AbWFUAPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 20:15:51 -0400
Date: Tue, 20 Jun 2006 17:18:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: <ravinandan.arakali@neterion.com>
Cc: tglx@linutronix.de, dgc@sgi.com, mingo@elte.hu, neilb@suse.de,
       jblunck@suse.de, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
       balbir@in.ibm.com, ananda.raju@neterion.com,
       leonid.grossman@neterion.com, jes@trained-monkey.org
Subject: Re: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries
 list (2nd version)
Message-Id: <20060620171831.32c9009a.akpm@osdl.org>
In-Reply-To: <007601c694c5$359c4620$3e10100a@pc.s2io.com>
References: <20060620151019.797f120c.akpm@osdl.org>
	<007601c694c5$359c4620$3e10100a@pc.s2io.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ravinandan Arakali" <ravinandan.arakali@neterion.com> wrote:
>
> The formal submission will take some more time.
> To boot your system, can you use the driver available on our website ?

Not really - it's not my system and I'd need to monkey around and generate
a diff which I then cannot test.


The driver you have there (REL_2.0.14.5152_LX.tar.gz) doesn't actually
appear to fix the bug:

int s2io_open(struct net_device *dev)
{
	nic_t *sp = dev->priv;
	int err = 0;

	/*
	 * Make sure you have link off by default every time
	 * Nic is initialized
	 */
	netif_carrier_off(dev);
	sp->last_link_state = 0;

	/* Initialize H/W and enable interrupts */
	err = s2io_card_up(sp);
	if (err) {
		DBG_PRINT(ERR_DBG, "%s: H/W initialization failed\n",
			  dev->name);
		if (err == -ENODEV)
			goto hw_init_failed;
		else
			goto hw_enable_failed;
	}

#ifdef CONFIG_PCI_MSI
	/* Store the values of the MSIX table in the nic_t structure */
	store_xmsi_data(sp);

	/* After proper initialization of H/W, register ISR */
	if (sp->intr_type == MSI) {
		err = request_irq((int) sp->pdev->irq, s2io_msi_handle,
			SA_SHIRQ, sp->name, dev);


It's still calling request_irq() _after_ "enable interrupts".
