Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267370AbUGVXW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267370AbUGVXW7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 19:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbUGVXW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 19:22:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:19853 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267373AbUGVXWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 19:22:50 -0400
Date: Thu, 22 Jul 2004 19:21:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ryan Arnold <rsa@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: [announce] HVCS for inclusion in 2.6 tree
Message-Id: <20040722192152.7f37ea91.akpm@osdl.org>
In-Reply-To: <1090528007.3161.7.camel@localhost>
References: <1089819720.3385.66.camel@localhost>
	<16633.55727.513217.364467@cargo.ozlabs.ibm.com>
	<1090528007.3161.7.camel@localhost>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Arnold <rsa@us.ibm.com> wrote:
>
> +static int hvcs_get_pi(struct hvcs_struct *hvcsd)
> +{
> +	/* struct hvcs_partner_info *head_pi = NULL; */
> +	struct hvcs_partner_info *pi = NULL;
> +	unsigned int unit_address = hvcsd->vdev->unit_address;
> +	struct list_head head;
> +	unsigned long flags;
> +	int retval;
> +
> +	spin_lock_irqsave(&hvcs_pi_lock, flags);
> +	if (!hvcs_pi_buff) {
> +		spin_unlock_irqrestore(&hvcs_pi_lock, flags);
> +		return -EFAULT;
> +	}
> +	retval = hvcs_get_partner_info(unit_address, &head, hvcs_pi_buff);
> +	if (retval) {
> +		printk(KERN_ERR "HVCS: Failed to fetch partner"
> +			" info for vty-server@%x.\n",unit_address);
> +		spin_lock_irqsave(&hvcs_pi_lock, flags);

                ^^ spin_unlock

> +		return retval;
> +	}
> +	spin_unlock_irqrestore(&hvcs_pi_lock, flags);
> 

(Just move the spin_unlock() to be prior to the test of retval).

Suggest you review all similar code in the patch for the same copy-n-paste
bug.

