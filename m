Return-Path: <linux-kernel-owner+w=401wt.eu-S932805AbWLTKbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932805AbWLTKbh (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 05:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbWLTKbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 05:31:37 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:40446 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932749AbWLTKbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 05:31:36 -0500
Date: Wed, 20 Dec 2006 11:28:46 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [patch] x86_64: fix boot hang caused by CALGARY_IOMMU_ENABLED_BY_DEFAULT
Message-ID: <20061220102846.GA17139@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] x86_64: fix boot hang caused by CALGARY_IOMMU_ENABLED_BY_DEFAULT
From: Ingo Molnar <mingo@elte.hu>

one of my boxes didnt boot the 2.6.20-rc1-rt0 kernel rpm, it hung during 
early bootup. After an hour or two of happy debugging i narrowed it down 
to the CALGARY_IOMMU_ENABLED_BY_DEFAULT option, which was freshly added 
to 2.6.20 via the x86_64 tree and /enabled by default/.

commit bff6547bb6a4e82c399d74e7fba78b12d2f162ed claims:

    [PATCH] Calgary: allow compiling Calgary in but not using it by default

    This patch makes it possible to compile Calgary in but not use it by
    default. In this mode, use 'iommu=calgary' to activate it.

but the change does not actually practice it:

 config CALGARY_IOMMU_ENABLED_BY_DEFAULT
        bool "Should Calgary be enabled by default?"
        default y
        depends on CALGARY_IOMMU
        help
          Should Calgary be enabled by default? if you choose 'y', Calgary
          will be used (if it exists). If you choose 'n', Calgary will not be
          used even if it exists. If you choose 'n' and would like to use
          Calgary anyway, pass 'iommu=calgary' on the kernel command line.
          If unsure, say Y.

it's both 'default y', and says "If unsure, say Y". Clearly not a typo.

disabling this option makes my box boot again. The patch below fixes the 
Kconfig entry. Grumble.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/x86_64/Kconfig |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux/arch/x86_64/Kconfig
===================================================================
--- linux.orig/arch/x86_64/Kconfig
+++ linux/arch/x86_64/Kconfig
@@ -495,14 +495,13 @@ config CALGARY_IOMMU
 
 config CALGARY_IOMMU_ENABLED_BY_DEFAULT
 	bool "Should Calgary be enabled by default?"
-	default y
 	depends on CALGARY_IOMMU
 	help
-	  Should Calgary be enabled by default? if you choose 'y', Calgary
+	  Should Calgary be enabled by default? If you choose 'y', Calgary
 	  will be used (if it exists). If you choose 'n', Calgary will not be
 	  used even if it exists. If you choose 'n' and would like to use
 	  Calgary anyway, pass 'iommu=calgary' on the kernel command line.
-	  If unsure, say Y.
+	  If unsure, say N.
 
 # need this always selected by IOMMU for the VIA workaround
 config SWIOTLB
