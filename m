Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266154AbUFIPD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266154AbUFIPD5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 11:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266156AbUFIPD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 11:03:57 -0400
Received: from holomorphy.com ([207.189.100.168]:1669 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266154AbUFIPDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 11:03:54 -0400
Date: Wed, 9 Jun 2004 07:58:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@fsmlabs.com>, Eric BEGOT <eric_begot@yahoo.fr>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-rc3-mm1
Message-ID: <20040609145849.GL1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@fsmlabs.com>,
	Eric BEGOT <eric_begot@yahoo.fr>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040609015001.31d249ca.akpm@osdl.org> <40C6F3C3.9040401@yahoo.fr> <Pine.LNX.4.58.0406090910170.1838@montezuma.fsmlabs.com> <20040609133653.GH1444@holomorphy.com> <Pine.LNX.4.58.0406090942420.1838@montezuma.fsmlabs.com> <20040609144809.GK1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040609144809.GK1444@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 07:48:09AM -0700, William Lee Irwin III wrote:
> I'm questioning whether the marking scheme is worth anything and if I
> should just rely on bounds-checking against the dynamically-detected
> physical APIC ID instead.

Actually I think blowing it away immediately is best. Bounds checks
don't work for everything.


-- wli

Index: mm1-2.6.7-rc3/arch/i386/kernel/mpparse.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/i386/kernel/mpparse.c	2004-06-09 07:42:04.221000000 -0700
+++ mm1-2.6.7-rc3/arch/i386/kernel/mpparse.c	2004-06-09 07:54:51.703325000 -0700
@@ -119,16 +119,6 @@
 }
 #endif
 
-static void MP_mark_version_physids(int version)
-{
-	int i;
-
-	for (i = 0; i < MAX_APICS; ++i) {
-		if (!MP_valid_apicid(i, version))
-			physid_set(i, phys_cpu_present_map);
-	}
-}
-
 void __init MP_processor_info (struct mpc_config_processor *m)
 {
  	int ver, apicid;
@@ -207,9 +197,7 @@
 	num_processors++;
 	ver = m->mpc_apicver;
 
-	if (MP_valid_apicid(apicid, ver))
-		MP_mark_version_physids(ver);
-	else {
+	if (!MP_valid_apicid(apicid, ver)) {
 		printk(KERN_WARNING "Processor #%d INVALID. (Max ID: %d).\n",
 			m->mpc_apicid, MAX_APICS);
 		--num_processors;
Index: mm1-2.6.7-rc3/arch/i386/mach-visws/mpparse.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/i386/mach-visws/mpparse.c	2004-06-09 07:11:51.380594000 -0700
+++ mm1-2.6.7-rc3/arch/i386/mach-visws/mpparse.c	2004-06-09 07:57:04.521134000 -0700
@@ -75,14 +75,6 @@
 			m->mpc_apicid);
 		ver = 0x10;
 	}
-	if (ver >= 0x14)
-		physid_set(0xff, phys_cpu_present_map);
-	else {
-		int i;
-
-		for (i = 0xf; i < MAX_APICS; ++i)
-			physid_set(i, phys_cpu_present_map);
-	}
 	apic_version[m->mpc_apicid] = ver;
 }
 
