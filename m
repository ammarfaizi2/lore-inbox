Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbWJBVSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbWJBVSh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbWJBVSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:18:37 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11684
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932540AbWJBVSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:18:36 -0400
Date: Mon, 02 Oct 2006 14:18:50 -0700 (PDT)
Message-Id: <20061002.141850.18280315.davem@davemloft.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, axboe@suse.de
Subject: Re: linux/compat.h includes asm/signal.h causing problems
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061002.140437.78732307.davem@davemloft.net>
References: <20061002.131414.74728780.davem@davemloft.net>
	<20061002135036.7bd1f76b.akpm@osdl.org>
	<20061002.140437.78732307.davem@davemloft.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Mon, 02 Oct 2006 14:04:37 -0700 (PDT)

> From: Andrew Morton <akpm@osdl.org>
> Date: Mon, 2 Oct 2006 13:50:36 -0700
> 
> > I don't know what a good fix is, really.  I guess one could put the
> > declaration of sigset_from_compat() into its own header file and include
> > that header from the right places.
> 
> I'm working on a patch that puts the compat signal bits into
> include/asm-sparc64/compat_signal.h and adds the necessary
> includes to a few *.c files under arch/sparc64 when needed.

Ok, this seems to work and is what I'll sent to Linus.

commit 0c2d4569948a93fac01a17e191ede4f754607a4a
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Mon Oct 2 14:17:57 2006 -0700

    [SPARC64]: Move signal compat bits to new header file.
    
    Create asm-sparc64/compat_signal.h and stuff things there.
    
    This avoids the "linux/compat.h includes asm/signal.h but
    asm/signal.h needs compat_sigset_t which isn't defined yet"
    problems introduced recently.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc64/kernel/signal32.c b/arch/sparc64/kernel/signal32.c
index 708ba9b..c45f21b 100644
--- a/arch/sparc64/kernel/signal32.c
+++ b/arch/sparc64/kernel/signal32.c
@@ -29,6 +29,7 @@ #include <asm/pgtable.h>
 #include <asm/psrcompat.h>
 #include <asm/fpumacro.h>
 #include <asm/visasm.h>
+#include <asm/compat_signal.h>
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
diff --git a/arch/sparc64/kernel/sys_sparc32.c b/arch/sparc64/kernel/sys_sparc32.c
index 69444f2..7c6499c 100644
--- a/arch/sparc64/kernel/sys_sparc32.c
+++ b/arch/sparc64/kernel/sys_sparc32.c
@@ -61,6 +61,7 @@ #include <asm/fpumacro.h>
 #include <asm/semaphore.h>
 #include <asm/mmu_context.h>
 #include <asm/a.out.h>
+#include <asm/compat_signal.h>
 
 asmlinkage long sys32_chown16(const char __user * filename, u16 user, u16 group)
 {
diff --git a/arch/sparc64/kernel/sys_sunos32.c b/arch/sparc64/kernel/sys_sunos32.c
index 953296b..b21e8dd 100644
--- a/arch/sparc64/kernel/sys_sunos32.c
+++ b/arch/sparc64/kernel/sys_sunos32.c
@@ -43,6 +43,7 @@ #include <asm/pconf.h>
 #include <asm/idprom.h> /* for gethostid() */
 #include <asm/unistd.h>
 #include <asm/system.h>
+#include <asm/compat_signal.h>
 
 /* For the nfs mount emulation */
 #include <linux/socket.h>
diff --git a/include/asm-sparc64/compat_signal.h b/include/asm-sparc64/compat_signal.h
new file mode 100644
index 0000000..7aefa30
--- /dev/null
+++ b/include/asm-sparc64/compat_signal.h
@@ -0,0 +1,30 @@
+#ifndef _COMPAT_SIGNAL_H
+#define _COMPAT_SIGNAL_H
+
+#include <linux/config.h>
+#include <linux/compat.h>
+#include <asm/signal.h>
+
+#ifdef CONFIG_COMPAT
+struct __new_sigaction32 {
+	unsigned		sa_handler;
+	unsigned int    	sa_flags;
+	unsigned		sa_restorer;     /* not used by Linux/SPARC yet */
+	compat_sigset_t 	sa_mask;
+};
+
+struct __old_sigaction32 {
+	unsigned		sa_handler;
+	compat_old_sigset_t  	sa_mask;
+	unsigned int    	sa_flags;
+	unsigned		sa_restorer;     /* not used by Linux/SPARC yet */
+};
+
+typedef struct sigaltstack32 {
+	u32			ss_sp;
+	int			ss_flags;
+	compat_size_t		ss_size;
+} stack_t32;
+#endif
+
+#endif /* !(_COMPAT_SIGNAL_H) */
diff --git a/include/asm-sparc64/signal.h b/include/asm-sparc64/signal.h
index 9968871..b695d08 100644
--- a/include/asm-sparc64/signal.h
+++ b/include/asm-sparc64/signal.h
@@ -167,23 +167,6 @@ struct __new_sigaction {
 	__new_sigset_t		sa_mask;
 };
 
-#ifdef __KERNEL__
-
-#ifdef CONFIG_COMPAT
-struct __new_sigaction32 {
-	unsigned		sa_handler;
-	unsigned int    	sa_flags;
-	unsigned		sa_restorer;     /* not used by Linux/SPARC yet */
-	compat_sigset_t 	sa_mask;
-};
-#endif
-
-struct k_sigaction {
-	struct __new_sigaction 	sa;
-	void __user		*ka_restorer;
-};
-#endif
-
 struct __old_sigaction {
 	__sighandler_t  	sa_handler;
 	__old_sigset_t  	sa_mask;
@@ -191,19 +174,6 @@ struct __old_sigaction {
 	void 			(*sa_restorer)(void);     /* not used by Linux/SPARC yet */
 };
 
-#ifdef __KERNEL__
-
-#ifdef CONFIG_COMPAT
-struct __old_sigaction32 {
-	unsigned		sa_handler;
-	compat_old_sigset_t  	sa_mask;
-	unsigned int    	sa_flags;
-	unsigned		sa_restorer;     /* not used by Linux/SPARC yet */
-};
-#endif
-
-#endif
-
 typedef struct sigaltstack {
 	void			__user *ss_sp;
 	int			ss_flags;
@@ -212,13 +182,10 @@ typedef struct sigaltstack {
 
 #ifdef __KERNEL__
 
-#ifdef CONFIG_COMPAT
-typedef struct sigaltstack32 {
-	u32			ss_sp;
-	int			ss_flags;
-	compat_size_t		ss_size;
-} stack_t32;
-#endif
+struct k_sigaction {
+	struct __new_sigaction 	sa;
+	void __user		*ka_restorer;
+};
 
 struct signal_deliver_cookie {
 	int restart_syscall;
