Return-Path: <linux-kernel-owner+w=401wt.eu-S932171AbWLLJWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWLLJWs (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 04:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWLLJWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 04:22:48 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:49355 "EHLO
	laptopd505.fenrus.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932169AbWLLJWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 04:22:47 -0500
Subject: Re: [PATCH] Whinge in paging_init if noexec is on with a non-PAE
	kernel
From: Arjan van de Ven <arjan@linux.intel.com>
To: Kyle McMartin <kyle@ubuntu.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061212023805.GE4044@athena.road.mcmartin.ca>
References: <20061212000359.GB4044@athena.road.mcmartin.ca>
	 <20061212023805.GE4044@athena.road.mcmartin.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Dec 2006 10:22:14 +0100
Message-Id: <1165915334.27217.565.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-11 at 21:38 -0500, Kyle McMartin wrote:
> On second thought, this is probably better since most people will
> presumably be booting non-PAE kernels, generating this message when
> they've not tried to force the issue seems silly.
> 
> This way, the user will only see a warning if they actually go
> out and specify "noexec=on" on the command line.


how about this instead? 


noexec=on as kernel option makes no sense, nx is enabled by default
since a really long time. What it does achieve is that it gives certain
people the impression that it makes the impossible possible: using NX in
situations where either the CPU or the kernel configuration make it not
possible.

This patch just removes the option and all the code for it, it's bloat.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

---
 Documentation/kernel-parameters.txt |    1 -
 arch/i386/mm/init.c                 |   10 ++--------
 arch/x86_64/kernel/setup64.c        |    5 +----
 3 files changed, 3 insertions(+), 13 deletions(-)

Index: linux-2.6/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.orig/Documentation/kernel-parameters.txt
+++ linux-2.6/Documentation/kernel-parameters.txt
@@ -1032,7 +1032,6 @@ and is between 256 and 4096 characters. 
 	noexec		[IA-64]
 
 	noexec		[IA-32,X86-64]
-			noexec=on: enable non-executable mappings (default)
 			noexec=off: disable nn-executable mappings
 
 	nofxsr		[BUGS=IA-32] Disables x86 floating point extended
Index: linux-2.6/arch/x86_64/kernel/setup64.c
===================================================================
--- linux-2.6.orig/arch/x86_64/kernel/setup64.c
+++ linux-2.6/arch/x86_64/kernel/setup64.c
@@ -50,10 +50,7 @@ static int __init nonx_setup(char *str)
 {
 	if (!str)
 		return -EINVAL;
-	if (!strncmp(str, "on", 2)) {
-                __supported_pte_mask |= _PAGE_NX; 
- 		do_not_nx = 0; 
-	} else if (!strncmp(str, "off", 3)) {
+	if (!strncmp(str, "off", 3)) {
 		do_not_nx = 1;
 		__supported_pte_mask &= ~_PAGE_NX;
         }
Index: linux-2.6/arch/i386/mm/init.c
===================================================================
--- linux-2.6.orig/arch/i386/mm/init.c
+++ linux-2.6/arch/i386/mm/init.c
@@ -428,21 +428,15 @@ static int disable_nx __initdata = 0;
 u64 __supported_pte_mask __read_mostly = ~_PAGE_NX;
 
 /*
- * noexec = on|off
+ * noexec = off
  *
  * Control non executable mappings.
  *
- * on      Enable
  * off     Disable
  */
 static int __init noexec_setup(char *str)
 {
-	if (!str || !strcmp(str, "on")) {
-		if (cpu_has_nx) {
-			__supported_pte_mask |= _PAGE_NX;
-			disable_nx = 0;
-		}
-	} else if (!strcmp(str,"off")) {
+	if (!strcmp(str,"off")) {
 		disable_nx = 1;
 		__supported_pte_mask &= ~_PAGE_NX;
 	} else

