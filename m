Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbWBGFNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWBGFNy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 00:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWBGFNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 00:13:54 -0500
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:2935 "HELO
	web31802.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964978AbWBGFNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 00:13:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=5MmkuO1aihMVhHbo9XfZc5Z/cs4aMdTI/YsCWSS4uDbw4AVXOL59KE+H6OrTDRzre6PHdwQPdELGbkTcLW3+30FNRledT0B+g1R43iRFQY0YoWRwQYXq2kkwezEuFjKhX4GINcqnVz0/MRNxqUg9DYRnmUjQsA5c11R+rXXmAVo=  ;
Message-ID: <20060207051352.11432.qmail@web31802.mail.mud.yahoo.com>
Date: Mon, 6 Feb 2006 21:13:52 -0800 (PST)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: [PATCH] x86-64: improve the format of stack dumps
To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Cc: rdunlap@xenotime.net, torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200602032213.55058.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the format of stack dumps for x86-64.
* Single column of stack entries. (similar to other arches)
* Print the offset in hexadecimal instead of decimal! (similar to other arches)
* Print the size of the routines as well. (similar to other arches)
* No white line after RIP.
* No duplicate register dump on RIP line.
* No white line after register dump.
* Formatted/lined up dump of the stacks.

For example:

SysRq : Show Regs
CPU 0:
Modules linked in: i2c_dev i2c_core
Pid: 0, comm: swapper Not tainted 2.6.16-rc2-git #34
RIP: 0010:[<ffffffff801096b1>] mwait_idle+0x3c/0x53
RSP: 0018:ffffffff8059bf70  EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffffff80109675 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff8052d698
RBP: ffffffff8059bf70 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff805d7184
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff8058d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002abae842f000 CR3: 00000000763b3000 CR4: 00000000000006e0
Call Trace:
        [<ffffffff80109654>] cpu_idle+0x6c/0x8d
        [<ffffffff8010802b>] rest_init+0x2b/0x31
        [<ffffffff8059c89a>] start_kernel+0x1dc/0x1de
        [<ffffffff8059c2a9>] _sinittext+0x2a9/0x2b0

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>

 arch/x86_64/kernel/process.c |    4 +-
 arch/x86_64/kernel/traps.c   |   75 +++++++++++++------------------------------
 include/linux/kallsyms.h     |    7 ++--
 kernel/kallsyms.c            |    4 +-
 4 files changed, 32 insertions(+), 58 deletions(-)

diff --git a/arch/x86_64/kernel/process.c b/arch/x86_64/kernel/process.c
index 8ded407..6a29b0e 100644
--- a/arch/x86_64/kernel/process.c
+++ b/arch/x86_64/kernel/process.c
@@ -302,9 +302,9 @@ void __show_regs(struct pt_regs * regs)
                system_utsname.release,
                (int)strcspn(system_utsname.version, " "),
                system_utsname.version);
-       printk("RIP: %04lx:[<%016lx>] ", regs->cs & 0xffff, regs->rip);
+       printk("RIP: %04lx:", regs->cs & 0xffff);
        printk_address(regs->rip); 
-       printk("\nRSP: %04lx:%016lx  EFLAGS: %08lx\n", regs->ss, regs->rsp,
+       printk("RSP: %04lx:%016lx  EFLAGS: %08lx\n", regs->ss, regs->rsp,
                regs->eflags);
        printk("RAX: %016lx RBX: %016lx RCX: %016lx\n",
               regs->rax, regs->rbx, regs->rcx);
diff --git a/arch/x86_64/kernel/traps.c b/arch/x86_64/kernel/traps.c
index 8bb0aed..842925e 100644
--- a/arch/x86_64/kernel/traps.c
+++ b/arch/x86_64/kernel/traps.c
@@ -30,6 +30,7 @@
 #include <linux/moduleparam.h>
 #include <linux/nmi.h>
 #include <linux/kprobes.h>
+#include <linux/kallsyms.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -92,30 +93,15 @@ static inline void conditional_sti(struc
 
 static int kstack_depth_to_print = 10;
 
-#ifdef CONFIG_KALLSYMS
-#include <linux/kallsyms.h> 
-int printk_address(unsigned long address)
-{ 
-       unsigned long offset = 0, symsize;
-       const char *symname;
-       char *modname;
-       char *delim = ":"; 
-       char namebuf[128];
-
-       symname = kallsyms_lookup(address, &symsize, &offset, &modname, namebuf); 
-       if (!symname) 
-               return printk("[<%016lx>]", address);
-       if (!modname) 
-               modname = delim = ""; 
-        return printk("<%016lx>{%s%s%s%s%+ld}",
-                     address,delim,modname,delim,symname,offset); 
-} 
-#else
-int printk_address(unsigned long address)
-{ 
-       return printk("[<%016lx>]", address);
-} 
-#endif
+int printk_address(unsigned long addr)
+{
+       int i = 0;
+       i += printk("[<%08lx>] ", addr);
+       i += __print_symbol("%s", addr);
+       i += printk("\n");
+
+       return i;
+}
 
 static unsigned long *in_exception_stack(unsigned cpu, unsigned long stack,
                                        unsigned *usedp, const char **idp)
@@ -185,43 +171,29 @@ void show_trace(unsigned long *stack)
 {
        const unsigned cpu = safe_smp_processor_id();
        unsigned long *irqstack_end = (unsigned long *)cpu_pda(cpu)->irqstackptr;
-       int i;
        unsigned used = 0;
 
-       printk("\nCall Trace:");
+       printk("Call Trace:\n");
 
-#define HANDLE_STACK(cond) \
-       do while (cond) { \
-               unsigned long addr = *stack++; \
-               if (kernel_text_address(addr)) { \
-                       if (i > 50) { \
-                               printk("\n       "); \
-                               i = 0; \
-                       } \
-                       else \
-                               i += printk(" "); \
-                       /* \
-                        * If the address is either in the text segment of the \
-                        * kernel, or in the region which contains vmalloc'ed \
-                        * memory, it *may* be the address of a calling \
-                        * routine; if so, print it so that someone tracing \
-                        * down the cause of the crash will be able to figure \
-                        * out the call path that was taken. \
-                        */ \
-                       i += printk_address(addr); \
-               } \
+#define HANDLE_STACK(cond)                          \
+       do while (cond) {                           \
+               unsigned long addr = *stack++;      \
+               if (kernel_text_address(addr)) {    \
+                       printk("        ");         \
+                       printk_address(addr);       \
+               }                                   \
        } while (0)
 
-       for(i = 11; ; ) {
+       for( ; ; ) {
                const char *id;
                unsigned long *estack_end;
                estack_end = in_exception_stack(cpu, (unsigned long)stack,
                                                &used, &id);
 
                if (estack_end) {
-                       i += printk(" <%s>", id);
+                       printk(" <%s>", id);
                        HANDLE_STACK (stack < estack_end);
-                       i += printk(" <EOE>");
+                       printk(" <EOE>");
                        stack = (unsigned long *) estack_end[-2];
                        continue;
                }
@@ -231,11 +203,11 @@ void show_trace(unsigned long *stack)
                                (IRQSTACKSIZE - 64) / sizeof(*irqstack);
 
                        if (stack >= irqstack && stack < irqstack_end) {
-                               i += printk(" <IRQ>");
+                               printk(" <IRQ>");
                                HANDLE_STACK (stack < irqstack_end);
                                stack = (unsigned long *) (irqstack_end[-1]);
                                irqstack_end = NULL;
-                               i += printk(" <EOI>");
+                               printk(" <EOI>");
                                continue;
                        }
                }
@@ -244,7 +216,6 @@ void show_trace(unsigned long *stack)
 
        HANDLE_STACK (((long) stack & (THREAD_SIZE-1)) != 0);
 #undef HANDLE_STACK
-       printk("\n");
 }
 
 void show_stack(struct task_struct *tsk, unsigned long * rsp)
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 9bbd040..f668e64 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -20,7 +20,7 @@ const char *kallsyms_lookup(unsigned lon
                            char **modname, char *namebuf);
 
 /* Replace "%s" in format with address, if found */
-extern void __print_symbol(const char *fmt, unsigned long address);
+extern int __print_symbol(const char *fmt, unsigned long address);
 
 #else /* !CONFIG_KALLSYMS */
 
@@ -38,7 +38,10 @@ static inline const char *kallsyms_looku
 }
 
 /* Stupid that this does nothing, but I didn't create this mess. */
-#define __print_symbol(fmt, addr)
+static inline int __print_symbol(const char *fmt, unsigned long addr)
+{
+       return 0;
+}
 #endif /*CONFIG_KALLSYMS*/
 
 /* This macro allows us to keep printk typechecking */
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 39277dd..fbd7cb4 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -231,7 +231,7 @@ const char *kallsyms_lookup(unsigned lon
 }
 
 /* Replace "%s" in format with address, or returns -errno. */
-void __print_symbol(const char *fmt, unsigned long address)
+int __print_symbol(const char *fmt, unsigned long address)
 {
        char *modname;
        const char *name;
@@ -251,7 +251,7 @@ void __print_symbol(const char *fmt, uns
                else
                        sprintf(buffer, "%s+%#lx/%#lx", name, offset, size);
        }
-       printk(fmt, buffer);
+       return printk(fmt, buffer);
 }
 
 /* To avoid using get_symbol_offset for every symbol, we carry prefix along. */


