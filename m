Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQJ1NPr>; Sat, 28 Oct 2000 09:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129435AbQJ1NPi>; Sat, 28 Oct 2000 09:15:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8722 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129210AbQJ1NPe>;
	Sat, 28 Oct 2000 09:15:34 -0400
Date: Sat, 28 Oct 2000 14:15:18 +0100
From: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Patrick van de Lageweg <patrick@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PROPOSED PATCH] ATM refcount + firestream
Message-ID: <20001028141518.A2272@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <Pine.LNX.4.21.0010270945510.13233-200000@panoramix.bitwizard.nl> <39F96BE1.B9C97C20@uow.edu.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <39F96BE1.B9C97C20@uow.edu.au>; from andrewm@uow.edu.au on Fri, Oct 27, 2000 at 10:49:53PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 27, 2000 at 10:49:53PM +1100, Andrew Morton wrote:
> Look, this modules stuff is really bad.  Phillip Rumpf proposed
> a radical alternative a while back which I felt was not given

While it might be a "radical alternative", it doesn't require any changes
to the subsystems that have been fixed so far.  At this time, applying the
patch would basically fix the rest of the subsystems as well (if the
drivers use MOD_{INC,DEC}_USE_COUNT, that is).

> sufficient consideration.  The idea was to make sys_delete_module()
> grab all the other CPUs and leave them spinning on a flag while
> the unload was proceeding.  This was very similar to
> arch/i386/kernel/apm.c:apm_power_off().

The idea here is other CPUs don't have to deal with the kernel going
through a number of inconsistent states while a module is unloaded.  At
any point in time, for any module, exactly one of the following is true:

1. you're in the module_exit function
2. the module is (being) loaded
3. the module isn't loaded.

> As far as I can recall, the only restriction was that you are
> not allowed to call module functions when the module refcount
> is zero if those functions can call schedule().

There are other restrictions which shouldn't really matter:

 - you can't schedule() and hope you end up on a particular CPU (you can
use smp_call_function though)

 - you can't copy_(from|to)_user in the module exit function (which would
be copies from/to rmmod anyway)

> prumpf, please dig out that patch.

attached (rediff against test10-pre6, it seems to work).

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=freeze-diff-09

diff -urN linux/arch/i386/mm/extable.c linux-prumpf/arch/i386/mm/extable.c
--- linux/arch/i386/mm/extable.c	Wed Nov 10 08:31:37 1999
+++ linux-prumpf/arch/i386/mm/extable.c	Sat Oct 28 06:14:43 2000
@@ -30,26 +30,30 @@
         return 0;
 }
 
+extern struct rw_semaphore module_mutex;
+
 unsigned long
 search_exception_table(unsigned long addr)
 {
-	unsigned long ret;
+	unsigned long ret = 0;
 
 #ifndef CONFIG_MODULES
 	/* There is only the kernel to search.  */
 	ret = search_one_table(__start___ex_table, __stop___ex_table-1, addr);
-	if (ret) return ret;
 #else
 	/* The kernel is the last "module" -- no need to treat it special.  */
 	struct module *mp;
+
+	down_read(&module_mutex);
 	for (mp = module_list; mp != NULL; mp = mp->next) {
 		if (mp->ex_table_start == NULL)
 			continue;
 		ret = search_one_table(mp->ex_table_start,
 				       mp->ex_table_end - 1, addr);
-		if (ret) return ret;
+		if (ret) break;
 	}
+	up_read(&module_mutex);
 #endif
 
-	return 0;
+	return ret;
 }
diff -urN linux/include/linux/smp.h linux-prumpf/include/linux/smp.h
--- linux/include/linux/smp.h	Tue Sep 26 14:31:51 2000
+++ linux-prumpf/include/linux/smp.h	Sat Oct 28 06:14:43 2000
@@ -71,6 +71,9 @@
 #define MSG_RESCHEDULE		0x0003	/* Reschedule request from master CPU*/
 #define MSG_CALL_FUNCTION       0x0004  /* Call function on all other CPUs */
 
+extern int freeze_other_cpus(void);
+extern void melt_other_cpus(void);
+
 #else
 
 /*
@@ -86,6 +89,8 @@
 #define cpu_number_map(cpu)			0
 #define smp_call_function(func,info,retry,wait)	({ 0; })
 #define cpu_online_map				1
+#define freeze_other_cpus()			0
+#define melt_other_cpus()			do { } while(0)
 
 #endif
 #endif
diff -urN linux/kernel/module.c linux-prumpf/kernel/module.c
--- linux/kernel/module.c	Sat Oct 28 05:03:26 2000
+++ linux-prumpf/kernel/module.c	Sat Oct 28 06:14:43 2000
@@ -37,6 +37,11 @@
 	ex_table_end:		__stop___ex_table
 };
 
+/* module_mutex protects module_list - if you can down_read() it, modules
+ * won't be added/removed, but their usecount, flags aso still might change.
+ */
+
+DECLARE_RWSEM(module_mutex);
 struct module *module_list = &kernel_module;
 
 static long get_mod_name(const char *user_name, char **buf);
@@ -105,7 +110,6 @@
 
 	if (!capable(CAP_SYS_MODULE))
 		return -EPERM;
-	lock_kernel();
 	if ((namelen = get_mod_name(name_user, &name)) < 0) {
 		error = namelen;
 		goto err0;
@@ -114,32 +118,40 @@
 		error = -EINVAL;
 		goto err1;
 	}
+	lock_kernel();
+	down_write(&module_mutex);
 	if (find_module(name) != NULL) {
 		error = -EEXIST;
-		goto err1;
+		goto err2;
 	}
 	if ((mod = (struct module *)module_map(size)) == NULL) {
 		error = -ENOMEM;
-		goto err1;
+		goto err2;
 	}
 
 	memset(mod, 0, sizeof(*mod));
 	mod->size_of_struct = sizeof(*mod);
-	mod->next = module_list;
 	mod->name = (char *)(mod + 1);
 	mod->size = size;
 	memcpy((char*)(mod+1), name, namelen+1);
 
 	put_mod_name(name);
 
+	mod->next = module_list;
 	module_list = mod;	/* link it in */
 
 	error = (long) mod;
+
+	up_write(&module_mutex);
+	unlock_kernel();
+
 	goto err0;
+err2:
+	up_write(&module_mutex);
+	unlock_kernel();
 err1:
 	put_mod_name(name);
 err0:
-	unlock_kernel();
 	return error;
 }
 
@@ -159,6 +171,7 @@
 	if (!capable(CAP_SYS_MODULE))
 		return -EPERM;
 	lock_kernel();
+	down_read(&module_mutex);
 	if ((namelen = get_mod_name(name_user, &name)) < 0) {
 		error = namelen;
 		goto err0;
@@ -338,6 +351,7 @@
 err1:
 	put_mod_name(name);
 err0:
+	up_read(&module_mutex);
 	unlock_kernel();
 	return error;
 }
@@ -345,16 +359,10 @@
 static spinlock_t unload_lock = SPIN_LOCK_UNLOCKED;
 int try_inc_mod_count(struct module *mod)
 {
-	int res = 1;
-	if (mod) {
-		spin_lock(&unload_lock);
-		if (mod->flags & MOD_DELETED)
-			res = 0;
-		else
-			__MOD_INC_USE_COUNT(mod);
-		spin_unlock(&unload_lock);
-	}
-	return res;
+	if (mod)
+		__MOD_INC_USE_COUNT(mod);
+	
+	return 1;
 }
 
 asmlinkage long
@@ -368,10 +376,12 @@
 	if (!capable(CAP_SYS_MODULE))
 		return -EPERM;
 
+	if ((error = get_mod_name(name_user, &name)) < 0)
+		return error;
+
 	lock_kernel();
+	down_write(&module_mutex);
 	if (name_user) {
-		if ((error = get_mod_name(name_user, &name)) < 0)
-			goto out;
 		if (error == 0) {
 			error = -EINVAL;
 			put_mod_name(name);
@@ -391,7 +401,11 @@
  		if (!__MOD_IN_USE(mod)) {
 			mod->flags |= MOD_DELETED;
 			spin_unlock(&unload_lock);
-			free_module(mod, 0);
+			error = freeze_other_cpus();
+			if(error == 0) {
+				free_module(mod, 0);
+				melt_other_cpus();
+			}
 			error = 0;
 		} else {
 			spin_unlock(&unload_lock);
@@ -418,7 +432,10 @@
 			} else {
 				mod->flags |= MOD_DELETED;
 				spin_unlock(&unload_lock);
-				free_module(mod, 1);
+				if(freeze_other_cpus() == 0) {
+					free_module(mod, 1);
+					melt_other_cpus();
+				}
 				something_changed = 1;
 			}
 		} else {
@@ -431,6 +448,7 @@
 		mod->flags &= ~MOD_JUST_FREED;
 	error = 0;
 out:
+	up_write(&module_mutex);
 	unlock_kernel();
 	return error;
 }
@@ -653,6 +671,7 @@
 	int err;
 
 	lock_kernel();
+	down_read(&module_mutex);
 	if (name_user == NULL)
 		mod = &kernel_module;
 	else {
@@ -698,6 +717,7 @@
 		break;
 	}
 out:
+	up_read(&module_mutex);
 	unlock_kernel();
 	return err;
 }
@@ -718,6 +738,7 @@
 	struct kernel_sym ksym;
 
 	lock_kernel();
+	down_read(&module_mutex);
 	for (mod = module_list, i = 0; mod; mod = mod->next) {
 		/* include the count for the module name! */
 		i += mod->nsyms + 1;
@@ -760,6 +781,7 @@
 		}
 	}
 out:
+	up_read(&module_mutex);
 	unlock_kernel();
 	return i;
 }
@@ -840,6 +862,8 @@
 	char tmpstr[64];
 	struct module_ref *ref;
 
+	down_read(&module_mutex);
+
 	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
 		long len;
 		const char *q;
@@ -906,8 +930,9 @@
 #undef safe_copy_str
 #undef safe_copy_cstr
 	}
-
 fini:
+	up_read(&module_mutex);
+
 	return PAGE_SIZE - left;
 }
 
@@ -924,6 +949,7 @@
 	off_t pos   = 0;
 	off_t begin = 0;
 
+	down_read(&module_mutex);
 	for (mod = module_list; mod; mod = mod->next) {
 		unsigned i;
 		struct module_symbol *sym;
@@ -958,6 +984,7 @@
 	len -= (offset - begin);
 	if (len > length)
 		len = length;
+	up_read(&module_mutex);
 	return len;
 }
 
@@ -1002,7 +1029,9 @@
 void put_module_symbol(unsigned long addr)
 {
 	struct module *mp;
-
+	
+	/* XXX: safe to sleep here ? */
+	down_read(&module_mutex);
 	for (mp = module_list; mp; mp = mp->next) {
 		if (MOD_CAN_QUERY(mp) &&
 		    addr >= (unsigned long)mp &&
@@ -1011,6 +1040,7 @@
 			return;
 		}
 	}
+	up_read(&module_mutex);
 }
 
 #else		/* CONFIG_MODULES */
diff -urN linux/lib/Makefile linux-prumpf/lib/Makefile
--- linux/lib/Makefile	Wed Jul 12 21:33:38 2000
+++ linux-prumpf/lib/Makefile	Sat Oct 28 06:14:43 2000
@@ -14,4 +14,8 @@
   L_OBJS += dec_and_lock.o
 endif
 
+ifeq ($(CONFIG_SMP),y)
+  L_OBJS += freeze.o
+endif
+
 include $(TOPDIR)/Rules.make
diff -urN linux/lib/freeze.c linux-prumpf/lib/freeze.c
--- linux/lib/freeze.c	Wed Dec 31 16:00:00 1969
+++ linux-prumpf/lib/freeze.c	Sat Oct 28 06:14:43 2000
@@ -0,0 +1,64 @@
+/* Currently, those functions are only used for module unloading.  I put them
+ * here as they might be useful for other people and would introduce
+ * unnecessary noise in module.c */
+#include <asm/atomic.h>
+#include <asm/errno.h>
+#include <asm/processor.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <linux/delay.h>
+
+static atomic_t freeze_count = ATOMIC_INIT(0);
+static volatile int ice_block;
+static spinlock_t freeze_lock = SPIN_LOCK_UNLOCKED;
+
+static int
+antarctica(void *unused)
+{
+	atomic_inc(&freeze_count);
+	while (ice_block)
+		;
+	atomic_dec(&freeze_count);
+	return 0;
+}
+
+int freeze_other_cpus(void)
+{
+	int cpu, retval;
+	/* wait up to one tick */
+	long timeout = 1000000 / HZ;
+
+	/* If you reenter this code, you're seriously fucked */
+	if (!spin_trylock(&freeze_lock))
+		return -EAGAIN;
+
+	ice_block = 1;
+	wmb();
+	for (cpu = 0; cpu < smp_num_cpus - 1; cpu++) {
+		retval = kernel_thread(antarctica, (void *)0, 0);
+		if (retval < 0)
+			goto out_melt;
+	}
+
+	while(atomic_read(&freeze_count) != smp_num_cpus - 1) {
+		if (--timeout == 0) {
+			retval = -ETIMEDOUT;
+			goto out_melt;
+		}
+		udelay(1);
+	}
+
+	return 0;
+out_melt:
+	ice_block = 0;
+	spin_unlock(&freeze_lock);
+	return retval;
+}
+
+void melt_other_cpus(void)
+{
+	ice_block = 0;
+	while(atomic_read(&freeze_count) != 0); /* this is paranoia */
+	spin_unlock(&freeze_lock);
+}

--WIyZ46R2i8wDzkSu--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
