Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317852AbSGQKsf>; Wed, 17 Jul 2002 06:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318241AbSGQKsf>; Wed, 17 Jul 2002 06:48:35 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:35748 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317852AbSGQKse>; Wed, 17 Jul 2002 06:48:34 -0400
Message-Id: <5.1.0.14.2.20020717105623.00aaa920@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 17 Jul 2002 11:54:35 +0100
To: Andrew Morton <akpm@zip.com.au>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [patch 13/13] lseek speedup
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3D35012B.EE9B1ABB@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

At 06:31 17/07/02, Andrew Morton wrote:
>  static inline loff_t llseek(struct file *file, loff_t offset, int origin)
>  {
>-       loff_t (*fn)(struct file *, loff_t, int);
>-
>-       fn = default_llseek;
>         if (file->f_op && file->f_op->llseek)
>-               fn = file->f_op->llseek;
>-       return fn(file, offset, origin);
>+               return (*file->f_op->llseek)(file, offset, origin);
>+       return default_llseek(file, offset, origin);
>  }

This one is interesting. I have been wondering for quite a while whether 
constructs like the original one actually produce better machine code or 
whether they should all be cleaned up just as you do here. I was never 
bothered enough about it to try but I have half an hour spare at the moment 
so I tried both - using gcc-2.96, RedHat 7.3 latest version, ia32, 
compiling for Athlon.

While I cannot speak for other compilers, gcc-2.96 at least generates 
better code for the old llseek() than for the new llseek() proposed by the 
above patch snippet.

The old code has following advantages:
         - Has only one conditional jump (comparing to two in new code.
         - Has no unconditional jump (comparing to one in new code).
         - Uses 16 bytes less stack space.
         - Machine code is shorter.

Here are the relevant different sections in sys_llseek() taken from the gcc 
generated assembly files both with and without just the above patch snippet 
applied:

----old code----
         movl    $default_llseek, %esi
         movl    16(%ebx), %eax
         testl   %eax, %eax
         je      .L1427
         movl    4(%eax), %eax
         testl   %eax, %eax
         cmovne  %eax, %esi
.L1427:
         pushl   48(%esp)
         pushl   %ecx
         pushl   %edx
         pushl   12(%esp)
         call    *%esi

----new code----
         movl    16(%ebx), %eax
         testl   %eax, %eax
         je      .L1428
         movl    4(%eax), %eax
         testl   %eax, %eax
         je      .L1428
         pushl   64(%esp)
         pushl   %ecx
         pushl   %edx
         pushl   %ebx
         call    *%eax
         jmp     .L1442
         .p2align 4,,7
.L1428:
         pushl   64(%esp)
         pushl   %ecx
         pushl   %edx
         pushl   12(%esp)
         call    default_llseek
.L1442:

Obviously we are counting a few cycles difference only (although the fewer 
jmps could make a bigger difference if the branch prediction of the CPU 
doesn't match to the common usage patch and the pipe line is stalled) and 
sys_llseek() is not exactly the most performance critical code, however I 
thought it is interesting to note that the old code is a "coding style" 
which produces better machine code in general with (gcc-2.96)...

And also it provided me with something fun to do in the half hour I am 
waiting for my gel to run. (-8 Back to lab work...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

