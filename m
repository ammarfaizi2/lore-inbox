Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbUKDWZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbUKDWZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbUKDWYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:24:53 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:1476 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262467AbUKDWGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 17:06:19 -0500
Subject: Re: [RFC] [PATCH] [3/3] LSM Stacking: stackable bsdjail
	(Documentation)
From: Serge Hallyn <serue@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1099609471.2096.10.camel@serge.austin.ibm.com>
References: <1099609471.2096.10.camel@serge.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1099610189.2096.34.camel@serge.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Nov 2004 17:16:29 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation for the bsdjail LSM.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

diff -Nrup linux-2.6.9/Documentation/bsdjail.txt
linux-2.6.9-jail/Documentation/bsdjail.txt
--- linux-2.6.9/Documentation/bsdjail.txt	1969-12-31 18:00:00.000000000
-0600
+++ linux-2.6.9-jail/Documentation/bsdjail.txt	2004-10-20
14:41:28.266075800 -0500
@@ -0,0 +1,135 @@
+BSD Jail Linux Security Module
+Serge E. Hallyn <serue@us.ibm.com>
+
+Description:
+
+Used in conjunction with per-process namespaces, this implements
+a subset of the BSD Jail functionality as a Linux LSM. What is
+currently implemented:
+
+  If a proces is in a jail, it:
+
+    2. Cannot mount or umount
+    3. Cannot send signals outside of jail
+    4. Cannot ptrace processes outside of jail
+    5. Cannot create devices
+    6. Cannot renice processes
+    7. Cannot load or unload modules
+    8. Cannot change network settings
+    9. May be assigned a specific ip address which will be used
+         for all it's socket binds.
+   10. Cannot see contents of /proc/<pid> entries of processes not in
the
+         same jail.  (We hide their existence for convenience's sake,
but
+         their existance can still be detected using, for instance,
statfs)
+   11. Has no CAP_SYS_RAWIO capability (no ioperm/iopl)
+   12. May not share IPC resources with processes outside its own jail.
+   13. May find it's valid network address (if restricted) under
+       /proc/$$/attr/current.
+
+  If properly locked into its own namespace, processes will not be able
+  to escape to parts of the system's filesystem which were made
+  unavailable (without outside help).
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
+	pointing this out).
+
+How to use:
+    1. Load the bsdjail module if not already loaded or compiled in:
+    
+         modprobe bsdjail
+
+    3. (Optional) Set up an ipv4 alias for the jail
+
+         # /sbin/ifconfig eth0:0 192.168.1.101
+         # /sbin/route add -host 192.168.1.101 dev eth0:0
+
+    3. Execute a shell under a new namespace:
+
+         exec clone_ns
+
+       (see http://www.win.tue.nl/~aeb/linux/lk/lk-6.html#6.3)
+
+    4. If not already done, set up the filesystem for the jail.  in our
+       example, we will set it up under /opt.
+    
+          mount /dev/hdc5 /opt
+          mount -t proc proc /opt/proc
+
+    5. Make sure there is an empty directory to put the old root in. 
We
+       will just use /opt/mnt
+
+          mkdir /opt/mnt
+
+    6. Pivot the old and new roots:
+
+          cd /opt
+          /sbin/pivot_root . mnt
+          /usr/sbin/chroot . /bin/sh
+
+    7. Unmount the old root
+
+          umount -l /mnt
+
+    6. Give the desired arguments for the jail.  If no arguments are
+       necessary, just say:
+
+          echo lock > /proc/$$/attr/exec
+
+       To lock the process into an ip alias, say:
+
+          echo "ip 192.168.1.101" > /proc/$$/attr/exec
+
+    7. Execute a new shell.  The shell will be under the new jail, and
in
+       the private namespace you've been setting up.
+    
+          exec /bin/sh
+
+    8. To allow friends/customers/whoever to use this system, you might
start
+       start some services.
+
+          sshd
+
+    9. Ssh is now running under the jail, so you no longer need the
original
+    shell:
+
+          exit
+
+The new shell runs in a private jail on the filesystem on /dev/hdc5. If
proc
+has been mounted under /dev/hdc5, then a "ps -auxw" under the jailed
shell
+will show only entries for processes started under that jail.
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
+     lock: specifies the next exec should land us in a jail.  (only
needed
+                if you don't want to give any other keywords)
+     ip: IPV4 addr for this jail
+     ip6: IPV6 addr for this jail
+     nrtask: Number of tasks in this jail
+     nice: The nice level for this jail.  (maybe should be min/max?)
+     slice: Max timeslice per process
+     data: Max size of DATA segment per process
+     memlock: Max size of memory which can be locked per process


