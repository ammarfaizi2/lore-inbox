Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424167AbWKIV1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424167AbWKIV1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 16:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424199AbWKIV1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 16:27:47 -0500
Received: from smtp-out.google.com ([216.239.45.12]:42736 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1424167AbWKIV1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 16:27:46 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:mime-version:
	content-type:content-transfer-encoding:content-disposition;
	b=gP6U0W+pNnQSlI6XMrF1pca8FFJxiyva4lcfQ5EjbbEjt+XaD2sp++lQNg8jDqG5s
	FK1ALQ4DwhUncP5Rp4ozg==
Message-ID: <8f95bb250611091327j14cc96adwf66c0ed0ecf3b8ba@mail.gmail.com>
Date: Thu, 9 Nov 2006 13:27:39 -0800
From: "Aaron Durbin" <adurbin@google.com>
To: "Andi Kleen" <ak@suse.de>
Subject: [PATCH] x86_64: Fix partial page check to ensure unusable memory is not being marked usable.
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Mel Gorman" <mel@csn.ul.ie>, "Andrew Morton" <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix partial page check in e820_register_active_regions to ensure
partial pages are
not being marked as active in the memory pool.

Signed-off-by: Aaron Durbin <adurbin@google.com>

---
This was causing a machine to reboot w/ an area in the e820 that was less
than the page size because the upper address was being use to mark a hole as
active in the memory pool.

 arch/x86_64/kernel/e820.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86_64/kernel/e820.c b/arch/x86_64/kernel/e820.c
index a75c829..855b561 100644
--- a/arch/x86_64/kernel/e820.c
+++ b/arch/x86_64/kernel/e820.c
@@ -278,7 +278,7 @@ e820_register_active_regions(int nid, un
 								>> PAGE_SHIFT;

 		/* Skip map entries smaller than a page */
-		if (ei_startpfn > ei_endpfn)
+		if (ei_startpfn >= ei_endpfn)
 			continue;

 		/* Check if end_pfn_map should be updated */
-- 
1.4.2.GIT
