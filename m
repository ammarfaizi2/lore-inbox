Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270488AbRHISdX>; Thu, 9 Aug 2001 14:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270544AbRHISdN>; Thu, 9 Aug 2001 14:33:13 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:55281
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S270488AbRHISdD>; Thu, 9 Aug 2001 14:33:03 -0400
Date: Thu, 9 Aug 2001 11:32:53 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Phil Brutsche <pbrutsch@tux.creighton.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Compile failure: 2.2.19 + eide patch on PPC
Message-ID: <20010809113253.B6706@mikef-linux.matchmail.com>
Mail-Followup-To: Phil Brutsche <pbrutsch@tux.creighton.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20010807122439.A22612@mikef-linux.matchmail.com> <Pine.LNX.4.33.0108071429460.30593-100000@tux.creighton.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0108071429460.30593-100000@tux.creighton.edu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2001 at 02:43:53PM -0500, Phil Brutsche wrote:
> A long time ago, in a galaxy far, far way, someone said...
> 
> > I am trying to compile 2.2.19 + ide.2.2.19.05042001.patch.  When doing this,
> > I get the errors below.
> >
> > I've also tried:
> > ide.2.2.19.03252001.patch
> > ide.2.2.19.04092001.patch
> 
> These patches are broken for PPC machines and have been for some time.  I
> suppose I should file a bug report...
> 
> It's simple enough to fix however.
> 


> You need an
> 
> #include <linux/ide.h>
> 
> before the
> 
> #include <asm/ide.h>
> 
> in ll_rw_blk.c.
> 
> Lines 27-30 of ll_rw_blk.c would end up looking like this:
> 
> #ifdef CONFIG_POWERMAC
> #include <linux/ide.h>
> #include <asm/ide.h>
> #endif
>

Ok, I've applied this, and also saved the changes in diff -u format:

--- 2.2.19-ide-05042001/drivers/block/ll_rw_blk.c~	Tue Aug  7 15:34:29 2001
+++ 2.2.19-ide-05042001/drivers/block/ll_rw_blk.c	Tue Aug  7 15:50:08 2001
@@ -25,6 +25,7 @@
 #include <linux/blk.h>
 
 #ifdef CONFIG_POWERMAC
+#include <linux/ide.h>
 #include <asm/ide.h>
 #endif
 
> Note that you will need the PCI fixup patch from
> http://www.cpu.lu/~mlan/linux/dev/pci.html if you want to be able to use a
> PCI IDE controller card, like the Promise Ultra33/Ultra66/Ultra100, in
> your PowerMac.  It seems that the PCI resources won't get seupt correctly
> by OpenFirmware otherwise.

I have three patches applied:
ide.2.2.19.05042001.patch.bz2
2.2.18-pci.diff.bz2 (applies with only one hunk shifted, no rejects on 2.2.19)
ide-fix.diff (The above diff you described)

> There are a number of other compilation problems in the code that will
> need similar "fixes".
> 

I still get this same error below:

> > # gcc -v
> > Reading specs from /usr/lib/gcc-lib/powerpc-linux/2.95.2/specs
> > gcc version 2.95.2 20000220 (Debian GNU/Linux)
> >
> > Error:
> > make[3]: Entering directory /usr/src/lk2.2/2.2.19-ide-05042001/drivers/block'
> > cc -D__KERNEL__ -I/usr/src/lk2.2/2.2.19-ide-05042001/include -Wall
> > -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
> > -D__powerpc__ -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2
> > -Wno-uninitialized -mmultiple -mstring   -DEXPORT_SYMTAB -c ll_rw_blk.c
> > In file included from ll_rw_blk.c:28:
> > /usr/src/lk2.2/2.2.19-ide-05042001/include/asm/ide.h:53: parse error before *'
> > /usr/src/lk2.2/2.2.19-ide-05042001/include/asm/ide.h:56: warning: function
> > declaration isn't a prototype
> 

Is LKML the best place for this question, or should I look for a PPC
specific list?  If so, can someone point me in the right direction?

Mike
