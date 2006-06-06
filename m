Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWFFOZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWFFOZM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 10:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWFFOZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 10:25:11 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:15849 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S932189AbWFFOZK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 10:25:10 -0400
Date: Tue, 6 Jun 2006 15:25:02 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: [PATCH] Fix mempolicy.h build error
Message-ID: <20060606142502.GA1881@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<linux/mempolicy.h> uses struct mm_struct and relies on a definition or
declaration somehow magically being dragged in which may result in a
build:

[...]
  CC      mm/mempolicy.o
In file included from mm/mempolicy.c:69:
include/linux/mempolicy.h:150: warning: ‘struct mm_struct’ declared inside parameter list
include/linux/mempolicy.h:150: warning: its scope is only this definition or declaration, which is probably not what you want
include/linux/mempolicy.h:175: warning: ‘struct mm_struct’ declared inside parameter list
mm/mempolicy.c:622: error: conflicting types for ‘do_migrate_pages’
include/linux/mempolicy.h:175: error: previous declaration of ‘do_migrate_pages’ was here
mm/mempolicy.c:1661: error: conflicting types for ‘mpol_rebind_mm’
include/linux/mempolicy.h:150: error: previous declaration of ‘mpol_rebind_mm’ was here
make[1]: *** [mm/mempolicy.o] Error 1
make: *** [mm] Error 2
[ralf@denk linux-ip35]$

Including <linux/sched.h> is a step into direction of include hell so
fixed by adding a forward declaration of struct mm_struct instead.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 6a7621b..f5fdca1 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -36,6 +36,7 @@ #include <linux/spinlock.h>
 #include <linux/nodemask.h>
 
 struct vm_area_struct;
+struct mm_struct;
 
 #ifdef CONFIG_NUMA
 
