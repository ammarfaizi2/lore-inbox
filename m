Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbTLPVLl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 16:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbTLPVLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 16:11:41 -0500
Received: from cv48.neoplus.adsl.tpnet.pl ([80.54.218.48]:29197 "EHLO
	satan.blackhosts") by vger.kernel.org with ESMTP id S262603AbTLPVL0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 16:11:26 -0500
Date: Tue, 16 Dec 2003 22:16:12 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Cc: dev@grsecurity.net
Subject: [2.4.x, 2.6 problem] registering of empty /proc/sys dirs leads to leaving pointers to freed memory
Message-ID: <20031216211611.GA16183@satan.blackhosts>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: Black Hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

(sent to linux-kernel and grsecurity dev)

Hello,

Yesterday I got an Oops on somewhat patched 2.4.20 when trying to run
"sensors" program without lm_sensors modules actually loaded. It
appeared that Oops occurs when numeric sysctl is performed with
{CTL_DEV, DEV_SENSORS, SENSORS_CHIPS} while there was even no
/proc/sys/dev directory (it was created on boot, then used by some
module and disappeared after module removal).

Although Oops is triggered in grsecurity code (in kernel/sysctl.c
ctl_perm() dereferences table->de->parent), it's caused by ugly
behaviour in raw, unpatched kernel.

Scenario
1. sysctl_init() in kernel/sysctl.c registers some sysctl tables
together with /proc/sys entries (including empty /proc/sys/dev and
/proc/sys/proc dirs).
2. some module, say "rtc", is loaded and creates some entry in
/proc/sys/dev
3. this module is unloaded, it unregisters its sysctl and /proc/sys
entries... and unregister_proc_table() removes empty, not used
/proc/sys/dev directory. Directory disappears from filesystem, but
empty CTL_DEV table still exists... and root_table[CTL_DEV].de contains
a pointer to memory, which has been freed (well, at least seems to be;
it's apparently used for other things - I checked it by reading from
/dev/kmem).
Although there is no access /proc/sys/dev, sysctl table for it is
still accessible by numeric sysctls.

This behaviour seems the same in 2.4.x and 2.6.0-test up to test11
(checked by reading structures from /dev/kmem).

Consequences:
- it's harmless in vanilla 2.4.x (I haven't found any read accesses to
  table->de other than in unregister_proc_table())
- in 2.4.x with grsecurity (confirmed on 2.4.23+grsec 2.0-rc3) it causes
  Oops in ctl_perm() on dereferencing table->de->parent or table->de->name
- in vanilla 2.6.0test similar issue may exist in selinux's sysctl hook
  (I found that it dereferences table->de too)

Possible fixes:
- avoid creating empty directories in /proc/sys, as they could be easily
  removed after some module removal (simplest one I think; attached
  patch (it's for 2.4.x, but porting to 2.6.0 seems simple) does this -
  it works for me and I can't see any side effects as for now; but I'm
  not sure if some other modules don't create empty directories - it must
  be checked)

- or maybe don't remove directory if it was created as empty one?

- or maybe when removing directory entry, clear all table->de pointers
  pointing to it?


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Linux       http://www.pld-linux.org/

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4-sysctl-empty.patch"

Don't register empty sysctl dirs in /proc/sys.
They would be removed after registering some other sysctl(s) in the
same directory (e.g. rtc in /proc/sys/dev) and unregistering all of
them (then initially empty e.g. /proc/sys/dev disappears).
After disappearing of directory topdir ->de (for "dev") points to
structure which has been freed.
It's harmless in vanilla 2.4, but with grsecurity causes an Oops
on numeric sysctls referring to removed directory (even with all
grsecurity features disabled, only patch applied).

The same issue seems to exist in 2.6, and _probably_ can cause similar
problems in selinux.

	-- Jakub Bogusz <qboosh@pld-linux.org>

--- linux-2.4.20/kernel/sysctl.c.orig	Mon Dec 15 11:05:08 2003
+++ linux-2.4.20/kernel/sysctl.c	Mon Dec 15 15:48:46 2003
@@ -124,10 +124,8 @@
 #ifdef CONFIG_NET
 extern ctl_table net_table[];
 #endif
-static ctl_table proc_table[];
 static ctl_table fs_table[];
 static ctl_table debug_table[];
-static ctl_table dev_table[];
 extern ctl_table random_table[];
 
 static ctl_table grsecurity_table[];
@@ -163,10 +161,8 @@
 #ifdef CONFIG_NET
 	{CTL_NET, "net", NULL, 0, 0555, net_table},
 #endif
-	{CTL_PROC, "proc", NULL, 0, 0555, proc_table},
 	{CTL_FS, "fs", NULL, 0, 0555, fs_table},
 	{CTL_DEBUG, "debug", NULL, 0, 0555, debug_table},
-        {CTL_DEV, "dev", NULL, 0, 0555, dev_table},
 	{0}
 };
 
@@ -488,10 +484,6 @@
 	{0}
 };
 
-static ctl_table proc_table[] = {
-	{0}
-};
-
 static ctl_table fs_table[] = {
 	{FS_NRINODE, "inode-nr", &inodes_stat, 2*sizeof(int),
 	 0444, NULL, &proc_dointvec},
@@ -526,10 +518,6 @@
 	{0}
 };
 
-static ctl_table dev_table[] = {
-	{0}
-};  
-
 extern void init_irq_proc (void);
 
 void __init sysctl_init(void)

--ReaqsoxgOBHFXBhH--
