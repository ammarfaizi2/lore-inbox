Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932595AbVI3WCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbVI3WCK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 18:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbVI3WCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 18:02:06 -0400
Received: from ns1.suse.de ([195.135.220.2]:55752 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932595AbVI3WCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 18:02:03 -0400
From: Andi Kleen <ak@suse.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [Patch] x86, x86_64: fix cpu model for family 0x6
Date: Sat, 1 Oct 2005 00:02:16 +0200
User-Agent: KMail/1.8
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <20050929190419.C15943@unix-os.sc.intel.com> <433D391A.70607@vc.cvut.cz> <20050930112310.A28092@unix-os.sc.intel.com>
In-Reply-To: <20050930112310.A28092@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510010002.16382.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 September 2005 20:23, Siddha, Suresh B wrote:
> On Fri, Sep 30, 2005 at 03:09:46PM +0200, Petr Vandrovec wrote:
> > Siddha, Suresh B wrote:
> > > -		if (c->x86 == 0xf) {
> > > +		if (c->x86 == 0xf)
> > >  			c->x86 += (tfms >> 20) & 0xff;
> > > +		if (c->x86 == 0x6 || c->x86 == 0xf)
> >
> > Are you sure this is correct?  You just incremented c->x86 by extended
> > family, so I believe test should be
> >
> >                  if (c->x86 == 0x6 || c->x86 >= 0xf)
>
> My bad. Your suggestion might work. But let me just follow what SDM Vol-2a
> says here. New patch appended.
>
> Andi, please apply.
I applied an earlier mix of your original one and Petr's suggestions. Hope 
it's ok. 

x86-64/i386: Fix CPU model for family 6

From: Suresh Siddha <suresh.b.siddha@intel.com>

According to cpuid instruction in IA32 SDM-Vol2, when computing cpu model,      
we need to consider extended model ID for family 0x6 also.                      

AK: Also added fixes/simplifcation from Petr Vandrovec
                                                                                
Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>        
Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/i386/kernel/cpu/common.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/common.c
+++ linux/arch/i386/kernel/cpu/common.c
@@ -233,10 +233,10 @@ static void __init early_cpu_detect(void
 		cpuid(0x00000001, &tfms, &misc, &junk, &cap0);
 		c->x86 = (tfms >> 8) & 15;
 		c->x86_model = (tfms >> 4) & 15;
-		if (c->x86 == 0xf) {
+		if (c->x86 == 0xf)
 			c->x86 += (tfms >> 20) & 0xff;
+		if (c->x86 >= 0x6)
 			c->x86_model += ((tfms >> 16) & 0xF) << 4;
-		}
 		c->x86_mask = tfms & 15;
 		if (cap0 & (1<<19))
 			c->x86_cache_alignment = ((misc >> 8) & 0xff) * 8;
Index: linux/arch/x86_64/kernel/setup.c
===================================================================
--- linux.orig/arch/x86_64/kernel/setup.c
+++ linux/arch/x86_64/kernel/setup.c
@@ -1059,10 +1059,10 @@ void __cpuinit early_identify_cpu(struct
 		c->x86 = (tfms >> 8) & 0xf;
 		c->x86_model = (tfms >> 4) & 0xf;
 		c->x86_mask = tfms & 0xf;
-		if (c->x86 == 0xf) {
+		if (c->x86 == 0xf)
 			c->x86 += (tfms >> 20) & 0xff;
+		if (c->x86 >= 0xf) 
 			c->x86_model += ((tfms >> 16) & 0xF) << 4;
-		} 
 		if (c->x86_capability[0] & (1<<19)) 
 			c->x86_clflush_size = ((misc >> 8) & 0xff) * 8;
 	} else {

