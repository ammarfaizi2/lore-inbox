Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261786AbTCQR0v>; Mon, 17 Mar 2003 12:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261798AbTCQR0u>; Mon, 17 Mar 2003 12:26:50 -0500
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:31468 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id <S261786AbTCQR0t>;
	Mon, 17 Mar 2003 12:26:49 -0500
Date: Mon, 17 Mar 2003 18:38:51 +0100
From: wind-lkml@cocodriloo.com
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: riel@surriel.com, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4 vm, program load, page faulting, ...
Message-ID: <20030317173851.GC11526@wind.cocodriloo.com>
References: <20030317151004.GR20188@holomorphy.com> <Pine.LNX.4.44.0303171100300.2571-100000@chimarrao.boston.redhat.com> <20030317165223.GA11526@wind.cocodriloo.com> <m3hea2gcoz.fsf@lexa.home.net> <20030317171246.GB11526@wind.cocodriloo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <20030317171246.GB11526@wind.cocodriloo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 17, 2003 at 06:12:46PM +0100, wind-lkml@cocodriloo.com wrote:
> On Mon, Mar 17, 2003 at 07:50:04PM +0300, Alex Tomas wrote:
> > >>>>> wind  (w) writes:
> > 
> >  w> On Mon, Mar 17, 2003 at 11:01:31AM -0500, Rik van Riel wrote:
> >  >> On Mon, 17 Mar 2003, William Lee Irwin III wrote:
> >  >> > On Sat, 15 Mar 2003, Paul Albrecht wrote:
> >  >> > >> ... Why does the kernel page fault on text pages, present in
> >  >> the page > >> cache, when a program starts? Couldn't the pte's for
> >  >> text present in the > >> page cache be resolved when they're
> >  >> mapped to memory?
> >  >> > 
> > 
> >  w> You should ask Andrew about his patch to do exactly that: he
> >  w> forced all PROC_EXEC mmaps to be nonlinear-mapped and this forced
> >  w> all programs to suck entire binaries into memory...  I recall he
> >  w> saw at least 25% improvement at launching gnome.
> > 
> > they talked about pages _already present_ in pagecache.
> 
> I wonder if this could be done by walking and faulting
> all pages at fs/binfmt_elf.c::elf_map just after do_mmap...
> will try it just now :)

OK, this is not tested, since I'm compiling it now... feel free
to correct :)


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="binfmt_elf.c.diff"

--- orig/fs/binfmt_elf.c	Mon Mar 17 18:26:59 2003
+++ work/fs/binfmt_elf.c	Mon Mar 17 18:26:31 2003
@@ -259,12 +259,23 @@ create_elf_tables(struct linux_binprm *b
 static inline unsigned long
 elf_map (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type)
 {
-	unsigned long map_addr;
+	unsigned long map_addr, pgoff;
+	struct mm *mm;
 
 	down_write(&current->mm->mmap_sem);
 	map_addr = do_mmap(filep, ELF_PAGESTART(addr),
 			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr), prot, type,
 			   eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
+
+	/* preload elf image  */
+
+	mm = current->mm;
+	addr = ELF_PAGESTART(addr);
+	for(pgoff = 0; pgoff < eppnt->p_filesz;){
+		do_mmap_pgoff(mm, filep, addr, PAGE_SIZE, prot, type, pgoff);
+		addr += PAGE_SIZE;
+		pgoff += PAGE_SIZE;
+	}
 
 	up_write(&current->mm->mmap_sem);
 	return(map_addr);

--jho1yZJdad60DJr+--
