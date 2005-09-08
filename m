Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932617AbVIHFmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbVIHFmv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 01:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbVIHFmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 01:42:51 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:36034 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932617AbVIHFms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 01:42:48 -0400
Date: Thu, 8 Sep 2005 14:42:47 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] SUBCPUSETS: subcpusets document
X-Mailer: Sylpheed version 2.1.0+svn (GTK+ 2.6.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20050908054247.AE8BF70037@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a document of the SUBCPUSETS.

Signed-off-by: KUROSAWA Takahiro <kurosawa@valinux.co.jp>


--- /dev/null
+++ to-work/Documentation/subcpuset.txt	2005-09-08 11:44:47.994331730 +0900
@@ -0,0 +1,129 @@
+Addition to the cpuset filesystem: "subcpuset"
+
+ "subcpuset" directories are incorporated in order to subdivide system
+ resources (ex. cpu, memory) into finer granularity.  We must declare
+ the toplevel directory of subcpuset before creating subcpuset
+ directories.  This declaration can be done by writing "1" to the
+ "subcpuset_top" file in that directory.
+
+ Subcpuset directories have different attributes (files) from normal 
+ cpuset directories.
+
+
+ File added to the normal cpuset directory:
+
+  - subcpuset_top (file, read/write, boolean value):
+
+    This file controls whether the parent directory should become the toplevel
+    directory of subcpuset or not.
+
+    If the content of this file is "1", then mkdir's in the directory create 
+    subcpuset directories.  If the content is "0" (default), then mkdir's 
+    create normal cpuset directories.
+
+    The contents of cpus, mems, cpu_exclusive, mem_exclusive, and 
+    notify_release in the directory can not be modified when the content 
+    of the subcpuset_top is "1".  The content of subcpuset_top can't be 
+    changed if the directory already has subdirectories.  Also, "1" can't
+    be written to subcpuset_top if cpus or mems is unset.
+
+ Files in the subcpuset directory:
+
+ - <resource>_guar (file, read/write, integer value):
+
+    Writing to this file sets the guarantee value of the <resource> 
+    for the subcpuset specified by the directory that this file resides in.
+    This file is optional and does not exist for some resource controllers.
+
+ - <resource>_lim (file, read/write, integer value):
+
+    Writing to this file sets the limit value of the <resource> 
+    for the subcpuset specified by the directory that this file resides in.
+    This file is optional and does not exist for some resource controllers.
+
+ - <resource>_cur (file, readonly, integer value):
+
+    Reading this file gets the current amount of the <resource>
+    assigned to the subcpuset specified by the directory that this file 
+    resides in.
+    This file is optional and does not exist for some resource controllers.
+
+ - notify_on_release:
+ - tasks:
+
+   These two files have the same functionality as the normal cpusets.
+
+
+Internal interface for the resource controller provided by subcpusets
+
+ - int subcpuset_register_controller(struct subcpuset_ctlr *ctlr);
+
+   The resource controller must register itself by calling this function.
+   This function must be called before the cpuset filesystem is mounted
+   for the first time since boot.
+
+   The argument ctlr should describe the controller information:
+
+     struct subcpuset_ctlr {
+             char *name;
+	     int idx;
+             void *(*create_toplevel)(struct cpuset *cs, cpumask_t cpus,
+                                      nodemask_t mems);
+             void (*destroy_toplevel)(void *top);
+             void *(*create)(void *top, struct cpuset *cs);
+             void (*destroy)(void *ctldata);
+             int (*set_lim)(void *ctldata, unsigned long val);
+             int (*set_guar)(void *ctldata, unsigned long val);
+             int (*get_cur)(void *ctldata, unsigned long *valp);
+     };
+
+     - name:
+       The name of controller, for example: "cpu", "mem_anon", "mem_cache."
+       This string is used for creating <name>_guar file and <name>_lim 
+       under the subcpuset directory.
+
+     - idx:
+       This member is used in the subcpuset core code.  Resource controllers
+       must not change this value.
+
+     - create_toplevel:
+       Pointer to the function that creates the toplevel resource data
+       of each subcpuset.  The function is called when the content of 
+       the subcpuset_top file is set to 1.
+
+     - destroy_toplevel:
+       Pointer to the function that frees the area created by the 
+       "create_toplevel" function.
+
+     - create:
+       Pointer to the function that is called when a subcpuset directory
+       is created.  The function should return the value that can be
+       used to identify the subcpuset and/or control its resource usage.
+       The caller can get this value by calling 
+       subcpuset_get_controller_data():
+
+        void *subcpuset_get_controller_data(struct cpuset *cs,
+                                            struct subcpuset_ctlr *ctlr);
+
+       The resource controller can get the toplevel resource data of the 
+       subcpuset by the following function, specifying the "cs" argument 
+       as the argument of the "create" function:
+
+        void *subcpuset_get_toplevel_data(struct cpuset *cs,
+                                          struct subcpuset_ctlr *ctlr);
+
+     - destroy:
+       Pointer to the function that frees the area created by the "create" 
+       function.
+
+     - set_lim:
+       Pointer to the function called when the resource limit is set
+       (i.e. write access to the <resource>_lim).
+
+     - set_guar:
+       Pointer to the function called when the resource guarantee is set
+       (i.e. write access to the <resource>_guar).
+
+     - get_cur:
+       Pointer to the function called when the current amount of the 
+       resource is queried (i.e. read access to the <resource>_cur).
