Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264479AbUESRpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUESRpS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 13:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbUESRpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 13:45:18 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:26053 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S264479AbUESRpK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 13:45:10 -0400
Message-ID: <40AB9D69.1010302@free.fr>
Date: Wed, 19 May 2004 19:46:17 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] bug in cpuid & msr on nosmp machine
References: <40AB8CDF.8060408@free.fr>
In-Reply-To: <40AB8CDF.8060408@free.fr>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070407020607020808010309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070407020607020808010309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

matthieu castet wrote:
> hi,
> 
> on monocpu machine (and maybe even on smp machine), when you try to 
> acces to a cpu that don't exist (/dev/cpu/1/cpuid), cpuid (msr) call 
> cpu_online, but on nosmp machine if the cpu!=0 this procude a BUG();
> So I add a check that verify if the cpu can exist before calling 
> cpu_online.
> 
> Matthieu CASTET
oups i send the wrong patch



--------------070407020607020808010309
Content-Type: text/x-patch;
 name="cpuid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpuid.patch"

--- linux-2.6.5/arch/i386/kernel/cpuid.c	2004-04-04 05:36:12.000000000 +0200
+++ linux/arch/i386/kernel/cpuid.c	2004-05-18 20:47:05.000000000 +0200
@@ -135,7 +135,7 @@
   int cpu = iminor(file->f_dentry->d_inode);
   struct cpuinfo_x86 *c = &(cpu_data)[cpu];
 
-  if (!cpu_online(cpu))
+  if (cpu >= num_possible_cpus() || !cpu_online(cpu))
     return -ENXIO;		/* No such CPU */
   if ( c->cpuid_level < 0 )
     return -EIO;		/* CPUID not supported */

--------------070407020607020808010309
Content-Type: text/x-patch;
 name="msr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="msr.patch"

--- linux-2.6.5/arch/i386/kernel/msr.c	2004-04-04 05:36:57.000000000 +0200
+++ linux/arch/i386/kernel/msr.c	2004-05-19 18:25:09.000000000 +0200
@@ -241,7 +241,7 @@
   int cpu = iminor(file->f_dentry->d_inode);
   struct cpuinfo_x86 *c = &(cpu_data)[cpu];
   
-  if (!cpu_online(cpu))
+  if (cpu >= num_possible_cpus() || !cpu_online(cpu))
     return -ENXIO;		/* No such CPU */
   if ( !cpu_has(c, X86_FEATURE_MSR) )
     return -EIO;		/* MSR not supported */

--------------070407020607020808010309--
