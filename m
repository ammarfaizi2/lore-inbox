Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWDSR43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWDSR43 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWDSRz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:55:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:65181 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751069AbWDSRyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:54:35 -0400
From: Tony Jones <tonyj@suse.de>
To: linux-kernel@vger.kernel.org
Cc: chrisw@sous-sol.org, Tony Jones <tonyj@suse.de>,
       linux-security-module@vger.kernel.org
Date: Wed, 19 Apr 2006 10:50:10 -0700
Message-Id: <20060419175010.29149.30803.sendpatchset@ermintrude.int.wirex.com>
In-Reply-To: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
Subject: [RFC][PATCH 8/11] security: AppArmor - Pathname matching submodule
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The file match.h specifies a sub module interface consisting of the following
functions:

	aamatch_alloc
	aamatch_free
		Allocates/deallocates submodule specific data used by each
		loaded profile (policy).

	aamatch_features
		Returns the list of features implemented by the submodule.
		These are literal, tailglob ("/path/**" match all paths
		below /path) and pattern (full shell based pathname expansion).

	aamatch_serialize
		Called by the module interface to serialize submodule specific
		data from userspace.

	aamatch_match
		Called to perform matching on a generated pathname.


The submodule submitted here implements only "literal" and "tailglob".
The version included with SuSE Linux implements "pattern" but via a method
that is not acceptable for mainline inclusion. We plan on developing
a new submodule as soon as possible that will implement the missing
functionality of the SuSE release using the textsearch framework and
a new bounded textsearch algorithm acceptable for subsequent inclusion
into the mainline kernel.


Signed-off-by: Tony Jones <tonyj@suse.de>

---
 security/apparmor/match/Makefile        |    5 +
 security/apparmor/match/match.h         |  132 ++++++++++++++++++++++++++++++++
 security/apparmor/match/match_default.c |   57 +++++++++++++
 3 files changed, 194 insertions(+)

--- /dev/null
+++ linux-2.6.17-rc1/security/apparmor/match/Makefile
@@ -0,0 +1,5 @@
+# Makefile for AppArmor aamatch submodule
+#
+obj-$(CONFIG_SECURITY_APPARMOR) += aamatch_default.o
+
+aamatch_default-y := match_default.o
--- /dev/null
+++ linux-2.6.17-rc1/security/apparmor/match/match.h
@@ -0,0 +1,132 @@
+/*
+ *	Copyright (C) 2002-2005 Novell/SUSE
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation, version 2 of the
+ *	License.
+ *
+ *	AppArmor submodule (match) prototypes
+ */
+
+#ifndef __MATCH_H
+#define __MATCH_H
+
+#include "../module_interface.h"
+#include "../apparmor.h"
+
+/* The following functions implement an interface used by the primary
+ * AppArmor module to perform name matching (n.b. "AppArmor" was previously
+ * called "SubDomain").
+
+ * aamatch_alloc
+ * aamatch_free
+ * aamatch_features
+ * aamatch_serialize
+ * aamatch_match
+ *
+ * The intent is for the primary module to export (via virtual fs entries)
+ * the features provided by the submodule (aamatch_features) so that the
+ * parser may only load policy that can be supported.
+ *
+ * The primary module will call aamatch_serialize to allow the submodule
+ * to consume submodule specific data from parser data stream and will call
+ * aamatch_match to determine if a pathname matches an aa_entry.
+ */
+
+typedef int (*aamatch_serializecb)
+	(struct aa_ext *, enum aa_code, void *, const char *);
+
+/**
+ * aamatch_alloc: allocate extradata (if necessary)
+ * @type: type of entry being allocated
+ * Return value: NULL indicates no data was allocated (ERR_PTR(x) on error)
+ */
+extern void* aamatch_alloc(enum entry_match_type type);
+
+/**
+ * aamatch_free: release data allocated by aamatch_alloc
+ * @entry_extradata: data previously allocated by aamatch_alloc
+ */
+extern void aamatch_free(void *entry_extradata);
+
+/**
+ * aamatch_features: return match types supported
+ * Return value: space seperated string (of types supported - use type=value
+ * to indicate variants of a type)
+ */
+extern const char* aamatch_features(void);
+
+/**
+ * aamatch_serialize: serialize extradata
+ * @entry_extradata: data previously allocated by aamatch_alloc
+ * @e: input stream
+ * @cb: callback fn (consume incoming data stream)
+ * Return value: 0 success, -ve error
+ */
+extern int aamatch_serialize(void *entry_extradata, struct aa_ext *e,
+			     aamatch_serializecb cb);
+
+/**
+ * aamatch_match: determine if pathname matches entry
+ * @pathname: pathname to verify
+ * @entry_name: entry name
+ * @type: type of entry
+ * @entry_extradata: data previously allocated by aamatch_alloc
+ * Return value: 1 match, 0 othersise
+ */
+extern unsigned int aamatch_match(const char *pathname, const char *entry_name,
+				  enum entry_match_type type,
+				  void *entry_extradata);
+
+
+/**
+ * sd_getmatch_type - return string representation of entry_match_type
+ * @type: entry match type
+ */
+static inline const char *sd_getmatch_type(enum entry_match_type type)
+{
+	const char *names[] = {
+		"aa_entry_literal",
+		"aa_entry_tailglob",
+		"aa_entry_pattern",
+		"aa_entry_invalid"
+	};
+
+	if (type >= aa_entry_invalid) {
+		type = aa_entry_invalid;
+	}
+
+	return names[type];
+}
+
+/**
+ * aamatch_match_common - helper function to check if a pathname matches
+ * a literal/tailglob
+ * @path: path requested to search for
+ * @entry_name: name from aa_entry
+ * @type: type of entry
+ */
+static inline int aamatch_match_common(const char *path,
+					   const char *entry_name,
+			   		   enum entry_match_type type)
+{
+	int retval;
+
+	/* literal, no pattern matching characters */
+	if (type == aa_entry_literal) {
+		retval = (strcmp(entry_name, path) == 0);
+	/* trailing ** glob pattern */
+	} else if (type == aa_entry_tailglob) {
+		retval = (strncmp(entry_name, path,
+				  strlen(entry_name) - 2) == 0);
+	} else {
+		AA_WARN("%s: Invalid entry_match_type %d\n",
+			__FUNCTION__, type);
+		retval = 0;
+	}
+
+	return retval;
+}
+
+#endif /* __MATCH_H */
--- /dev/null
+++ linux-2.6.17-rc1/security/apparmor/match/match_default.c
@@ -0,0 +1,57 @@
+/*
+ *	Copyright (C) 2002-2005 Novell/SUSE
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation, version 2 of the
+ *	License.
+ *
+ *	http://forge.novell.com/modules/xfmod/project/?apparmor
+ *
+ *	AppArmor default match submodule (literal and tailglob)
+ */
+
+#include <linux/module.h>
+#include "match.h"
+
+static const char *features="literal tailglob";
+
+void* aamatch_alloc(enum entry_match_type type)
+{
+	return NULL;
+}
+
+void aamatch_free(void *ptr)
+{
+}
+
+const char *aamatch_features(void)
+{
+	return features;
+}
+
+int aamatch_serialize(void *entry_extradata, struct aa_ext *e,
+		      aamatch_serializecb cb)
+{
+	return 0;
+}
+
+unsigned int aamatch_match(const char *pathname, const char *entry_name,
+			   enum entry_match_type type, void *entry_extradata)
+{
+	int ret;
+
+	ret = aamatch_match_common(pathname, entry_name, type);
+
+	return ret;
+}
+
+EXPORT_SYMBOL_GPL(aamatch_alloc);
+EXPORT_SYMBOL_GPL(aamatch_free);
+EXPORT_SYMBOL_GPL(aamatch_features);
+EXPORT_SYMBOL_GPL(aamatch_serialize);
+EXPORT_SYMBOL_GPL(aamatch_match);
+
+MODULE_DESCRIPTION("AppArmor match module (aamatch) [default]");
+MODULE_AUTHOR("Tony Jones <tonyj@suse.de>");
+MODULE_LICENSE("GPL");
