Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030478AbWJDJ5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030478AbWJDJ5v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 05:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030786AbWJDJ5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 05:57:51 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:6670 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1030478AbWJDJ5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 05:57:50 -0400
Message-ID: <45238577.5090200@shadowen.org>
Date: Wed, 04 Oct 2006 10:57:11 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: kmannth@us.ibm.com
CC: torvalds@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       andrew <akpm@osdl.org>
Subject: Re: [PATCH 1/1]  i383 numa: fix numaq/summit apicid conflict
References: <1159925153.6512.11.camel@keithlap>
In-Reply-To: <1159925153.6512.11.camel@keithlap>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

keith mannthey wrote:
> From: Keith Mannthey <kmannth@us.ibm.com> 
> 
>   This patch allows numaq to properly align cpus to their given node
> during boot. Pass logical apicid to apicid_to_node and allow the summit
> sub-arch to use physical apicid (hard_smp_processor_id()). 
>   Tested against numaq and summit based systems with no issues. against
> 2.6.18-git18. 
> 
> Signed-off-by: Keith Mannthey  <kmannth@us.ibm.com>
> ---
>  arch/i386/kernel/smpboot.c               |    2 +-
>  include/asm-i386/mach-summit/mach_apic.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff -urN linux-2.6.18/arch/i386/kernel/smpboot.c linux-2.6.18-git18/arch/i386/kernel/smpboot.c
> --- linux-2.6.18/arch/i386/kernel/smpboot.c	2006-10-02 02:59:49.000000000 -0700
> +++ linux-2.6.18-git18/arch/i386/kernel/smpboot.c	2006-10-02 00:36:52.000000000 -0700
> @@ -648,7 +648,7 @@
>  {
>  	int cpu = smp_processor_id();
>  	int apicid = logical_smp_processor_id();
> -	int node = apicid_to_node(hard_smp_processor_id());
> +	int node = apicid_to_node(apicid);
>  
>  	if (!node_online(node))
>  		node = first_online_node;
> diff -urN linux-2.6.18/include/asm-i386/mach-summit/mach_apic.h linux-2.6.18-git18/include/asm-i386/mach-summit/mach_apic.h
> --- linux-2.6.18/include/asm-i386/mach-summit/mach_apic.h	2006-10-02 02:59:54.000000000 -0700
> +++ linux-2.6.18-git18/include/asm-i386/mach-summit/mach_apic.h	2006-10-02 00:51:24.000000000 -0700
> @@ -88,7 +88,7 @@
>  
>  static inline int apicid_to_node(int logical_apicid)
>  {
> -	return apicid_2_node[logical_apicid];
> +	return apicid_2_node[hard_smp_processor_id()];
>  }
>  
>  /* Mapping from cpu number to logical apicid */

My worry here is that we might have users who are calling this about
other cpus.  As you have effectivly ignored the parameter on summit here.

Can we not just map the hard_smp_processor_id to its logical apic id
when filling in the apicid_2_node array on summit?  Such that it really
does have the logical id in there?

-apw
