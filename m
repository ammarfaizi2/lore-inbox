Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262525AbVC3XN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbVC3XN3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 18:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbVC3XN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 18:13:27 -0500
Received: from smtpout.mac.com ([17.250.248.85]:57809 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262525AbVC3XM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 18:12:26 -0500
In-Reply-To: <424AFA98.9080402@grupopie.com>
References: <200503300125.j2U1PFQ9005082@laptop11.inf.utfsm.cl> <OofSaT76.1112169183.7124470.khali@localhost> <d2er4p$qp$1@sea.gmane.org> <424AFA98.9080402@grupopie.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <aae129062f1e3992c8ec025d5f239be9@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Shankar Unni <shankarunni@netscape.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, bunk@stusta.de, khali@linux-fr.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Big GCC bug!!! [Was: Re: Do not misuse Coverity please]
Date: Wed, 30 Mar 2005 18:11:43 -0500
To: Paulo Marques <pmarques@grupopie.com>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 30, 2005, at 14:14, Paulo Marques wrote:
> Just a minor nitpick, though: wouldn't it be possible for an
> application to catch the SIGSEGV and let the code proceed,
> making invalid the assumption made by gcc?

Uhh, it's even worse than that.  Have a look at the following code:
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <errno.h>
> #include <sys/types.h>
> #include <sys/mman.h>
>
> struct test {
>         int code;
> };
> int test_check_first(struct test *a) {
>         int ret;
>         if (!a) return -1;
>         ret = a->code;
>         return ret;
> }
> int test_check_last(struct test *a) {
>         int ret;
>         ret = a->code;
>         if (!a) return -1;
>         return ret;
> }
>
> int main() {
>         int i;
>         struct test *nullmem = mmap(NULL, 4096, PROT_READ|PROT_WRITE,
>                         MAP_ANON|MAP_FIXED|MAP_PRIVATE, -1, 0);
>         if (nullmem == MAP_FAILED) {
>                 fprintf(stderr,"mmap: %s\n",strerror(errno));
>                 exit(1);
>         }
>         for (i = 0; i < 2; i++) {
>                 nullmem[i].code = i;
>                 printf("nullmem[%d].code = %d\n",i,i);
>                 printf("test_check_first(&nullmem[%d]) = %d\n",i,
>                         test_check_first(&nullmem[i]));
>                 printf("test_check_last(&nullmem[%d]) = %d\n",i,
>                         test_check_last(&nullmem[i]));
>         }
>         munmap(nullmem,4096);
>         exit(0);
> }

Without optimization:
> king:~# gcc -o mmapnull mmapnull.c
> king:~# ./mmapnull
> nullmem[0].code = 0
> test_check_first(&nullmem[0]) = -1
> test_check_last(&nullmem[0]) = -1
> nullmem[1].code = 1
> test_check_first(&nullmem[1]) = 1
> test_check_last(&nullmem[1]) = 1

With optimization:
> king:~# gcc -O2 -o mmapnull mmapnull.c
> king:~# ./mmapnull
> nullmem[0].code = 0
> test_check_first(&nullmem[0]) = -1
> test_check_last(&nullmem[0]) = 0
                         BUG ==> ^^^
> nullmem[1].code = 1
> test_check_first(&nullmem[1]) = 1
> test_check_last(&nullmem[1]) = 1

This is on multiple platforms, including PPC Linux, X86 Linux, and
PPC Mac OS X.  All exhibit the exact same behavior and output.  I
think I'll probably go report a GCC bug now :-D

Dereferencing null pointers is relied upon by a number of various
emulators and such, and is "platform-defined" in the standard, so
since Linux allows mmap at NULL, GCC shouldn't optimize that case
any differently.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


