Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268591AbUI2Peq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268591AbUI2Peq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 11:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268527AbUI2Pep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 11:34:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31207 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268663AbUI2P2j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 11:28:39 -0400
Date: Wed, 29 Sep 2004 16:28:34 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Hannes Reinecke <hare@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [Patch] Fix oops on rmmod usb-storage
Message-ID: <20040929152834.GH16153@parcelfarce.linux.theplanet.co.uk>
References: <415A67B8.2080003@suse.de> <1096466196.2028.8.camel@mulgrave> <1096463876.15905.23.camel@localhost.localdomain> <1096467874.1762.15.camel@mulgrave> <415ACA4C.807@suse.de> <1096470919.1762.21.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096470919.1762.21.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 11:15:13AM -0400, James Bottomley wrote:
>  struct scsi_cmnd *scsi_get_command(struct scsi_device *dev, int gfp_mask)
>  {
> -	struct scsi_cmnd *cmd = __scsi_get_command(dev->host, gfp_mask);
> +	struct scsi_cmnd *cmd;
> +
> +	/* Bail if we can't get a reference to the device */
> +	if (!get_device(&dev->sdev_gendev))
> +		return NULL;

How can this happen?  You're taking the address of dev->sdev_gendev, so it
can't be NULL:

struct device * get_device(struct device * dev)
{
        return dev ? to_dev(kobject_get(&dev->kobj)) : NULL;
}

(kobject_get returns its argument).

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
