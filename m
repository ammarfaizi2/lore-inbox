Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbWIVRLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbWIVRLJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 13:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWIVRLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 13:11:09 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:38871 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932614AbWIVRLF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 13:11:05 -0400
Subject: Re: [Patch] i386 bootioremap / kexec fix
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Vivek goyal <vgoyal@in.ibm.com>,
       dave hansen <haveblue@us.ibm.com>
In-Reply-To: <20060921201604.2cea5abb.akpm@osdl.org>
References: <1158893685.5657.72.camel@keithlap>
	 <20060921201604.2cea5abb.akpm@osdl.org>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Fri, 22 Sep 2006 10:11:02 -0700
Message-Id: <1158945063.5667.7.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-21 at 20:16 -0700, Andrew Morton wrote:
> On Thu, 21 Sep 2006 19:54:45 -0700
> keith mannthey <kmannth@us.ibm.com> wrote:
> 
> > 
> >   With CONFIG_PHYSICAL_START set to a non default values the i386
> > boot_ioremap code calculated its pte index wrong and users of
> > boot_ioremap have their areas incorrectly mapped  (for me SRAT table not
> > mapped during early boot). This patch removes the addr < BOOT_PTE_PTRS
> > constraint. 
> > 
> > Signed-off-by: Keith Mannthey<kmannth@us.ibm.com>
> > ---
> >  boot_ioremap.c |    7 +++++--
> >  1 files changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff -urN linux-2.6.18-rc6-mm2-orig/arch/i386/mm/boot_ioremap.c
> > linux-2.6.17/arch/i386/mm/boot_ioremap.c
> > --- linux-2.6.18-rc6-mm2-orig/arch/i386/mm/boot_ioremap.c	2006-09-18
> > 01:19:22.000000000 -0700
> > +++ linux-2.6.17/arch/i386/mm/boot_ioremap.c	2006-09-18
> > 01:23:33.000000000 -0700
> > @@ -29,8 +29,11 @@
> >   */
> >  
> >  #define BOOT_PTE_PTRS (PTRS_PER_PTE*2)
> > -#define boot_pte_index(address) \
> > -	     (((address) >> PAGE_SHIFT) & (BOOT_PTE_PTRS - 1))
> > +
> > +static unsigned long boot_pte_index(unsigned long vaddr) 
> > +{
> > +	return __pa(vaddr) >> PAGE_SHIFT;
> > +}
> >  
> >  static inline boot_pte_t* boot_vaddr_to_pte(void *address)
> >  {
> 
> Thanks.  This patch is against 2.6.18-rc6-mm2, yes?  Does it fix a bug which
> is only in -mm?  If so, do you know which patch introduced it?  Seems to me
> that this is a 2.6.18 fix?

The patch was against 2.6.18-rc6-mm2 but the problem is a 2.6.1[678]
issue.  The problem has always been present but my great new config
(KDUMP Kernel starts 16mb) brought it to the surface. 

For a little more context about how the fix came to be see
http://lkml.org/lkml/2006/9/12/357

> 
> Is this the thing which was causing your NUMA machine to fail?  If so, does
> 2.6.18 boot OK now?
Yes boots better now.  With the SRAT discovered it can setup 2 nodes in the VM.  

> You have a bit of wordwrapping happening there btw.
Sorry about I will work to be more careful. 

Thanks,
  Keith 

