Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWEDRQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWEDRQW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 13:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWEDRQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 13:16:21 -0400
Received: from mga06.intel.com ([134.134.136.21]:18855 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750760AbWEDRQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 13:16:21 -0400
X-IronPort-AV: i="4.05,89,1146466800"; 
   d="scan'208"; a="31521765:sNHT6219765573"
Date: Thu, 4 May 2006 10:09:40 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Jan Beulich <jbeulich@novell.com>
Cc: tigran@veritas.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] fix x86 microcode driver handling of multiple matching revisions
Message-ID: <20060504100940.A2571@unix-os.sc.intel.com>
References: <444F9D34.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <444F9D34.76E4.0078.0@novell.com>; from jbeulich@novell.com on Wed, Apr 26, 2006 at 04:17:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 04:17:56PM +0200, Jan Beulich wrote:
> @@ -197,21 +202,33 @@ static inline void mark_microcode_update
>  	pr_debug("   Checksum 0x%x\n", cksum);
>  
>  	if (mc_header->rev < uci->rev) {
> -		printk(KERN_ERR "microcode: CPU%d not 'upgrading' to earlier revision"
> -		       " 0x%x (current=0x%x)\n", cpu_num, mc_header->rev, uci->rev);
> -		goto out;
> +		if (uci->err == MC_NOTFOUND) {
> +			uci->err = MC_IGNORED;
> +			uci->cksum = mc_header->rev;
> +		} else if (uci->err == MC_IGNORED && uci->cksum < mc_header->rev)
> +			uci->cksum = mc_header->rev;
>  	} else if (mc_header->rev == uci->rev) {
> -		/* notify the caller of success on this cpu */
> -		uci->err = MC_SUCCESS;
> -		goto out;
> +		if (uci->err < MC_MARKED) {
> +			/* notify the caller of success on this cpu */
> +			uci->err = MC_SUCCESS;
> +		}
> +	} else if (uci->err != MC_ALLOCATED || mc_header->rev > uci->mc->hdr.rev) {
> +		pr_debug("microcode: CPU%d found a matching microcode update with "
> +			" revision 0x%x (current=0x%x)\n", cpu_num, mc_header->rev, uci->rev);
> +		uci->cksum = cksum;
> +		uci->pf = pf; /* keep the original mc pf for cksum calculation */
> +		uci->err = MC_MARKED; /* found the match */
> +		for_each_online_cpu(cpu_num) {
> +			if (ucode_cpu_info[cpu_num].mc == uci->mc) {
> +				uci->mc = NULL;
> +				break;
> +			}

Isn't there a memory leak here? Shouldn't this be
		for_each_online_cpu(cpu) {
			if (cpu == cpu_num)
				continue;
			if (ucode_cpu_info[cpu].mc == uci->mc) {
				uci->mc = NULL;
				break;
			}
		}

thanks,
suresh

> +		}
> +		if (uci->mc != NULL) {
> +			vfree(uci->mc);
> +			uci->mc = NULL;
> +		}
