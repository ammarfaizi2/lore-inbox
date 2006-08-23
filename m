Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWHWG2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWHWG2Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 02:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWHWG2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 02:28:24 -0400
Received: from mga06.intel.com ([134.134.136.21]:56103 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S932363AbWHWG2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 02:28:24 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,158,1154934000"; 
   d="scan'208"; a="113254170:sNHT17699689"
Date: Tue, 22 Aug 2006 23:28:21 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: Pozsar Balazs <pozsy@uhulinux.hu>
Cc: Jeff Garzik <jgarzik@pobox.com>, Prakash Punnoor <prakash@punnoor.de>,
       Jiri Benc <jbenc@suse.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] Fixes for ULi5261 (tulip driver)
Message-ID: <20060823062821.GD10658@goober>
References: <20050427124911.6212670f@griffin.suse.cz> <20060816191139.5d13fda8@griffin.suse.cz> <20060816174329.GC17650@ojjektum.uhulinux.hu> <200608162002.06793.prakash@punnoor.de> <20060816195345.GA12868@ojjektum.uhulinux.hu> <20060819001640.GE20111@goober> <20060819061507.GB8571@ojjektum.uhulinux.hu> <44E721E1.2030203@pobox.com> <20060821090351.GB19425@ojjektum.uhulinux.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821090351.GB19425@ojjektum.uhulinux.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pozsar,

On Mon, Aug 21, 2006 at 11:03:51AM +0200, Pozsar Balazs wrote:
> 
> Does this seem better?
> 
> Signed-off-by: Pozsar Balazs <pozsy@uhulinux.hu>
> 
> Fix uli526x initialization
> 
> 
> --- a/drivers/net/tulip/uli526x.c	2006-08-21 10:57:43.000000000 +0200
> +++ a/drivers/net/tulip/uli526x.c	2006-08-21 11:01:37.000000000 +0200
> @@ -486,6 +486,7 @@
>  	u8	phy_tmp;
>  	u16	phy_value;
>  	u16 phy_reg_reset;
> +	int resetwait = 10;
>  
>  	ULI526X_DBUG(0, "uli526x_init()", 0);
>  
> @@ -515,7 +516,11 @@
>  	phy_reg_reset = phy_read(db->ioaddr, db->phy_addr, 0, db->chip_id);
>  	phy_reg_reset = (phy_reg_reset | 0x8000);
>  	phy_write(db->ioaddr, db->phy_addr, 0, phy_reg_reset, db->chip_id);
> -	udelay(500);
> +	while (resetwait-- > 0) {
> +		if (!(phy_read(db->ioaddr, db->phy_addr, 0, db->chip_id) & 0x8000))
> +			break;
> +		udelay(500);
> +	}
>  
>  	/* Process Phyxcer Media Mode */
>  	uli526x_set_phyxcer(db);

Thanks for writing up this patch.  udelay(500) seems a touch
heavyweight, however.  Would you mind experimenting a bit to see what
the delay typically ends up being?  Just add a KERN_DEBUG message
printing out resetwait and then fiddle with the udelay granularity.

-VAL
