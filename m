Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVHDRah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVHDRah (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 13:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVHDR37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 13:29:59 -0400
Received: from fmr23.intel.com ([143.183.121.15]:5350 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262405AbVHDR3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 13:29:20 -0400
Date: Thu, 4 Aug 2005 10:27:12 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>,
       zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [patch 5/8] x86_64:Dont do broadcast IPIs when hotplug is enabled in flat mode.
Message-ID: <20050804102712.A16102@unix-os.sc.intel.com>
References: <20050801202017.043754000@araj-em64t> <20050801203011.403184000@araj-em64t> <20050804105107.GD97893@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050804105107.GD97893@muc.de>; from ak@muc.de on Thu, Aug 04, 2005 at 12:51:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 12:51:07PM +0200, Andi Kleen wrote:
> >  static void flat_send_IPI_allbutself(int vector)
> >  {
> > +#ifndef CONFIG_HOTPLUG_CPU
> >  	if (((num_online_cpus()) - 1) >= 1)
> >  		__send_IPI_shortcut(APIC_DEST_ALLBUT, vector,APIC_DEST_LOGICAL);
> > +#else
> > +	cpumask_t allbutme = cpu_online_map;
> > +	int me = get_cpu(); /* Ensure we are not preempted when we clear */
> > +	cpu_clear(me, allbutme);
> > +	flat_send_IPI_mask(allbutme, vector);
> > +	put_cpu();
> 
> This still needs the num_online_cpus()s check.
> 
> -Andi

Modified patch attached.

Andrew: the filename in your -mm queue is below, with the attached
patch.

x86_64dont-do-broadcast-ipis-when-hotplug-is-enabled-in-flat-mode.patch

-- 
Cheers,
Ashok Raj
- Open Source Technology Center


Note: Recent introduction of physflat mode for x86_64 inadvertently deleted 
the use of non-shortcut version of routines breaking CPU hotplug. The option
to select this via cmdline also is deleted with the physflat patch, hence
directly placing this code under CONFIG_HOTPLUG_CPU.

We dont want to use broadcast mode IPI's when hotplug is enabled. This causes
bad effects in send IPI to a cpu that is offline which can trip when the 
cpu is in the process of being kicked alive.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
-------------------------------------------------------
 arch/x86_64/kernel/genapic_flat.c |   10 ++++++++++
 1 files changed, 10 insertions(+)

Index: linux-2.6.13-rc4-mm1/arch/x86_64/kernel/genapic_flat.c
===================================================================
--- linux-2.6.13-rc4-mm1.orig/arch/x86_64/kernel/genapic_flat.c
+++ linux-2.6.13-rc4-mm1/arch/x86_64/kernel/genapic_flat.c
@@ -78,8 +78,18 @@ static void flat_send_IPI_mask(cpumask_t
 
 static void flat_send_IPI_allbutself(int vector)
 {
+#ifndef CONFIG_HOTPLUG_CPU
 	if (((num_online_cpus()) - 1) >= 1)
 		__send_IPI_shortcut(APIC_DEST_ALLBUT, vector,APIC_DEST_LOGICAL);
+#else
+	cpumask_t allbutme = cpu_online_map;
+	int me = get_cpu(); /* Ensure we are not preempted when we clear */
+	cpu_clear(me, allbutme);
+
+	if (!cpus_empty(allbutme))
+		flat_send_IPI_mask(allbutme, vector);
+	put_cpu();
+#endif
 }
 
 static void flat_send_IPI_all(int vector)
