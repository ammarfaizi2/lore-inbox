Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314448AbSFATC6>; Sat, 1 Jun 2002 15:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314748AbSFATC5>; Sat, 1 Jun 2002 15:02:57 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:26095 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S314448AbSFATCx>; Sat, 1 Jun 2002 15:02:53 -0400
Date: Sat, 1 Jun 2002 15:02:53 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Tom Vier <tmv@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/slab garbage
Message-ID: <20020601150253.A5566@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0205281905260.7798-100000@freak.distro.conectiva> <20020601184737.GA618@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 01, 2002 at 02:47:37PM -0400, Tom Vier wrote:
> when i cat /proc/slabinfo, after the normal info, it's spits out garbage;
> seemingly random memory contents. it's printing past the end of the buffer.
> i can email an example upon request.
> 
> Linux zero 2.4.19-pre9 #1 Tue May 28 20:54:41 EDT 2002 alpha unknown

The patch below should fix it properly: it's a backport of Al Viro's 
seqfile patch for slabinfo.  The first part also reverts the vnsprintf 
changes made previously as seq file relies on C99 style behaviour 
of snprintf.  It's against a 2.4.19ish tree, but I've not checked 
that it applies against 2.4.19-pre9.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."

diff -urN linux/lib/vsprintf.c linux.diff/lib/vsprintf.c
--- linux/lib/vsprintf.c	Mon May 27 17:51:27 2002
+++ linux.diff/lib/vsprintf.c	Mon May 27 17:54:21 2002
@@ -172,41 +172,50 @@
 	if (!(type&(ZEROPAD+LEFT))) {
 		while(size-->0) {
 			if (buf <= end)
-				*buf++ = ' ';
+				*buf = ' ';
+			++buf;
 		}
 	}
 	if (sign) {
 		if (buf <= end)
-			*buf++ = sign;
+			*buf = sign;
+		++buf;
 	}
 	if (type & SPECIAL) {
 		if (base==8) {
 			if (buf <= end)
-				*buf++ = '0';
+				*buf = '0';
+			++buf;
 		} else if (base==16) {
 			if (buf <= end)
-				*buf++ = '0';
+				*buf = '0';
+			++buf;
 			if (buf <= end)
-				*buf++ = digits[33];
+				*buf = digits[33];
+			++buf;
 		}
 	}
 	if (!(type & LEFT)) {
 		while (size-- > 0) {
 			if (buf <= end)
-				*buf++ = c;
+				*buf = c;
+			++buf;
 		}
 	}
 	while (i < precision--) {
 		if (buf <= end)
-			*buf++ = '0';
+			*buf = '0';
+		++buf;
 	}
 	while (i-- > 0) {
 		if (buf <= end)
-			*buf++ = tmp[i];
+			*buf = tmp[i];
+		++buf;
 	}
 	while (size-- > 0) {
 		if (buf <= end)
-			*buf++ = ' ';
+			*buf = ' ';
+		++buf;
 	}
 	return buf;
 }
@@ -238,10 +247,6 @@
 				/* 'z' support added 23/7/1999 S.H.    */
 				/* 'z' changed to 'Z' --davidm 1/25/99 */
 
-	/* Enforce absolute minimum size: one character + the trailing 0 */
-	if (size < 2)
-		return 0;
-
 	str = buf;
 	end = buf + size - 1;
 
@@ -253,7 +258,8 @@
 	for (; *fmt ; ++fmt) {
 		if (*fmt != '%') {
 			if (str <= end)
-				*str++ = *fmt;
+				*str = *fmt;
+			++str;
 			continue;
 		}
 
@@ -317,15 +323,18 @@
 				if (!(flags & LEFT)) {
 					while (--field_width > 0) {
 						if (str <= end)
-							*str++ = ' ';
+							*str = ' ';
+						++str;
 					}
 				}
 				c = (unsigned char) va_arg(args, int);
 				if (str <= end)
-					*str++ = c;
+					*str = c;
+				++str;
 				while (--field_width > 0) {
 					if (str <= end)
-						*str++ = ' ';
+						*str = ' ';
+					++str;
 				}
 				continue;
 
@@ -339,16 +348,19 @@
 				if (!(flags & LEFT)) {
 					while (len < field_width--) {
 						if (str <= end)
-							*str++ = ' ';
+							*str = ' ';
+						++str;
 					}
 				}
 				for (i = 0; i < len; ++i) {
 					if (str <= end)
-						*str++ = *s++;
+						*str = *s;
+					++str; ++s;
 				}
 				while (len < field_width--) {
 					if (str <= end)
-						*str++ = ' ';
+						*str = ' ';
+					++str;
 				}
 				continue;
 
@@ -380,7 +392,8 @@
 
 			case '%':
 				if (str <= end)
-					*str++ = '%';
+					*str = '%';
+				++str;
 				continue;
 
 				/* integer number formats - set up the flags and "break" */
@@ -402,10 +415,12 @@
 
 			default:
 				if (str <= end)
-					*str++ = '%';
+					*str = '%';
+				++str;
 				if (*fmt) {
 					if (str <= end)
-						*str++ = *fmt;
+						*str = *fmt;
+					++str;
 				} else {
 					--fmt;
 				}
diff -urN linux.orig/fs/proc/proc_misc.c linux.work/fs/proc/proc_misc.c
--- linux.orig/fs/proc/proc_misc.c	Mon May 27 17:14:07 2002
+++ linux.work/fs/proc/proc_misc.c	Mon May 27 17:14:39 2002
@@ -289,6 +289,20 @@
 };
 #endif
 
+extern struct seq_operations slabinfo_op;
+extern ssize_t slabinfo_write(struct file *, const char *, size_t, loff_t *);
+static int slabinfo_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &slabinfo_op);
+}
+static struct file_operations proc_slabinfo_operations = {
+	open:		slabinfo_open,
+	read:		seq_read,
+	write:		slabinfo_write,
+	llseek:		seq_lseek,
+	release:	seq_release,
+};
+
 static int kstat_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -589,6 +603,7 @@
 	if (entry)
 		entry->proc_fops = &proc_kmsg_operations;
 	create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
+	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
 #ifdef CONFIG_MODULES
 	create_seq_entry("ksyms", 0, &proc_ksyms_operations);
 #endif
@@ -613,8 +628,4 @@
 			entry->proc_fops = &ppc_htab_operations;
 	}
 #endif
-	entry = create_proc_read_entry("slabinfo", S_IWUSR | S_IRUGO, NULL,
-				       slabinfo_read_proc, NULL);
-	if (entry)
-		entry->write_proc = slabinfo_write_proc;
 }
diff -urN linux.orig/include/linux/slab.h linux.work/include/linux/slab.h
--- linux.orig/include/linux/slab.h	Mon May 27 17:14:07 2002
+++ linux.work/include/linux/slab.h	Mon May 27 17:14:39 2002
@@ -62,10 +62,6 @@
 extern void kfree(const void *);
 
 extern int FASTCALL(kmem_cache_reap(int));
-extern int slabinfo_read_proc(char *page, char **start, off_t off,
-				 int count, int *eof, void *data);
-extern int slabinfo_write_proc(struct file *file, const char *buffer,
-			   unsigned long count, void *data);
 
 /* System wide caches */
 extern kmem_cache_t	*vm_area_cachep;
diff -urN linux.orig/mm/slab.c linux.work/mm/slab.c
--- linux.orig/mm/slab.c	Mon May 27 17:14:07 2002
+++ linux.work/mm/slab.c	Mon May 27 17:14:39 2002
@@ -72,6 +72,8 @@
 #include	<linux/slab.h>
 #include	<linux/interrupt.h>
 #include	<linux/init.h>
+#include	<linux/compiler.h>
+#include	<linux/seq_file.h>
 #include	<asm/uaccess.h>
 
 /*
@@ -1849,31 +1851,56 @@
 }
 
 #ifdef CONFIG_PROC_FS
-/* /proc/slabinfo
- *	cache-name num-active-objs total-objs
- *	obj-size num-active-slabs total-slabs
- *	num-pages-per-slab
- */
-#define FIXUP(t)				\
-	do {					\
-		if (len <= off) {		\
-			off -= len;		\
-			len = 0;		\
-		} else {			\
-			if (len-off >= count)	\
-				goto t;		\
-		}				\
-	} while (0)
 
-static int proc_getdata (char*page, char**start, off_t off, int count)
+static void *s_start(struct seq_file *m, loff_t *pos)
 {
+	loff_t n = *pos;
 	struct list_head *p;
-	int len = 0;
 
-	/* Output format version, so at least we can change it without _too_
-	 * many complaints.
-	 */
-	len += snprintf(page+len, PAGE_SIZE-len, "slabinfo - version: 1.1"
+	down(&cache_chain_sem);
+	if (!n)
+		return (void *)1;
+	p = &cache_cache.next;
+	while (--n) {
+		p = p->next;
+		if (p == &cache_cache.next)
+			return NULL;
+	}
+	return list_entry(p, kmem_cache_t, next);
+}
+
+static void *s_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	kmem_cache_t *cachep = p;
+	++*pos;
+	if (p == (void *)1)
+		return &cache_cache;
+	cachep = list_entry(cachep->next.next, kmem_cache_t, next);
+	return cachep == &cache_cache ? NULL : cachep;
+}
+
+static void s_stop(struct seq_file *m, void *p)
+{
+	up(&cache_chain_sem);
+}
+
+static int s_show(struct seq_file *m, void *p)
+{
+	kmem_cache_t *cachep = p;
+	struct list_head *q;
+	slab_t		*slabp;
+	unsigned long	active_objs;
+	unsigned long	num_objs;
+	unsigned long	active_slabs = 0;
+	unsigned long	num_slabs;
+	const char *name; 
+
+	if (p == (void*)1) {
+		/*
+		 * Output format version, so at least we can change it
+		 * without _too_ many complaints.
+		 */
+		seq_puts(m, "slabinfo - version: 1.1"
 #if STATS
 				" (statistics)"
 #endif
@@ -1881,117 +1908,91 @@
 				" (SMP)"
 #endif
 				"\n");
-	FIXUP(got_data);
-
-	down(&cache_chain_sem);
-	p = &cache_cache.next;
-	do {
-		kmem_cache_t	*cachep;
-		struct list_head *q;
-		slab_t		*slabp;
-		unsigned long	active_objs;
-		unsigned long	num_objs;
-		unsigned long	active_slabs = 0;
-		unsigned long	num_slabs;
-		cachep = list_entry(p, kmem_cache_t, next);
+		return 0;
+	}
 
-		spin_lock_irq(&cachep->spinlock);
-		active_objs = 0;
-		num_slabs = 0;
-		list_for_each(q,&cachep->slabs_full) {
-			slabp = list_entry(q, slab_t, list);
-			if (slabp->inuse != cachep->num)
-				BUG();
-			active_objs += cachep->num;
-			active_slabs++;
-		}
-		list_for_each(q,&cachep->slabs_partial) {
-			slabp = list_entry(q, slab_t, list);
-			if (slabp->inuse == cachep->num || !slabp->inuse)
-				BUG();
-			active_objs += slabp->inuse;
-			active_slabs++;
-		}
-		list_for_each(q,&cachep->slabs_free) {
-			slabp = list_entry(q, slab_t, list);
-			if (slabp->inuse)
-				BUG();
-			num_slabs++;
-		}
-		num_slabs+=active_slabs;
-		num_objs = num_slabs*cachep->num;
+	spin_lock_irq(&cachep->spinlock);
+	active_objs = 0;
+	num_slabs = 0;
+	list_for_each(q,&cachep->slabs_full) {
+		slabp = list_entry(q, slab_t, list);
+		if (slabp->inuse != cachep->num)
+			BUG();
+		active_objs += cachep->num;
+		active_slabs++;
+	}
+	list_for_each(q,&cachep->slabs_partial) {
+		slabp = list_entry(q, slab_t, list);
+		if (slabp->inuse == cachep->num || !slabp->inuse)
+			BUG();
+		active_objs += slabp->inuse;
+		active_slabs++;
+	}
+	list_for_each(q,&cachep->slabs_free) {
+		slabp = list_entry(q, slab_t, list);
+		if (slabp->inuse)
+			BUG();
+		num_slabs++;
+	}
+	num_slabs+=active_slabs;
+	num_objs = num_slabs*cachep->num;
 
-		len += snprintf(page+len, PAGE_SIZE-len,
-			"%-17s %6lu %6lu %6u %4lu %4lu %4u",
-			cachep->name, active_objs, num_objs, cachep->objsize,
-			active_slabs, num_slabs, (1<<cachep->gfporder));
+	name = cachep->name; 
+	{
+	char tmp; 
+	if (__get_user(tmp, name)) 
+		name = "broken"; 
+	}       
+
+	seq_printf(m, "%-17s %6lu %6lu %6u %4lu %4lu %4u",
+		name, active_objs, num_objs, cachep->objsize,
+		active_slabs, num_slabs, (1<<cachep->gfporder));
 
 #if STATS
-		{
-			unsigned long errors = cachep->errors;
-			unsigned long high = cachep->high_mark;
-			unsigned long grown = cachep->grown;
-			unsigned long reaped = cachep->reaped;
-			unsigned long allocs = cachep->num_allocations;
-
-			len += snprintf(page+len, PAGE_SIZE-len,
-					" : %6lu %7lu %5lu %4lu %4lu",
-					high, allocs, grown, reaped, errors);
-		}
+	{
+		unsigned long errors = cachep->errors;
+		unsigned long high = cachep->high_mark;
+		unsigned long grown = cachep->grown;
+		unsigned long reaped = cachep->reaped;
+		unsigned long allocs = cachep->num_allocations;
+
+		seq_printf(m, " : %6lu %7lu %5lu %4lu %4lu",
+				high, allocs, grown, reaped, errors);
+	}
 #endif
 #ifdef CONFIG_SMP
-		{
-			cpucache_t *cc = cc_data(cachep);
-			unsigned int batchcount = cachep->batchcount;
-			unsigned int limit;
-
-			if (cc)
-				limit = cc->limit;
-			else
-				limit = 0;
-			len += snprintf(page+len, PAGE_SIZE-len, " : %4u %4u",
-					limit, batchcount);
-		}
+	{
+		cpucache_t *cc = cc_data(cachep);
+		unsigned int batchcount = cachep->batchcount;
+		unsigned int limit;
+
+		if (cc)
+			limit = cc->limit;
+		else
+			limit = 0;
+		seq_printf(m, " : %4u %4u",
+				limit, batchcount);
+	}
 #endif
 #if STATS && defined(CONFIG_SMP)
-		{
-			unsigned long allochit = atomic_read(&cachep->allochit);
-			unsigned long allocmiss = atomic_read(&cachep->allocmiss);
-			unsigned long freehit = atomic_read(&cachep->freehit);
-			unsigned long freemiss = atomic_read(&cachep->freemiss);
-			len += snprintf(page+len, PAGE_SIZE-len,
-					" : %6lu %6lu %6lu %6lu",
-					allochit, allocmiss, freehit, freemiss);
-		}
-#endif
-		len += snprintf(page+len, PAGE_SIZE-len, "\n");
-		spin_unlock_irq(&cachep->spinlock);
-		FIXUP(got_data_up);
-		p = cachep->next.next;
-		if (len > PAGE_SIZE - 512)
-			break;
-	} while (p != &cache_cache.next);
-got_data_up:
-	up(&cache_chain_sem);
-
-got_data:
-	if (off < len) {
-		*start = page+off;
-		return len;
+	{
+		unsigned long allochit = atomic_read(&cachep->allochit);
+		unsigned long allocmiss = atomic_read(&cachep->allocmiss);
+		unsigned long freehit = atomic_read(&cachep->freehit);
+		unsigned long freemiss = atomic_read(&cachep->freemiss);
+		seq_printf(m, " : %6lu %6lu %6lu %6lu",
+				allochit, allocmiss, freehit, freemiss);
 	}
+#endif
+	spin_unlock_irq(&cachep->spinlock);
+	seq_putc(m, '\n');
 	return 0;
 }
 
 /**
- * slabinfo_read_proc - generates /proc/slabinfo
- * @page: scratch area, one page long
- * @start: pointer to the pointer to the output buffer
- * @off: offset within /proc/slabinfo the caller is interested in
- * @count: requested len in bytes
- * @eof: eof marker
- * @data: unused
+ * slabinfo_op - iterator that generates /proc/slabinfo
  *
- * The contents of the buffer are
+ * Output layout:
  * cache-name
  * num-active-objs
  * total-objs
@@ -2001,28 +2002,24 @@
  * num-pages-per-slab
  * + further values on SMP and with statistics enabled
  */
-int slabinfo_read_proc (char *page, char **start, off_t off,
-				 int count, int *eof, void *data)
-{
-	int len = proc_getdata(page, start, off, count);
-	len -= (*start-page);
-	if (len <= count)
-		*eof = 1;
-	if (len>count) len = count;
-	if (len<0) len = 0;
-	return len;
-}
+
+struct seq_operations slabinfo_op = {
+	start:	s_start,
+	next:	s_next,
+	stop:	s_stop,
+	show:	s_show
+};
 
 #define MAX_SLABINFO_WRITE 128
 /**
- * slabinfo_write_proc - SMP tuning for the slab allocator
+ * slabinfo_write - SMP tuning for the slab allocator
  * @file: unused
  * @buffer: user buffer
  * @count: data len
  * @data: unused
  */
-int slabinfo_write_proc (struct file *file, const char *buffer,
-				unsigned long count, void *data)
+ssize_t slabinfo_write(struct file *file, const char *buffer,
+				size_t count, loff_t *ppos)
 {
 #ifdef CONFIG_SMP
 	char kbuf[MAX_SLABINFO_WRITE+1], *tmp;
