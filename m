Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319652AbSH3TOc>; Fri, 30 Aug 2002 15:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319653AbSH3TOc>; Fri, 30 Aug 2002 15:14:32 -0400
Received: from users.ccur.com ([208.248.32.211]:39832 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S319652AbSH3TO3>;
	Fri, 30 Aug 2002 15:14:29 -0400
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200208301917.TAA09417@rudolph.ccur.com>
Subject: [PATCH] read of /proc/n/mem can grow target stack by 2Gigabytes
To: viro@math.psu.edu, riel@conectiva.com.br, linux-kernel@vger.kernel.org
Date: Fri, 30 Aug 2002 15:17:59 -0400 (EDT)
Reply-To: joe.korty@ccur.com (Joe Korty)
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When `ulimit -s unlimited', a read of a properly selected illegal
address through /proc/n/mem will returns zeros and grow the stack of
the target process by 2 gigabytes.  A load or store insn from within
the process instead correctly generates SIGSEGV.

To be correct, the read(2) should have returned EIO or EFAULT and not
have changed the size of the stack vma region.

The following patch prevents readers of other process's address
spaces from being able to change the stack size of the target
process.

A simple test program is also attached.

Joe


--- linux-2.4.20-pre5-base/mm/memory.c	2002-08-02 20:39:46.000000000 -0400
+++ linux-2.4.20-pre5/mm/memory.c	2002-08-30 13:14:54.000000000 -0400
@@ -459,6 +459,12 @@
 {
 	int i;
 	unsigned int flags;
+	int force_nogrow;
+
+	/* for now, tie the needs of callers to allow or deny growth in growable vma
+	 * regions to the `force' arg, rather than introducing a new arg.
+	 */
+	force_nogrow = force;
 
 	/*
 	 * Require read or write permissions.
@@ -471,7 +477,13 @@
 	do {
 		struct vm_area_struct *	vma;
 
-		vma = find_extend_vma(mm, start);
+		if (force_nogrow) {
+			vma = find_vma(mm, start);
+			if(vma && (vma->vm_start > start))
+				return i ? : -EFAULT;
+		} else {
+			vma = find_extend_vma(mm, start);
+		}
 
 		if ( !vma || (pages && vma->vm_flags & VM_IO) || !(flags & vma->vm_flags) )
 			return i ? : -EFAULT;



------------- end of patch --------------- beginning of test program.


/* the read(2) should return an EIO, the pointer-follow should
 * generate a SIGSEGV, and the /proc/n/map output should be
 * the same both before and after the run.
 * 
 * execute `ulimit -s unlimited' beforehand, else the results
 * will not be correct.
 *
 * i386-only: on other platforms the hard-wired address constants
 * need to be changed.
 */
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <signal.h>

int dummy;
char fn[1024], fn2[1024];

void sigsegv(int signo) {
    printf("SIGSEGV happened\n");
    system(fn);
    exit(1);
}

main(int argc, char **argv) {
    int stat, fd;
    off_t off;

    setbuf(stdout, NULL);
    signal(SIGSEGV, sigsegv);

    sprintf(fn, "cat /proc/%d/maps", getpid());
    system(fn);

    /* first read the illegal address thru the proc fs */

    printf("reading via /proc/*/mem interface\n");
    sprintf(fn2, "/proc/%d/mem", getpid());
    fd=open(fn2, O_RDWR, 0);
    if(fd == -1) {
	perror("open");
	exit(1);
    }
    off=lseek(fd, (off_t)0x56008000, SEEK_SET);
    if(off == -1) {
	perror("lseek");
	exit(1);
    }
    stat = read(fd, &dummy, sizeof(dummy));
    if(stat == -1) {
	perror("read");
    }


    /* then read another illegal address thru a pointer */

    printf("reading via a load insn\n");
    dummy = *(int *)0x46008000;
    
    system(fn);
    exit(0);
}
