Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264429AbUESQen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264429AbUESQen (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 12:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbUESQen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 12:34:43 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:42141 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S264429AbUESQei
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 12:34:38 -0400
Message-ID: <40AB8CDF.8060408@free.fr>
Date: Wed, 19 May 2004 18:35:43 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] bug in cpuid & msr on nosmp machine
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060108090909050307060504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060108090909050307060504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

hi,

on monocpu machine (and maybe even on smp machine), when you try to 
acces to a cpu that don't exist (/dev/cpu/1/cpuid), cpuid (msr) call 
cpu_online, but on nosmp machine if the cpu!=0 this procude a BUG();
So I add a check that verify if the cpu can exist before calling cpu_online.

Matthieu CASTET

--------------060108090909050307060504
Content-Type: text/x-patch;
 name="cpuid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpuid.patch"

--- linux/arch/i386/kernel/cpuid.c	2004-05-18 20:47:05.000000000 +0200
+++ linux-2.6.5/arch/i386/kernel/cpuid.c	2004-04-04 05:36:12.000000000 +0200
@@ -135,7 +135,7 @@
   int cpu = iminor(file->f_dentry->d_inode);
   struct cpuinfo_x86 *c = &(cpu_data)[cpu];
 
-  if (cpu >= num_possible_cpus() || !cpu_online(cpu))
+  if (!cpu_online(cpu))
     return -ENXIO;		/* No such CPU */
   if ( c->cpuid_level < 0 )
     return -EIO;		/* CPUID not supported */

--------------060108090909050307060504
Content-Type: text/x-patch;
 name="msr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="msr.patch"

--- linux/arch/i386/kernel/msr.c	2004-05-19 18:25:09.000000000 +0200
+++ linux-2.6.5/arch/i386/kernel/msr.c	2004-04-04 05:36:57.000000000 +0200
@@ -241,7 +241,7 @@
   int cpu = iminor(file->f_dentry->d_inode);
   struct cpuinfo_x86 *c = &(cpu_data)[cpu];
   
-  if (cpu >= num_possible_cpus() || !cpu_online(cpu))
+  if (!cpu_online(cpu))
     return -ENXIO;		/* No such CPU */
   if ( !cpu_has(c, X86_FEATURE_MSR) )
     return -EIO;		/* MSR not supported */

--------------060108090909050307060504--
