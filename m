Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293725AbSCUKBy>; Thu, 21 Mar 2002 05:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293737AbSCUKBo>; Thu, 21 Mar 2002 05:01:44 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:45961 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293725AbSCUKBf>; Thu, 21 Mar 2002 05:01:35 -0500
Date: Thu, 21 Mar 2002 15:33:20 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Mark Gross <mgross@unix-os.sc.intel.com>
Cc: Daniel Jacobowitz <dan@debian.org>, Pavel Machek <pavel@suse.cz>,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        marcelo@conectiva.com.br, tachino@jp.fujitsu.com, jefreyr@pacbell.net,
        vamsi_krishna@in.ibm.com, richardj_moore@uk.ibm.com,
        hanharat@us.ibm.com, bsuparna@in.ibm.com, bharata@in.ibm.com,
        asit.k.mallick@intel.com, david.p.howell@intel.com,
        tony.luck@intel.com, sunil.saxena@intel.com
Subject: Re: [PATCH] multithreaded coredumps for elf exeecutables
Message-ID: <20020321153320.A1356@in.ibm.com>
Reply-To: vamsi@in.ibm.com
In-Reply-To: <20020315170726.A3405@in.ibm.com> <20020320113630.A6882@in.ibm.com> <20020320133709.A10958@nevyn.them.org> <200203201912.g2KJC2W24374@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

Does moving the down_write() to be after the registers of all 
threads are collected help? (This patch on top of our previous
one)
--
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


-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5262355 Extn: 3959
Internet: vamsi@in.ibm.com

On Wed, Mar 20, 2002 at 11:14:56AM -0500, Mark Gross wrote:
> I've only JUST started on the Itanium version of this patch.  In my initial 
> testing, after hacking around some of the compilation issues,  I do get a 
> type of process freezing when attempting this.  Could be this bug.  
> 
> Thanks for the tip ;)
> 
> --mgross
> 
> 
> 
> On Wednesday 20 March 2002 01:37 pm, Daniel Jacobowitz wrote:
> > On Wed, Mar 20, 2002 at 11:36:30AM +0530, Vamsi Krishna S . wrote:
> > > There is serialization at higher level. We take a write lock
> > > on current->mm->mmap_sem at the beginning of elf_core_dump
> > > function which is released just before leaving the function.
> > > So, if one thread enters elf_core_dump and starts dumping core,
> > > no other thread (same mm) of the same process can start
> > > dumping.
> > > <snip>
> >
> > That's not a feature, it's a bug.  You can't take the mmap_sem before
> > collecting thread status; it will cause a deadlock on at least ia64,
> > where some registers are collected from user memory.
> >
> > (Thanks to Manfred Spraul for explaining that to me.)
