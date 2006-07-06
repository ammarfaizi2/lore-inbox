Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030371AbWGFRwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbWGFRwg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 13:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbWGFRwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 13:52:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11198 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030371AbWGFRwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 13:52:34 -0400
Date: Thu, 6 Jul 2006 10:52:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, bernds_cb1@t-online.de, sam@ravnborg.org,
       dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] FDPIC: Add coredump capability for the ELF-FDPIC
 binfmt [try #3]
Message-Id: <20060706105223.97b9a531.akpm@osdl.org>
In-Reply-To: <20060706124727.7098.44363.stgit@warthog.cambridge.redhat.com>
References: <20060706124716.7098.5752.stgit@warthog.cambridge.redhat.com>
	<20060706124727.7098.44363.stgit@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2006 13:47:27 +0100
David Howells <dhowells@redhat.com> wrote:

> From: David Howells <dhowells@redhat.com>
> 
> Add coredump capability for the ELF-FDPIC binfmt.
> 
> ..
>
> +static int dump_seek(struct file *file, off_t off)
> +{
> +	if (file->f_op->llseek) {
> +		if (file->f_op->llseek(file, off, 0) != off)
> +			return 0;
> +	} else {
> +		file->f_pos = off;
> +	}
> +	return 1;
> +}

llseek takes a loff_t and file->f_pos is loff_t.  I guess it's a bit moot
on such a CPU.  Was it deliberate?

(how come the kernel doesn't have a SEEK_SET #define?)

> +/*
> + * Decide whether a segment is worth dumping; default is yes to be
> + * sure (missing info is worse than too much; etc).
> + * Personally I'd include everything, and use the coredump limit...
> + *
> + * I think we should skip something. But I am not sure how. H.J.
> + */
> +static inline int maydump(struct vm_area_struct *vma)
> +{
> +	/* Do not dump I/O mapped devices or special mappings */
> +	if (vma->vm_flags & (VM_IO | VM_RESERVED)) {
> +		kdcore("%08lx: %08lx: no (IO)", vma->vm_start, vma->vm_flags);
> +		return 0;
> +	}
> +
> +	/* If we may not read the contents, don't allow us to dump
> +	 * them either. "dump_write()" can't handle it anyway.
> +	 */
> +	if (!(vma->vm_flags & VM_READ)) {
> +		kdcore("%08lx: %08lx: no (!read)", vma->vm_start, vma->vm_flags);
> +		return 0;
> +	}
> +
> +	/* Dump shared memory only if mapped from an anonymous file. */
> +	if (vma->vm_flags & VM_SHARED) {
> +		if (vma->vm_file->f_dentry->d_inode->i_nlink == 0) {
> +			kdcore("%08lx: %08lx: no (share)", vma->vm_start, vma->vm_flags);
> +			return 1;
> +		}
> +
> +		kdcore("%08lx: %08lx: no (share)", vma->vm_start, vma->vm_flags);
> +		return 0;
> +	}
> +
> +#ifdef CONFIG_MMU
> +	/* If it hasn't been written to, don't write it out */
> +	if (!vma->anon_vma) {
> +		kdcore("%08lx: %08lx: no (!anon)", vma->vm_start, vma->vm_flags);
> +		return 0;
> +	}
> +#endif
> +
> +	kdcore("%08lx: %08lx: yes", vma->vm_start, vma->vm_flags);
> +	return 1;
> +}

Three callsites - seems too large to inline.

> +#define roundup(x, y)  ((((x) + ((y) - 1)) / (y)) * (y))

The GFS2 tree has 

--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -32,6 +32,7 @@ #define STACK_MAGIC	0xdeadbeef
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 #define ALIGN(x,a) (((x)+(a)-1)&~((a)-1))
+#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
 #define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
 
 #define	KERN_EMERG	"<0>"	/* system is unusable			*/

Which seems reasonable to me.  I'll steal it from them.

> +/* #define DEBUG */
> +
> +#define DUMP_WRITE(addr, nr)	\
> +	do { if (!dump_write(file, (addr), (nr))) return 0; } while(0)
> +#define DUMP_SEEK(off)	\
> +	do { if (!dump_seek(file, (off))) return 0; } while(0)
>
> ...
>
> +#undef DUMP_WRITE
> +#undef DUMP_SEEK
> +
> +#define DUMP_WRITE(addr, nr)	\
> +	if ((size += (nr)) > limit || !dump_write(file, (addr), (nr))) \
> +		goto end_coredump;
> +#define DUMP_SEEK(off)	\
> +	if (!dump_seek(file, (off))) \
> +		goto end_coredump;

Embedding returns and gotos in macros is evil.  For new code it's worth
doing it vaguely tastefully.

	ret = dump_write(...);
	if (ret < 0)
		goto actually_return_an_error_code;

> +	for (vml = current->mm->context.vmlist; vml; vml = vml->next)
> +	    segs++;

Does this need locking?


