Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262490AbSJWBgj>; Tue, 22 Oct 2002 21:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262525AbSJWBgi>; Tue, 22 Oct 2002 21:36:38 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:3829 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262490AbSJWBge>;
	Tue, 22 Oct 2002 21:36:34 -0400
Subject: [RFC] linux-2.5.44_vsyscall-proc_A0
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: andrea <andrea@suse.de>, ak@muc.de, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       george anzinger <george@mvista.com>, Jeff Dike <jdike@karaya.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>
In-Reply-To: <1035336629.954.90.camel@cog>
References: <1035336629.954.90.camel@cog>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Oct 2002 18:32:51 -0700
Message-Id: <1035336772.954.95.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All
	Well, just to fan the flames a bit, here is a patch (applies on top of
vsyscall_A1)that adds a /proc/vsyscall interface which gives the address
of the vsyscall page if its mapped in. This could be then used to help
the UML folks virtualize things, as well as give a cross platform
interface that could be used. There's probably a better place in /proc
for this, but this is just something to start from. 
	
Let me know your thoughts.
-john

diff -Nru a/arch/i386/kernel/vsyscall.c b/arch/i386/kernel/vsyscall.c
--- a/arch/i386/kernel/vsyscall.c	Tue Oct 22 18:24:42 2002
+++ b/arch/i386/kernel/vsyscall.c	Tue Oct 22 18:24:42 2002
@@ -23,6 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/timer.h>
 #include <linux/sched.h>
+#include <linux/proc_fs.h>
 
 #include <asm/vsyscall.h>
 #include <asm/pgtable.h>
@@ -45,7 +46,7 @@
 
 #else
 long __vxtime_sequence[2] __section_vxtime_sequence;
-
+static unsigned long vsyscall_ptr;
 static inline void do_vgettimeofday(struct timeval * tv)
 {
 	long sequence;
@@ -163,6 +164,7 @@
 	pm = pmd_offset(pd,(unsigned long)&__last_tsc_low);
 	pm->pmd |= _PAGE_USER;
 
+	vsyscall_ptr = (unsigned long)&vgettimeofday;
 }
 
 static int __init vsyscall_init(void)
@@ -173,7 +175,7 @@
 	if ((unsigned long) &vtime != VSYSCALL_ADDR(__NR_vtime))
 		panic("vtime link addr broken");
 	if (VSYSCALL_ADDR(0) != __fix_to_virt(VSYSCALL_FIRST_PAGE))
-		panic("fixmap first vsyscall %lx should be %lx", __fix_to_virt(VSYSCALL_FIRST_PAGE),
+		panic("fixmap first vsyscall %lx should be %x", __fix_to_virt(VSYSCALL_FIRST_PAGE),
 		      VSYSCALL_ADDR(0));
 
 	/* XXX: we'll also need to make sure the TSC is 
@@ -193,7 +195,42 @@
 	printk("VSYSCALL: fixmap virt addr: 0x%lx\n",
 		__fix_to_virt(VSYSCALL_FIRST_PAGE));
 
+	init_vsyscall_proc();
 	return 0;
 }
 
 __initcall(vsyscall_init);
+
+
+/* /proc entry */
+#define HEX_DIGITS 8
+static int vsyscall_read_proc (char *page, char **start, off_t off,
+			int count, int *eof, void *data)
+{
+	if (count < HEX_DIGITS+1)
+		return -EINVAL;
+	return sprintf (page, "0x%08lx\n", vsyscall_ptr);
+}
+static int vsyscall_write_proc (struct file *file, const char *buffer,
+					unsigned long count, void *data)
+{
+	return count;
+}
+
+void init_vsyscall_proc (void)
+{
+	struct proc_dir_entry *entry;
+	int i;
+
+	/* create /proc/vsyscall */
+	entry = create_proc_entry("vsyscall", S_IROTH, NULL);
+
+	if (!entry)
+	    return;
+
+	entry->nlink = 1;
+	entry->data = NULL;
+	entry->read_proc = vsyscall_read_proc;
+	entry->write_proc = vsyscall_write_proc;
+
+}

