Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbVFIAFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbVFIAFC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 20:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVFIACJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 20:02:09 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:60384 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261408AbVFHX7U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 19:59:20 -0400
Date: Wed, 8 Jun 2005 19:03:59 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>
Subject: [patch 10/11] lsm stacking: hook completeness verification
Message-ID: <20050609000359.GJ27314@serge.austin.ibm.com>
References: <20050608235505.GA27298@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608235505.GA27298@serge.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a script to check whether all security_operations hooks are defined
in both dummy_security_ops (through security_fixup_ops) and in stacker_ops.
Also adds a note in security.h to remind developers that all hooks must
be defined in these two modules, and to verify this using the
lsm_verify_hooks.sh script.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 include/linux/security.h    |    4 ++++
 scripts/lsm_verify_hooks.sh |   44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

Index: linux-2.6.12-rc2/include/linux/security.h
===================================================================
--- linux-2.6.12-rc2.orig/include/linux/security.h	2005-05-23 15:01:00.000000000 -0500
+++ linux-2.6.12-rc2/include/linux/security.h	2005-05-23 15:01:43.000000000 -0500
@@ -121,6 +121,10 @@
 /**
  * struct security_operations - main security structure
  *
+ * When adding functions to this structure, please add them to
+ * dummy.c and stacker.c, and run linux/scripts/lsm_verify_hooks.sh
+ * to verify their inclusion in these modules.
+ *
  * Security hooks for program execution operations.
  *
  * @bprm_alloc_security:
Index: linux-2.6.12-rc2/scripts/lsm_verify_hooks.sh
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-rc2/scripts/lsm_verify_hooks.sh	2005-05-23 15:01:43.000000000 -0500
@@ -0,0 +1,44 @@
+#!/bin/sh
+
+# Author: Serge E. Hallyn <serue@us.ibm.com>
+
+# Checks that both the dummy and stacker modules define all the
+# security hooks.
+
+# This probably should be done in perl
+
+# Copyright (C) 2002,2003,2004,2005 Serge E. Hallyn <serue@us.ibm.com>
+# Copyright (C) 2002 David A. Wheeler <dwheeler@dwheeler.com>.
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+
+# Grab the relevant pieces of text
+sed -n '/^void security_fixup_ops /,/}/p' dummy.c > dummy.out
+sed -n '/^static struct security_operations/,/}/p' stacker.c > stack.out
+../scripts/Lindent -o tmpsec.h ../include/linux/security.h
+sed -n '/^struct security_operations {/,/}/p' tmpsec.h > sech.out
+rm tmpsec.h
+
+# Get a list of functions in security.h
+cat sech.out | sed -n '/\t[a-z]/p' | sed -e 's/^\t[a-z]* (\*\([^)]*\).*$/\1/' > sech.out
+
+# check dummy.c
+for line in `cat sech.out`; do
+	grep $line dummy.out > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		echo "WARNING: $line missing from dummy module!"
+	fi
+done
+
+# check stacker.c
+for line in `cat sech.out`; do
+	grep $line stack.out > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		echo "WARNING: $line missing from stacker module!"
+	fi
+done
+
+rm sech.out stack.out dummy.out
+echo "LSM hook verification done."
