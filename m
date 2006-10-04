Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422675AbWJDRqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbWJDRqn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422683AbWJDRqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:46:42 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:17874 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422675AbWJDRql
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:46:41 -0400
Subject: Re: [PATCH 1/1]  i383 numa: fix numaq/summit apicid conflict
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Andy Whitcroft <apw@shadowen.org>
Cc: torvalds@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       andrew <akpm@osdl.org>
In-Reply-To: <45238577.5090200@shadowen.org>
References: <1159925153.6512.11.camel@keithlap>
	 <45238577.5090200@shadowen.org>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Wed, 04 Oct 2006 10:46:33 -0700
Message-Id: <1159983993.5660.13.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-04 at 10:57 +0100, Andy Whitcroft wrote:
> keith mannthey wrote:
> > From: Keith Mannthey <kmannth@us.ibm.com> 
> > 
> >   This patch allows numaq to properly align cpus to their given node
> > during boot. Pass logical apicid to apicid_to_node and allow the summit
> > sub-arch to use physical apicid (hard_smp_processor_id()). 
> >   Tested against numaq and summit based systems with no issues. against
> > 2.6.18-git18. 
> > 
> > Signed-off-by: Keith Mannthey  <kmannth@us.ibm.com>
> > ---
> >  arch/i386/kernel/smpboot.c               |    2 +-
> >  include/asm-i386/mach-summit/mach_apic.h |    2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff -urN linux-2.6.18/arch/i386/kernel/smpboot.c linux-2.6.18-git18/arch/i386/kernel/smpboot.c
> > --- linux-2.6.18/arch/i386/kernel/smpboot.c	2006-10-02 02:59:49.000000000 -0700
> > +++ linux-2.6.18-git18/arch/i386/kernel/smpboot.c	2006-10-02 00:36:52.000000000 -0700
> > @@ -648,7 +648,7 @@
> >  {
> >  	int cpu = smp_processor_id();
> >  	int apicid = logical_smp_processor_id();
> > -	int node = apicid_to_node(hard_smp_processor_id());
> > +	int node = apicid_to_node(apicid);
> >  
> >  	if (!node_online(node))
> >  		node = first_online_node;
> > diff -urN linux-2.6.18/include/asm-i386/mach-summit/mach_apic.h linux-2.6.18-git18/include/asm-i386/mach-summit/mach_apic.h
> > --- linux-2.6.18/include/asm-i386/mach-summit/mach_apic.h	2006-10-02 02:59:54.000000000 -0700
> > +++ linux-2.6.18-git18/include/asm-i386/mach-summit/mach_apic.h	2006-10-02 00:51:24.000000000 -0700
> > @@ -88,7 +88,7 @@
> >  
> >  static inline int apicid_to_node(int logical_apicid)
> >  {
> > -	return apicid_2_node[logical_apicid];
> > +	return apicid_2_node[hard_smp_processor_id()];
> >  }
> >  
> >  /* Mapping from cpu number to logical apicid */
> 
> My worry here is that we might have users who are calling this about
> other cpus.  As you have effectivly ignored the parameter on summit here.

  I sort of thought about riping out the parameter to apicid_to_node and
letting summit and numaq fill in whatever they need.  apicid_to_node
should only be used in map_cpu_to_logical_apicid.  After this the kernel
has a nice cpu to node mapping and a great interface for it. 

> Can we not just map the hard_smp_processor_id to its logical apic id
> when filling in the apicid_2_node array on summit?  Such that it really
> does have the logical id in there?
  The apicid_2_node array comes right from the SRAT table....   Without
constructing yet another table I don't seem to have a good way to
translate logical to physical or vice versa. 

  Maybe making the callers of apicid_to_node pass both logical and
physical apicid will relive the worry?

  Sure we can create another bootime mapping but it seems overkill.
Really only summit and numaq do anything useful with apicid_to_node and
i386 numa for that matter and I don't expect any new numa sub
arches.... 


What do you think?

Thanks, 
  Keith 

