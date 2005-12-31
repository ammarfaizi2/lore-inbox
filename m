Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbVLaO2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVLaO2y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 09:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbVLaO2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 09:28:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12812 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932282AbVLaO2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 09:28:54 -0500
Date: Sat, 31 Dec 2005 15:28:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Steve Work <swork@aventail.com>, Stas Sergeev <stsp@aknet.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multi-thread corefiles broken since April
Message-ID: <20051231142851.GH3811@stusta.de>
References: <4397D844.8060903@aventail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4397D844.8060903@aventail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

please open a bug at http://bugzilla.kernel.org/ for this issue so that 
it doesn't get lost.

@Stas:
It was your patch that broke it, can you look into it?

TIA
Adrian


On Wed, Dec 07, 2005 at 10:52:52PM -0800, Steve Work wrote:
> Coredumps from programs with more than one thread show garbage 
> information for all threads except the primary.  The problem was 
> introduced with:
> 
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=5df240826c90afdc7956f55a004ea6b702df9203
> 
> on Apr 16 ("fix crash in entry.S restore_all") and is still present in 
> current builds.
> 
> "kill -SEGV" this program and "info threads" the resulting corefile to 
> see the problem:
> 
> #include <pthread.h>
> static void* thread_sleep(void* x) { while (1) sleep(30); }
> int main(int c, char** v) {
>     const static int tcount = 5;
>     pthread_t thr[tcount];
>     int i;
>     for (i=0; i<tcount; ++i)
>         pthread_create(&thr[i], NULL, thread_sleep, NULL);
>     while (1)
>         sleep(30);
>     return 0;
> }
> 
> (gdb) info threads
>   7 process 18138  0x00000246 in ?? ()
>   6 process 18139  0x00000246 in ?? ()
>   5 process 18140  0x00000246 in ?? ()
>   4 process 18141  0x00000246 in ?? ()
>   3 process 18142  0x00000246 in ?? ()
>   2 process 18143  0x00000246 in ?? ()
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
>   childregs = (struct pt_regs *) ((unsigned long) childregs - 8);
> 
> but presumably re-introduces the crash the original patch was intended 
> to fix.  Should this line be conditioned somehow?  Or do the corefile 
> write routines need to know about this adjusted offset?
> 
> Steve Work
