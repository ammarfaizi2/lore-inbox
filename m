Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263157AbUJ1Xtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263157AbUJ1Xtt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbUJ1XrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:47:19 -0400
Received: from colin2.muc.de ([193.149.48.15]:45579 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263092AbUJ1XqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:46:05 -0400
Date: 29 Oct 2004 01:46:02 +0200
Date: Fri, 29 Oct 2004 01:46:02 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: [PATCH] x86_64: Fix safe_smp_processor_id after genapic
Message-ID: <20041028234602.GA94390@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


genapic broke early safe_smp_processor_id(), especially when you
got a WARN_ON or oops early it would loops forever in show_trace.
The reason was that the x86_cpu_to_apicid array wasn't correctly
initialized.

This patch fixes this by just testing for this case.


Orginally from James Cleverdon
Acked-by: Andi Kleen <ak@muc.de> 

Please apply ASAP

Index: linux/include/asm-x86_64/smp.h
===================================================================
--- linux.orig/include/asm-x86_64/smp.h	2004-10-28 11:32:15.%N +0200
+++ linux/include/asm-x86_64/smp.h	2004-10-29 01:30:29.%N +0200
@@ -104,6 +104,11 @@
 		if (x86_cpu_to_apicid[i] == apicid)
 			return i;
 
+	/* No entries in x86_cpu_to_apicid?  Either no MPS|ACPI,
+	 * or called too early.  Either way, we must be CPU 0. */
+      	if (x86_cpu_to_apicid[0] == BAD_APICID)
+		return 0;
+
 	return -1;
 }
 
