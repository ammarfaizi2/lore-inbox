Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129477AbQK1RVW>; Tue, 28 Nov 2000 12:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129520AbQK1RVM>; Tue, 28 Nov 2000 12:21:12 -0500
Received: from cs.wustl.edu ([128.252.165.15]:49631 "EHLO
        taumsauk.cs.wustl.edu") by vger.kernel.org with ESMTP
        id <S129477AbQK1RU6>; Tue, 28 Nov 2000 12:20:58 -0500
From: Berkley Shands <berkley@cs.wustl.edu>
Date: Tue, 28 Nov 2000 10:50:53 -0600 (CST)
Message-Id: <200011281650.KAA0000004329@mudpuddle.cs.wustl.edu>
To: linux-kernel@vger.kernel.org
Subject: /proc/net/atm/<device> handling wrong 2.4.0-test9+
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been reported in the linux-atm mailing list as well..
/usr/src/linux/net/atm/proc.c has a problem.
in 2.4.0-test9 and later, the routine atm_proc_dev_register(); is called
before atm_proc_init();
the latter is called at the very end of startup, long after the pci
devices are
initialized. This results in the /proc devices being in /proc/eni:1 or
/proc/wuapic:1
not in /proc/net/atm/eni:1 or /proc/net/atm/wuapic:1

here is a quicky patch to correct this.

diff -Naur linux-2.4.0-test11-clean/net/atm/proc.c linux/net/atm/proc.c
--- linux-2.4.0-test11-clean/net/atm/proc.c     Sat Jul  8 21:26:13 2000
+++ linux/net/atm/proc.c        Tue Nov 28 10:24:17 2000
@@ -547,6 +547,11 @@
        int digits,num;
        int error;

+/* atm_proc_init isn't called until the end of the startup */
+/* so make the call now instead */
+
+       if (! atm_proc_root)
+          atm_proc_init();             /* force /proc/net/atm to exist */
        error = -ENOMEM;
        digits = 0;
        for (num = dev->number; num; num /= 10) digits++;
@@ -589,9 +594,12 @@
        struct proc_dir_entry *devices = NULL,*pvc = NULL,*svc = NULL;
        struct proc_dir_entry *arp = NULL,*lec = NULL,*vc = NULL;

+       if (atm_proc_root)
+          return 0;            /* already made */
        atm_proc_root = proc_mkdir("net/atm",NULL);
        if (!atm_proc_root)
                return -ENOMEM;
+
        CREATE_ENTRY(devices);
        CREATE_ENTRY(pvc);
        CREATE_ENTRY(svc);

berkley
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
