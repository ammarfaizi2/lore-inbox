Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161432AbWJKVSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161432AbWJKVSY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161434AbWJKVIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:08:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:32674 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161432AbWJKVIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:08:14 -0400
Date: Wed, 11 Oct 2006 14:07:41 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Mark Huang <mlhuang@cs.princeton.edu>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 47/67] load_module: no BUG if module_subsys uninitialized
Message-ID: <20061011210741.GV16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="load_module-no-bug-if-module_subsys-uninitialized.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: "Ed Swierk" <eswierk@arastra.com>

Invoking load_module() before param_sysfs_init() is called crashes in
mod_sysfs_setup(), since the kset in module_subsys is not initialized yet.

In my case, net-pf-1 is getting modprobed as a result of hotplug trying to
create a UNIX socket.  Calls to hotplug begin after the topology_init
initcall.

Another patch for the same symptom (module_subsys-initialize-earlier.patch)
moves param_sysfs_init() to the subsys initcalls, but this is still not
early enough in the boot process in some cases.  In particular,
topology_init() causes /sbin/hotplug to run, which requests net-pf-1 (the
UNIX socket protocol) which can be compiled as a module.  Moving
param_sysfs_init() to the postcore initcalls fixes this particular race,
but there might well be other cases where a usermodehelper causes a module
to load earlier still.

The patch makes load_module() return an error rather than crashing the
kernel if invoked before module_subsys is initialized.

Cc: Mark Huang <mlhuang@cs.princeton.edu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 kernel/module.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-2.6.18.orig/kernel/module.c
+++ linux-2.6.18/kernel/module.c
@@ -1054,6 +1054,12 @@ static int mod_sysfs_setup(struct module
 {
 	int err;
 
+	if (!module_subsys.kset.subsys) {
+		printk(KERN_ERR "%s: module_subsys not initialized\n",
+		       mod->name);
+		err = -EINVAL;
+		goto out;
+	}
 	memset(&mod->mkobj.kobj, 0, sizeof(mod->mkobj.kobj));
 	err = kobject_set_name(&mod->mkobj.kobj, "%s", mod->name);
 	if (err)

--
