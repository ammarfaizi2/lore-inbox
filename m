Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318366AbSHPNRr>; Fri, 16 Aug 2002 09:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318365AbSHPNRq>; Fri, 16 Aug 2002 09:17:46 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:39069 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318366AbSHPNRf>; Fri, 16 Aug 2002 09:17:35 -0400
Date: Fri, 16 Aug 2002 18:48:32 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [patch] Scalable statistics counters using seq_file interfaces
Message-ID: <20020816184832.B30703@in.ibm.com>
References: <20020814165049.I27366@in.ibm.com> <20020814193702.A22887@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020814193702.A22887@infradead.org>; from hch@infradead.org on Wed, Aug 14, 2002 at 07:37:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph,

On Wed, Aug 14, 2002 at 07:37:02PM +0100, Christoph Hellwig wrote:
> ...
> My educated guess is that I will rewrite the code to not depend on procfs

Right now you have procfs dependency only if you need /proc reporting.
You can have satctrs without /proc too, you just have to pass NULL
to statctr_group parameter in statctr_init ......

> > diff -ruN -X dontdiff linux-2.5.31/fs/proc/root.c statctr-2.5.31/fs/proc/root.c
> > --- linux-2.5.31/fs/proc/root.c	Sun Aug 11 07:11:50 2002
> > +++ statctr-2.5.31/fs/proc/root.c	Tue Aug 13 10:14:46 2002
> > @@ -19,6 +19,7 @@
> >  #include <linux/smp_lock.h>
> >  
> >  struct proc_dir_entry *proc_net, *proc_bus, *proc_root_fs, *proc_root_driver;
> > +struct proc_dir_entry *proc_statistics;
> >  
> >  #ifdef CONFIG_SYSCTL
> >  struct proc_dir_entry *proc_sys_root;
> > @@ -77,6 +78,7 @@
> >  	proc_rtas_init();
> >  #endif
> >  	proc_bus = proc_mkdir("bus", 0);
> > +	proc_statistics = proc_mkdir("statistics", 0);
> 
> Any reason you don't do this in kernel/statctr.c?

I don't have an  init routine at boot time to create the default parent 
directory for statctr proc entries; Of course, I can make one and 
put it in statctr.c and call it from init/main.c, but I  thought this 
must be better than that. 

> 
> > +#ifndef _LINUX_STATCTR_H
> > +#define _LINUX_STATCTR_H
> > + 
> > +#ifdef  __KERNEL__
> 
> Is this needed?

I have seen this check used frequently. I assumed it was to 
prevent userspace from using the headers....hence the ifdefs.
Pls let me know if "#ifdef  __KERNEL__"  has any other reasoning behind it 
in other places where it is used right now.... anywayz that's gone now.

> 
> > +static inline struct statctr_pentry 
> > +*create_statctr_pentry(struct proc_dir_entry *parent, const char *name) 
> 
> Shouldn't this be:
> 
> static inline struct statctr_pentry *
> create_statctr_pentry(struct proc_dir_entry *parent, const char *name)

Sure, I can change that, but there is no documented preference on that AFAIK.

> 
> > +{
> > +	return(NULL);
> > +}
> 
> return is not function-like and the additional braces are heavily disliked
> in the kernel (at least for new code)

I should have used a consistent format for return at least...
I'll change this too, but again it is not documented in CodingStyle.
 
> 
> > +static inline int __statctr_init(statctr_t *stctr, int gfp_mask)
> > +{
> > +	stctr->ctr = kmalloc_percpu(sizeof(*(stctr->ctr)), gfp_mask); 
> > +	if(!stctr->ctr)
> 
> Kernel coding style has a space after the if.
> 

There is no explicit in CodingStyle on the space after if, but that is
part of the K&R coding style I guess.....
 
> > +		return -1;
> 
> -ENOMEM?

Yep, that'd be better. 

> 
> > +void free_statctr_pentry(struct statctr_pentry *pentry)
> > +{
> > +	if(!list_empty(&pentry->head))
> 
> Add an unlikely?

Sure, but does it really make any difference? (It ain't fastpath ... you
probably won't call this routine at all .. maybe at subsystem end or
module unload...)

> 
> It might be worth to rework the code to follow Documentation/CodingStyle

I had read the CodingStyle sometime back, and I thought I conformed to it,
Most of the stuff you've pointed out are not in CodingStyle right now,
perhaps its time to update Documentation/CodingStyle?  


Thanks for the feedback, Here's the new patch .. like it?

-Kiran


diff -ruN -X dontdiff linux-2.5.31/fs/proc/root.c statctr-2.5.31/fs/proc/root.c
--- linux-2.5.31/fs/proc/root.c	Sun Aug 11 07:11:50 2002
+++ statctr-2.5.31/fs/proc/root.c	Fri Aug 16 13:26:29 2002
@@ -19,6 +19,7 @@
 #include <linux/smp_lock.h>
 
 struct proc_dir_entry *proc_net, *proc_bus, *proc_root_fs, *proc_root_driver;
+struct proc_dir_entry *proc_statistics;
 
 #ifdef CONFIG_SYSCTL
 struct proc_dir_entry *proc_sys_root;
@@ -77,6 +78,7 @@
 	proc_rtas_init();
 #endif
 	proc_bus = proc_mkdir("bus", 0);
+	proc_statistics = proc_mkdir("statistics", 0);
 }
 
 static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentry)
diff -ruN -X dontdiff linux-2.5.31/include/linux/statctr.h statctr-2.5.31/include/linux/statctr.h
--- linux-2.5.31/include/linux/statctr.h	Thu Jan  1 05:30:00 1970
+++ statctr-2.5.31/include/linux/statctr.h	Fri Aug 16 16:22:37 2002
@@ -0,0 +1,245 @@
+/*
+ * Scalable Statistics Counters.
+ *
+ * Visit http://lse.sourceforge.net/counters for detailed explanation of
+ *  Scalable Statistic Counters 
+ *
+ * Copyright (c) IBM Corporation, 2001, 2002
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Author:              Ravikiran Thirumalai <kiran@in.ibm.com>
+ *
+ * include/linux/statctr.h
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/proc_fs.h>
+
+struct statctr_group {
+	struct proc_dir_entry 	*parent;
+	char			*procname;
+	struct list_head	head;
+};
+
+typedef struct {
+#ifdef	CONFIG_SMP
+	unsigned long 		*ctr;
+#else
+	unsigned long 		ctr;
+#endif
+#ifdef	CONFIG_PROC_FS
+	char 			*name;
+	struct list_head	grouplist;
+#endif  /* CONFIG_PROC_FS */
+} statctr_t;
+
+/* prototypes */
+extern int statctr_init(statctr_t *, 
+			struct statctr_group *, const char *,int);
+extern void statctr_cleanup(statctr_t *);
+
+#ifdef CONFIG_PROC_FS
+extern struct proc_dir_entry *proc_statistics;
+extern struct statctr_group *
+create_statctr_group(struct proc_dir_entry *, const char *);
+extern void free_statctr_group(struct statctr_group *);
+#else
+static inline struct statctr_group *
+create_statctr_group(struct proc_dir_entry *parent, const char *name) 
+{
+	return NULL;
+}
+static inline void free_statctr_group(struct statctr_group *group)
+{ 
+} 
+#endif
+
+#ifdef	CONFIG_SMP 
+
+static inline int __statctr_init(statctr_t *stctr, int gfp_mask)
+{
+	stctr->ctr = kmalloc_percpu(sizeof(*(stctr->ctr)), gfp_mask); 
+	if (!stctr->ctr) 
+		return -ENOMEM;
+	return 0;
+}
+
+static inline void __statctr_cleanup(statctr_t *stctr)
+{
+	kfree_percpu(stctr->ctr);
+}
+
+/** 
+ * statctr_inc - Increment the statistics counter by one.
+ * @stctr: Statistics counter 
+ *
+ * Increments the counter by one.  Internally only the per-cpu counter is 
+ * incremented.
+ */
+
+static inline void statctr_inc(statctr_t *stctr)
+{
+	(*this_cpu_ptr(stctr->ctr))++;
+}
+
+/**
+ * statctr_dec - Deccrement the statistics counter by one.
+ * @stctr: Statistics counter
+ *
+ * Decrements the counter by one.  Internally only the per-cpu counter is
+ * incremented.
+ */
+ 
+static inline void statctr_dec(statctr_t *stctr)
+{
+	(*this_cpu_ptr(stctr->ctr))--;
+}
+
+/**
+ * statctr_set - Set the statistics counter to value passed.
+ * @stctr: Statistcs counter
+ * @val: Value to be set..
+ *
+ * Sets the statistics counter. If statctr_read() is invoked after a counter 
+ * is set, return value of statctr_read shud reflect the value set.
+ */
+ 
+static inline void statctr_set(statctr_t *stctr, unsigned long val)
+{
+	int i;
+
+	for (i=0; i < NR_CPUS; i++) {
+		if (cpu_possible(i))
+			*per_cpu_ptr(stctr->ctr, i) = 0;
+	}
+	*this_cpu_ptr(stctr->ctr) = val;
+}
+
+/**
+ * statctr_read - Returns the counter value.
+ * @stctr: Statistics counter
+ *
+ * Reads all of the other per-cpu versions of this counter, consolidates them
+ * and returns to the caller.
+ */
+ 
+static inline unsigned long statctr_read(statctr_t *stctr)
+{
+	int i;
+	unsigned long res = 0;
+	for (i=0; i < NR_CPUS; i++)
+		if (cpu_possible(i))
+			res += *per_cpu_ptr(stctr->ctr, i);
+	return res;
+}
+
+/**
+ * statctr_read_local - Returns the cpu local counter value.
+ * @stctr: Statistics counter
+ */
+ 
+static inline unsigned long statctr_read_local(statctr_t *stctr)
+{
+	return *this_cpu_ptr(stctr->ctr);
+}
+
+/**
+ * statctr_read_cpu - Returns the cpu counter value.
+ * @stctr: Statistics counter
+ */
+ 
+static inline unsigned long statctr_read_cpu(statctr_t *stctr, int cpu)
+{
+	return *per_cpu_ptr(stctr->ctr, cpu);
+}
+
+/**
+ * statctr_add - Adds the passed val to the counter value.
+ * @stctr: Statistics counter
+ * @val: Addend
+ *
+ */
+ 
+static inline void statctr_add(statctr_t *stctr, unsigned long val)
+{
+        *this_cpu_ptr(stctr->ctr) += val;
+}
+
+/**
+ * statctr_sub - Subtracts the passed val from the counter value.
+ * @stctr: Statistics counter
+ * @val: Subtrahend
+ *
+ */
+ 
+static inline void statctr_sub(statctr_t *stctr, unsigned long val)
+{
+        *this_cpu_ptr(stctr->ctr) -= val;
+}
+
+#else /* CONFIG_SMP */
+
+static inline int __statctr_init(statctr_t *stctr, int gfp_mask)
+{
+	return 0;
+}
+
+static inline void __statctr_cleanup(statctr_t *stctr) {}
+
+static inline void statctr_inc(statctr_t *stctr)
+{
+	(stctr->ctr)++;
+}
+
+static inline void statctr_dec(statctr_t *stctr)
+{
+	(stctr->ctr)--;
+}
+
+static inline unsigned long statctr_read(statctr_t *stctr)
+{
+	return stctr->ctr;
+}
+
+static inline unsigned long statctr_read_local(statctr_t *stctr)
+{
+	return stctr->ctr;
+}
+
+static inline unsigned long statctr_read_cpu(statctr_t *stctr, int cpu)
+{
+	return stctr->ctr;
+}
+
+static inline void statctr_set(statctr_t *stctr, unsigned long val) 
+{
+	stctr->ctr = val;
+}
+
+static inline void statctr_add(statctr_t *stctr, unsigned long val) 
+{
+	stctr->ctr += val;
+}
+
+static inline void statctr_sub(statctr_t *stctr, unsigned long val)
+{
+	stctr->ctr -= val;
+}
+
+#endif  /* CONFIG_SMP */
diff -ruN -X dontdiff linux-2.5.31/kernel/Makefile statctr-2.5.31/kernel/Makefile
--- linux-2.5.31/kernel/Makefile	Sun Aug 11 07:11:23 2002
+++ statctr-2.5.31/kernel/Makefile	Fri Aug 16 13:26:29 2002
@@ -10,12 +10,13 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o suspend.o dma.o
+		printk.o platform.o suspend.o dma.o statctr.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o futex.o platform.o
+	    signal.o sys.o kmod.o context.o futex.o platform.o \
+	    statctr.o
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
diff -ruN -X dontdiff linux-2.5.31/kernel/statctr.c statctr-2.5.31/kernel/statctr.c
--- linux-2.5.31/kernel/statctr.c	Thu Jan  1 05:30:00 1970
+++ statctr-2.5.31/kernel/statctr.c	Fri Aug 16 16:42:52 2002
@@ -0,0 +1,265 @@
+/*
+ * Scalable Statistics Counters.
+ *
+ * Visit http://lse.sourceforge.net/counters for detailed explanation of
+ *  Scalable Statistic Counters
+ *  
+ * Copyright (c) IBM Corporation, 2001, 2002.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Author:              Ravikiran Thirumalai <kiran@in.ibm.com>
+ *
+ * kernel/statctr.c
+ *
+ */
+
+#include <linux/statctr.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/seq_file.h>
+
+#ifdef	CONFIG_PROC_FS
+
+static void *statctr_start(struct seq_file *m, loff_t *pos)
+{
+	struct statctr_group *group = m->private;
+	struct list_head *tmp;
+	loff_t n = *pos; 
+
+	list_for_each(tmp, &group->head) 
+		if (!n--)
+			return list_entry(tmp, statctr_t, grouplist); 
+	return NULL;
+}
+		
+static void *statctr_next(struct seq_file *m, void *v, loff_t *pos) 
+{
+	struct statctr_group *group = m->private;
+	struct list_head *p = ((statctr_t *)v)->grouplist.next;
+	(*pos)++;
+	return p == &group->head ? NULL : list_entry(p, statctr_t, grouplist);
+}
+
+static void statctr_stop(struct seq_file *m, void *v)
+{
+}
+
+static int statctr_show(struct seq_file *m, void *v)
+{
+	char *spc = " ", *str; 
+	statctr_t *stctr = v;
+	if (!stctr->name)
+		str = spc;
+	else 
+		str = stctr->name;
+	seq_printf(m, "%15s %lu\n", str, statctr_read(stctr));
+	return 0;
+}
+
+static struct seq_operations statctr_seq_ops = {
+	.start	= statctr_start,
+	.next	= statctr_next,
+	.stop	= statctr_stop,
+	.show	= statctr_show,
+};
+
+static int statctr_open(struct inode *inode, struct file *file)
+{
+	struct proc_dir_entry *entry;
+	int res;
+	res = seq_open(file, &statctr_seq_ops);
+	if (!res) {
+		entry = PDE(inode);
+		((struct seq_file *)file->private_data)->private = entry->data;
+	}
+	return res;
+}
+
+static struct file_operations proc_statctr_ops = {
+	.open	 = statctr_open,
+	.read	 = seq_read,
+	.llseek	 = seq_lseek,
+	.release = seq_release,
+};		
+		 
+static int
+create_statctr_seq_entry(const char *name, mode_t mode, 
+			 struct proc_dir_entry *parent,
+			 struct statctr_group *group)
+{
+	int ret = 0;
+	struct proc_dir_entry *entry; 
+	entry = create_proc_entry(name, mode, parent);
+	if (entry) {
+		entry->proc_fops = &proc_statctr_ops;
+		entry->data = group;
+	}
+	else
+		ret = -1;
+	return ret;
+}
+
+/**
+ * create_statctr_group - Creates and sets up a "statctr group" 
+ * @parent  : proc_dir_entry under which @procname entry should appear.
+ *	      NULL is ok; but procname will be created under 
+ *	      '/proc/statistics/' -- that is as /proc/statistics/$procname
+ * @procname: Name of the /proc file which the statctr group represents
+ * 
+ * Memory to the statctr proc entry will be allocated by this method.
+ * This method registers the procname file under proc_dir_entry.
+ * Returns non zero on error.
+ */
+struct statctr_group *
+	create_statctr_group(struct proc_dir_entry *parent,
+				   const char *procname)
+{
+	struct statctr_group *group = NULL;
+	struct proc_dir_entry *tmpparent;
+
+	if (!procname)
+		return NULL;
+
+	if (!parent)
+		tmpparent = proc_statistics;
+	else
+		tmpparent = parent;
+
+	group = kmalloc(sizeof(*group), GFP_KERNEL);
+	if (!group) 
+		return NULL;
+
+	if (create_statctr_seq_entry (procname, 0444, tmpparent, group)) {
+		kfree(group);
+		return NULL;
+	}
+
+	group->procname = kmalloc(strlen(procname) + 1, GFP_KERNEL);
+	if (!group->procname) {
+		remove_proc_entry(procname, tmpparent);
+		kfree(group);
+		return NULL;
+	}
+	memcpy(group->procname, procname, strlen(procname)+1);
+	group->parent = tmpparent;
+	INIT_LIST_HEAD(&group->head);
+	
+	return group;
+}
+
+/**
+ * free_statctr_group - Perform cleanup functions on a statctr group
+ * @group: Pointer to struct statctr_group type; 
+ * This method unregisters the proc entry associated with this @group and
+ * frees the memory pointed by it. 
+ */
+void free_statctr_group(struct statctr_group *group)
+{
+	if (unlikely(!list_empty(&group->head)))
+		BUG();
+	remove_proc_entry(group->procname, group->parent);
+	kfree(group->procname);
+	kfree(group);
+}
+
+static int statctr_link_group(statctr_t *stctr, 
+			       struct statctr_group *group,
+			       const char *ctrname, 
+			       int gfp_mask)
+{
+	stctr->name = NULL;
+	if (!group) {
+		INIT_LIST_HEAD(&stctr->grouplist);
+		return 0;
+	}
+	
+	if (ctrname) {
+		stctr->name = kmalloc(strlen(ctrname) + 1, gfp_mask); 
+		if (!stctr->name)
+			return -ENOMEM;
+		memcpy(stctr->name, ctrname, strlen(ctrname)+1);
+	}
+	
+	list_add_tail(&stctr->grouplist, &group->head);
+	return 0;
+}
+	
+static void statctr_unlink_group(statctr_t *stctr)
+{
+	if (stctr->name)
+		kfree(stctr->name);
+	if (!list_empty(&stctr->grouplist))
+		list_del(&stctr->grouplist);
+}
+#else	/* CONFIG_PROC_FS */
+#define statctr_link_group(stctr, group, ctrname, gfp_mask) \
+		({do { } while (0); 0;}) 
+#define	statctr_unlink_group(stctr)  do { } while (0)
+#endif	/* CONFIG_PROC_FS */
+
+/**
+ * statctr_init - Sets up the statistics counter
+ * @stctr    :	Pointer to statctr_t type; counter to be initialised
+ * @group   : 	The struct statctr_group type which represents a 
+ *		/proc entry. This should have been created by using the 
+ *		create_statctr_group interface. Passing NULL turns 
+ *		off /proc association for the counter & @ctrname is ignored.
+ * @ctrname  :	This is the label of the counter in the /proc file
+ *		indicated by @group. NULL is also fine; you just don't see
+ *		a label against the counter value then.
+ * @gfp_mask     :	GFP_xx flags to be passed for kernel memory allocation.
+ *
+ * Allocates memory to a statistics counter. Returns 0 on successful
+ * allocation and non zero otherwise.  Makes a /proc entry based on the
+ * group parameter.  statctr_init s linking to a single statctr_group
+ * should be done either single threadedly or with your own serialization.
+ * There could have been a per group lock on the statctr_group, but
+ * then you would have no control over the order in which entries show up 
+ * on /proc
+ */
+int statctr_init(statctr_t *stctr, 
+		 struct statctr_group *group, 
+		 const char *ctrname, 
+		 int gfp_mask)
+{
+	int ret;
+	if ((ret = __statctr_init(stctr, gfp_mask)))
+		return ret;
+	if ((ret = statctr_link_group(stctr, group, ctrname, gfp_mask))) {
+		__statctr_cleanup(stctr);
+		return ret;
+	}
+	return 0;
+}
+
+/**
+ * statctr_cleanup - Perform cleanup functions on a statctr counter
+ * @ctr: Pointer to statctr_t type; 
+ */
+void statctr_cleanup(statctr_t *stctr)
+{
+	__statctr_cleanup(stctr);
+	statctr_unlink_group(stctr);
+}
+
+#ifdef  CONFIG_PROC_FS  
+EXPORT_SYMBOL(create_statctr_group);
+EXPORT_SYMBOL(free_statctr_group);
+#endif
+
+EXPORT_SYMBOL(statctr_init);
+EXPORT_SYMBOL(statctr_cleanup);
+
