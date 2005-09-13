Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965162AbVIMTRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbVIMTRj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 15:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbVIMTRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 15:17:38 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:53470 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965160AbVIMTRh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 15:17:37 -0400
Date: Tue, 13 Sep 2005 14:16:05 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, lxie@us.ibm.com,
       santil@us.ibm.com
Subject: Re: [Patch] ibmvscsi compatibility fix
Message-ID: <20050913191605.GA608@IBM-BWN8ZTBWAO1>
References: <20050912024350.60e89eb1.akpm@osdl.org> <20050912222437.GA13124@sergelap.austin.ibm.com> <20050912161013.76ef833f.akpm@osdl.org> <20050913013840.GG5382@krispykreme> <20050913085643.GA24156@sergelap.austin.ibm.com> <20050913150902.GA22071@cs.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913150902.GA22071@cs.umn.edu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Works like a charm on my machine with 2.6.13-mm2.

thanks,
-serge

Quoting Dave C Boutcher (sleddog@us.ibm.com):
> Linda Xie ever so gently pointed out that she had a patch
> to preserve compatibility with older SLES targets, and I told
> her we didn't need to push it to mainline.
> 
> This patch explicitly checks the version of the IBMVSCSI target
> and ensures that large scatterlists are not sent to older 
> targets.
> 
> Andrew, while this stuff usually goes through James, it would
> probably make Serge happier if you could pick it up for the next
> mm.  
> 
> Signed-off-by: Linda Xie <lxie@us.ibm.com>
> Signed-off-by: Dave Boutcher <boutcher@us.ibm.com>
> 
> --- linux-2.6.13-mm3-orig/drivers/scsi/ibmvscsi/ibmvscsi.c	2005-09-13 09:50:31.000000000 -0500
> +++ linux-2.6.13.1/drivers/scsi/ibmvscsi/ibmvscsi.c	2005-09-13 09:09:41.000000000 -0500
> @@ -727,6 +727,16 @@
>  		if (hostdata->madapter_info.port_max_txu[0]) 
>  			hostdata->host->max_sectors = 
>  				hostdata->madapter_info.port_max_txu[0] >> 9;
> +		
> +		if (hostdata->madapter_info.os_type == 3 &&
> +		    strcmp(hostdata->madapter_info.srp_version, "1.6a") <= 0) {
> +			printk("ibmvscsi: host (Ver. %s) doesn't support large"
> +			       "transfers\n",
> +			       hostdata->madapter_info.srp_version);
> +			printk("ibmvscsi: limiting scatterlists to %d\n",
> +			       MAX_INDIRECT_BUFS);
> +			hostdata->host->sg_tablesize = MAX_INDIRECT_BUFS;
> +		}
>  	}
>  }
>  
> 

