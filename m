Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267588AbTAQRB1>; Fri, 17 Jan 2003 12:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267599AbTAQRB1>; Fri, 17 Jan 2003 12:01:27 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58373 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267588AbTAQRB0>; Fri, 17 Jan 2003 12:01:26 -0500
Date: Fri, 17 Jan 2003 17:10:22 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: John Cherry <cherry@osdl.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.59
Message-ID: <20030117171022.C13888@flint.arm.linux.org.uk>
Mail-Followup-To: John Cherry <cherry@osdl.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301161826430.8879-100000@penguin.transmeta.com> <1042822516.14996.10.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1042822516.14996.10.camel@cherrypit.pdx.osdl.net>; from cherry@osdl.org on Fri, Jan 17, 2003 at 08:55:16AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 08:55:16AM -0800, John Cherry wrote:
> Compile statistics: 2.5.59
> 
> Not much change.
> 
>                            2.5.58                       2.5.59
>                        ------------------------ ------------------------
> bzImage (defconfig)      20 warnings/0 errors     20 warnings/0 errors
> bzImage (allmodconfig)   32 warnings/9 errors     32 warnings/9 errors
> modules (allmodconfig) 3156 warnings/154 errors 3119 warnings/159 errors
> 
> Compile statistics have been for kernel releases from 2.5.46 to 2.5.59
> at: www.osdl.org/archive/cherry/stability

Have a couple of extra warnings:

fs/binfmt_elf.c: In function `create_elf_tables':
fs/binfmt_elf.c:239: warning: initialization makes integer from pointer without a cast
fs/binfmt_elf.c:249: warning: initialization makes integer from pointer without a cast

#ifndef elf_addr_t
#define elf_addr_t unsigned long
#endif

        elf_addr_t *argv, *envp;

        __put_user(NULL, argv);
        __put_user(NULL, envp);

It would therefore appear that x86 __put_user is not properly type-checking
the arguments to __put_user().

Here's a patch which fixes the warning (but doesn't fix x86's type-check
challenged __put_user implementation):

--- orig/fs/binfmt_elf.c	Thu Nov 28 16:45:26 2002
+++ linux/fs/binfmt_elf.c	Fri Jan 17 17:08:50 2003
@@ -236,7 +236,7 @@
 			return;
 		p += len;
 	}
-	__put_user(NULL, argv);
+	__put_user(0, argv);
 	current->mm->arg_end = current->mm->env_start = p;
 	while (envc-- > 0) {
 		size_t len;
@@ -246,7 +246,7 @@
 			return;
 		p += len;
 	}
-	__put_user(NULL, envp);
+	__put_user(0, envp);
 	current->mm->env_end = p;
 
 	/* Put the elf_info on the stack in the right place.  */


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

