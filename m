Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbTHXPha (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 11:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbTHXPha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 11:37:30 -0400
Received: from amdext.amd.com ([139.95.251.1]:57585 "EHLO amdext.amd.com")
	by vger.kernel.org with ESMTP id S261228AbTHXPh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 11:37:28 -0400
Message-ID: <99F2150714F93F448942F9A9F112634C080EF00E@txexmtae.amd.com>
From: paul.devriendt@amd.com
To: pavel@suse.cz, davej@redhat.com, linux-kernel@vger.kernel.org, aj@suse.de,
       mark.langsdorf@amd.com, richard.brunner@amd.com
Subject: RE: Cpufreq for opteron
Date: Sun, 24 Aug 2003 10:31:56 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 135605E41809484-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears to me that the BUG_ON() macro will take the machine
down ? The BUG_ON() checks in this code (a sample below, but 
this applies to all of the driver) are not fatal conditions - 
execution can continue if an error is returned. Taking the 
machine down to report on a non-fatal condition seems somewhat 
rude.

Paul.

> -----Original Message-----
> From: Pavel Machek [mailto:pavel@suse.cz]
> Sent: Friday, August 22, 2003 3:06 PM
> To: Dave Jones; kernel list; Devriendt, Paul; aj@suse.de; Langsdorf,
> Mark; Brunner, Richard
> Subject: Re: Cpufreq for opteron
> 
> 
> Hi!
> 
> Here's an updated version. It is quite a bit shorter, and thats
> good. Does it look good enough for inclusion?
> 							Pavel
> 
> +static int
> +write_new_fid(u32 fid)
> +{
> +	u32 lo;
> +	u32 savevid = currvid;
> +
> +	if ((fid & INVALID_FID_MASK) || (currvid & INVALID_VID_MASK)) {
> +		printk(KERN_ERR PFX
> +		       "internal error - fid/vid overflow on fid write\n");
> +		return 1;
> +	}
> +
> +	lo = fid | (currvid << MSR_C_LO_VID_SHIFT) | MSR_C_LO_INIT_FID_VID;
> +
> +	dprintk(KERN_DEBUG PFX "writing fid %x, lo %x, hi %x\n",
> +		fid, lo, plllock * PLL_LOCK_CONVERSION);
> +
> +	wrmsr(MSR_FIDVID_CTL, lo, plllock * PLL_LOCK_CONVERSION);
> +
> +	if (query_current_values_with_pending_wait())
> +		return 1;
> +
> +	count_off_irt();
> +
> +	BUG_ON(savevid != currvid);
> +	BUG_ON(fid != currfid);
> +	return 0;
> +}

