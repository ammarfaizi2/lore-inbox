Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbUBVPoX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 10:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbUBVPoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 10:44:23 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:4226 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261571AbUBVPm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 10:42:28 -0500
Date: Sun, 22 Feb 2004 16:42:25 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Dan Kegel <dank@kegel.com>
Cc: linux-kernel@vger.kernel.org, Jim Wilson <wilson@specifixinc.com>,
       Judith Lebzelter <judith@osdl.org>, cliff white <cliffw@osdl.org>,
       "Timothy D. Witham" <wookie@osdl.org>
Subject: Re: Kernel Cross Compiling [update]
Message-ID: <20040222154225.GA22719@MAIL.13thfloor.at>
Mail-Followup-To: Dan Kegel <dank@kegel.com>,
	linux-kernel@vger.kernel.org, Jim Wilson <wilson@specifixinc.com>,
	Judith Lebzelter <judith@osdl.org>, cliff white <cliffw@osdl.org>,
	"Timothy D. Witham" <wookie@osdl.org>
References: <20040222035350.GB31813@MAIL.13thfloor.at> <403845F5.5030101@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403845F5.5030101@kegel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 21, 2004 at 10:02:29PM -0800, Dan Kegel wrote:
> Herbert Poetzl wrote:
> >   the GCC testsuite contains 2854 files in the relevant 
> >   subdirs consistency.vlad, gcc.c-torture, gcc.dg, and
> >   gcc.misc-tests.
> >    
> >   after removing the non relevant tests (file matching 
> >   egrep '#include|float|double') 1799 C files remain.
> >     
> >   the result of the tests and comparison[4] shows that
> >   both compilers produce the same code, except for one
> >   little difference[5], which I'm unable to explain ...  
> > [5]  http://vserver.13thfloor.at/Stuff/Cross/Comparison/TEST-alpha.diff
> > ...
> 
> >   my conclusion so far is that my approach should be
> >   sufficient for Kernel Cross Compiling.
> 
> Perhaps, but it's harder to repeat than using my crosstool script;
> you said you had to munge a bunch of header files, but with
> crosstool no special munging is required.  AFAIR you haven't
> posted your header-munging procedure.

you probably 'only' missed it, because I provide
(and did provide) ALL the required patches since
the first posting ...

http://vserver.13thfloor.at/Stuff/Cross/

the header changes are 'minimal' and labeled
gcc-3.3.2-cross-*-fix.diff.bz2

> It's vaguely possible that your header munging was wrong, which
> caused that one diff on alpha.

might be, if you know what's wrong, please let me 
know ... the differences for alpha can be found at

http://vserver.13thfloor.at/Stuff/Cross/gcc-3.3.2-cross-alpha-fix.diff.bz2

> Say, could you compare compiling the kernel with the two
> toolchains, and see if there are any differences?

hmm, yes, problem is, after 'downgrading' my binutils
to 2.14 (from 2.14.90.0.8) both toolchains (yours and
mine) fail to compile the alpha 2.6.3 kernel with

make: *** [.tmp_vmlinux1] Error 139

(with 2.14.90.0.8 mine seems to work, haven't tried to
update yours)

but I figured that comparing the .o files, especially
the built-in.o for each directory, would be a good
alternative ... to do that, I did the folowing:

 - find all built-in object files (84)
 - dump the code with 'objdump -d' 
 - compare the resulting code with diff

besides the expected difference caused by the path

-linux-2.6.3-bertl/drivers/built-in.o:     file format elf64-alpha
+linux-2.6.3-dan/drivers/built-in.o:     file format elf64-alpha
 
the only 'real' difference is this, which looks to
me equivalent, but I don't know what causes this
difference ...
 
@@ -29385,10 +29385,10 @@ Disassembly of section .text:
    1bf34:      00 00 fe 2f     unop    
    1bf38:      1f 04 ff 47     nop     
    1bf3c:      00 00 fe 2f     unop    
-   1bf40:      0b 14 a4 45     or      s4,0x20,s2
-   1bf44:      20 00 8d 21     lda     s3,32(s4)
+   1bf40:      0c 14 a4 45     or      s4,0x20,s3
+   1bf44:      20 00 6d 21     lda     s2,32(s4)
    1bf48:      58 00 28 a4     ldq     t0,88(t7)
-   1bf4c:      02 04 6c 45     or      s2,s3,t1
+   1bf4c:      02 04 8b 45     or      s3,s2,t1
    1bf50:      01 00 22 44     and     t0,t1,t0
    1bf54:      74 fd 3f f4     bne     t0,1b528 <vt_ioctl+0xe88>
    1bf58:      40 00 de 20     lda     t5,64(sp)
@@ -29412,7 +29412,7 @@ Disassembly of section .text:
    1bfa0:      00 00 fe 2f     unop    
    1bfa4:      0a fa 1f f4     bne     v0,1a7d0 <vt_ioctl+0x130>
    1bfa8:      58 00 28 a4     ldq     t0,88(t7)
-   1bfac:      02 04 6c 45     or      s2,s3,t1
+   1bfac:      02 04 8b 45     or      s3,s2,t1
    1bfb0:      01 00 22 44     and     t0,t1,t0
    1bfb4:      5c fd 3f f4     bne     t0,1b528 <vt_ioctl+0xe88>
    1bfb8:      06 04 ed 47     mov     s4,t5


best,
Herbert

> - Dan
> 
> -- 
> US citizens: if you're considering voting for Bush, look at these first:
> http://www.misleader.org/
> http://www.cbc.ca/news/background/arar/
> http://www.house.gov/reform/min/politicsandscience/
