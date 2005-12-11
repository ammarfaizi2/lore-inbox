Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161074AbVLKAom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbVLKAom (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 19:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161077AbVLKAom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 19:44:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:464 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161074AbVLKAol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 19:44:41 -0500
Date: Sat, 10 Dec 2005 16:44:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steve Work <swork@aventail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multi-thread corefiles broken since April
Message-Id: <20051210164425.458f2efd.akpm@osdl.org>
In-Reply-To: <4397D844.8060903@aventail.com>
References: <4397D844.8060903@aventail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Work <swork@aventail.com> wrote:
>
> Coredumps from programs with more than one thread show garbage 
> information for all threads except the primary.  The problem was 
> introduced with:
> 
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=5df240826c90afdc7956f55a004ea6b702df9203
> 
> on Apr 16 ("fix crash in entry.S restore_all") and is still present in 
> current builds.

Thanks for working that out.

> "kill -SEGV" this program and "info threads" the resulting corefile to 
> see the problem:
> 
> #include <pthread.h>
> static void* thread_sleep(void* x) { while (1) sleep(30); }
> int main(int c, char** v) {
>      const static int tcount = 5;
>      pthread_t thr[tcount];
>      int i;
>      for (i=0; i<tcount; ++i)
>          pthread_create(&thr[i], NULL, thread_sleep, NULL);
>      while (1)
>          sleep(30);
>      return 0;
> }
> 
> (gdb) info threads
>    7 process 18138  0x00000246 in ?? ()
>    6 process 18139  0x00000246 in ?? ()
>    5 process 18140  0x00000246 in ?? ()
>    4 process 18141  0x00000246 in ?? ()
>    3 process 18142  0x00000246 in ?? ()
>    2 process 18143  0x00000246 in ?? ()
> * 1 process 18137  0xb7e69db6 in nanosleep () from /lib/tls/libc.so.6
> (gdb)
> 
> All these threads should show a legitimate location (the same spot in 
> nanosleep) and do on kernels prior to the commit named above.  (Notice 
> one too many threads listed here also -- is this a related problem?)
> 
> Commenting out this line (in asm/i386/kernel/process.c:copy_thread) 
> fixes the corefiles:
> 
>    childregs = (struct pt_regs *) ((unsigned long) childregs - 8);
> 
> but presumably re-introduces the crash the original patch was intended 
> to fix.  Should this line be conditioned somehow?  Or do the corefile 
> write routines need to know about this adjusted offset?
> 

Yes, I guess fixing up the core output would be the way to fix it.
