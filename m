Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135593AbREHXsu>; Tue, 8 May 2001 19:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135595AbREHXsk>; Tue, 8 May 2001 19:48:40 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:36303 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S135593AbREHXse>; Tue, 8 May 2001 19:48:34 -0400
Date: Wed, 9 May 2001 01:46:35 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org, linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] 2.4.4: mmap() fails for certain legal requests
In-Reply-To: <15096.27432.381478.837650@pizda.ninka.net>
Message-ID: <Pine.GSO.3.96.1010508235846.4713H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 May 2001, David S. Miller wrote:

> That's pretty arrogant that cut and pasting a few lines into some
> architecture specific files and reporting the updated patch is too
> much to ask.

 I'm sorry if you find me arrogant -- that certainly was not my intent.  I
did look at the files and changes are not as trivial as cut and paste.

> Perhaps reviewing your change is also, too much to ask.  Perhaps
> we are too lazy and short on time to have a look at your change.

 Well, I've been using similar changes since July.  I may live with
patches forever and be fine.  Still this is not the point with free
software.  It would be malicious if I had a fix and I wouldn't share it. 
Sooner or later someone would discover the problem again and would waste
time to track it down unnecessarily.  And again, and again...

> I don't think it's asking a lot to provide a complete change.

 It's not a lot, supposedly, but look at the case from my point of view. 
It's a bugfix and not a new feature.  I've invested a few hours in finding
the cause of a weird bug on a MIPS/Linux machine.  I am providing a ready
solution that works for most architectures with the exception of a few
ones I'm not familiar with. 

 Well, it's great I have an opportunity to get better knowledge on these
architectures, but I cannot always afford it and I know there are people
who already have enough knowledge to be sure bits get written correctly
immediately.  I never hesitate to do job myself in the areas I am familiar
with or when I have enough free time (and I do have, from time to time). 
I don't have time currently, I am afraid (basically I am now stealing the
time I would otherwise spend sleeping for a task that was quite low on my
priority list) and I am sure someone familiar with the specific ports
would spend less time than I do.  Finally I do consider my time equally
worth to anyone else's one, so why should I have to spend x units of time,
whilst some else would only spend x/2 or x/3 or whatever...  Of course I
consider this rule working both ways. 

> I'm sure the MIPS folks know all too well whats it's like when their
> port is crapped up because someone only made changes to x86 port
> portions.  At least for me on after working on Sparc for some time,
> I'm adamant about providing complete changes so that this kind of
> grief is avoided for other port maintainers.

 The port gets crapped from time to time, although Ralf is doing great job
to keep it fine, so it's more that specific MIPS hosts lag behind the rest
of the kernel.  Still I consider it the specific maintainer's job to get
things synchronized.  It just works better this way. 

> In the time you used to compose your response to me, and now
> to read this email from me, you could have fixed up the patch
> perhaps 2 or 3 times.  Just do it and get it over with ok?

 I'm not so sure, I'm afraid, especially at this time of the day.  Check
timestamps of mails if curious... 

> Dziekuje.

 Nie za ma co. ;-)

 A patch follows.  Architecture-specific changes are completely untested. 
I hope I got things right, otherwise I'll consider my time wasted.

 BTW, I've noticed the "if (flags & MAP_FIXED)" statements in
arch_get_unmapped_area() in arch/sparc*/kernel/sys_sparc.c are dead code
now, as get_unmapped_area() in mm/mmap.c never calls it if MAP_FIXED is
set in flags.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

diff -up --recursive --new-file linux-2.4.4.macro/arch/ia64/kernel/sys_ia64.c linux-2.4.4/arch/ia64/kernel/sys_ia64.c
--- linux-2.4.4.macro/arch/ia64/kernel/sys_ia64.c	Mon May  7 16:43:50 2001
+++ linux-2.4.4/arch/ia64/kernel/sys_ia64.c	Tue May  8 23:25:49 2001
@@ -28,13 +28,22 @@ arch_get_unmapped_area (struct file *fil
 
 	if (len > RGN_MAP_LIMIT)
 		return -ENOMEM;
-	if (!addr)
-		addr = TASK_UNMAPPED_BASE;
 
+	if (addr) {
+		if (flags & MAP_SHARED)
+			addr = COLOR_ALIGN(addr);
+		else
+			addr = PAGE_ALIGN(addr);
+		vmm = find_vma(current->mm, addr);
+		if (TASK_SIZE - len >= addr &&
+		    rgn_offset(addr) + len <= RGN_MAP_LIMIT) &&
+		    (!vmm || addr + len <= vmm->vm_start))
+			return addr;
+	}
 	if (flags & MAP_SHARED)
-		addr = COLOR_ALIGN(addr);
+		addr = COLOR_ALIGN(TASK_UNMAPPED_BASE);
 	else
-		addr = PAGE_ALIGN(addr);
+		addr = PAGE_ALIGN(TASK_UNMAPPED_BASE);
 
 	for (vmm = find_vma(current->mm, addr); ; vmm = vmm->vm_next) {
 		/* At this point:  (!vmm || addr < vmm->vm_end). */
diff -up --recursive --new-file linux-2.4.4.macro/arch/sparc/kernel/sys_sparc.c linux-2.4.4/arch/sparc/kernel/sys_sparc.c
--- linux-2.4.4.macro/arch/sparc/kernel/sys_sparc.c	Mon May  7 16:22:42 2001
+++ linux-2.4.4/arch/sparc/kernel/sys_sparc.c	Tue May  8 22:50:51 2001
@@ -54,17 +54,31 @@ unsigned long arch_get_unmapped_area(str
 		return -ENOMEM;
 	if (ARCH_SUN4C_SUN4 && len > 0x20000000)
 		return -ENOMEM;
-	if (!addr)
-		addr = TASK_UNMAPPED_BASE;
 
+	if (addr) {
+		if (flags & MAP_SHARED)
+			addr = COLOR_ALIGN(addr);
+		else
+			addr = PAGE_ALIGN(addr);
+		vmm = find_vma(current->mm, addr);
+		if (ARCH_SUN4C_SUN4 && addr < 0xe0000000 &&
+		    0x20000000 - len < addr) {
+			addr = PAGE_OFFSET;
+			vmm = find_vma(current->mm, PAGE_OFFSET);
+		}
+		if (TASK_SIZE - PAGE_SIZE - len >= addr &&
+		    (!vmm || addr + len <= vmm->vm_start))
+			return addr;
+	}
 	if (flags & MAP_SHARED)
-		addr = COLOUR_ALIGN(addr);
+		addr = COLOR_ALIGN(TASK_UNMAPPED_BASE);
 	else
-		addr = PAGE_ALIGN(addr);
+		addr = PAGE_ALIGN(TASK_UNMAPPED_BASE);
 
 	for (vmm = find_vma(current->mm, addr); ; vmm = vmm->vm_next) {
 		/* At this point:  (!vmm || addr < vmm->vm_end). */
-		if (ARCH_SUN4C_SUN4 && addr < 0xe0000000 && 0x20000000 - len < addr) {
+		if (ARCH_SUN4C_SUN4 && addr < 0xe0000000 &&
+		    0x20000000 - len < addr) {
 			addr = PAGE_OFFSET;
 			vmm = find_vma(current->mm, PAGE_OFFSET);
 		}
diff -up --recursive --new-file linux-2.4.4.macro/arch/sparc64/kernel/sys_sparc.c linux-2.4.4/arch/sparc64/kernel/sys_sparc.c
--- linux-2.4.4.macro/arch/sparc64/kernel/sys_sparc.c	Mon May  7 16:44:01 2001
+++ linux-2.4.4/arch/sparc64/kernel/sys_sparc.c	Tue May  8 22:30:09 2001
@@ -60,15 +60,27 @@ unsigned long arch_get_unmapped_area(str
 		task_size = 0xf0000000UL;
 	if (len > task_size || len > -PAGE_OFFSET)
 		return -ENOMEM;
-	if (!addr)
-		addr = TASK_UNMAPPED_BASE;
 
+	task_size -= len;
+
+	if (addr) {
+		if (flags & MAP_SHARED)
+			addr = COLOR_ALIGN(addr);
+		else
+			addr = PAGE_ALIGN(addr);
+		vmm = find_vma(current->mm, addr);
+		if (addr < PAGE_OFFSET && -PAGE_OFFSET - len < addr) {
+			addr = PAGE_OFFSET;
+			vmm = find_vma(current->mm, PAGE_OFFSET);
+		}
+		if (task_size >= addr &&
+		    (!vmm || addr + len <= vmm->vm_start))
+			return addr;
+	}
 	if (flags & MAP_SHARED)
-		addr = COLOUR_ALIGN(addr);
+		addr = COLOR_ALIGN(TASK_UNMAPPED_BASE);
 	else
-		addr = PAGE_ALIGN(addr);
-
-	task_size -= len;
+		addr = PAGE_ALIGN(TASK_UNMAPPED_BASE);
 
 	for (vmm = find_vma(current->mm, addr); ; vmm = vmm->vm_next) {
 		/* At this point:  (!vmm || addr < vmm->vm_end). */
diff -up --recursive --new-file linux-2.4.4.macro/mm/mmap.c linux-2.4.4/mm/mmap.c
--- linux-2.4.4.macro/mm/mmap.c	Mon May  7 16:44:32 2001
+++ linux-2.4.4/mm/mmap.c	Tue May  8 22:16:00 2001
@@ -219,7 +219,7 @@ unsigned long do_mmap_pgoff(struct file 
 	if ((len = PAGE_ALIGN(len)) == 0)
 		return addr;
 
-	if (len > TASK_SIZE || addr > TASK_SIZE-len)
+	if (len > TASK_SIZE)
 		return -EINVAL;
 
 	/* offset overflow? */
@@ -405,9 +405,15 @@ static inline unsigned long arch_get_unm
 
 	if (len > TASK_SIZE)
 		return -ENOMEM;
-	if (!addr)
-		addr = TASK_UNMAPPED_BASE;
-	addr = PAGE_ALIGN(addr);
+
+	if (addr) {
+		addr = PAGE_ALIGN(addr);
+		vma = find_vma(current->mm, addr);
+		if (TASK_SIZE - len >= addr &&
+		    (!vma || addr + len <= vma->vm_start))
+			return addr;
+	}
+	addr = PAGE_ALIGN(TASK_UNMAPPED_BASE);
 
 	for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
 		/* At this point:  (!vma || addr < vma->vm_end). */
@@ -425,6 +431,8 @@ extern unsigned long arch_get_unmapped_a
 unsigned long get_unmapped_area(struct file *file, unsigned long addr, unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	if (flags & MAP_FIXED) {
+		if (addr > TASK_SIZE - len)
+			return -EINVAL;
 		if (addr & ~PAGE_MASK)
 			return -EINVAL;
 		return addr;

