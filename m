Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276650AbRJPThu>; Tue, 16 Oct 2001 15:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276538AbRJPThc>; Tue, 16 Oct 2001 15:37:32 -0400
Received: from fe070.worldonline.dk ([212.54.64.208]:26131 "HELO
	fe070.worldonline.dk") by vger.kernel.org with SMTP
	id <S276650AbRJPTh2>; Tue, 16 Oct 2001 15:37:28 -0400
Message-ID: <3BCC8C88.58BBCC39@eisenstein.dk>
Date: Tue, 16 Oct 2001 21:37:44 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] various minor cleanups against 2.4.13-pre3 - comments requested
Content-Type: multipart/mixed;
 boundary="------------5077D299A3622042620D700B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5077D299A3622042620D700B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Hi everyone,


I've posted the majority of this before (against 2.4.13-pre2), but I
never got any response (probably partially becourse my clock was set
24hrs into the past). 

I have updated the patch against 2.4.13-pre3 and added a fix for a minor
typo in panic.c
I'm posting this to the list to get comments about these cleanups, not
becourse I expect to get any part of this accepted into the kernel at
this point. I would very much like to know if these cleanups are worth
the effort and if what I have done looks allright. Any constructive
criticism is very much appreciated.


Here's a summary of what the patch does:


init/main.c : root_dev_setup()
        In the for() loop the counter "i" is compared to "sizeof
root_device_name". "i" is declared as int
        (signed) and sizeof always returns an unsigned value, so I
believe "i" should be declared unsigned.

init/main.c : parse_options()
        The check that adds "line" to either "envp_init" or "argv_init"
checks to see if the buffers are full
        and break;s the while() loop if _either_ buffer is full - it
should use continue; so both buffers can
        get a chance to fill up.
        Robert M. Love should get credit for finding this one, I found
it by looking at an old patch of his, and
        I just checked to see if it was still there and read the code to
see if it was correct.

kernel/exec_domain.c :
        Contrary to most other files in the kernel source the functions
in exec_domain.c are defined with the
        return values on a line by themselves. Most places in kernel
source have the entire function definition
        on a single line (as long as it does not exceed 80 chars in
length). So I moved the function definitions
        onto a single line.

kernel/exec_domain.c : get_exec_domain_list()
        The len variable (signed) is compared to PAGE_SIZE (unsigned).
Changing len to "unsigned int" avoids
        comparison between signed and unsigned.

        It seems that there are tons of places throughout the kernel
where signed and unsigned variables are
        compared. I won't mind going through the source and try to see
where this can be avoided easily, but I'm
        not sure it it's worth the effort?

kernel/panic.c : panic()
	There's a small typo in the text that's printk()'d to the user - it
says "...the boot prom\n" where I believe it should say "...the boot
prompt\n".


The patch itself is attached as "2.4.13-pre3-jj1.patch". 
Since these changes are all very minor I have included them all in a
single patch file, but I can split them out into 3 individual patches on
request.


Best regards,
Jesper Juhl
juhl@eisenstein.dk
--------------5077D299A3622042620D700B
Content-Type: text/plain; charset=us-ascii;
 name="2.4.13-pre3-jj1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.13-pre3-jj1.patch"

diff -ur linux-2.4.13-pre3-orig/init/main.c linux-2.4.13-pre3/init/main.c
--- linux-2.4.13-pre3-orig/init/main.c	Tue Oct 16 21:18:14 2001
+++ linux-2.4.13-pre3/init/main.c	Tue Oct 16 21:22:33 2001
@@ -291,7 +291,7 @@
 
 static int __init root_dev_setup(char *line)
 {
-	int i;
+	unsigned int i;
 	char ch;
 
 	ROOT_DEV = name_to_kdev_t(line);
@@ -465,11 +465,11 @@
 		 */
 		if (strchr(line,'=')) {
 			if (envs >= MAX_INIT_ENVS)
-				break;
+				continue;
 			envp_init[++envs] = line;
 		} else {
 			if (args >= MAX_INIT_ARGS)
-				break;
+				continue;
 			if (*line)
 				argv_init[++args] = line;
 		}
diff -ur linux-2.4.13-pre3-orig/kernel/exec_domain.c linux-2.4.13-pre3/kernel/exec_domain.c
--- linux-2.4.13-pre3-orig/kernel/exec_domain.c	Fri Oct  5 01:41:54 2001
+++ linux-2.4.13-pre3/kernel/exec_domain.c	Tue Oct 16 21:22:33 2001
@@ -40,8 +40,7 @@
 };
 
 
-static void
-default_handler(int segment, struct pt_regs *regp)
+static void default_handler(int segment, struct pt_regs *regp)
 {
 	u_long			pers = 0;
 
@@ -73,8 +72,7 @@
 		send_sig(SIGSEGV, current, 1);
 }
 
-static struct exec_domain *
-lookup_exec_domain(u_long personality)
+static struct exec_domain *lookup_exec_domain(u_long personality)
 {
 	struct exec_domain *	ep;
 	char			buffer[30];
@@ -106,8 +104,7 @@
 	return (ep);
 }
 
-int
-register_exec_domain(struct exec_domain *ep)
+int register_exec_domain(struct exec_domain *ep)
 {
 	struct exec_domain	*tmp;
 	int			err = -EBUSY;
@@ -133,8 +130,7 @@
 	return (err);
 }
 
-int
-unregister_exec_domain(struct exec_domain *ep)
+int unregister_exec_domain(struct exec_domain *ep)
 {
 	struct exec_domain	**epp;
 
@@ -154,8 +150,7 @@
 	return 0;
 }
 
-int
-__set_personality(u_long personality)
+int __set_personality(u_long personality)
 {
 	struct exec_domain	*ep, *oep;
 
@@ -201,11 +196,10 @@
 	return 0;
 }
 
-int
-get_exec_domain_list(char *page)
+int get_exec_domain_list(char *page)
 {
 	struct exec_domain	*ep;
-	int			len = 0;
+	unsigned int		len = 0;
 
 	read_lock(&exec_domains_lock);
 	for (ep = exec_domains; ep && len < PAGE_SIZE - 80; ep = ep->next)
@@ -216,8 +210,7 @@
 	return (len);
 }
 
-asmlinkage long
-sys_personality(u_long personality)
+asmlinkage long sys_personality(u_long personality)
 {
 	u_long old = current->personality;;
 
@@ -274,8 +267,7 @@
 	{0}
 };
 
-static int __init
-abi_register_sysctl(void)
+static int __init abi_register_sysctl(void)
 {
 	register_sysctl_table(abi_root_table, 1);
 	return 0;
diff -ur linux-2.4.13-pre3-orig/kernel/panic.c linux-2.4.13-pre3/kernel/panic.c
--- linux-2.4.13-pre3-orig/kernel/panic.c	Sun Sep 30 21:26:08 2001
+++ linux-2.4.13-pre3/kernel/panic.c	Tue Oct 16 21:22:50 2001
@@ -88,7 +88,7 @@
 		extern int stop_a_enabled;
 		/* Make sure the user can actually press L1-A */
 		stop_a_enabled = 1;
-		printk("Press L1-A to return to the boot prom\n");
+		printk("Press L1-A to return to the boot prompt\n");
 	}
 #endif
 #if defined(CONFIG_ARCH_S390)

--------------5077D299A3622042620D700B--

