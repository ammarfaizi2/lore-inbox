Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWELPtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWELPtg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 11:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWELPtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 11:49:36 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:12432 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751279AbWELPtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 11:49:35 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] oprofile: Fix unnecessary cleverness
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 12 May 2006 17:49:29 +0200
Message-ID: <877j4ri6pi.fsf@pike.pond.sub.org>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nmi_create_files() in arch/i386/oprofile/nmi_int.c depends on
model->num_counters (number of performance counters) being less than
10.  While this is currently the case, it's too clever by half.

Other archs aren't quite as clever: they assume 100.  I suggest to
normalize them all to 1000.

diff -r ddba92a5cba9 arch/i386/oprofile/nmi_int.c
--- a/arch/i386/oprofile/nmi_int.c	Tue May 09 12:41:38 2006 +0200
+++ b/arch/i386/oprofile/nmi_int.c	Fri May 12 17:45:25 2006 +0200
@@ -281,9 +281,9 @@ static int nmi_create_files(struct super
 
 	for (i = 0; i < model->num_counters; ++i) {
 		struct dentry * dir;
-		char buf[2];
- 
-		snprintf(buf, 2, "%d", i);
+		char buf[4];
+ 
+		snprintf(buf, sizeof(buf), "%d", i);
 		dir = oprofilefs_mkdir(sb, root, buf);
 		oprofilefs_create_ulong(sb, dir, "enabled", &counter_config[i].enabled); 
 		oprofilefs_create_ulong(sb, dir, "event", &counter_config[i].event); 
diff -r ddba92a5cba9 arch/alpha/oprofile/common.c
--- a/arch/alpha/oprofile/common.c	Tue May 09 12:41:38 2006 +0200
+++ b/arch/alpha/oprofile/common.c	Fri May 12 17:45:25 2006 +0200
@@ -112,7 +112,7 @@ op_axp_create_files(struct super_block *
 
 	for (i = 0; i < model->num_counters; ++i) {
 		struct dentry *dir;
-		char buf[3];
+		char buf[4];
 
 		snprintf(buf, sizeof buf, "%d", i);
 		dir = oprofilefs_mkdir(sb, root, buf);
diff -r ddba92a5cba9 arch/mips/oprofile/common.c
--- a/arch/mips/oprofile/common.c	Tue May 09 12:41:38 2006 +0200
+++ b/arch/mips/oprofile/common.c	Fri May 12 17:45:25 2006 +0200
@@ -38,7 +38,7 @@ static int op_mips_create_files(struct s
 
 	for (i = 0; i < model->num_counters; ++i) {
 		struct dentry *dir;
-		char buf[3];
+		char buf[4];
 
 		snprintf(buf, sizeof buf, "%d", i);
 		dir = oprofilefs_mkdir(sb, root, buf);
diff -r ddba92a5cba9 arch/powerpc/oprofile/common.c
--- a/arch/powerpc/oprofile/common.c	Tue May 09 12:41:38 2006 +0200
+++ b/arch/powerpc/oprofile/common.c	Fri May 12 17:45:25 2006 +0200
@@ -93,7 +93,7 @@ static int op_powerpc_create_files(struc
 
 	for (i = 0; i < model->num_counters; ++i) {
 		struct dentry *dir;
-		char buf[3];
+		char buf[4];
 
 		snprintf(buf, sizeof buf, "%d", i);
 		dir = oprofilefs_mkdir(sb, root, buf);
diff -r ddba92a5cba9 arch/sh/oprofile/op_model_sh7750.c
--- a/arch/sh/oprofile/op_model_sh7750.c	Tue May 09 12:41:38 2006 +0200
+++ b/arch/sh/oprofile/op_model_sh7750.c	Fri May 12 17:45:25 2006 +0200
@@ -198,7 +198,7 @@ static int sh7750_perf_counter_create_fi
 
 	for (i = 0; i < NR_CNTRS; i++) {
 		struct dentry *dir;
-		char buf[3];
+		char buf[4];
 
 		snprintf(buf, sizeof(buf), "%d", i);
 		dir = oprofilefs_mkdir(sb, root, buf);
