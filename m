Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTEVRDv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 13:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbTEVRDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 13:03:51 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:57605 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262861AbTEVRDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 13:03:46 -0400
Subject: [PATCH] 1/2 Add exposure of the irq delivery mask on x86
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: arjanv@redhat.com, wli@holomorphy.com
Content-Type: multipart/mixed; boundary="=-2YbZKuucwg8/BGJOaOBl"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 22 May 2003 13:16:48 -0400
Message-Id: <1053623808.1798.221.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2YbZKuucwg8/BGJOaOBl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


This exposes a delivery mask in /proc/<irq>/mask for the userspace irq
balancer to use in its calculations.

The only current consumer of this on x86 would be voyager I think (patch
for voyager follows).

James


--=-2YbZKuucwg8/BGJOaOBl
Content-Disposition: attachment; filename=tmp.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=tmp.diff; charset=ISO-8859-1

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.1209  -> 1.1210=20
#	arch/i386/kernel/irq.c	1.36    -> 1.37  =20
#	include/asm-i386/irq.h	1.9     -> 1.10  =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/22	jejb@oldfenric.sc.steeleye.com	1.1210
# Add irq masks into /proc/<irq> for x86
#=20
# This exposes the mask both as an external variable and through the /proc
# interface.  Machine specific code is still required to reflect the true
# value.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	Thu May 22 13:13:57 2003
+++ b/arch/i386/kernel/irq.c	Thu May 22 13:13:57 2003
@@ -868,8 +868,20 @@
 #ifdef CONFIG_SMP
=20
 static struct proc_dir_entry * smp_affinity_entry [NR_IRQS];
+static struct proc_dir_entry * smp_mask_entry [NR_IRQS];
=20
 unsigned long irq_affinity [NR_IRQS] =3D { [0 ... NR_IRQS-1] =3D ~0UL };
+unsigned long irq_mask [NR_IRQS] =3D { [0 ... NR_IRQS-1] =3D ~0UL };
+
+static int irq_mask_read_proc(char *page, char **start, off_t off,
+			int count, int *eof, void *data)
+{
+	if (count < HEX_DIGITS+1)
+		return -EINVAL;
+	return sprintf (page, "%08lx\n", irq_mask [(long)data]);
+}
+
+
 static int irq_affinity_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
@@ -959,6 +971,18 @@
 		}
=20
 		smp_affinity_entry[irq] =3D entry;
+
+		entry =3D create_proc_entry("mask", 0400, irq_dir[irq]);
+
+		if (entry) {
+			entry->nlink =3D 1;
+			entry->data =3D (void *)(long)irq;
+			entry->read_proc =3D irq_mask_read_proc;
+			entry->write_proc =3D NULL;
+		}
+
+		smp_mask_entry[irq] =3D entry;
+
 	}
 #endif
 }
diff -Nru a/include/asm-i386/irq.h b/include/asm-i386/irq.h
--- a/include/asm-i386/irq.h	Thu May 22 13:13:57 2003
+++ b/include/asm-i386/irq.h	Thu May 22 13:13:57 2003
@@ -25,6 +25,8 @@
 extern void enable_irq(unsigned int);
 extern void release_x86_irqs(struct task_struct *);
=20
+extern unsigned long irq_mask [NR_IRQS];
+
 #ifdef CONFIG_X86_LOCAL_APIC
 #define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */
 #endif

--=-2YbZKuucwg8/BGJOaOBl--

