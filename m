Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265723AbTFXGpm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 02:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265724AbTFXGpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 02:45:42 -0400
Received: from dp.samba.org ([66.70.73.150]:15056 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265723AbTFXGp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 02:45:28 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: corbet@lwn.net (Jonathan Corbet)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Allow arbitrary number of init funcs in modules 
In-reply-to: Your message of "Mon, 23 Jun 2003 13:11:41 CST."
             <20030623191141.31814.qmail@eklektix.com> 
Date: Tue, 24 Jun 2003 16:57:34 +1000
Message-Id: <20030624065937.1B45E2C273@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030623191141.31814.qmail@eklektix.com> you write:
> > Feedback is extremely welcome,
> 
> OK...you asked for it.  I found three separate bugs, two of them oopsed the

OK, patch applied, ancient-style module init supported (after separate
patch to clean out some cruft) and init-sorting routine fixed too.
Tested on 2.5.73-bk1, test patch included.

For convenience, all patches in one long mail.

Feedback still welcome 8)
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Centralize token pasting and generation of unique IDs
Author: Rusty Russell
Status: Tested on 2.5.70-bk13

D: Add __cat(a,b) to implement token pasting to stringify.h.  To
D: generate unique names, __unique_id(stem) is implemented (it'd be
D: nice to have a gcc extension to give a unique identifier).  Change
D: module.h to use them.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26569-linux-2.5.70-bk16/include/linux/module.h .26569-linux-2.5.70-bk16.updated/include/linux/module.h
--- .26569-linux-2.5.70-bk16/include/linux/module.h	2003-06-12 09:58:02.000000000 +1000
+++ .26569-linux-2.5.70-bk16.updated/include/linux/module.h	2003-06-12 16:19:16.000000000 +1000
@@ -55,10 +55,8 @@ search_extable(const struct exception_ta
 	       unsigned long value);
 
 #ifdef MODULE
-#define ___module_cat(a,b) __mod_ ## a ## b
-#define __module_cat(a,b) ___module_cat(a,b)
 #define __MODULE_INFO(tag, name, info)					  \
-static const char __module_cat(name,__LINE__)[]				  \
+static const char __unique_id(name)[]					  \
   __attribute__((section(".modinfo"),unused)) = __stringify(tag) "=" info
 
 #define MODULE_GENERIC_TABLE(gtype,name)			\
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26569-linux-2.5.70-bk16/include/linux/stringify.h .26569-linux-2.5.70-bk16.updated/include/linux/stringify.h
--- .26569-linux-2.5.70-bk16/include/linux/stringify.h	2003-01-02 12:25:36.000000000 +1100
+++ .26569-linux-2.5.70-bk16.updated/include/linux/stringify.h	2003-06-12 16:32:17.000000000 +1000
@@ -9,4 +9,11 @@
 #define __stringify_1(x)	#x
 #define __stringify(x)		__stringify_1(x)
 
+/* Paste two tokens together. */
+#define ___cat(a,b) a ## b
+#define __cat(a,b) ___cat(a,b)
+
+/* Try to give a unique identifier: this comes close, iff used as static. */
+#define __unique_id(stem) \
+	__cat(__cat(__uniq,stem),__cat(__LINE__,KBUILD_BASENAME))
 #endif	/* !__LINUX_STRINGIFY_H */

Name: Delete redundant init_module and cleanup_module prototypes.
Author: Rusty Russell
Status: Trivial

D: A few places pre-declare "int module_init(void);" and "void
D: module_cleanup(void);".  Other than being obsolete, this is
D: unneccessary (it's in init.h anyway).
D: 
D: There are still about 100 places which still use the
D: obsolete-since-2.2 "a function named module_init() magically gets
D: called": this change frees us up implement that via a macro.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11903-linux-2.5.73-bk1/drivers/block/paride/pf.c .11903-linux-2.5.73-bk1.updated/drivers/block/paride/pf.c
--- .11903-linux-2.5.73-bk1/drivers/block/paride/pf.c	2003-05-05 12:36:58.000000000 +1000
+++ .11903-linux-2.5.73-bk1.updated/drivers/block/paride/pf.c	2003-06-24 11:43:58.000000000 +1000
@@ -222,9 +222,6 @@ MODULE_PARM(drive3, "1-7i");
 #define ATAPI_READ_10		0x28
 #define ATAPI_WRITE_10		0x2a
 
-#ifdef MODULE
-void cleanup_module(void);
-#endif
 static int pf_open(struct inode *inode, struct file *file);
 static void do_pf_request(request_queue_t * q);
 static int pf_ioctl(struct inode *inode, struct file *file,
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11903-linux-2.5.73-bk1/drivers/char/istallion.c .11903-linux-2.5.73-bk1.updated/drivers/char/istallion.c
--- .11903-linux-2.5.73-bk1/drivers/char/istallion.c	2003-06-15 11:29:51.000000000 +1000
+++ .11903-linux-2.5.73-bk1.updated/drivers/char/istallion.c	2003-06-24 11:43:58.000000000 +1000
@@ -650,8 +650,6 @@ static unsigned int	stli_baudrates[] = {
  */
 
 #ifdef MODULE
-int		init_module(void);
-void		cleanup_module(void);
 static void	stli_argbrds(void);
 static int	stli_parsebrd(stlconf_t *confp, char **argp);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11903-linux-2.5.73-bk1/drivers/char/moxa.c .11903-linux-2.5.73-bk1.updated/drivers/char/moxa.c
--- .11903-linux-2.5.73-bk1/drivers/char/moxa.c	2003-06-23 10:52:46.000000000 +1000
+++ .11903-linux-2.5.73-bk1.updated/drivers/char/moxa.c	2003-06-24 11:43:58.000000000 +1000
@@ -216,10 +216,7 @@ static struct timer_list moxaEmptyTimer[
 static struct semaphore moxaBuffSem;
 
 int moxa_init(void);
-#ifdef MODULE
-int init_module(void);
-void cleanup_module(void);
-#endif
+
 /*
  * static functions:
  */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11903-linux-2.5.73-bk1/drivers/char/nwbutton.h .11903-linux-2.5.73-bk1.updated/drivers/char/nwbutton.h
--- .11903-linux-2.5.73-bk1/drivers/char/nwbutton.h	2003-05-27 15:02:08.000000000 +1000
+++ .11903-linux-2.5.73-bk1.updated/drivers/char/nwbutton.h	2003-06-24 11:43:58.000000000 +1000
@@ -32,10 +32,6 @@ int button_init (void);
 int button_add_callback (void (*callback) (void), int count);
 int button_del_callback (void (*callback) (void));
 static void button_consume_callbacks (int bpcount);
-#ifdef MODULE
-int init_module (void);
-void cleanup_module (void);
-#endif /* MODULE */
 
 #else /* Not compiling the driver itself */
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11903-linux-2.5.73-bk1/drivers/char/pcxx.c .11903-linux-2.5.73-bk1.updated/drivers/char/pcxx.c
--- .11903-linux-2.5.73-bk1/drivers/char/pcxx.c	2003-06-15 11:29:51.000000000 +1000
+++ .11903-linux-2.5.73-bk1.updated/drivers/char/pcxx.c	2003-06-24 11:50:28.000000000 +1000
@@ -209,17 +209,9 @@ static void cleanup_board_resources(void
 
 #ifdef MODULE
 
-/*
- * pcxe_init() is our init_module():
- */
-#define pcxe_init init_module
-
-void	cleanup_module(void);
-
-
 /*****************************************************************************/
 
-void cleanup_module()
+static void pcxe_cleanup()
 {
 
 	unsigned long	flags;
@@ -240,6 +232,12 @@ void cleanup_module()
 	kfree(digi_channels);
 	restore_flags(flags);
 }
+
+/*
+ * pcxe_init() is our init_module():
+ */
+module_init(pcxe_init);
+module_cleanup(pcxe_cleanup);
 #endif
 
 static inline struct channel *chan(register struct tty_struct *tty)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11903-linux-2.5.73-bk1/drivers/char/stallion.c .11903-linux-2.5.73-bk1.updated/drivers/char/stallion.c
--- .11903-linux-2.5.73-bk1/drivers/char/stallion.c	2003-06-15 11:29:52.000000000 +1000
+++ .11903-linux-2.5.73-bk1.updated/drivers/char/stallion.c	2003-06-24 11:43:58.000000000 +1000
@@ -472,8 +472,6 @@ static unsigned int	stl_baudrates[] = {
  */
 
 #ifdef MODULE
-int		init_module(void);
-void		cleanup_module(void);
 static void	stl_argbrds(void);
 static int	stl_parsebrd(stlconf_t *confp, char **argp);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11903-linux-2.5.73-bk1/drivers/net/wan/sdladrv.c .11903-linux-2.5.73-bk1.updated/drivers/net/wan/sdladrv.c
--- .11903-linux-2.5.73-bk1/drivers/net/wan/sdladrv.c	2003-06-15 11:29:56.000000000 +1000
+++ .11903-linux-2.5.73-bk1.updated/drivers/net/wan/sdladrv.c	2003-06-24 11:43:58.000000000 +1000
@@ -160,10 +160,6 @@
 
 /****** Function Prototypes *************************************************/
 
-/* Module entry points. These are called by the OS and must be public. */
-int init_module (void);
-void cleanup_module (void);
-
 /* Hardware-specific functions */
 static int sdla_detect	(sdlahw_t* hw);
 static int sdla_autodpm	(sdlahw_t* hw);
@@ -325,11 +321,7 @@ static int pci_slot_ar[MAX_S514_CARDS];
  * Context:	process
  */
 
-#ifdef MODULE
-int init_module (void)
-#else
 int sdladrv_init(void)
-#endif
 {
 	int i=0;
 
@@ -354,9 +346,12 @@ int sdladrv_init(void)
  * Module 'remove' entry point.
  * o release all remaining system resources
  */
-void cleanup_module (void)
+static void sdladrv_cleanup(void)
 {
 }
+
+module_init(sdladrv_init);
+module_cleanup(sdladrv_cleanup);
 #endif
 
 /******* Kernel APIs ********************************************************/
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11903-linux-2.5.73-bk1/drivers/net/wan/sdlamain.c .11903-linux-2.5.73-bk1.updated/drivers/net/wan/sdlamain.c
--- .11903-linux-2.5.73-bk1/drivers/net/wan/sdlamain.c	2003-05-27 15:02:12.000000000 +1000
+++ .11903-linux-2.5.73-bk1.updated/drivers/net/wan/sdlamain.c	2003-06-24 11:43:58.000000000 +1000
@@ -177,10 +177,6 @@ static void dbg_kfree(void * v, int line
 extern void disable_irq(unsigned int);
 extern void enable_irq(unsigned int);
  
-/* Module entry points */
-int init_module (void);
-void cleanup_module (void);
-
 /* WAN link driver entry points */
 static int setup(struct wan_device* wandev, wandev_conf_t* conf);
 static int shutdown(struct wan_device* wandev);
@@ -246,11 +242,7 @@ static int wanpipe_bh_critical=0;
  * Context:	process
  */
  
-#ifdef MODULE
-int init_module (void)
-#else
 int wanpipe_init(void)
-#endif
 {
 	int cnt, err = 0;
 
@@ -313,7 +305,7 @@ int wanpipe_init(void)
  * o unregister all adapters from the WAN router
  * o release all remaining system resources
  */
-void cleanup_module (void)
+static void wanpipe_cleanup(void)
 {
 	int i;
 
@@ -329,6 +321,8 @@ void cleanup_module (void)
 	printk(KERN_INFO "\nwanpipe: WANPIPE Modules Unloaded.\n");
 }
 
+module_init(wanpipe_init);
+module_exit(wanpipe_cleanup);
 #endif
 
 /******* WAN Device Driver Entry Points *************************************/

Name: Eliminate Unused Functions
Author: Rusty Russell
Status: Tested on 2.5.70-bk16

D: GCC 3.3 has the ability to eliminate unused static functions.  This includes
D: code like this:
D:
D: static int unusedfunc(void) { ... };
D: int otherfunc(void)
D: {
D:         (void)unusedfunc;
D: ...
D: 
D: This means that macros can suppress the "unused" warning on functions
D: without preventing the function elimination.  This should allow us to
D: remove a number of #ifdefs around unused functions.
D:
D: Unfortunately, this elimination is only performed if
D: -finline-functions is used.  In order to prevent GCC automatically
D: inlining anything, we also specify "--param max-inline-insns-auto=0".
D:
D: Earlier compilers don't understand this parameter, so we test for
D: it at build time.
D:
D: Results:
D:   gcc 3.3 without patch:
D:       -rwxrwxr-x    1 rusty    rusty     5115166 Jun 13 09:17 vmlinux
D:   gcc 3.3 with patch:
D:       -rwxrwxr-x    1 rusty    rusty     5115166 Jun 13 09:58 vmlinux
D:   gcc 3.3 without patch (small unused function added):
D:       -rwxrwxr-x    1 rusty    rusty     5115195 Jun 13 10:14 vmlinux
D:   gcc 3.3 with patch (small unused function added):
D:       -rwxrwxr-x    1 rusty    rusty     5115166 Jun 13 10:15 vmlinux

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.70-bk16-check_region/Makefile working-2.5.70-bk16-check_region-inline/Makefile
--- working-2.5.70-bk16-check_region/Makefile	2003-06-12 09:57:39.000000000 +1000
+++ working-2.5.70-bk16-check_region-inline/Makefile	2003-06-12 21:34:40.000000000 +1000
@@ -213,10 +213,12 @@ CFLAGS_KERNEL	=
 AFLAGS_KERNEL	=
 
 NOSTDINC_FLAGS  = -nostdinc -iwithprefix include
+# Needs gcc 3.3 or above to understand max-inline-insns-auto.
+INLINE_OPTS	:= $(shell $(CC) -o /non/existent/file -c --param max-inline-insns-auto=0 -xc /dev/null 2>&1 | grep /non/existent/file >/dev/null && echo -finline-functions --param max-inline-insns-auto=0)
 
 CPPFLAGS	:= -D__KERNEL__ -Iinclude
 CFLAGS 		:= $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
-	  	   -fno-strict-aliasing -fno-common
+	  	   $(INLINE_OPTS) -fno-strict-aliasing -fno-common
 AFLAGS		:= -D__ASSEMBLY__ $(CPPFLAGS)
 
 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \

Name: Test Arbitrary Number of Init and Exit Functions
Author: Rusty Russell
Status: Tested on 2.5.73-bk1
Depends: Module/init_exit.patch.gz

D: Test code for module_init_exit: adds example helpers for proc_net
D: and netfilter, and uses them in netfilter.  Also adds module foo
D: which uses really old-style init.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15095-linux-2.5.73-bk1/include/linux/netfilter.h .15095-linux-2.5.73-bk1.updated/include/linux/netfilter.h
--- .15095-linux-2.5.73-bk1/include/linux/netfilter.h	2003-05-05 12:37:12.000000000 +1000
+++ .15095-linux-2.5.73-bk1.updated/include/linux/netfilter.h	2003-06-24 12:19:07.000000000 +1000
@@ -9,6 +9,8 @@
 #include <linux/if.h>
 #include <linux/wait.h>
 #include <linux/list.h>
+#include <linux/stringify.h>
+#include <linux/module.h>
 #endif
 
 /* Responses from hook functions. */
@@ -91,6 +93,21 @@ struct nf_info
 int nf_register_hook(struct nf_hook_ops *reg);
 void nf_unregister_hook(struct nf_hook_ops *reg);
 
+/* Automatically register/unregister */
+#define module_nf_hook(_prio, _hookfn, _pf, _hooknum, _hookprio)	     \
+ static struct nf_hook_ops __cat(nf_hook, _hookfn)			     \
+ = { .hook=_hookfn, .owner=THIS_MODULE, .pf=_pf, .hooknum=_hooknum,	     \
+     .priority=_hookprio }; 						     \
+ static int __init __cat(nfh_reg, _hookfn)(void)			     \
+ {									     \
+ 	return nf_register_hook(&__cat(nf_hook, _hookfn));		     \
+ }									     \
+ static void __init __cat(nfh_unreg, _hookfn)(void)			     \
+ {									     \
+ 	nf_unregister_hook(&__cat(nf_hook, _hookfn));			     \
+ }									     \
+ module_init_exit(_prio, __cat(nfh_reg, _hookfn), __cat(nfh_unreg, _hookfn))
+
 /* Functions to register get/setsockopt ranges (non-inclusive).  You
    need to check permissions yourself! */
 int nf_register_sockopt(struct nf_sockopt_ops *reg);
@@ -163,6 +180,10 @@ extern void nf_invalidate_cache(int pf);
 
 #else /* !CONFIG_NETFILTER */
 #define NF_HOOK(pf, hook, skb, indev, outdev, okfn) (okfn)(skb)
+
+/* Just check type and suppress unused message. */
+#define module_nf_hook(prio, hookfn, pf, hooknum, hookprio)	\
+static inline nf_hookfn *__unique_id(hookfn) { return hookfn; }
 #endif /*CONFIG_NETFILTER*/
 
 #endif /*__KERNEL__*/
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15095-linux-2.5.73-bk1/include/linux/proc_fs.h .15095-linux-2.5.73-bk1.updated/include/linux/proc_fs.h
--- .15095-linux-2.5.73-bk1/include/linux/proc_fs.h	2003-06-15 11:30:09.000000000 +1000
+++ .15095-linux-2.5.73-bk1.updated/include/linux/proc_fs.h	2003-06-24 12:19:07.000000000 +1000
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
+#include <linux/init.h>
 #include <asm/atomic.h>
 
 /*
@@ -191,6 +192,20 @@ static inline void proc_net_remove(const
 extern void kclist_add(struct kcore_list *, void *, size_t);
 extern struct kcore_list *kclist_del(void *);
 
+#define module_proc_net(prio, name, fn)					     \
+static int __cat(_proc_net_init,fn)(void)				     \
+{									     \
+	struct proc_dir_entry *proc = proc_net_create(name, 0, fn);	     \
+	if (!proc)							     \
+		return -EINVAL;						     \
+	proc->owner = THIS_MODULE;					     \
+	return 0;							     \
+}									     \
+static void __cat(_proc_net_exit,fn)(void)				     \
+{									     \
+	proc_net_remove(name);						     \
+}									     \
+module_init_exit(prio, __cat(_proc_net_init,fn), __cat(_proc_net_exit,fn))
 #else
 
 #define proc_root_driver NULL
@@ -236,6 +251,10 @@ static inline struct kcore_list * kclist
 	return NULL;
 }
 
+/* Check type and stop gcc from complaining about unused function, but
+ * allow gcc 3.3+ to discard it. */
+#define module_proc_net(prio, name, fn)     \
+static inline get_info_t *__unique_id(test_fntype)(void) { return fn; }
 #endif /* CONFIG_PROC_FS */
 
 struct proc_inode {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15095-linux-2.5.73-bk1/net/ipv4/Makefile .15095-linux-2.5.73-bk1.updated/net/ipv4/Makefile
--- .15095-linux-2.5.73-bk1/net/ipv4/Makefile	2003-06-15 11:30:12.000000000 +1000
+++ .15095-linux-2.5.73-bk1.updated/net/ipv4/Makefile	2003-06-24 12:19:07.000000000 +1000
@@ -23,3 +23,4 @@ obj-$(CONFIG_IP_PNP) += ipconfig.o
 obj-$(CONFIG_NETFILTER)	+= netfilter/
 
 obj-y += xfrm4_policy.o xfrm4_state.o xfrm4_input.o xfrm4_tunnel.o
+obj-m += foo.o
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15095-linux-2.5.73-bk1/net/ipv4/foo.c .15095-linux-2.5.73-bk1.updated/net/ipv4/foo.c
--- .15095-linux-2.5.73-bk1/net/ipv4/foo.c	1970-01-01 10:00:00.000000000 +1000
+++ .15095-linux-2.5.73-bk1.updated/net/ipv4/foo.c	2003-06-24 16:45:38.000000000 +1000
@@ -0,0 +1,42 @@
+#include <linux/types.h>
+#include <linux/ip.h>
+#include <linux/netfilter.h>
+#include <linux/netfilter_ipv4.h>
+#include <linux/init.h>
+#include <linux/moduleparam.h>
+
+static int fail_hook;
+module_param(fail_hook, int, 0);
+
+#define HOOK(n) 				\
+static int init##n(void)			\
+{						\
+	printk("foo: init %u\n", n);		\
+	if (n == fail_hook)			\
+		return -EINVAL;			\
+	return 0;				\
+}						\
+static void fini##n(void)			\
+{						\
+	printk("foo: fini %u\n", n);		\
+}						\
+module_init_exit(-n, init##n, fini##n)
+
+HOOK(5);
+HOOK(1);
+HOOK(2);
+HOOK(3);
+HOOK(4);
+HOOK(6);
+
+/* Old-style... */
+int init_module(void)
+{
+	printk("foo: init module\n");
+	return 0;
+}
+
+void cleanup_module(void)
+{
+	printk("foo: cleanup module\n");
+}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15095-linux-2.5.73-bk1/net/ipv4/netfilter/ip_conntrack_standalone.c .15095-linux-2.5.73-bk1.updated/net/ipv4/netfilter/ip_conntrack_standalone.c
--- .15095-linux-2.5.73-bk1/net/ipv4/netfilter/ip_conntrack_standalone.c	2003-05-05 12:37:14.000000000 +1000
+++ .15095-linux-2.5.73-bk1.updated/net/ipv4/netfilter/ip_conntrack_standalone.c	2003-06-24 12:19:07.000000000 +1000
@@ -223,95 +223,6 @@ static unsigned int ip_conntrack_local(u
 	return ip_conntrack_in(hooknum, pskb, in, out, okfn);
 }
 
-/* Connection tracking may drop packets, but never alters them, so
-   make it the first hook. */
-static struct nf_hook_ops ip_conntrack_in_ops = {
-	.hook		= ip_conntrack_in,
-	.owner		= THIS_MODULE,
-	.pf		= PF_INET,
-	.hooknum	= NF_IP_PRE_ROUTING,
-	.priority	= NF_IP_PRI_CONNTRACK,
-};
-
-static struct nf_hook_ops ip_conntrack_local_out_ops = {
-	.hook		= ip_conntrack_local,
-	.owner		= THIS_MODULE,
-	.pf		= PF_INET,
-	.hooknum	= NF_IP_LOCAL_OUT,
-	.priority	= NF_IP_PRI_CONNTRACK,
-};
-
-/* Refragmenter; last chance. */
-static struct nf_hook_ops ip_conntrack_out_ops = {
-	.hook		= ip_refrag,
-	.owner		= THIS_MODULE,
-	.pf		= PF_INET,
-	.hooknum	= NF_IP_POST_ROUTING,
-	.priority	= NF_IP_PRI_LAST,
-};
-
-static struct nf_hook_ops ip_conntrack_local_in_ops = {
-	.hook		= ip_confirm,
-	.owner		= THIS_MODULE,
-	.pf		= PF_INET,
-	.hooknum	= NF_IP_LOCAL_IN,
-	.priority	= NF_IP_PRI_LAST-1,
-};
-
-static int init_or_cleanup(int init)
-{
-	struct proc_dir_entry *proc;
-	int ret = 0;
-
-	if (!init) goto cleanup;
-
-	ret = ip_conntrack_init();
-	if (ret < 0)
-		goto cleanup_nothing;
-
-	proc = proc_net_create("ip_conntrack",0,list_conntracks);
-	if (!proc) goto cleanup_init;
-	proc->owner = THIS_MODULE;
-
-	ret = nf_register_hook(&ip_conntrack_in_ops);
-	if (ret < 0) {
-		printk("ip_conntrack: can't register pre-routing hook.\n");
-		goto cleanup_proc;
-	}
-	ret = nf_register_hook(&ip_conntrack_local_out_ops);
-	if (ret < 0) {
-		printk("ip_conntrack: can't register local out hook.\n");
-		goto cleanup_inops;
-	}
-	ret = nf_register_hook(&ip_conntrack_out_ops);
-	if (ret < 0) {
-		printk("ip_conntrack: can't register post-routing hook.\n");
-		goto cleanup_inandlocalops;
-	}
-	ret = nf_register_hook(&ip_conntrack_local_in_ops);
-	if (ret < 0) {
-		printk("ip_conntrack: can't register local in hook.\n");
-		goto cleanup_inoutandlocalops;
-	}
-
-	return ret;
-
- cleanup:
-	nf_unregister_hook(&ip_conntrack_local_in_ops);
- cleanup_inoutandlocalops:
-	nf_unregister_hook(&ip_conntrack_out_ops);
- cleanup_inandlocalops:
-	nf_unregister_hook(&ip_conntrack_local_out_ops);
- cleanup_inops:
-	nf_unregister_hook(&ip_conntrack_in_ops);
- cleanup_proc:
-	proc_net_remove("ip_conntrack");
- cleanup_init:
-	ip_conntrack_cleanup();
- cleanup_nothing:
-	return ret;
-}
-
 /* FIXME: Allow NULL functions and sub in pointers to generic for
    them. --RR */
 int ip_conntrack_protocol_register(struct ip_conntrack_protocol *proto)
@@ -351,25 +262,26 @@ void ip_conntrack_protocol_unregister(st
 	ip_ct_selective_cleanup(kill_proto, &proto->proto);
 }
 
-static int __init init(void)
-{
-	return init_or_cleanup(1);
-}
-
-static void __exit fini(void)
-{
-	init_or_cleanup(0);
-}
-
-module_init(init);
-module_exit(fini);
-
 /* Some modules need us, but don't depend directly on any symbol.
    They should call this. */
 void need_ip_conntrack(void)
 {
 }
 
+module_init_exit(-1, ip_conntrack_init, ip_conntrack_cleanup);
+module_proc_net(0, "ip_conntrack", list_conntracks);
+
+/* Connection tracking may drop packets, but never alters them, so
+   make it the first hook. */
+module_nf_hook(0, ip_conntrack_in, PF_INET, NF_IP_PRE_ROUTING,
+	       NF_IP_PRI_CONNTRACK);
+module_nf_hook(0, ip_conntrack_local, PF_INET, NF_IP_LOCAL_OUT,
+	       NF_IP_PRI_CONNTRACK);
+module_nf_hook(0, ip_confirm, PF_INET, NF_IP_LOCAL_IN, NF_IP_PRI_LAST-1);
+
+/* Refragmenter; last chance. */
+module_nf_hook(0, ip_refrag, PF_INET, NF_IP_POST_ROUTING, NF_IP_PRI_LAST);
+
 EXPORT_SYMBOL(ip_conntrack_protocol_register);
 EXPORT_SYMBOL(ip_conntrack_protocol_unregister);
 EXPORT_SYMBOL(invert_tuplepr);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15095-linux-2.5.73-bk1/net/ipv4/netfilter/ip_tables.c .15095-linux-2.5.73-bk1.updated/net/ipv4/netfilter/ip_tables.c
--- .15095-linux-2.5.73-bk1/net/ipv4/netfilter/ip_tables.c	2003-05-27 15:02:26.000000000 +1000
+++ .15095-linux-2.5.73-bk1.updated/net/ipv4/netfilter/ip_tables.c	2003-06-24 12:19:07.000000000 +1000
@@ -1702,7 +1702,6 @@ static struct ipt_match icmp_matchstruct
 	.checkentry	= &icmp_checkentry,
 };
 
-#ifdef CONFIG_PROC_FS
 static inline int print_name(const struct ipt_table *t,
 			     off_t start_offset, char *buffer, int length,
 			     off_t *pos, unsigned int *count)
@@ -1737,13 +1736,13 @@ static int ipt_get_tables(char *buffer, 
 	*start=(char *)((unsigned long)count-offset);
 	return pos;
 }
-#endif /*CONFIG_PROC_FS*/
+
+module_proc_net(-1, "ip_tables_names", ipt_get_tables);
 
 static int __init init(void)
 {
 	int ret;
 
-	/* Noone else will be downing sem now, so we won't sleep */
 	down(&ipt_mutex);
 	list_append(&ipt_target, &ipt_standard_target);
 	list_append(&ipt_target, &ipt_error_target);
@@ -1759,19 +1758,6 @@ static int __init init(void)
 		return ret;
 	}
 
-#ifdef CONFIG_PROC_FS
-	{
-	struct proc_dir_entry *proc;
-
-	proc = proc_net_create("ip_tables_names", 0, ipt_get_tables);
-	if (!proc) {
-		nf_unregister_sockopt(&ipt_sockopts);
-		return -ENOMEM;
-	}
-	proc->owner = THIS_MODULE;
-	}
-#endif
-
 	printk("ip_tables: (C) 2000-2002 Netfilter core team\n");
 	return 0;
 }
@@ -1779,9 +1765,6 @@ static int __init init(void)
 static void __exit fini(void)
 {
 	nf_unregister_sockopt(&ipt_sockopts);
-#ifdef CONFIG_PROC_FS
-	proc_net_remove("ip_tables_names");
-#endif
 }
 
 EXPORT_SYMBOL(ipt_register_table);
