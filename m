Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbWDMXIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbWDMXIg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWDMXIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:08:15 -0400
Received: from cantor2.suse.de ([195.135.220.15]:16590 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932468AbWDMXIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:08:13 -0400
Date: Thu, 13 Apr 2006 16:06:51 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       paulus@samba.org, anton@samba.org,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 01/22] powerpc: iSeries needs slb_initialize to be called
Message-ID: <20060413230651.GB5613@kroah.com>
References: <20060413230141.330705000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="powerpc-iseries-needs-slb_initialize-to-be-called.patch"
In-Reply-To: <20060413230637.GA5613@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
Since the powerpc 64k pages patch went in, systems that have SLBs
(like Power4 iSeries) needed to have slb_initialize called to set up
some variables for the SLB miss handler.  This was not being called
on the boot processor on iSeries, so on single cpu iSeries machines,
we would get apparent memory curruption as soon as we entered user mode.

This patch fixes that by calling slb_initialize on the boot cpu if the
processor has an SLB.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/powerpc/kernel/setup_64.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- linux-2.6.16.5.orig/arch/powerpc/kernel/setup_64.c
+++ linux-2.6.16.5/arch/powerpc/kernel/setup_64.c
@@ -256,12 +256,10 @@ void __init early_setup(unsigned long dt
 	/*
 	 * Initialize stab / SLB management except on iSeries
 	 */
-	if (!firmware_has_feature(FW_FEATURE_ISERIES)) {
-		if (cpu_has_feature(CPU_FTR_SLB))
-			slb_initialize();
-		else
-			stab_initialize(lpaca->stab_real);
-	}
+	if (cpu_has_feature(CPU_FTR_SLB))
+		slb_initialize();
+	else if (!firmware_has_feature(FW_FEATURE_ISERIES))
+		stab_initialize(lpaca->stab_real);
 
 	DBG(" <- early_setup()\n");
 }

--
