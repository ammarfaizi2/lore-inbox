Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWGFXYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWGFXYR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 19:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWGFXYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 19:24:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38091 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751045AbWGFXYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 19:24:16 -0400
Date: Thu, 6 Jul 2006 16:27:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: dhowells@redhat.com, torvalds@osdl.org, bernds_cb1@t-online.de,
       sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] FDPIC: Add coredump capability for the ELF-FDPIC
 binfmt [try #3]
Message-Id: <20060706162731.577748e7.akpm@osdl.org>
In-Reply-To: <26133.1152211129@warthog.cambridge.redhat.com>
References: <20060706105223.97b9a531.akpm@osdl.org>
	<20060706124716.7098.5752.stgit@warthog.cambridge.redhat.com>
	<20060706124727.7098.44363.stgit@warthog.cambridge.redhat.com>
	<26133.1152211129@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > llseek takes a loff_t and file->f_pos is loff_t.  I guess it's a bit moot
> > on such a CPU.  Was it deliberate?
> 
> It compiles with no error and no warning, so I haven't noticed.  This is as
> binfmt_elf.c is, I believe, so that is probably wrong too.

binfmt_elf uses loff_t.

> > (how come the kernel doesn't have a SEEK_SET #define?)
> 
> I don't know.  It probably should.
> 
> > Three callsites - seems too large to inline.
> 
> Again taken from binfmt_elf.c, although I added the debugging stuff.  It
> shouldn't matter as the compiler will make its own decision (or does "inline"
> get #defined to always-inline nowadays?).

Yes, we still play games with inline (include/linux/compiler*.h)

If it has a single callsite, leave it uninlined and gcc will usually inline
it.  If it has multiple callsites then leave it uninlined and gcc will
(hopefully) not inline it.  So omitting the inline is usually the right
thing to do.

> > Which seems reasonable to me.  I'll steal it from them.
> 
> Okay.
> 
> > Embedding returns and gotos in macros is evil.  For new code it's worth
> > doing it vaguely tastefully.
> 
> Again, stolen verbatim from binfmt_elf.c.  I'd prefer to keep it comparable by
> the blink-comparator method if possible.

Well..  copy-n-paste from a bad source gives a bad dest.

diff -puN fs/binfmt_elf.c~binfmt_elf-macro-cleanup fs/binfmt_elf.c
--- a/fs/binfmt_elf.c~binfmt_elf-macro-cleanup
+++ a/fs/binfmt_elf.c
@@ -1207,11 +1207,6 @@ static int notesize(struct memelfnote *e
 	return sz;
 }
 
-#define DUMP_WRITE(addr, nr)	\
-	do { if (!dump_write(file, (addr), (nr))) return 0; } while(0)
-#define DUMP_SEEK(off)	\
-	do { if (!dump_seek(file, (off))) return 0; } while(0)
-
 static int writenote(struct memelfnote *men, struct file *file)
 {
 	struct elf_note en;
@@ -1220,24 +1215,21 @@ static int writenote(struct memelfnote *
 	en.n_descsz = men->datasz;
 	en.n_type = men->type;
 
-	DUMP_WRITE(&en, sizeof(en));
-	DUMP_WRITE(men->name, en.n_namesz);
+	if (!dump_write(&en, sizeof(en)))
+		goto err;
+	if (!dump_write(men->name, en.n_namesz))
+		goto err;
 	/* XXX - cast from long long to long to avoid need for libgcc.a */
-	DUMP_SEEK(roundup((unsigned long)file->f_pos, 4));	/* XXX */
-	DUMP_WRITE(men->data, men->datasz);
-	DUMP_SEEK(roundup((unsigned long)file->f_pos, 4));	/* XXX */
-
+	if (!dump_seek(roundup((unsigned long)file->f_pos, 4)))
+		goto err;
+	if (!dump_write(men->data, men->datasz))
+		goto err;
+	if (!dump_seek(roundup((unsigned long)file->f_pos, 4)))
+		goto err;
 	return 1;
+err:
+	return 0;
 }
-#undef DUMP_WRITE
-#undef DUMP_SEEK
-
-#define DUMP_WRITE(addr, nr)	\
-	if ((size += (nr)) > limit || !dump_write(file, (addr), (nr))) \
-		goto end_coredump;
-#define DUMP_SEEK(off)	\
-	if (!dump_seek(file, (off))) \
-		goto end_coredump;
 
 static void fill_elf_header(struct elfhdr *elf, int segs)
 {
@@ -1555,7 +1547,11 @@ static int elf_core_dump(long signr, str
 	fs = get_fs();
 	set_fs(KERNEL_DS);
 
-	DUMP_WRITE(elf, sizeof(*elf));
+	size += sizeof(*elf);
+	if (size > limit)
+		goto end_coredump;
+	if (!dump_write(file, elf, sizeof(*elf))
+		goto end_coredump;
 	offset += sizeof(*elf);				/* Elf header */
 	offset += (segs+1) * sizeof(struct elf_phdr);	/* Program headers */
 
@@ -1571,7 +1567,11 @@ static int elf_core_dump(long signr, str
 
 		fill_elf_note_phdr(&phdr, sz, offset);
 		offset += sz;
-		DUMP_WRITE(&phdr, sizeof(phdr));
+		size += sizeof(phdr);
+		if (size > limit)
+			goto end_coredump;
+		if (!dump_write(file, &phdr, sizeof(phdr))
+			goto end_coredump;
 	}
 
 	/* Page-align dumped data */
@@ -1598,7 +1598,11 @@ static int elf_core_dump(long signr, str
 			phdr.p_flags |= PF_X;
 		phdr.p_align = ELF_EXEC_PAGESIZE;
 
-		DUMP_WRITE(&phdr, sizeof(phdr));
+		size += sizeof(phdr);
+		if (size > limit)
+			goto end_coredump;
+		if (!dump_write(file, &phdr, sizeof(phdr))
+			goto end_coredump;
 	}
 
 #ifdef ELF_CORE_WRITE_EXTRA_PHDRS
@@ -1620,7 +1624,8 @@ static int elf_core_dump(long signr, str
 				goto end_coredump;
 	}
  
-	DUMP_SEEK(dataoff);
+	if (!dump_seek(file, dataoff))
+		goto end_coredump;
 
 	for (vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
 		unsigned long addr;
@@ -1636,10 +1641,13 @@ static int elf_core_dump(long signr, str
 
 			if (get_user_pages(current, current->mm, addr, 1, 0, 1,
 						&page, &vma) <= 0) {
-				DUMP_SEEK(file->f_pos + PAGE_SIZE);
+				if (!dump_seek(file, file->f_pos + PAGE_SIZE))
+					goto end_coredump
 			} else {
 				if (page == ZERO_PAGE(addr)) {
-					DUMP_SEEK(file->f_pos + PAGE_SIZE);
+					if (!dump_seek(file,
+						       file->f_pos + PAGE_SIZE))
+						goto end_coredump;
 				} else {
 					void *kaddr;
 					flush_cache_page(vma, addr,
_

