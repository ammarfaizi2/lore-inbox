Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314283AbSDRJqk>; Thu, 18 Apr 2002 05:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314281AbSDRJqj>; Thu, 18 Apr 2002 05:46:39 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:26632 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314282AbSDRJqh>;
	Thu, 18 Apr 2002 05:46:37 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [RFC] 2.5.8 sort kernel tables
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 18 Apr 2002 19:46:26 +1000
Message-ID: <1589.1019123186@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The use of __init and __exit sections breaks the assumption that tables
such as __ex_table are sorted, it has already broken the dbe table in
mips on 2.5.  This patch against 2.5.8 adds a generic sort routine and
sorts the i386 exception table.

This sorting needs to be extended to several other tables, to all
architectures, to modutils (insmod loads some of these tables for
modules) and back ported to 2.4.  Before I spend the rest of the time,
any objections?

ndex: 8.1/init/main.c
--- 8.1/init/main.c Mon, 15 Apr 2002 13:28:23 +1000 kaos (linux-2.5/w/d/29_main.c 1.16 444)
+++ 8.1(w)/init/main.c Thu, 18 Apr 2002 19:36:40 +1000 kaos (linux-2.5/w/d/29_main.c 1.16 444)
@@ -257,6 +257,56 @@ static void __init parse_options(char *l
 	envp_init[envs+1] = NULL;
 }
 
+/* Quick and dirty bubble sort to ensure that certain kernel tables really are
+ * sorted.  Various kernel tables, in particular the exception entries, are
+ * assumed to be in ascending order.  These tables are built by the linker from
+ * sections in each object.  The linker is not a problem, it appends entries to
+ * the tables as each object is added to vmlinux.  However the use of __init and
+ * __exit in objects can break the ordering, within each object the entries are
+ * in order, the linker appends them in order but the entries are not in order
+ * across objects.
+ *
+ * Do not assume that the table from the linker is correct, sort it at boot
+ * time.  Since 90%+ of the entries will be sorted, a bubble sort is good
+ * enough, it only runs once per table per boot.  The sort only does binary
+ * keys and only sorts in ascending order.
+ */
+
+void __init sort_table(void *table, size_t entry_size, size_t entries, size_t key_size, size_t key_offset)
+{
+	char *a, *b;
+	int i, j, changed = 1;
+	char save[entry_size];
+	a = (char *)table;
+	if (key_size != 4 && key_size != 8) {
+		printk(KERN_ERR "sort_table key_size %d is incorrect\n", key_size);
+		return;
+	}
+	for (i = 0; i < entries && changed; a += entry_size, ++i) {
+		changed = 0;
+		b = a + entry_size;
+		for (j = i + 1; j < entries; b += entry_size, ++j) {
+			if (key_size == 4) {
+				if (*((__u32 *)(b+key_offset-entry_size)) >
+				    *((__u32 *)(b+key_offset))) {
+					memcpy(save, b, entry_size);
+					memcpy(b, b-entry_size, entry_size);
+					memcpy(b-entry_size, save, entry_size);
+					changed = 1;
+				}
+			}
+			else {
+				if (*((__u64 *)(b+key_offset-entry_size)) >
+				    *((__u64 *)(b+key_offset))) {
+					memcpy(save, b, entry_size);
+					memcpy(b, b-entry_size, entry_size);
+					memcpy(b-entry_size, save, entry_size);
+					changed = 1;
+				}
+			}
+		}
+	}
+}
 
 extern void setup_arch(char **);
 extern void cpu_idle(void);
@@ -343,6 +393,7 @@ asmlinkage void __init start_kernel(void
  */
 	lock_kernel();
 	printk(linux_banner);
+	sort_arch_tables();
 	setup_arch(&command_line);
 	setup_per_cpu_areas();
 	printk("Kernel command line: %s\n", saved_command_line);
Index: 8.1/arch/i386/mm/extable.c
--- 8.1/arch/i386/mm/extable.c Sat, 24 Nov 2001 05:28:08 +1100 kaos (linux-2.5/b/b/41_extable.c 1.1 444)
+++ 8.1(w)/arch/i386/mm/extable.c Thu, 18 Apr 2002 19:37:50 +1000 kaos (linux-2.5/b/b/41_extable.c 1.1 444)
@@ -31,6 +31,14 @@ search_one_table(const struct exception_
         return 0;
 }
 
+void __init sort_arch_tables(void)
+{
+	sort_table((void *) __start___ex_table, sizeof(*__start___ex_table),
+			__stop___ex_table - __start___ex_table,
+			sizeof(__start___ex_table->insn),
+			offsetof(typeof(*__start___ex_table), insn));
+}
+
 extern spinlock_t modlist_lock;
 
 unsigned long
Index: 8.1/include/linux/kernel.h
--- 8.1/include/linux/kernel.h Sat, 09 Feb 2002 15:37:49 +1100 kaos (linux-2.5/v/d/17_kernel.h 1.4 444)
+++ 8.1(w)/include/linux/kernel.h Thu, 18 Apr 2002 18:38:26 +1000 kaos (linux-2.5/v/d/17_kernel.h 1.4 444)
@@ -95,6 +95,9 @@ extern const char *print_tainted(void);
 #define TAINT_FORCED_MODULE		(1<<1)
 #define TAINT_UNSAFE_SMP		(1<<2)
 
+extern void sort_arch_tables(void);
+extern void sort_table(void *table, size_t entry_size, size_t entries, size_t key_size, size_t key_offset);
+
 #if DEBUG
 #define pr_debug(fmt,arg...) \
 	printk(KERN_DEBUG fmt,##arg)

