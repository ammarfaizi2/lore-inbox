Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269815AbRHQHuM>; Fri, 17 Aug 2001 03:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269807AbRHQHuD>; Fri, 17 Aug 2001 03:50:03 -0400
Received: from elin.scali.no ([195.139.250.10]:16393 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S269804AbRHQHt5>;
	Fri, 17 Aug 2001 03:49:57 -0400
Subject: [PATCH] processes with shared vm
From: Terje Eggestad <terje.eggestad@scali.no>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-1AvxMXrTa4966SCAB5Eq"
Message-Id: <997973469.7632.10.camel@pc-16>
Mime-Version: 1.0
X-Mailer: Evolution/0.12 (Preview Release)
Date: 17 Aug 2001 09:50:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1AvxMXrTa4966SCAB5Eq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I figured out that it's difficult to find out from /proc
which processes that share VM (created with clone(CLONE_VM)). 

made a patch that adds in /proc/<pid>/status a VmClones field that tells
how many proc that uses the same VM (mm_struct).  if there are clones I
add another field VmFirstClone with the pid of clone with the lowest
pid. 

Needed for things like gtop that adds mem usage of groups of proc, or
else they add up the usage of SIZE and RSS of threads.

The patch need to be applied to linux/fs/proc/array.c

NB: developed on 2.4.3

TJ

-- 
_________________________________________________________________________

Terje Eggestad                  terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 70 Bogerud                      +47 975 31 574  (MOBILE)
N-0621 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

--=-1AvxMXrTa4966SCAB5Eq
Content-Type: text/x-patch
Content-Disposition: attachment; filename=vmclone.patch
Content-ID: <997973147.7502.4.camel@pc-16>
Content-Transfer-Encoding: 7bit

*** array.c	Thu Aug 16 16:33:56 2001
--- array.c.orig	Mon Mar 19 21:34:55 2001
***************
*** 50,61 ****
   * Al Viro & Jeff Garzik :  moved most of the thing into base.c and
   *			 :  proc_misc.c. The rest may eventually go into
   *			 :  base.c too.
-  *
-  * Terje Eggestad    :  added in /proc/<pid>/status a VmClones: n
-  *                   :  that tells how many proc that uses the same VM (mm_struct).
-  *                   :  if there are clones add another field VmFirstClone with the
-  *                   :  clone with the lowest pid. Needed for things like gtop that adds 
-  *                   :  mem usage of groups of proc, or else they add up the usage of threads.
   */
  
  #include <linux/config.h>
--- 50,55 ----
***************
*** 184,190 ****
  static inline char * task_mem(struct mm_struct *mm, char *buffer)
  {
  	struct vm_area_struct * vma;
!  	unsigned long data = 0, stack = 0;
  	unsigned long exec = 0, lib = 0;
  
  	down_read(&mm->mmap_sem);
--- 178,184 ----
  static inline char * task_mem(struct mm_struct *mm, char *buffer)
  {
  	struct vm_area_struct * vma;
! 	unsigned long data = 0, stack = 0;
  	unsigned long exec = 0, lib = 0;
  
  	down_read(&mm->mmap_sem);
***************
*** 212,235 ****
  		"VmData:\t%8lu kB\n"
  		"VmStk:\t%8lu kB\n"
  		"VmExe:\t%8lu kB\n"
! 		"VmLib:\t%8lu kB\n"
! 		"VmClones:\t%d\n",
  		mm->total_vm << (PAGE_SHIFT-10),
  		mm->locked_vm << (PAGE_SHIFT-10),
  		mm->rss << (PAGE_SHIFT-10),
  		data - stack, stack,
! 		exec - lib, lib, 
! 		mm->mm_users.counter-2);
! 	/* if we've vm clones, find the lowest/first pid of the clones */	
! 	if (mm->mm_users.counter > 2) {
! 	  struct task_struct *p;
! 	  read_lock(&tasklist_lock);
! 	  for_each_task(p) {
! 	    if (p->mm == mm) break;
! 	  };
! 	  buffer += sprintf(buffer, "VmFirstClone:\t%d\n", p->pid);
! 	  read_unlock(&tasklist_lock);
! 	};
  	up_read(&mm->mmap_sem);
  	return buffer;
  }
--- 206,217 ----
  		"VmData:\t%8lu kB\n"
  		"VmStk:\t%8lu kB\n"
  		"VmExe:\t%8lu kB\n"
! 		"VmLib:\t%8lu kB\n",
  		mm->total_vm << (PAGE_SHIFT-10),
  		mm->locked_vm << (PAGE_SHIFT-10),
  		mm->rss << (PAGE_SHIFT-10),
  		data - stack, stack,
! 		exec - lib, lib);
  	up_read(&mm->mmap_sem);
  	return buffer;
  }

--=-1AvxMXrTa4966SCAB5Eq--


