Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWJEVnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWJEVnW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWJEVmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:42:51 -0400
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:60594 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932255AbWJEVmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:42:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=PQe2Au2zFucVfrarCHmbssToGj8KYFqzMM7L45mDSeZWzrsvVUXua2hLOGFmq8VATK+rEYePjh0pG+YxogtarHH7stdEjvCIGnRRtF6xiP/crTDQ7mx0IWfDkJdqwTnysJzk3eSeIEsuVu+BU0JcqG5W0zX3fJy0qLQyo4wXVd4=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 14/14] uml: allow finer tuning for host VMSPLIT setting
Date: Thu, 05 Oct 2006 23:39:20 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061005213920.17268.4856.stgit@memento.home.lan>
In-Reply-To: <20061005213212.17268.7409.stgit@memento.home.lan>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Now that various memory splits are enabled, add a config option allowing the
user to compile UML for its need - HOST_2G_2G allowed to choose either 3G/1G or
2G/2G, and enabling it reduced the usable virtual memory.

Detecting this at run time should be implemented in the future, but we must make
the stop-gap measure work well enough (this is valid in _many_ cases).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Kconfig.i386 |   49 ++++++++++++++++++++++++++++++++++---------------
 1 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/arch/um/Kconfig.i386 b/arch/um/Kconfig.i386
index f6eb72d..f191a55 100644
--- a/arch/um/Kconfig.i386
+++ b/arch/um/Kconfig.i386
@@ -16,23 +16,42 @@ config SEMAPHORE_SLEEPERS
 	bool
 	default y
 
-config HOST_2G_2G
-	bool "2G/2G host address space split"
-	default n
-	help
-	This is needed when the host on which you run has a 2G/2G memory
-	split, instead of the customary 3G/1G.
-
-	Note that to enable such a host
-	configuration, which makes sense only in some cases, you need special
-	host patches.
-
-	So, if you do not know what to do here, say 'N'.
+choice
+	prompt "Host memory split"
+	default HOST_VMSPLIT_3G
+	---help---
+	   This is needed when the host kernel on which you run has a non-default
+	   (like 2G/2G) memory split, instead of the customary 3G/1G. If you did
+	   not recompile your own kernel but use the default distro's one, you can
+	   safely accept the "Default split" option.
+
+	   It can be enabled on recent (>=2.6.16-rc2) vanilla kernels via
+	   CONFIG_VM_SPLIT_*, or on previous kernels with special patches (-ck
+	   patchset by Con Kolivas, or other ones) - option names match closely the
+	   host CONFIG_VM_SPLIT_* ones.
+
+	   A lower setting (where 1G/3G is lowest and 3G/1G is higher) will
+	   tolerate even more "normal" host kernels, but an higher setting will be
+	   stricter.
+
+	   So, if you do not know what to do here, say 'Default split'.
+
+	config HOST_VMSPLIT_3G
+		bool "Default split (3G/1G user/kernel host split)"
+	config HOST_VMSPLIT_3G_OPT
+		bool "3G/1G user/kernel host split (for full 1G low memory)"
+	config HOST_VMSPLIT_2G
+		bool "2G/2G user/kernel host split"
+	config HOST_VMSPLIT_1G
+		bool "1G/3G user/kernel host split"
+endchoice
 
 config TOP_ADDR
- 	hex
- 	default 0xc0000000 if !HOST_2G_2G
- 	default 0x80000000 if HOST_2G_2G
+	hex
+	default 0xB0000000 if HOST_VMSPLIT_3G_OPT
+	default 0x78000000 if HOST_VMSPLIT_2G
+	default 0x40000000 if HOST_VMSPLIT_1G
+	default 0xC0000000
 
 config 3_LEVEL_PGTABLES
 	bool "Three-level pagetables (EXPERIMENTAL)"
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
