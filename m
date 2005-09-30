Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932581AbVI3SX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbVI3SX3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 14:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbVI3SX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 14:23:29 -0400
Received: from fmr21.intel.com ([143.183.121.13]:57290 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932581AbVI3SX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 14:23:28 -0400
Date: Fri, 30 Sep 2005 11:23:10 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org
Subject: Re: [Patch] x86, x86_64: fix cpu model for family 0x6
Message-ID: <20050930112310.A28092@unix-os.sc.intel.com>
References: <20050929190419.C15943@unix-os.sc.intel.com> <433D391A.70607@vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <433D391A.70607@vc.cvut.cz>; from vandrove@vc.cvut.cz on Fri, Sep 30, 2005 at 03:09:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 03:09:46PM +0200, Petr Vandrovec wrote:
> Siddha, Suresh B wrote:
> > -		if (c->x86 == 0xf) {
> > +		if (c->x86 == 0xf)
> >  			c->x86 += (tfms >> 20) & 0xff;
> > +		if (c->x86 == 0x6 || c->x86 == 0xf)
> 
> Are you sure this is correct?  You just incremented c->x86 by extended
> family, so I believe test should be
> 
>                  if (c->x86 == 0x6 || c->x86 >= 0xf)

My bad. Your suggestion might work. But let me just follow what SDM Vol-2a
says here. New patch appended.

Andi, please apply.

thanks,
suresh

--

According to cpuid instruction in IA32 SDM-Vol2, when computing cpu model,
we need to consider extended model ID for family 0x6 also.
  
Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

--- linux-2.6.14-rc2-git7/arch/x86_64/kernel/setup.c~	2005-09-29 18:05:26.503939536 -0700
+++ linux-2.6.14-rc2-git7/arch/x86_64/kernel/setup.c	2005-09-30 10:17:37.964209680 -0700
@@ -1059,10 +1059,10 @@ void __cpuinit early_identify_cpu(struct
 		c->x86 = (tfms >> 8) & 0xf;
 		c->x86_model = (tfms >> 4) & 0xf;
 		c->x86_mask = tfms & 0xf;
-		if (c->x86 == 0xf) {
-			c->x86 += (tfms >> 20) & 0xff;
+		if (c->x86 == 0x6 || c->x86 == 0xf)
 			c->x86_model += ((tfms >> 16) & 0xF) << 4;
-		} 
+		if (c->x86 == 0xf)
+			c->x86 += (tfms >> 20) & 0xff;
 		if (c->x86_capability[0] & (1<<19)) 
 			c->x86_clflush_size = ((misc >> 8) & 0xff) * 8;
 	} else {
--- linux-2.6.14-rc2-git7/arch/x86_64/kernel/setup.c~	2005-09-29 18:05:26.503939536 -0700
+++ linux-2.6.14-rc2-git7/arch/x86_64/kernel/setup.c	2005-09-30 10:17:37.964209680 -0700
@@ -1059,10 +1059,10 @@ void __cpuinit early_identify_cpu(struct
 		c->x86 = (tfms >> 8) & 0xf;
 		c->x86_model = (tfms >> 4) & 0xf;
 		c->x86_mask = tfms & 0xf;
-		if (c->x86 == 0xf) {
-			c->x86 += (tfms >> 20) & 0xff;
+		if (c->x86 == 0x6 || c->x86 == 0xf)
 			c->x86_model += ((tfms >> 16) & 0xF) << 4;
-		} 
+		if (c->x86 == 0xf)
+			c->x86 += (tfms >> 20) & 0xff;
 		if (c->x86_capability[0] & (1<<19)) 
 			c->x86_clflush_size = ((misc >> 8) & 0xff) * 8;
 	} else {
