Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261903AbTCQTWL>; Mon, 17 Mar 2003 14:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261909AbTCQTWK>; Mon, 17 Mar 2003 14:22:10 -0500
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:25077 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id <S261903AbTCQTWG>;
	Mon, 17 Mar 2003 14:22:06 -0500
From: wind@cocodriloo.com
Date: Mon, 17 Mar 2003 20:34:11 +0100
To: wind-lkml@cocodriloo.com
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Alex Tomas <bzzz@tmi.comex.ru>, riel@surriel.com, akpm@digeo.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4 vm, program load, page faulting, ...
Message-ID: <20030317193411.GE11526@wind.cocodriloo.com>
References: <20030317151004.GR20188@holomorphy.com> <20030317171246.GB11526@wind.cocodriloo.com> <20030317173851.GC11526@wind.cocodriloo.com> <200303171957.49233.m.c.p@wolk-project.de> <20030317190636.GD11526@wind.cocodriloo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bAmEntskrkuBymla"
Content-Disposition: inline
In-Reply-To: <20030317190636.GD11526@wind.cocodriloo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 17, 2003 at 08:06:36PM +0100, wind-lkml@cocodriloo.com wrote:
> On Mon, Mar 17, 2003 at 07:57:49PM +0100, Marc-Christian Petersen wrote:
> > On Monday 17 March 2003 18:38, wind-lkml@cocodriloo.com wrote:
> > 
> > Hi Wind,
> > 
> > > > I wonder if this could be done by walking and faulting
> > > > all pages at fs/binfmt_elf.c::elf_map just after do_mmap...
> > > > will try it just now :)
> > >
> > > OK, this is not tested, since I'm compiling it now... feel free
> > > to correct :)
> > 
> > mm/mmap.c:
> > 
> > unsigned long do_mmap_pgoff(struct file * file, unsigned long addr, unsigned 
> > long len,
> >         unsigned long prot, unsigned long flags, unsigned long pgoff)
> > {
> > 
> > your "do_mmap_pgoff" calls 7 arguments. Obviously it cannot compile 8-)
> > 
> 
> My first patch, I'm just becoming intimate with printk ;)

OK, so I took a different approach, and just called handle_mm_fault just
like if there had been user-level accesses to the file.

Applied on 2.5.63-uml1 and booted debian woody with it.

Can any of you try it on a real machine? (I dont have a test machine :(

Greets, Antonio.


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="prefault.patch"

--- orig/fs/binfmt_elf.c	Mon Mar 17 20:30:17 2003
+++ work/fs/binfmt_elf.c	Mon Mar 17 20:30:29 2003
@@ -259,12 +259,26 @@ create_elf_tables(struct linux_binprm *b
 static inline unsigned long
 elf_map (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type)
 {
-	unsigned long map_addr;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	unsigned long map_addr, n;
 
 	down_write(&current->mm->mmap_sem);
 	map_addr = do_mmap(filep, ELF_PAGESTART(addr),
 			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr), prot, type,
 			   eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
+
+
+	addr = ELF_PAGESTART(addr);
+	mm = current->mm;
+	vma = find_vma(mm, addr);
+	if(!vma)
+		goto out;
+
+	for(n = 0; n < eppnt->p_filesz; n+=PAGE_SIZE)
+		handle_mm_fault(mm, vma, addr + n, 0);
+
+out:
 	up_write(&current->mm->mmap_sem);
 	return(map_addr);
 }

--bAmEntskrkuBymla--
