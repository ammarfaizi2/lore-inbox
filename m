Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVARWhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVARWhX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 17:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVARWhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 17:37:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:26013 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261453AbVARWhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 17:37:18 -0500
Date: Tue, 18 Jan 2005 14:37:05 -0800
From: Chris Wright <chrisw@osdl.org>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, emilyr@us.ibm.com,
       toml@us.ibm.com, tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/1] tpm: fix cause of SMP stack traces
Message-ID: <20050118143705.F469@build.pdx.osdl.net>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com> <Pine.LNX.4.58.0412161632200.4219@jo.austin.ibm.com> <Pine.LNX.4.58.0412171642570.9229@jo.austin.ibm.com> <Pine.LNX.4.58.0412201146060.10943@jo.austin.ibm.com> <29495f1d041221085144b08901@mail.gmail.com> <Pine.LNX.4.58.0412211209410.14092@jo.austin.ibm.com> <Pine.LNX.4.58.0501121236180.2453@jo.austin.ibm.com> <Pine.LNX.4.58.0501181621200.2473@jo.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0501181621200.2473@jo.austin.ibm.com>; from kjhall@us.ibm.com on Tue, Jan 18, 2005 at 04:29:23PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kylene Hall (kjhall@us.ibm.com) wrote:
> There were misplaced spinlock acquires and releases in the probe, open, 
> close and release paths which were causing might_sleep and schedule while 
> atomic error messages accompanied by stack traces when the kernel was 
> compiled with SMP support. Bug reported by Reben Jenster 
> <ruben@hotheads.de>
> 
> Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
> ---
> diff -uprN linux-2.6.10/drivers/char/tpm/tpm.c linux-2.6.10-tpm/drivers/char/tpm/tpm.c
> --- linux-2.6.10/drivers/char/tpm/tpm.c	2005-01-18 16:42:17.000000000 -0600
> +++ linux-2.6.10-tpm/drivers/char/tpm/tpm.c	2005-01-18 12:52:53.000000000 -0600
> @@ -373,8 +372,9 @@ int tpm_open(struct inode *inode, struct
>  {
>  	int rc = 0, minor = iminor(inode);
>  	struct tpm_chip *chip = NULL, *pos;
> +	unsigned long flags;
>  
> -	spin_lock(&driver_lock);
> +	spin_lock_irqsave(&driver_lock, flags);

Hmm, unless I'm missing something, this is only worse (for might sleep
warnings).  Now you've disabled irq's too.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
