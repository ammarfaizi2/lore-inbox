Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285887AbRLHKBl>; Sat, 8 Dec 2001 05:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285889AbRLHKBc>; Sat, 8 Dec 2001 05:01:32 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:34766 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S285887AbRLHKBO>; Sat, 8 Dec 2001 05:01:14 -0500
X-Gnus-Agent-Meta-Information: mail nil
From: Christoph Rohland <cr@sap.com>
To: David.Egolf@Bull.com, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux - Patch to shmat
In-Reply-To: <OF82220913.E96CC81C-ON07256B1B.002C703D@az05.bull.com>
Organisation: SAP LinuxLab
In-Reply-To: <OF82220913.E96CC81C-ON07256B1B.002C703D@az05.bull.com>
Message-ID: <m3y9kehwp9.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
Date: 08 Dec 2001 10:53:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo and Linus,

On Fri, 7 Dec 2001, David Egolf wrote:
> We put your patch on a dual processor IA32 machine.  It correctly
> ran our prior test which did not employ threads.  We also designed a
> test which was meant to stress the gating by attempting overlapped
> virtual mappings from ten different threads on the same process.  We
> detected no problems with the patch as everything ran with correct
> status. 

David Egolf and his colleages from Bull noticed that a pretty crucial
test was dropped by me when redesigning SYSV shm and tmpfs. If you
give an address to shmat it no longer checks if there is already a
mapping and happily maps it unconditionally at the given address. This
should only happen with the SHM_REMAP flag.

The appended patch reintroduces the necessary checks.

Please apply
		Christoph

--- 2.4.16/ipc/shm.c	Sun Oct 28 16:59:03 2001
+++ m2.4.16/ipc/shm.c	Sat Dec  8 10:35:17 2001
@@ -569,6 +569,7 @@
 {
 	struct shmid_kernel *shp;
 	unsigned long addr;
+	unsigned long size;
 	struct file * file;
 	int    err;
 	unsigned long flags;
@@ -588,8 +589,12 @@
 				return -EINVAL;
 		}
 		flags = MAP_SHARED | MAP_FIXED;
-	} else
+	} else {
+		if ((shmflg & SHM_REMAP))
+			return -EINVAL;
+
 		flags = MAP_SHARED;
+	}
 
 	if (shmflg & SHM_RDONLY) {
 		prot = PROT_READ;
@@ -603,7 +608,7 @@
 
 	/*
 	 * We cannot rely on the fs check since SYSV IPC does have an
-	 * aditional creator id...
+	 * additional creator id...
 	 */
 	shp = shm_lock(shmid);
 	if(shp == NULL)
@@ -618,11 +623,27 @@
 		return -EACCES;
 	}
 	file = shp->shm_file;
+	size = file->f_dentry->d_inode->i_size;
 	shp->shm_nattch++;
 	shm_unlock(shmid);
 
 	down_write(&current->mm->mmap_sem);
-	user_addr = (void *) do_mmap (file, addr, file->f_dentry->d_inode->i_size, prot, flags, 0);
+	if (addr && !(shmflg & SHM_REMAP)) {
+		user_addr = ERR_PTR(-EINVAL);
+		if (find_vma_intersection(current->mm, addr, addr + size))
+			goto invalid;
+		/*
+		 * If shm segment goes below stack, make sure there is some
+		 * space left for the stack to grow (at least 4 pages).
+		 */
+		if (addr < current->mm->start_stack &&
+		    addr > current->mm->start_stack - size - PAGE_SIZE * 5)
+			goto invalid;
+	}
+		
+	user_addr = (void*) do_mmap (file, addr, size, prot, flags, 0);
+
+invalid:
 	up_write(&current->mm->mmap_sem);
 
 	down (&shm_ids.sem);

