Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293457AbSEMH2V>; Mon, 13 May 2002 03:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315862AbSEMH2U>; Mon, 13 May 2002 03:28:20 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:61605 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293457AbSEMH2T>;
	Mon, 13 May 2002 03:28:19 -0400
Message-Id: <200205130728.g4D7S20109786@northrelay01.pok.ibm.com>
User-Agent: Pan/0.11.2 (Unix)
From: "Vamsi Krishna S." <vamsi_krishna@in.ibm.com>
To: mgross@unix-os.sc.intel.com, linux-kernel@vger.kernel.org,
        manfred@colorfullife.com, vamsi@in.ibm.com
Subject: Re: [PATCH] multithreaded coredumps for elf exeecutables for O(1)  scheduler
Date: Mon, 13 May 2002 13:05:43 +0530
In-Reply-To: <3CDBFFCD.94589E4F@colorfullife.com> <200205101813.g4AIDLw17587@unix-os.sc.intel.com>
Reply-To: vamsi_krishna@in.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Despite other problems with ia64, stopping vm ops after the status (regs) of
all the threads is captured, is a bug fix in generic code, and our
patch effectively nukes that. Not a good thing. I had posted a patch on top
of the previous tcore patch to fix this, I suppose it still applies to the
2.5.x patch. Please apply that (given here).

Vamsi.

Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5262355 Extn: 3959
Internet: vamsi@in.ibm.com

--- 2417-tcore/fs/binfmt_elf.c.ori	Thu Mar 21 15:30:08 2002
+++ 2417-tcore/fs/binfmt_elf.c	Thu Mar 21 15:27:29 2002
@@ -1289,10 +1289,6 @@
 	int dump_threads = 0;
 	int thread_status_size = 0;
 	
-	/* now stop all vm operations */
-	down_write(&current->mm->mmap_sem);
-	segs = current->mm->map_count;
-
  	if (atomic_read(&current->mm->mm_users) != 1) {
 		dump_threads = core_dumps_threads;
 	}
@@ -1337,6 +1333,19 @@
 		}
 	} /* End if(dump_threads) */
 
+	/*
+	 * This transfers the registers from regs into the standard
+	 * coredump arrangement, whatever that is. We need to do this
+	 * before acquiring mmap_sem as on some architectures (IA64)
+	 * we may need to access user pages to get register state.
+	 */
+	memset(&prstatus, 0, sizeof(prstatus));
+	elf_core_copy_regs(&prstatus.pr_reg, regs);
+
+	/* now stop all vm operations */
+	down_write(&current->mm->mmap_sem);
+	segs = current->mm->map_count;
+
 #ifdef DEBUG
 	printk("elf_core_dump: %d segs %lu limit\n", segs, limit);
 #endif
@@ -1358,16 +1367,9 @@
 	 * Set up the notes in similar form to SVR4 core dumps made
 	 * with info from their /proc.
 	 */
-	memset(&prstatus, 0, sizeof(prstatus));
 	fill_prstatus(&prstatus, current, signr);
 	fill_note(&notes[0], "CORE", NT_PRSTATUS, sizeof(prstatus), &prstatus);
 
-	/*
-	 * This transfers the registers from regs into the standard
-	 * coredump arrangement, whatever that is.
-	 */
-	elf_core_copy_regs(&prstatus.pr_reg, regs);
-
 #ifdef DEBUG
 	dump_regs("Passed in regs", (elf_greg_t *)regs);
 	dump_regs("prstatus regs", (elf_greg_t *)&prstatus.pr_reg);



On Fri, 10 May 2002 23:46:59 +0530, Mark Gross wrote:

> ia64 requires more tweaks than just this to work.  This patch as it stands isn't
> expected to work for ia64.
> 
> Getting the register states for the note sections is more involved for ia64 as
> well as the avoiding of patch collisions with  the diffs in
> /pub/linux/kernel/ports/ia64/v2.5/
> 
> I have an ia64 patch set thats partially tested for 2.4.17, that seems to work.
> It didn't get posted as O(1) support became a bigger priority.
> 
> I'm hoping to start updating the ia64 patch to support 2.5x very soon.
> 
> --mgross
> 
> On Friday 10 May 2002 01:13 pm, Manfred Spraul wrote:
>> Have you checked that your patch doesn't deadlock on ia64?
>>
>> > +       /* First pause all related threaded processes */ +       if
>> > (dump_threads)       {
>> > +               suspend_threads();
>> > +       }
>> > +
>> > +       /* now stop all vm operations */
>> > +       down_write(&current->mm->mmap_sem); +       segs =
>> > current->mm->map_count;
>> > +
>>
>> Stopping all vm operations means that copy_{to,from}_user can cause deadlocks.
>> ia64 needs copy_to_user in their stack unwind handler, IIRC called by
>> ELF_CORE_COPY_REGS.
>>
>> Afaics you don't handle that. You must dump all thread state before
>> down_write(mmap_sem). And I don't see how you protect against 2 threads of one
>> process calling suspend_threads() simultaneously.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html Please read the FAQ at
> http://www.tux.org/lkml/
