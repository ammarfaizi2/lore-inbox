Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWFUAba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWFUAba (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 20:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWFUAba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 20:31:30 -0400
Received: from barracuda.s2io.com ([72.1.205.138]:63668 "EHLO
	barracuda.mail.s2io.com") by vger.kernel.org with ESMTP
	id S1751404AbWFUAb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 20:31:29 -0400
X-ASG-Debug-ID: 1150849886-17837-165-0
X-Barracuda-URL: http://72.1.205.138:8000/cgi-bin/mark.cgi
X-ASG-Whitelist: Client
Reply-To: <ravinandan.arakali@neterion.com>
From: "Ravinandan Arakali" <ravinandan.arakali@neterion.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <tglx@linutronix.de>, <dgc@sgi.com>, <mingo@elte.hu>, <neilb@suse.de>,
       <jblunck@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
       <balbir@in.ibm.com>, <ananda.raju@neterion.com>,
       <leonid.grossman@neterion.com>, <jes@trained-monkey.org>
X-ASG-Orig-Subj: RE: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries list (2nd version)
Subject: RE: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries list (2nd version)
Date: Tue, 20 Jun 2006 17:31:04 -0700
Message-ID: <007a01c694c9$fbbe7c20$3e10100a@pc.s2io.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20060620171831.32c9009a.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=3.5 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are right. Driver on website does not have the fix yet. It's still in
our internal tree.
We will submit patch to netdev either later today or tomorrow morning.

Ravi

-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org]
Sent: Tuesday, June 20, 2006 5:19 PM
To: ravinandan.arakali@neterion.com
Cc: tglx@linutronix.de; dgc@sgi.com; mingo@elte.hu; neilb@suse.de;
jblunck@suse.de; linux-kernel@vger.kernel.org;
linux-fsdevel@vger.kernel.org; viro@zeniv.linux.org.uk;
balbir@in.ibm.com; ananda.raju@neterion.com;
leonid.grossman@neterion.com; jes@trained-monkey.org
Subject: Re: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries
list (2nd version)


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

