Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154973AbPKRAGU>; Wed, 17 Nov 1999 19:06:20 -0500
Received: by vger.rutgers.edu id <S154258AbPKRAGA>; Wed, 17 Nov 1999 19:06:00 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:12313 "EHLO sgi.com") by vger.rutgers.edu with ESMTP id <S155080AbPKRAFn>; Wed, 17 Nov 1999 19:05:43 -0500
Date: Wed, 17 Nov 1999 16:05:35 -0800
From: Dimitris Michailidis <dimitris@darkside.engr.sgi.com>
Message-Id: <199911180005.QAA03724@darkside.engr.sgi.com>
To: linux-kernel@vger.rutgers.edu
Subject: [PATCH] kernel profiling driver/module
Cc: dimitris@cthulhu.engr.sgi.com
Sender: owner-linux-kernel@vger.rutgers.edu

This patch against 2.3.26 turns profiling into a module and adds a profile 
driver with associated ioctls for controlling the profiling facilities.  The
benefit of having this as a module is that one can profile a running kernel
(presently profile is a boot option) and allows profiling to be turned off
so that it doesn't waste resources when not needed.

This version provides just timer-based PC sampling profiling, similar to
what is now in Linux (however, it includes user and idle time in the profile).
In the near future this module will be expanded to provide additional
facilities such as call graphs and sampling driven by the performance 
monitoring counters.

Comments, suggestions, wishes welcome.

---
Dimitris Michailidis		dimitris@engr.sgi.com

diff -rcP linux-2.3.26.orig/arch/i386/kernel/i386_ksyms.c linux-2.3.26/arch/i386/kernel/i386_ksyms.c
*** linux-2.3.26.orig/arch/i386/kernel/i386_ksyms.c	Mon Nov  1 13:28:43 1999
--- linux-2.3.26/arch/i386/kernel/i386_ksyms.c	Tue Nov 16 17:13:56 1999
***************
*** 105,110 ****
--- 105,115 ----
  EXPORT_SYMBOL(__global_save_flags);
  EXPORT_SYMBOL(__global_restore_flags);
  EXPORT_SYMBOL(smp_call_function);
+ 
+ #if defined(CONFIG_PROFILING) || defined(CONFIG_PROFILING_MODULE)
+ EXPORT_SYMBOL(prof_multiplier);
+ EXPORT_SYMBOL(setup_profiling_timer);
+ #endif
  #endif
  
  #ifdef CONFIG_MCA
diff -rcP linux-2.3.26.orig/arch/i386/kernel/smp.c linux-2.3.26/arch/i386/kernel/smp.c
*** linux-2.3.26.orig/arch/i386/kernel/smp.c	Thu Oct  7 10:17:08 1999
--- linux-2.3.26/arch/i386/kernel/smp.c	Tue Nov 16 17:01:51 1999
***************
*** 15,20 ****
--- 15,21 ----
  #include <linux/kernel_stat.h>
  #include <linux/smp_lock.h>
  #include <linux/irq.h>
+ #include <linux/profile.h>
  
  #include <linux/delay.h>
  #include <linux/mc146818rtc.h>
***************
*** 586,603 ****
  }
  
  /*
!  * This part sets up the APIC 32 bit clock in LVTT1, with HZ interrupts
   * per second. We assume that the caller has already set up the local
   * APIC.
   *
!  * The APIC timer is not exactly sync with the external timer chip, it
   * closely follows bus clocks.
   */
  
- int prof_multiplier[NR_CPUS] = { 1, };
- int prof_old_multiplier[NR_CPUS] = { 1, };
- int prof_counter[NR_CPUS] = { 1, };
- 
  /*
   * The timer chip is already set up at HZ interrupts per second here,
   * but we do not accept timer interrupts yet. We only allow the BP
--- 587,600 ----
  }
  
  /*
!  * This part sets up the APIC 32-bit clock in LVTT1, with HZ interrupts
   * per second. We assume that the caller has already set up the local
   * APIC.
   *
!  * The APIC timer is not exactly in sync with the external timer chip, it
   * closely follows bus clocks.
   */
  
  /*
   * The timer chip is already set up at HZ interrupts per second here,
   * but we do not accept timer interrupts yet. We only allow the BP
***************
*** 810,818 ****
  	__restore_flags(flags);
  }
  
  /*
!  * the frequency of the profiling timer can be changed
!  * by writing a multiplier value into /proc/profile.
   */
  int setup_profiling_timer(unsigned int multiplier)
  {
--- 807,823 ----
  	__restore_flags(flags);
  }
  
+ #undef APIC_DIVISOR
+ 
+ #if defined(CONFIG_PROFILING) || defined(CONFIG_PROFILING_MODULE)
+ 
+ int prof_multiplier[NR_CPUS] = { [0 ... NR_CPUS - 1] = 1 };
+ int prof_old_multiplier[NR_CPUS] = { [0 ... NR_CPUS - 1] = 1 };
+ int prof_counter[NR_CPUS] = { [0 ... NR_CPUS - 1] = 1 };
+ 
  /*
!  * Change the frequency of the profiling timer.  The multiplier is specified
!  * by an appropriate ioctl() on /dev/profile.
   */
  int setup_profiling_timer(unsigned int multiplier)
  {
***************
*** 837,844 ****
  
  	return 0;
  }
! 
! #undef APIC_DIVISOR
  
  /*
   * Local timer interrupt handler. It does both profiling and
--- 842,848 ----
  
  	return 0;
  }
! #endif
  
  /*
   * Local timer interrupt handler. It does both profiling and
***************
*** 855,873 ****
  	int user = (user_mode(regs) != 0);
  	int cpu = smp_processor_id();
  
! 	/*
! 	 * The profiling function is SMP safe. (nothing can mess
! 	 * around with "current", and the profiling counters are
! 	 * updated with atomic operations). This is especially
! 	 * useful with a profiling multiplier != 1
! 	 */
! 	if (!user)
! 		x86_do_profile(regs->eip);
  
! 	if (--prof_counter[cpu] <= 0) {
  		int system = 1 - user;
  		struct task_struct * p = current;
  
  		/*
  		 * The multiplier may have changed since the last time we got
  		 * to this point as a result of the user writing to
--- 859,877 ----
  	int user = (user_mode(regs) != 0);
  	int cpu = smp_processor_id();
  
! #if defined(CONFIG_PROFILING) || defined(CONFIG_PROFILING_MODULE)
! 	prof_hook_p prof_hook = prof_timer_hook;
! 	
! 	if (prof_hook)
! 		prof_hook(regs);
  
! 	if (--prof_counter[cpu] <= 0)
! #endif
! 	{
  		int system = 1 - user;
  		struct task_struct * p = current;
  
+ #if defined(CONFIG_PROFILING) || defined(CONFIG_PROFILING_MODULE)
  		/*
  		 * The multiplier may have changed since the last time we got
  		 * to this point as a result of the user writing to
***************
*** 881,886 ****
--- 885,891 ----
  			__setup_APIC_LVTT(calibration_result/prof_counter[cpu]);
  			prof_old_multiplier[cpu] = prof_counter[cpu];
  		}
+ #endif
  
  		/*
  		 * After doing the above, we need to make like
***************
*** 947,950 ****
  	ack_APIC_irq();
  	smp_local_timer_interrupt(regs);
  }
- 
--- 952,954 ----
diff -rcP linux-2.3.26.orig/arch/i386/kernel/smpboot.c linux-2.3.26/arch/i386/kernel/smpboot.c
*** linux-2.3.26.orig/arch/i386/kernel/smpboot.c	Wed Oct 27 18:40:00 1999
--- linux-2.3.26/arch/i386/kernel/smpboot.c	Thu Nov 11 17:21:26 1999
***************
*** 1415,1424 ****
   * Cycle through the processors sending APIC IPIs to boot each.
   */
  
- extern int prof_multiplier[NR_CPUS];
- extern int prof_old_multiplier[NR_CPUS];
- extern int prof_counter[NR_CPUS];
- 
  void __init smp_boot_cpus(void)
  {
  	int i;
--- 1415,1420 ----
***************
*** 1429,1443 ****
  #endif
  	/*
  	 * Initialize the logical to physical CPU number mapping
- 	 * and the per-CPU profiling counter/multiplier
  	 */
  
! 	for (i = 0; i < NR_CPUS; i++) {
  		cpu_number_map[i] = -1;
- 		prof_counter[i] = 1;
- 		prof_old_multiplier[i] = 1;
- 		prof_multiplier[i] = 1;
- 	}
  
  	/*
  	 * Setup boot CPU information
--- 1425,1434 ----
  #endif
  	/*
  	 * Initialize the logical to physical CPU number mapping
  	 */
  
! 	for (i = 0; i < NR_CPUS; i++)
  		cpu_number_map[i] = -1;
  
  	/*
  	 * Setup boot CPU information
diff -rcP linux-2.3.26.orig/arch/i386/kernel/time.c linux-2.3.26/arch/i386/kernel/time.c
*** linux-2.3.26.orig/arch/i386/kernel/time.c	Thu Oct  7 10:17:08 1999
--- linux-2.3.26/arch/i386/kernel/time.c	Tue Nov 16 17:02:27 1999
***************
*** 41,46 ****
--- 41,47 ----
  #include <linux/delay.h>
  #include <linux/init.h>
  #include <linux/smp.h>
+ #include <linux/profile.h>
  
  #include <asm/processor.h>
  #include <asm/uaccess.h>
***************
*** 56,67 ****
  #include <asm/fixmap.h>
  #include <asm/cobalt.h>
  
- /*
-  * for x86_do_profile()
-  */
- #include <linux/irq.h>
- 
- 
  unsigned long cpu_hz;	/* Detected as we calibrate the TSC */
  
  /* Number of usecs that the last interrupt was delayed */
--- 57,62 ----
***************
*** 370,377 ****
   * system, in that case we have to call the local interrupt handler.
   */
  #ifndef __SMP__
! 	if (!user_mode(regs))
! 		x86_do_profile(regs->eip);
  #else
  	if (!smp_found_config)
  		smp_local_timer_interrupt(regs);
--- 365,374 ----
   * system, in that case we have to call the local interrupt handler.
   */
  #ifndef __SMP__
! #if defined(CONFIG_PROFILING) || defined(CONFIG_PROFILING_MODULE)
! 	if (prof_timer_hook)
! 		prof_timer_hook(regs);
! #endif
  #else
  	if (!smp_found_config)
  		smp_local_timer_interrupt(regs);
diff -rcP linux-2.3.26.orig/drivers/char/Config.in linux-2.3.26/drivers/char/Config.in
*** linux-2.3.26.orig/drivers/char/Config.in	Fri Oct 29 10:59:17 1999
--- linux-2.3.26/drivers/char/Config.in	Mon Nov 15 13:22:08 1999
***************
*** 96,101 ****
--- 96,103 ----
    dep_tristate '  Include support for Iomega Buz' CONFIG_VIDEO_BUZ $CONFIG_VIDEO_ZORAN
  fi
  
+ tristate 'Kernel Profiling Support' CONFIG_PROFILING
+ 
  bool 'Watchdog Timer Support'	CONFIG_WATCHDOG
  if [ "$CONFIG_WATCHDOG" != "n" ]; then
    mainmenu_option next_comment
diff -rcP linux-2.3.26.orig/drivers/char/Makefile linux-2.3.26/drivers/char/Makefile
*** linux-2.3.26.orig/drivers/char/Makefile	Tue Nov  2 21:35:46 1999
--- linux-2.3.26/drivers/char/Makefile	Mon Nov 15 13:25:31 1999
***************
*** 256,261 ****
--- 256,269 ----
    endif
  endif
  
+ ifeq ($(CONFIG_PROFILING),y)
+ O_OBJS += profile.o
+ else
+   ifeq ($(CONFIG_PROFILING),m)
+   M_OBJS += profile.o
+   endif
+ endif
+ 
  ifeq ($(CONFIG_SOFT_WATCHDOG),y)
  O_OBJS += softdog.o
  else
diff -rcP linux-2.3.26.orig/drivers/char/profile.c linux-2.3.26/drivers/char/profile.c
*** linux-2.3.26.orig/drivers/char/profile.c	Wed Dec 31 16:00:00 1969
--- linux-2.3.26/drivers/char/profile.c	Wed Nov 17 14:52:08 1999
***************
*** 0 ****
--- 1,276 ----
+ /*
+  * linux/drivers/char/profile.c
+  *
+  * Implementation of profiling devices.  We reserve minor number 255 for a 
+  * control interface.  ioctl()s on this device control various profiling
+  * settings. 
+  * 
+  * Written by Dimitris Michailidis (dimitris@engr.sgi.com)
+  */
+ 
+ #include <linux/module.h>
+ #include <linux/profile.h>
+ #include <linux/init.h>
+ #include <linux/fs.h>
+ #include <linux/major.h>
+ #include <linux/proc_fs.h>
+ #include <linux/slab.h>
+ #include <linux/vmalloc.h>
+ #include <linux/smp.h>
+ 
+ #include <asm/uaccess.h>
+ #include <asm/profile.h>
+ 
+ #define PROF_CNTRL_MINOR 255
+ #define DFL_PC_RES 4
+ 
+ int prof_enabled = 0;
+ unsigned int prof_shift, PC_resolution = DFL_PC_RES;
+ unsigned long jiffies_at_stop = 0;
+ 
+ /* This buffer holds PC samples */
+ PC_sample_count_t *PC_sample_buf = NULL;
+ size_t PC_buf_sz;
+ 
+ MODULE_AUTHOR("Dimitris Michailidis");
+ MODULE_DESCRIPTION("Kernel profile driver");
+ 
+ MODULE_PARM(PC_resolution, "i");
+ MODULE_PARM_DESC(PC_resolution, "resolution of PC samples "
+ 		                "(rounded down to a power of 2)");
+ 
+ /* The next few definitions deal with procfs */
+ static ssize_t read_prof_buf(char *prof_buf, char *user_buf, size_t count,
+ 			     loff_t *ppos)
+ {
+ 	if (!prof_buf)
+ 		return -EIO;
+ 	if (*ppos >= PC_buf_sz)
+ 		return 0;
+ 	if (count > PC_buf_sz - *ppos)
+ 		count = PC_buf_sz - *ppos;
+ 	copy_to_user(user_buf, prof_buf + *ppos, count);
+ 	*ppos += count;
+ 	return count;
+ }
+ 
+ static ssize_t read_PC_samples(struct file *file, char *user_buf,
+ 			       size_t count, loff_t *ppos)
+ {
+ 	return read_prof_buf((char *)PC_sample_buf, user_buf, count, ppos);
+ }
+ 
+ static struct file_operations proc_PC_sample_ops = {
+ 	NULL,            /* lseek */
+ 	read_PC_samples,
+ };
+ 
+ static struct inode_operations proc_PC_sample_inode_ops = {
+         &proc_PC_sample_ops,
+ };
+ 
+ /* Clear profiling buffers */
+ static int prof_clear_mem(void)
+ {
+ 	if (!PC_sample_buf)
+ 		return -ENOMEM;
+ 	memset(PC_sample_buf, 0, PC_buf_sz);
+ 	return 0;
+ }
+ 
+ /* Allocate memory for the various profiling buffers.
+  * We are lazy and only do this if we really try to use
+  * the profiling facilities.
+  */
+ static int prof_alloc_mem(void)
+ {
+ 	PC_sample_buf = (PC_sample_count_t *) vmalloc(PC_buf_sz);
+ 	if (PC_sample_buf == NULL)
+ 		return -ENOMEM;
+ 	return prof_clear_mem();
+ }
+ 
+ /* Deallocate profiling buffers */
+ static void prof_free_mem(void)
+ {
+ 	/* vfree() handles NULL pointers */
+ 	vfree(PC_sample_buf);
+ 	PC_sample_buf = NULL;
+ }
+ 
+ /* This function records PC samples.
+  * Typically called from interrupt handlers.  SMP safe.
+  */
+ static void PC_sample(struct pt_regs *regs)
+ {
+ 	unsigned long pc;
+ 
+ 	if (user_mode(regs))
+ 		pc = (unsigned long) &USER;
+ 	else {
+ 		pc = GET_PC_FROM_REGS(regs);
+ 		if (pc >= (unsigned long) &_etext)
+ 			pc = (unsigned long) &IN_MODULE;
+ 	}
+ 	pc -= (unsigned long) &_stext;
+ 	atomic_inc((atomic_t *) &PC_sample_buf[pc >> prof_shift]);
+ }
+ 
+ /* Open a profiling device */
+ static int prof_open(struct inode *inode, struct file *filp)
+ {
+ 	int minor = MINOR(inode->i_rdev);
+ 
+ 	if (minor != PROF_CNTRL_MINOR)    /* no other devices presently */
+ 		return -ENODEV;
+ 
+ 	MOD_INC_USE_COUNT;
+ 	return 0;
+ }
+ 
+ /* close a profiling device */
+ static int prof_release(struct inode *inode, struct file *filp)
+ {
+ 	MOD_DEC_USE_COUNT;
+         return 0;
+ }
+ 
+ /*
+  * ioctl handler for the profile control device.
+  */
+ int prof_ctl_ioctl(struct inode *inode, struct file *filp,
+ 		   unsigned int command, unsigned long arg)
+ {
+ 	int err = 0;
+ 
+ 	switch (command) {
+ 	case PROF_START:
+ 		if (PC_sample_buf == NULL && (err = prof_alloc_mem()))
+ 			return err;
+ 		MOD_INC_USE_COUNT;
+ 		prof_enabled = 1;
+ 		prof_timer_hook = PC_sample;
+ 		break;
+ 	case PROF_STOP:
+ 		prof_timer_hook = NULL;
+ 		jiffies_at_stop = jiffies;
+ 		prof_enabled = 0;
+ 		MOD_DEC_USE_COUNT;
+ 		break;
+ 	case PROF_RESET:
+ 		err = prof_clear_mem();
+ 		break;
+ 	case PROF_SET_SAMPLE_FREQ: {
+ #ifdef __SMP__
+ 		err = setup_profiling_timer(arg / HZ);
+ #else
+ 		err = -EINVAL;
+ #endif
+ 		break;
+ 	}
+ 	case PROF_GET_SAMPLE_FREQ: {
+ 		unsigned int freq = HZ;
+ #ifdef __SMP__
+ 		freq *= prof_multiplier[0];
+ #endif
+ 		err = copy_to_user((void *)arg, &freq, sizeof freq);
+ 		break;
+ 	}
+ 	case PROF_GET_PC_RES:
+ 		err = copy_to_user((void *)arg, &PC_resolution,
+ 				   sizeof PC_resolution);
+ 		break;
+ 	case PROF_GET_ON_OFF_STATE:
+ 		err = copy_to_user((void *)arg, &prof_enabled,
+ 				   sizeof prof_enabled);
+ 		break;
+ 	default:
+ 		err = -EINVAL;
+ 	}
+ 
+ 	return err;
+ }
+ 
+ static struct file_operations prof_ctl_fops = {
+ 	NULL,		/* llseek */
+ 	NULL,		/* read */
+ 	NULL,		/* write */
+ 	NULL,		/* readdir */
+ 	NULL,		/* poll */
+ 	prof_ctl_ioctl,	/* ioctl */
+ 	NULL,		/* mmap */
+ 	prof_open,	/* open */
+ 	NULL,		/* flush */
+ 	prof_release,	/* release */
+ 	NULL		/* fsync */
+ };
+ 
+ #ifndef MODULE
+ static int __init profile_setup(char *str)
+ {
+ 	int res;
+ 
+ 	if (get_option(&str, &res)) PC_resolution = res;
+ 	return 1;
+ }
+ 
+ __setup("profile=", profile_setup);
+ #else
+ static int can_unload(void)
+ {
+ 	int ret = atomic_read(&__this_module.uc.usecount);
+ 
+ 	/* It is conceivable that we may try to delete this module just as 
+ 	 * an interrupt handler is trying to write into a profile buffer.
+ 	 * Since unloading the module frees the buffers that would be
+ 	 * unfortunate.  To avoid such races this module may not be unloaded 
+ 	 * within one second after profiling is turned off.
+ 	 */
+ 	if (jiffies - jiffies_at_stop < HZ)
+ 		ret = 1;
+ 
+ 	return ret;
+ }
+ #endif
+ 
+ static int __init profile_init(void)
+ {
+ 	struct proc_dir_entry *ent;
+ 
+ 	size_t text_size = (size_t) &_etext - (size_t) &_stext;
+ 
+ 	/* round PC_resolution down to a power of 2 and compute its log */
+ 	if (PC_resolution == 0)
+ 		PC_resolution = DFL_PC_RES;
+ 	while ((PC_resolution & (PC_resolution - 1)) != 0)
+ 		PC_resolution &= PC_resolution - 1;
+ 	for (prof_shift = 0; (1 << prof_shift) < PC_resolution; prof_shift++);
+ 	
+ 	PC_buf_sz = (text_size >> prof_shift) * sizeof(PC_sample_count_t);
+ 
+ #ifdef MODULE
+ 	__this_module.can_unload = can_unload;
+ #endif
+ 
+ 	if (!create_proc_entry("profile", S_IFDIR, 0)) {
+ 		printk(KERN_ERR "profile: unable to create /proc entries\n");
+ 		return -ENODEV;
+ 	}
+ 	if ((ent = create_proc_entry("profile/PC_samples", 0, 0)) != NULL) {
+ 		ent->size = PC_buf_sz;
+ 		ent->ops = &proc_PC_sample_inode_ops;
+ 	}
+ 
+ 	return register_chrdev(PROF_MAJOR, "profile", &prof_ctl_fops);
+ }
+ 
+ static void __exit profile_exit(void)
+ {
+ 	unregister_chrdev(PROF_MAJOR, "profile");
+ 	remove_proc_entry("profile/PC_samples", 0);
+ 	remove_proc_entry("profile", 0);
+ 	prof_free_mem();
+ }
+ 
+ module_init(profile_init);
+ module_exit(profile_exit);
diff -rcP linux-2.3.26.orig/fs/proc/array.c linux-2.3.26/fs/proc/array.c
*** linux-2.3.26.orig/fs/proc/array.c	Fri Nov  5 10:22:51 1999
--- linux-2.3.26/fs/proc/array.c	Wed Nov 17 14:37:17 1999
***************
*** 94,99 ****
--- 94,100 ----
  	&proc_kcore_operations,
  };
  
+ #if 0
  /*
   * This function accesses profiling information. The returned data is
   * binary: the sampling step and the actual contents of the profile
***************
*** 157,165 ****
  	read_profile,
  	write_profile,
  };
! 
  struct inode_operations proc_profile_inode_operations = {
! 	&proc_profile_operations,
  };
  
  static struct page * get_phys_addr(struct mm_struct * mm, unsigned long ptr)
--- 158,166 ----
  	read_profile,
  	write_profile,
  };
! #endif
  struct inode_operations proc_profile_inode_operations = {
! //	&proc_profile_operations,
  };
  
  static struct page * get_phys_addr(struct mm_struct * mm, unsigned long ptr)
diff -rcP linux-2.3.26.orig/fs/proc/proc_misc.c linux-2.3.26/fs/proc/proc_misc.c
*** linux-2.3.26.orig/fs/proc/proc_misc.c	Mon Nov  1 11:37:00 1999
--- linux-2.3.26/fs/proc/proc_misc.c	Mon Nov 15 13:12:30 1999
***************
*** 614,621 ****
  	proc_register(&proc_root, &proc_root_kmsg);
  	proc_register(&proc_root, &proc_root_kcore);
  	proc_root_kcore.size = (MAP_NR(high_memory) << PAGE_SHIFT) + PAGE_SIZE;
! 	if (prof_shift) {
  		proc_register(&proc_root, &proc_root_profile);
  		proc_root_profile.size = (1+prof_len) * sizeof(unsigned int);
! 	}
  }
--- 614,621 ----
  	proc_register(&proc_root, &proc_root_kmsg);
  	proc_register(&proc_root, &proc_root_kcore);
  	proc_root_kcore.size = (MAP_NR(high_memory) << PAGE_SHIFT) + PAGE_SIZE;
! /*	if (prof_shift) {
  		proc_register(&proc_root, &proc_root_profile);
  		proc_root_profile.size = (1+prof_len) * sizeof(unsigned int);
! 	} */
  }
diff -rcP linux-2.3.26.orig/include/asm-i386/hw_irq.h linux-2.3.26/include/asm-i386/hw_irq.h
*** linux-2.3.26.orig/include/asm-i386/hw_irq.h	Sat Nov  6 19:07:56 1999
--- linux-2.3.26/include/asm-i386/hw_irq.h	Wed Nov 17 14:36:46 1999
***************
*** 201,226 ****
  	"pushl $"#nr"-256\n\t" \
  	"jmp common_interrupt");
  
- /*
-  * x86 profiling function, SMP safe. We might want to do this in
-  * assembly totally?
-  */
- static inline void x86_do_profile (unsigned long eip)
- {
- 	if (prof_buffer && current->pid) {
- 		eip -= (unsigned long) &_stext;
- 		eip >>= prof_shift;
- 		/*
- 		 * Don't ignore out-of-bounds EIP values silently,
- 		 * put them into the last histogram slot, so if
- 		 * present, they will show up as a sharp peak.
- 		 */
- 		if (eip > prof_len-1)
- 			eip = prof_len-1;
- 		atomic_inc((atomic_t *)&prof_buffer[eip]);
- 	}
- }
- 
  #ifdef __SMP__ /*more of this file should probably be ifdefed SMP */
  static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {
  	if (IO_APIC_IRQ(i))
--- 201,206 ----
diff -rcP linux-2.3.26.orig/include/asm-i386/profile.h linux-2.3.26/include/asm-i386/profile.h
*** linux-2.3.26.orig/include/asm-i386/profile.h	Wed Dec 31 16:00:00 1969
--- linux-2.3.26/include/asm-i386/profile.h	Mon Nov 15 13:51:48 1999
***************
*** 0 ****
--- 1,10 ----
+ #ifndef _ASM_PROFILE_H
+ #define _ASM_PROFILE_H
+ 
+ #ifdef __KERNEL__
+ 
+ #define GET_PC_FROM_REGS(regs) ((regs)->eip)
+ 
+ #endif /* __KERNEL__ */
+ 
+ #endif /* !_ASM_PROFILE_H */
diff -rcP linux-2.3.26.orig/include/asm-i386/smp.h linux-2.3.26/include/asm-i386/smp.h
*** linux-2.3.26.orig/include/asm-i386/smp.h	Sat Nov  6 19:06:14 1999
--- linux-2.3.26/include/asm-i386/smp.h	Wed Nov 17 14:35:47 1999
***************
*** 180,185 ****
--- 180,187 ----
  extern void smp_local_timer_interrupt(struct pt_regs * regs);
  extern void (*mtrr_hook) (void);
  extern void setup_APIC_clocks(void);
+ extern int setup_profiling_timer(unsigned int);
+ extern int prof_multiplier[];
  extern void zap_low_mappings (void);
  extern volatile int cpu_number_map[NR_CPUS];
  extern volatile int __cpu_logical_map[NR_CPUS];
diff -rcP linux-2.3.26.orig/include/linux/kernel.h linux-2.3.26/include/linux/kernel.h
*** linux-2.3.26.orig/include/linux/kernel.h	Tue Oct 19 10:22:19 1999
--- linux-2.3.26/include/linux/kernel.h	Thu Nov 11 12:36:40 1999
***************
*** 23,28 ****
--- 23,31 ----
  
  #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
  
+ #define ROUNDDOWN(x,y)  (((x)/(y))*(y))
+ #define ROUNDUP(x,y)    ((((x)+(y)-1)/(y))*(y))
+ 
  #define	KERN_EMERG	"<0>"	/* system is unusable			*/
  #define	KERN_ALERT	"<1>"	/* action must be taken immediately	*/
  #define	KERN_CRIT	"<2>"	/* critical conditions			*/
diff -rcP linux-2.3.26.orig/include/linux/major.h linux-2.3.26/include/linux/major.h
*** linux-2.3.26.orig/include/linux/major.h	Wed Nov  3 17:50:32 1999
--- linux-2.3.26/include/linux/major.h	Wed Nov 10 16:11:49 1999
***************
*** 117,122 ****
--- 117,124 ----
  
  #define AURORA_MAJOR 79
  
+ #define PROF_MAJOR	112
+ 
  #define RTF_MAJOR	150
  #define RAW_MAJOR	162
  
diff -rcP linux-2.3.26.orig/include/linux/profile.h linux-2.3.26/include/linux/profile.h
*** linux-2.3.26.orig/include/linux/profile.h	Wed Dec 31 16:00:00 1969
--- linux-2.3.26/include/linux/profile.h	Mon Nov 15 17:33:40 1999
***************
*** 0 ****
--- 1,31 ----
+ #ifndef _LINUX_PROFILE_H
+ #define _LINUX_PROFILE_H
+ 
+ typedef unsigned int PC_sample_count_t;
+ 
+ /* profiling ioctl codes */
+ enum {
+ 	PROF_START,
+ 	PROF_STOP,
+ 	PROF_RESET,
+ 	PROF_SET_SAMPLE_FREQ,
+ 	PROF_GET_SAMPLE_FREQ,
+ 	PROF_GET_PC_RES,
+ 	PROF_GET_ON_OFF_STATE
+ };
+ 
+ #ifdef __KERNEL__
+ 
+ #include <asm/ptrace.h>
+ 
+ typedef void (*prof_hook_p)(struct pt_regs *);
+ 
+ extern char _stext, _etext;
+ extern prof_hook_p prof_timer_hook;
+ 
+ extern void USER(void);            /* these can not be in a module */
+ extern void IN_MODULE(void);
+ 
+ #endif /* __KERNEL__ */
+ 
+ #endif /* !_LINUX_PROFILE_H */
diff -rcP linux-2.3.26.orig/include/linux/sched.h linux-2.3.26/include/linux/sched.h
*** linux-2.3.26.orig/include/linux/sched.h	Sat Nov  6 19:06:19 1999
--- linux-2.3.26/include/linux/sched.h	Wed Nov 17 14:35:49 1999
***************
*** 488,497 ****
  extern struct timeval xtime;
  extern void do_timer(struct pt_regs *);
  
- extern unsigned int * prof_buffer;
- extern unsigned long prof_len;
- extern unsigned long prof_shift;
- 
  #define CURRENT_TIME (xtime.tv_sec)
  
  extern void FASTCALL(__wake_up(wait_queue_head_t *q, unsigned int mode));
--- 488,493 ----
diff -rcP linux-2.3.26.orig/init/main.c linux-2.3.26/init/main.c
*** linux-2.3.26.orig/init/main.c	Tue Oct 19 10:22:19 1999
--- linux-2.3.26/init/main.c	Thu Nov 11 17:55:54 1999
***************
*** 71,77 ****
  #error sorry, your GCC is too old. It builds incorrect kernels.
  #endif
  
- extern char _stext, _etext;
  extern char *linux_banner;
  
  extern int console_loglevel;
--- 71,76 ----
***************
*** 160,175 ****
  	return(str);
  }
  
- static int __init profile_setup(char *str)
- {
-     int par;
-     if (get_option(&str,&par)) prof_shift = par;
- 	return 1;
- }
- 
- __setup("profile=", profile_setup);
- 
- 
  static struct dev_name_struct {
  	const char *name;
  	const int num;
--- 159,164 ----
***************
*** 471,487 ****
  #ifdef CONFIG_MODULES
  	init_modules();
  #endif
- 	if (prof_shift) {
- 		unsigned int size;
- 		/* only text is profiled */
- 		prof_len = (unsigned long) &_etext - (unsigned long) &_stext;
- 		prof_len >>= prof_shift;
- 		
- 		size = prof_len * sizeof(unsigned int) + PAGE_SIZE-1;
- 		prof_buffer = (unsigned int *) alloc_bootmem(size);
- 		memset(prof_buffer, 0, size);
- 	}
- 
  	kmem_cache_init();
  	sti();
  	calibrate_delay();
--- 460,465 ----
diff -rcP linux-2.3.26.orig/kernel/Makefile linux-2.3.26/kernel/Makefile
*** linux-2.3.26.orig/kernel/Makefile	Sun Jul  4 13:41:08 1999
--- linux-2.3.26/kernel/Makefile	Tue Nov 16 04:36:57 1999
***************
*** 25,30 ****
--- 25,34 ----
  OX_OBJS  += ksyms.o
  endif
  
+ ifdef CONFIG_PROFILING
+ OX_OBJS += profile.o
+ endif
+ 
  CFLAGS_sched.o := $(PROFILING) -fno-omit-frame-pointer
  
  include $(TOPDIR)/Rules.make
diff -rcP linux-2.3.26.orig/kernel/profile.c linux-2.3.26/kernel/profile.c
*** linux-2.3.26.orig/kernel/profile.c	Wed Dec 31 16:00:00 1969
--- linux-2.3.26/kernel/profile.c	Tue Nov 16 17:22:15 1999
***************
*** 0 ****
--- 1,19 ----
+ #include <linux/config.h>
+ #include <linux/profile.h>
+ #include <linux/module.h>
+ 
+ /* profiling function to call in timer interrupt */
+ prof_hook_p prof_timer_hook __attribute__ ((aligned (__alignof__(char*)))) = 0;
+ 
+ /*
+  * The following functions are defined so their names may appear in profiles.
+  * They are not intended to be called.
+  */
+ void USER(void) {}
+ void IN_MODULE(void) {}
+ 
+ EXPORT_SYMBOL(USER);
+ EXPORT_SYMBOL(IN_MODULE);
+ EXPORT_SYMBOL(prof_timer_hook);
+ EXPORT_SYMBOL(_stext);
+ EXPORT_SYMBOL(_etext);
diff -rcP linux-2.3.26.orig/kernel/sched.c linux-2.3.26/kernel/sched.c
*** linux-2.3.26.orig/kernel/sched.c	Thu Oct 14 14:28:12 1999
--- linux-2.3.26/kernel/sched.c	Thu Nov 11 17:57:35 1999
***************
*** 80,88 ****
  unsigned long event = 0;
  
  extern int do_setitimer(int, struct itimerval *, struct itimerval *);
- unsigned int * prof_buffer = NULL;
- unsigned long prof_len = 0;
- unsigned long prof_shift = 0;
  
  extern void mem_use(void);
  
--- 80,85 ----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
