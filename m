Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269106AbTGJJLd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 05:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269107AbTGJJLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 05:11:32 -0400
Received: from holomorphy.com ([66.224.33.161]:38832 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S269106AbTGJJL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 05:11:26 -0400
Date: Thu, 10 Jul 2003 02:27:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: Piet Delaney <piet@www.piet.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm3 - apm_save_cpus() Macro still bombs out
Message-ID: <20030710092720.GT15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Thomas Schlichter <schlicht@uni-mannheim.de>,
	Piet Delaney <piet@www.piet.net>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030708223548.791247f5.akpm@osdl.org> <20030709021849.31eb3aec.akpm@osdl.org> <1057815890.22772.19.camel@www.piet.net> <200307101122.59138.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307101122.59138.schlicht@uni-mannheim.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 11:22:56AM +0200, Thomas Schlichter wrote:
> Well, I didn't try the CPU_MASK_NONE fix. I am using my fix attached to my 
> first mail, but Andrew ment it was too complex (your quoting from above). So 
> he proposed the simpler fix, wich simply looked good to me...

Could you try the following?


diff -prauN mm3-2.5.74-1/arch/i386/kernel/apm.c mm3-2.5.74-apm-1/arch/i386/kernel/apm.c
--- mm3-2.5.74-1/arch/i386/kernel/apm.c	2003-07-09 00:03:25.000000000 -0700
+++ mm3-2.5.74-apm-1/arch/i386/kernel/apm.c	2003-07-10 00:53:51.000000000 -0700
@@ -506,8 +506,6 @@ static void apm_error(char *str, int err
  * Lock APM functionality to physical CPU 0
  */
  
-#ifdef CONFIG_SMP
-
 static cpumask_t apm_save_cpus(void)
 {
 	cpumask_t x = current->cpus_allowed;
@@ -522,17 +520,6 @@ static inline void apm_restore_cpus(cpum
 	set_cpus_allowed(current, mask);
 }
 
-#else
-
-/*
- *	No CPU lockdown needed on a uniprocessor
- */
- 
-#define apm_save_cpus()	0
-#define apm_restore_cpus(x)	(void)(x)
-
-#endif
-
 /*
  * These are the actual BIOS calls.  Depending on APM_ZERO_SEGS and
  * apm_info.allow_ints, we are being really paranoid here!  Not only
