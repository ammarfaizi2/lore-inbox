Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261988AbTCQW4f>; Mon, 17 Mar 2003 17:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262001AbTCQW4f>; Mon, 17 Mar 2003 17:56:35 -0500
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:42476 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id <S261988AbTCQW4c>;
	Mon, 17 Mar 2003 17:56:32 -0500
From: wind@cocodriloo.com
Date: Tue, 18 Mar 2003 00:08:39 +0100
To: Andrew Morton <akpm@digeo.com>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, wind@cocodriloo.com, riel@surriel.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4 vm, program load, page faulting, ...
Message-ID: <20030317230839.GG11526@wind.cocodriloo.com>
References: <20030317151004.GR20188@holomorphy.com> <Pine.LNX.4.44.0303171100300.2571-100000@chimarrao.boston.redhat.com> <20030317165223.GA11526@wind.cocodriloo.com> <m3hea2gcoz.fsf@lexa.home.net> <20030317140506.686282a5.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7DO5AaGCk89r4vaK"
Content-Disposition: inline
In-Reply-To: <20030317140506.686282a5.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 17, 2003 at 02:05:06PM -0800, Andrew Morton wrote:
> Alex Tomas <bzzz@tmi.comex.ru> wrote:
> >
> >  w> You should ask Andrew about his patch to do exactly that: he
> >  w> forced all PROC_EXEC mmaps to be nonlinear-mapped and this forced
> >  w> all programs to suck entire binaries into memory...  I recall he
> >  w> saw at least 25% improvement at launching gnome.
> > 
> > they talked about pages _already present_ in pagecache.
> 
> 2.5.64-mm8 does that too.  At mmap-time it will, for a PROT_EXEC mapping,
> pull every affected page off disk and it will instantiate pte's against
> them all via install_page().
> 
> So there should be zero major and minor faults against that mmap region
> during application startup.
> 
> The improved IO layout appears to halve startup time for big things.  I
> haven't attempted to instrument the effects of the reduced minor fault rate. 
> If indeed the rate _has_ decreased.  If it hasn't, it's a bug...
> 
> 
> 
> This is all a bit dubious for several reasons.  Most particularly, the
> up-front instantiation of the pages in pagetables makes unneeded pages harder
> to reclaim.  It would be really neat if someone could try putting the
> madvise(MADV_WILLNEED) into glibc and test that.  Maybe on a 2.4 kernel.


something like this one?


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="prefault-madvise.patch"

--- base/fs/binfmt_elf.c	Mon Mar 17 23:44:55 2003
+++ work/fs/binfmt_elf.c	Tue Mar 18 00:03:34 2003
@@ -256,6 +256,8 @@ create_elf_tables(struct linux_binprm *b
 
 #ifndef elf_map
 
+asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
+
 static inline unsigned long
 elf_map (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type)
 {
@@ -266,6 +268,10 @@ elf_map (struct file *filep, unsigned lo
 			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr), prot, type,
 			   eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
 	up_write(&current->mm->mmap_sem);
+
+	if(prot & PROT_EXEC)
+		sys_madvise(map_addr, eppnt->p_filesz, MADV_WILLNEED);
+
 	return(map_addr);
 }
 

--7DO5AaGCk89r4vaK--
