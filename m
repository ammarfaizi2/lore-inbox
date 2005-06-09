Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbVFIAXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbVFIAXI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 20:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVFIALe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 20:11:34 -0400
Received: from fire.osdl.org ([65.172.181.4]:33673 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262249AbVFIAJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 20:09:12 -0400
Date: Wed, 8 Jun 2005 17:08:11 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, ak@suse.de
Subject: [patch 05/09] x86_64: Fix ptrace boundary check
Message-ID: <20050609000811.GL13152@shell0.pdx.osdl.net>
References: <20050608234637.GG13152@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608234637.GG13152@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't allow accesses below register frame in ptrace

There was a "off by one quad word" error in there. 

Found and fixed by John Blackwood

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Chris Wright <chrisw@osdl.org>

 arch/x86_64/kernel/ptrace.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: release-2.6.11/arch/x86_64/kernel/ptrace.c
===================================================================
--- release-2.6.11.orig/arch/x86_64/kernel/ptrace.c
+++ release-2.6.11/arch/x86_64/kernel/ptrace.c
@@ -252,7 +252,7 @@ asmlinkage long sys_ptrace(long request,
 			break;
 
 		switch (addr) { 
-		case 0 ... sizeof(struct user_regs_struct):
+		case 0 ... sizeof(struct user_regs_struct) - sizeof(long):
 			tmp = getreg(child, addr);
 			break;
 		case offsetof(struct user, u_debugreg[0]):
@@ -297,7 +297,7 @@ asmlinkage long sys_ptrace(long request,
 			break;
 
 		switch (addr) { 
-		case 0 ... sizeof(struct user_regs_struct): 
+		case 0 ... sizeof(struct user_regs_struct) - sizeof(long):
 			ret = putreg(child, addr, data);
 			break;
 		/* Disallows to set a breakpoint into the vsyscall */
