Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbUANJNl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265439AbUANJNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:13:39 -0500
Received: from pD9E5637F.dip.t-dialin.net ([217.229.99.127]:21888 "EHLO
	averell.firstfloor.org") by vger.kernel.org with ESMTP
	id S265531AbUANJMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:12:31 -0500
Date: Wed, 14 Jan 2004 10:12:22 +0100
From: Andi Kleen <ak@muc.de>
To: akpm@osdl.org
Cc: jh@suse.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix more gcc 3.4 warnings
Message-ID: <20040114091222.GA1998@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just many more warning fixes for a gcc 3.4 snapshot.

It warns for a lot of things now, e.g. for ?: and ({ ... }) and casts
as lvalues. And for functions marked inline in headers, but no body.

Actually there are more warnings, i stopped fixing at some point.
Some of the warnings seem to be dubious (e.g. the binfmt_elf.c
one, which looks more like a compiler bug to me) 

I also fixed the _exit() prototype to be void because gcc was complaining
about this.

-Andi

diff -u linux-34/fs/ext3/namei.c-o linux-34/fs/ext3/namei.c
--- linux-34/fs/ext3/namei.c-o	2003-09-28 10:53:18.000000000 +0200
+++ linux-34/fs/ext3/namei.c	2004-01-13 13:16:01.000000000 +0100
@@ -1311,7 +1311,7 @@
 	memcpy (data1, de, len);
 	de = (struct ext3_dir_entry_2 *) data1;
 	top = data1 + len;
-	while (((char *) de2=(char*)de+le16_to_cpu(de->rec_len)) < top)
+	while ((char *)(de2=(void*)de+le16_to_cpu(de->rec_len)) < top)
 		de = de2;
 	de->rec_len = cpu_to_le16(data1 + blocksize - (char *) de);
 	/* Initialize the root; the dot dirents already exist */
diff -u linux-34/fs/compat_ioctl.c-o linux-34/fs/compat_ioctl.c
--- linux-34/fs/compat_ioctl.c-o	2004-01-09 09:27:16.000000000 +0100
+++ linux-34/fs/compat_ioctl.c	2004-01-13 13:26:26.000000000 +0100
@@ -1897,12 +1897,14 @@
 	struct blkpg_ioctl_arg a;
 	struct blkpg_partition p;
 	int err;
+	compat_caddr_t data; 
 	mm_segment_t old_fs = get_fs();
 	
 	err = get_user(a.op, &arg->op);
 	err |= __get_user(a.flags, &arg->flags);
 	err |= __get_user(a.datalen, &arg->datalen);
-	err |= __get_user((long)a.data, &arg->data);
+	err |= __get_user(data, &arg->data);
+	a.data = compat_ptr(data);
 	if (err) return err;
 	switch (a.op) {
 	case BLKPG_ADD_PARTITION:
@@ -2081,6 +2083,7 @@
 		case FDDEFPRM32:
 		case FDGETPRM32:
 		{
+			compat_uptr_t name;
 			struct floppy_struct *f;
 
 			f = karg = kmalloc(sizeof(struct floppy_struct), GFP_KERNEL);
@@ -2097,7 +2100,8 @@
 			err |= __get_user(f->rate, &((struct floppy_struct32 *)arg)->rate);
 			err |= __get_user(f->spec1, &((struct floppy_struct32 *)arg)->spec1);
 			err |= __get_user(f->fmt_gap, &((struct floppy_struct32 *)arg)->fmt_gap);
-			err |= __get_user((u64)f->name, &((struct floppy_struct32 *)arg)->name);
+			err |= __get_user(name, &((struct floppy_struct32 *)arg)->name);
+			f->name = compat_ptr(name);
 			if (err) {
 				err = -EFAULT;
 				goto out;
diff -u linux-34/fs/readdir.c-o linux-34/fs/readdir.c
--- linux-34/fs/readdir.c-o	2003-10-09 00:28:55.000000000 +0200
+++ linux-34/fs/readdir.c	2004-01-13 13:04:33.000000000 +0100
@@ -159,7 +159,7 @@
 	if (__put_user(0, dirent->d_name + namlen))
 		goto efault;
 	buf->previous = dirent;
-	((char *) dirent) += reclen;
+	dirent = (void *)dirent + reclen;
 	buf->current_dir = dirent;
 	buf->count -= reclen;
 	return 0;
@@ -245,7 +245,7 @@
 	if (__put_user(0, dirent->d_name + namlen))
 		goto efault;
 	buf->previous = dirent;
-	((char *) dirent) += reclen;
+	dirent = (void *)dirent + reclen;
 	buf->current_dir = dirent;
 	buf->count -= reclen;
 	return 0;
diff -u linux-34/lib/crc32.c-o linux-34/lib/crc32.c
--- linux-34/lib/crc32.c-o	2003-05-27 03:00:20.000000000 +0200
+++ linux-34/lib/crc32.c	2004-01-13 22:40:22.000000000 +0100
@@ -99,7 +99,9 @@
 	/* Align it */
 	if(unlikely(((long)b)&3 && len)){
 		do {
-			DO_CRC(*((u8 *)b)++);
+			u8 *p = (u8 *)b; 
+			DO_CRC(*p++);
+			b = (void *)p;
 		} while ((--len) && ((long)b)&3 );
 	}
 	if(likely(len >= 4)){
@@ -120,7 +122,9 @@
 	/* And the last few bytes */
 	if(len){
 		do {
-			DO_CRC(*((u8 *)b)++);
+			u8 *p = (u8 *)b; 
+			DO_CRC(*p++);
+			b = (void *)p;
 		} while (--len);
 	}
 
@@ -200,7 +204,9 @@
 	/* Align it */
 	if(unlikely(((long)b)&3 && len)){
 		do {
-			DO_CRC(*((u8 *)b)++);
+			u8 *p = (u8 *)b;
+			DO_CRC(*p++);
+			b = (u32 *)p;
 		} while ((--len) && ((long)b)&3 );
 	}
 	if(likely(len >= 4)){
@@ -221,7 +227,9 @@
 	/* And the last few bytes */
 	if(len){
 		do {
-			DO_CRC(*((u8 *)b)++);
+			u8 *p = (u8 *)b; 
+			DO_CRC(*p++);
+			b = (void *)p;
 		} while (--len);
 	}
 	return __be32_to_cpu(crc);
diff -u linux-34/net/netlink/af_netlink.c-o linux-34/net/netlink/af_netlink.c
--- linux-34/net/netlink/af_netlink.c-o	2003-11-24 04:46:36.000000000 +0100
+++ linux-34/net/netlink/af_netlink.c	2004-01-13 13:31:34.000000000 +0100
@@ -230,7 +230,8 @@
 	sock_init_data(sock,sk);
 	sk_set_owner(sk, THIS_MODULE);
 
-	nlk = nlk_sk(sk) = kmalloc(sizeof(*nlk), GFP_KERNEL);
+	nlk = kmalloc(sizeof(*nlk), GFP_KERNEL);
+	sk->sk_protinfo = nlk;
 	if (!nlk) {
 		sk_free(sk);
 		return -ENOMEM;
diff -u linux-34/net/packet/af_packet.c-o linux-34/net/packet/af_packet.c
--- linux-34/net/packet/af_packet.c-o	2004-01-09 09:27:21.000000000 +0100
+++ linux-34/net/packet/af_packet.c	2004-01-13 13:33:27.000000000 +0100
@@ -961,7 +961,8 @@
 	sock_init_data(sock,sk);
 	sk_set_owner(sk, THIS_MODULE);
 
-	po = pkt_sk(sk) = kmalloc(sizeof(*po), GFP_KERNEL);
+	po = kmalloc(sizeof(*po), GFP_KERNEL);
+	sk->sk_protinfo = po;
 	if (!po)
 		goto out_free;
 	memset(po, 0, sizeof(*po));
diff -u linux-34/init/Kconfig-o linux-34/init/Kconfig
diff -u linux-34/drivers/ieee1394/highlevel.c-o linux-34/drivers/ieee1394/highlevel.c
--- linux-34/drivers/ieee1394/highlevel.c-o	2004-01-09 09:27:12.000000000 +0100
+++ linux-34/drivers/ieee1394/highlevel.c	2004-01-13 14:12:23.000000000 +0100
@@ -504,7 +504,7 @@
                                 rcode = RCODE_TYPE_ERROR;
                         }
 
-			(u8 *)data += partlength;
+			data += partlength;
                         length -= partlength;
                         addr += partlength;
 
@@ -550,7 +550,7 @@
                                 rcode = RCODE_TYPE_ERROR;
                         }
 
-			(u8 *)data += partlength;
+			data += partlength;
                         length -= partlength;
                         addr += partlength;
 
diff -u linux-34/include/linux/efi.h-o linux-34/include/linux/efi.h
--- linux-34/include/linux/efi.h-o	2004-01-09 09:27:19.000000000 +0100
+++ linux-34/include/linux/efi.h	2004-01-13 12:56:20.000000000 +0100
@@ -297,8 +297,8 @@
 extern void efi_initialize_iomem_resources(struct resource *code_resource,
 					struct resource *data_resource);
 extern efi_status_t phys_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc);
-extern unsigned long inline __init efi_get_time(void);
-extern int inline __init efi_set_rtc_mmss(unsigned long nowtime);
+extern unsigned long __init efi_get_time(void);
+extern int __init efi_set_rtc_mmss(unsigned long nowtime);
 extern struct efi_memory_map memmap;
 
 #ifdef CONFIG_EFI
diff -u linux-34/include/linux/sched.h-o linux-34/include/linux/sched.h
--- linux-34/include/linux/sched.h-o	2004-01-09 09:27:20.000000000 +0100
+++ linux-34/include/linux/sched.h	2004-01-13 12:56:30.000000000 +0100
@@ -669,7 +669,7 @@
 extern struct mm_struct * mm_alloc(void);
 
 /* mmdrop drops the mm and the page tables */
-extern inline void FASTCALL(__mmdrop(struct mm_struct *));
+extern void FASTCALL(__mmdrop(struct mm_struct *));
 static inline void mmdrop(struct mm_struct * mm)
 {
 	if (atomic_dec_and_test(&mm->mm_count))
diff -u linux-34/include/linux/reiserfs_fs.h-o linux-34/include/linux/reiserfs_fs.h
--- linux-34/include/linux/reiserfs_fs.h-o	2004-01-09 09:27:20.000000000 +0100
+++ linux-34/include/linux/reiserfs_fs.h	2004-01-13 22:28:16.000000000 +0100
@@ -1781,25 +1781,25 @@
 /* stree.c */
 int B_IS_IN_TREE(const struct buffer_head *);
 extern inline void copy_short_key (void * to, const void * from);
-extern inline void copy_item_head(struct item_head * p_v_to, 
+extern void copy_item_head(struct item_head * p_v_to, 
 								  const struct item_head * p_v_from);
 
 // first key is in cpu form, second - le
-extern inline int comp_keys (const struct key * le_key, 
+extern int comp_keys (const struct key * le_key, 
 			     const struct cpu_key * cpu_key);
-extern inline int  comp_short_keys (const struct key * le_key, 
+extern int  comp_short_keys (const struct key * le_key, 
 				    const struct cpu_key * cpu_key);
-extern inline void le_key2cpu_key (struct cpu_key * to, const struct key * from);
+extern void le_key2cpu_key (struct cpu_key * to, const struct key * from);
 
 // both are cpu keys
-extern inline int comp_cpu_keys (const struct cpu_key *, const struct cpu_key *);
-extern inline int comp_short_cpu_keys (const struct cpu_key *, 
+extern  int comp_cpu_keys (const struct cpu_key *, const struct cpu_key *);
+extern int comp_short_cpu_keys (const struct cpu_key *, 
 				       const struct cpu_key *);
-extern inline void cpu_key2cpu_key (struct cpu_key *, const struct cpu_key *);
+extern void cpu_key2cpu_key (struct cpu_key *, const struct cpu_key *);
 
 // both are in le form
-extern inline int comp_le_keys (const struct key *, const struct key *);
-extern inline int comp_short_le_keys (const struct key *, const struct key *);
+extern int comp_le_keys (const struct key *, const struct key *);
+extern int comp_short_le_keys (const struct key *, const struct key *);
 
 //
 // get key version from on disk key - kludge
diff -u linux-34/include/asm-x86_64/apic.h-o linux-34/include/asm-x86_64/apic.h
--- linux-34/include/asm-x86_64/apic.h-o	2003-08-09 16:48:14.000000000 +0200
+++ linux-34/include/asm-x86_64/apic.h	2004-01-13 12:57:39.000000000 +0100
@@ -79,7 +79,7 @@
 extern void enable_lapic_nmi_watchdog(void);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
-extern inline void nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
+extern void nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
diff -u linux-34/include/asm-x86_64/unistd.h-o linux-34/include/asm-x86_64/unistd.h
--- linux-34/include/asm-x86_64/unistd.h-o	2004-01-09 09:27:19.000000000 +0100
+++ linux-34/include/asm-x86_64/unistd.h	2004-01-13 13:15:06.000000000 +0100
@@ -694,7 +694,7 @@
 }
 
 extern long sys_exit(int) __attribute__((noreturn));
-extern inline long exit(int error_code)
+extern inline void exit(int error_code)
 {
 	sys_exit(error_code);
 }
diff -u linux-34/include/asm-x86_64/hw_irq.h-o linux-34/include/asm-x86_64/hw_irq.h
--- linux-34/include/asm-x86_64/hw_irq.h-o	2004-01-09 09:27:19.000000000 +0100
+++ linux-34/include/asm-x86_64/hw_irq.h	2004-01-13 13:00:36.000000000 +0100
@@ -77,7 +77,7 @@
 
 #ifndef __ASSEMBLY__
 extern u8 irq_vector[NR_IRQ_VECTORS];
-#define IO_APIC_VECTOR(irq)	((int)irq_vector[irq])
+#define IO_APIC_VECTOR(irq)	(irq_vector[irq])
 
 /*
  * Various low-level irq details needed by irq.c, process.c,
diff -u linux-34/include/asm-i386/apic.h-o linux-34/include/asm-i386/apic.h
--- linux-34/include/asm-i386/apic.h-o	2003-09-11 04:12:39.000000000 +0200
+++ linux-34/include/asm-i386/apic.h	2004-01-13 12:57:30.000000000 +0100
@@ -85,7 +85,7 @@
 extern void enable_lapic_nmi_watchdog(void);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
-extern inline void nmi_watchdog_tick (struct pt_regs * regs);
+extern void nmi_watchdog_tick (struct pt_regs * regs);
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
diff -u linux-34/include/asm-i386/unistd.h-o linux-34/include/asm-i386/unistd.h
--- linux-34/include/asm-i386/unistd.h-o	2003-10-09 00:28:59.000000000 +0200
+++ linux-34/include/asm-i386/unistd.h	2004-01-13 13:15:31.000000000 +0100
@@ -394,7 +394,7 @@
 static inline _syscall3(int,execve,const char *,file,char **,argv,char **,envp)
 static inline _syscall3(int,open,const char *,file,int,flag,int,mode)
 static inline _syscall1(int,close,int,fd)
-static inline _syscall1(int,_exit,int,exitcode)
+static inline _syscall1(void,_exit,int,exitcode)
 static inline _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
 
 #endif
diff -u linux-34/include/asm-i386/hw_irq.h-o linux-34/include/asm-i386/hw_irq.h
--- linux-34/include/asm-i386/hw_irq.h-o	2004-01-09 09:27:18.000000000 +0100
+++ linux-34/include/asm-i386/hw_irq.h	2004-01-13 13:00:26.000000000 +0100
@@ -26,7 +26,7 @@
  */
 
 extern u8 irq_vector[NR_IRQ_VECTORS];
-#define IO_APIC_VECTOR(irq)	((int)irq_vector[irq])
+#define IO_APIC_VECTOR(irq)	(irq_vector[irq])
 
 extern void (*interrupt[NR_IRQS])(void);
 
