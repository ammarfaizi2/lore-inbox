Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129601AbRAaFbq>; Wed, 31 Jan 2001 00:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129921AbRAaFb0>; Wed, 31 Jan 2001 00:31:26 -0500
Received: from cs.rice.edu ([128.42.1.30]:8100 "EHLO cs.rice.edu")
	by vger.kernel.org with ESMTP id <S129601AbRAaFbP>;
	Wed, 31 Jan 2001 00:31:15 -0500
From: Mohit Aron <aron@cs.rice.edu>
Message-Id: <200101310531.XAA09534@cs.rice.edu>
Subject: gprof cannot profile multi-threaded programs 
To: linux-kernel@vger.kernel.org
Date: Tue, 30 Jan 2001 23:31:13 -0600 (CST)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I'm using Linux-2.2 and discovered a problem with the profiling of
a multi-threaded program (uses Linux pthreads). Basically, upon compiling
the program with '-pg' option, running it and invoking gprof on the 
gmon.out file only shows the profile information corresponding to the  
computation done by the first thread (that starts in main()). The computation
performed by any other thread (created using pthread_create()) is not 
accounted for.

I analyzed the problem to be the following. Linux uses periodic SIGPROF signals
for profiling (Linux doesn't use the profil system call used in other OS's like
Solaris where the kernel does the profiling on behalf of the process). All
profile information is collected in the context of the signal handler for the
SIGPROF signal in Linux. Unfortunately, any thread that's created using
pthread_create() does not get these periodic SIGPROF signals. Hence any thread
other than the first thread is not profiled. The fix is to use setitimer()
system call immediately in the thread startup function for any new thread to
make the SIGPROF signal to be delivered at the designated interrupt frequency
(every 10ms). With this fix, the profile produced by gprof reflects the overall
computation done by all threads in the process. A more general fix would be
to fix the kernel to make any new threads inherit the setitimer() settings
for the parent thread.

Does anyone know if this problem has already been fixed ? If so, please send me
a pointer to the patch. Thanks,


- Mohit
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
