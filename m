Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267828AbUIJTU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267828AbUIJTU2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 15:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267825AbUIJTU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 15:20:28 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:58335 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S267828AbUIJTQj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 15:16:39 -0400
Subject: Re: [PATCH] BSD Jail LSM (3/3)
From: Serge Hallyn <serue@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1094847705.2188.94.camel@serge.austin.ibm.com>
References: <1094847705.2188.94.camel@serge.austin.ibm.com>
Content-Type: multipart/mixed; boundary="=-mkj/S/LSTLivHqCUx/kv"
Message-Id: <1094847831.2188.106.camel@serge.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 10 Sep 2004 15:23:51 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mkj/S/LSTLivHqCUx/kv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached is a patch carrying the documentation for the bsdjail LSM.

Please apply.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

-serge

--=-mkj/S/LSTLivHqCUx/kv
Content-Disposition: attachment; filename=jail-doc.diff
Content-Type: text/x-patch; name=jail-doc.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Nru /home/hallyn/kernels/linux-2.6.8.1/Documentation/bsdjail.txt linux-2.6.8.1/Documentation/bsdjail.txt
--- /home/hallyn/kernels/linux-2.6.8.1/Documentation/bsdjail.txt	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.8.1/Documentation/bsdjail.txt	2004-09-10 14:12:59.163385088 -0500
@@ -0,0 +1,99 @@
+BSD Jail Linux Security Module
+Serge E. Hallyn <serue@us.ibm.com>
+
+Description:
+
+Implements a subset of the BSD Jail functionality as a Linux LSM.
+What is currently implemented:
+
+  If a proces is in a jail, it:
+
+    1. Is locked under a chroot (as are all children) which is not
+         vulnerable to the well-known chdir(..)(etc)chroot(.) escape.
+    2. Cannot mount or umount
+    3. Cannot send signals outside of jail
+    4. Cannot ptrace processes outside of jail
+    5. Cannot create devices
+    6. Cannot renice processes
+    7. Cannot load or unload modules
+    8. Cannot change network settings
+    9. May be assigned a specific ip address which will be used
+         for all it's socket binds.
+   10. Cannot see contents of /proc/<pid> entries of processes not in the
+         same jail.  (We hide their existence for convenience's sake, but
+         their existance can still be detected using, for instance, statfs)
+   11. Has no CAP_SYS_RAWIO capability (no ioperm/iopl)
+   12. May not share IPC resources with processes outside its own jail.
+   13. May find it's valid network address (if restricted) under
+       /proc/$$/attr/current.
+
+WARNINGS:
+The security of this module is very much dependent on the security
+of the rest of the system.  You must carefully think through your
+use of the system.
+
+Some examples:
+	1. If you leave /dev/hda1 in the jail, processes in the
+	jail can access that filesystem (i.e. /sbin/debugfs).
+	2. If you provide root access within a jail, this can of
+	course be used to setuid binaries in the jail.  Combined
+	with an unjailed regular user account, this gives jailed
+	users unjailed root access.  (thanks to Brad Spender for
+	pointing this out).  To protect against this, use jails
+	in private namespaces, with the jail filesystems mounted
+	ONLY within the jail namespaces.  For instance:
+
+$ # (Make sure /dev/hdc5 is not mounted anywhere)
+$ new_namespace_shell /bin/bash
+$ mount /dev/hdc5 /opt
+$ mount -t proc proc /opt/proc
+$ echo -n "root /opt" > /proc/$$/attr/exec
+$ echo -n "ip 9.53.94.111" > /proc/$$/attr/exec
+$ exec /bin/sh
+$ sshd
+$ apachectl start
+$ exit
+
+How to use:
+    1. modprobe bsdjail
+    [ 1.5 /sbin/ifconfig eth0:0 2.2.2.2;
+      1.6 /sbin/route add -host 2.2.2.2 dev eth0:0
+      (optional) ]
+    2. Make sure the root filesystem (ie /dev/hdc5) is not mounted
+       anywhere else.
+    3. exec_private_namespace /bin/sh
+    4. mount /dev/hdc5 /opt
+    5. mount -t proc proc /opt/proc
+    6. echo -n "root /opt" > /proc/$$/attr/exec
+       echo -n "ip 2.2.2.2" > /proc/$$/attr/exec (optional)
+    7. exec /bin/sh
+    8. sshd
+    9. exit
+
+The new shell will now run in a private jail on the filesystem on
+/dev/hdc5. If proc has been mounted under /dev/hdc5, then a "ps -auxw"
+under the jailed shell will show only entries for processes started under
+that jail.
+
+If a private IP was specified for the jail, then 
+		cat /proc/$$/attr/current
+will show the address for the private network device.  Other network
+devices will be visible through /sbin/ifconfig -a, but not usable.
+
+If the reading process is not in a jail, then
+		cat /proc/$$/attr/current
+returns information about the root and ip * for the target process,
+or "Not Jailed" if the target process is not jailed.
+
+Cat /proc/$$/attr/exec gives a list of the valid keywords to cat into
+/proc/$$/attr/exec when starting a jail.
+
+Current valid keywords for creating a jail are:
+
+     root: Root of jail's fs
+     ip: Ip addr for this jail
+     nrtask: Number of tasks in this jail
+     nice: The nice level for this jail.  (maybe should be min/max?)
+     slice: Max timeslice per process
+     data: Max size of DATA segment per process
+     memlock: Max size of memory which can be locked per process

--=-mkj/S/LSTLivHqCUx/kv--

