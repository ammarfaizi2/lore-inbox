Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261517AbSJYRym>; Fri, 25 Oct 2002 13:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbSJYRyl>; Fri, 25 Oct 2002 13:54:41 -0400
Received: from ns.suse.de ([213.95.15.193]:12809 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261517AbSJYRyi>;
	Fri, 25 Oct 2002 13:54:38 -0400
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "'Mario Smarduch'" <cms063@email.mot.com>,
       IA64 Linux Mail Group <linux-ia64@linuxia64.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fixing /proc/kcore
References: <39B5C4829263D411AA93009027AE9EBB1EF28F7B@fmsmsx35.fm.intel.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 25 Oct 2002 20:00:52 +0200
In-Reply-To: "Luck, Tony"'s message of "25 Oct 2002 19:50:59 +0200"
Message-ID: <p73bs5itn3f.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luck, Tony" <tony.luck@intel.com> writes:

> This message is in MIME format. Since your mail reader does not understand
> this format, some or all of this message may not be legible.
> 
> ------_=_NextPart_000_01C27C4E.CD496DB0
> Content-Type: text/plain;
> 	charset="utf-7"
> 
> /proc/kcore is what you need, but it is broken on ia64 (and
> has been since the dawn of time for access to region 5) because
> it assumes that all kernel virtual addresses are above PAGE+AF8-OFFSET.
> This isn't true on ia64, VMALLOC+AF8-START is smaller than PAGE+AF8-OFFSET.

I recently fixed a similar problem on x86-64. There the modules are outside
the vmalloc area, but also not in the direct mapping. I just changed
the module mapping and the kernel mapping to put themselves into the vmlist.
kcore checks vmlist first and then afterwards tries direct addresses.

Also the kernel addresses are negative, which needed some more changes
in seek.

Here is the 2.4.19 patch which should to 2.5 too.

I think it's a bit cleaner than yours and will probably help you too.
Just put everything special into vmlist too.

-Andi

Index: linux/fs/proc/inode.c
===================================================================
RCS file: /home/cvs/Repository/linux/fs/proc/inode.c,v
retrieving revision 1.4
retrieving revision 1.5
diff -u -u -r1.4 -r1.5
--- linux/fs/proc/inode.c	2002/01/15 10:09:21	1.4
--- linux/fs/proc/inode.c	2002/10/17 13:02:13	1.5
@@ -186,6 +186,7 @@
 	s->s_blocksize_bits = 10;
 	s->s_magic = PROC_SUPER_MAGIC;
 	s->s_op = &proc_sops;
+	s->s_maxbytes = ~0ULL;
 	
 	root_inode = proc_get_inode(s, PROC_ROOT_INO, &proc_root);
 	if (!root_inode)
Index: linux/fs/proc/kcore.c
===================================================================
RCS file: /home/cvs/Repository/linux/fs/proc/kcore.c,v
retrieving revision 1.3
retrieving revision 1.4
diff -u -u -r1.3 -r1.4
--- linux/fs/proc/kcore.c	2002/03/21 11:54:59	1.3
--- linux/fs/proc/kcore.c	2002/10/17 13:02:13	1.4
@@ -27,11 +27,14 @@
 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
 }
 
+static loff_t lseek_kcore(struct file * file, loff_t offset, int origin);
+
 static ssize_t read_kcore(struct file *, char *, size_t, loff_t *);
 
 struct file_operations proc_kcore_operations = {
 	read:		read_kcore,
 	open:		open_kcore,
+	lseek:		lseek_kcore,
 };
 
 #ifdef CONFIG_KCORE_AOUT
@@ -112,9 +115,9 @@
 
 extern char saved_command_line[];
 
-static size_t get_kcore_size(int *num_vma, size_t *elf_buflen)
+static unsigned long get_kcore_size(int *num_vma, size_t *elf_buflen)
 {
-	size_t try, size;
+	unsigned long try, size;
 	struct vm_struct *m;
 
 	*num_vma = 0;
@@ -125,7 +128,7 @@
 	}
 
 	for (m=vmlist; m; m=m->next) {
-		try = (size_t)m->addr + m->size;
+		try = (unsigned long)m->addr + m->size;
 		if (try > size)
 			size = try;
 		*num_vma = *num_vma + 1;
@@ -313,14 +316,14 @@
 static ssize_t read_kcore(struct file *file, char *buffer, size_t buflen, loff_t *fpos)
 {
 	ssize_t acc = 0;
-	size_t size, tsz;
+	unsigned long size, tsz;
 	size_t elf_buflen;
 	int num_vma;
 	unsigned long start;
 
 	read_lock(&vmlist_lock);
 	proc_root_kcore->size = size = get_kcore_size(&num_vma, &elf_buflen);
-	if (buflen == 0 || *fpos >= size) {
+	if (buflen == 0 || (unsigned long long)*fpos >= size) {
 		read_unlock(&vmlist_lock);
 		return 0;
 	}
@@ -390,9 +393,16 @@
 	start = PAGE_OFFSET + (*fpos - elf_buflen);
 	if ((tsz = (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)
 		tsz = buflen;
-		
 	while (buflen) {
-		if ((start >= VMALLOC_START) && (start < VMALLOC_END)) {
+		int err; 
+	
+		if ((start > PAGE_OFFSET) && (start < (unsigned long)high_memory)) {
+			if (kern_addr_valid(start)) {
+				err = copy_to_user(buffer, (char *)start, tsz);
+			} else {
+				err = clear_user(buffer, tsz);
+			}
+		} else {
 			char * elf_buf;
 			struct vm_struct *m;
 			unsigned long curstart = start;
@@ -432,24 +442,11 @@
 					(char *)vmstart, vmsize);
 			}
 			read_unlock(&vmlist_lock);
-			if (copy_to_user(buffer, elf_buf, tsz)) {
-				kfree(elf_buf);
-				return -EFAULT;
-			}
+			err = copy_to_user(buffer, elf_buf, tsz); 
 			kfree(elf_buf);
-		} else if ((start > PAGE_OFFSET) && (start < 
-						(unsigned long)high_memory)) {
-			if (kern_addr_valid(start)) {
-				if (copy_to_user(buffer, (char *)start, tsz))
-					return -EFAULT;
-			} else {
-				if (clear_user(buffer, tsz))
-					return -EFAULT;
-			}
-		} else {
-			if (clear_user(buffer, tsz))
-				return -EFAULT;
-		}
+		} 	
+		if (err)
+			return -EFAULT; 
 		buflen -= tsz;
 		*fpos += tsz;
 		buffer += tsz;
@@ -461,3 +458,19 @@
 	return acc;
 }
 #endif /* CONFIG_KCORE_AOUT */
+
+static loff_t lseek_kcore(struct file * file, loff_t offset, int origin)
+{
+	long long retval;
+
+	switch (origin) {
+		case 2:
+			offset += file->f_dentry->d_inode->i_size;
+			break;
+		case 1:
+			offset += file->f_pos;
+	}
+	/* RED-PEN user can fake an error here by setting offset to >=-4095 && <0  */
+	file->f_pos = offset;
+	return offset;
+}
