Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbSKNC7b>; Wed, 13 Nov 2002 21:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbSKNC7b>; Wed, 13 Nov 2002 21:59:31 -0500
Received: from [195.223.140.107] ([195.223.140.107]:15761 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S261376AbSKNC7a>;
	Wed, 13 Nov 2002 21:59:30 -0500
Date: Thu, 14 Nov 2002 04:05:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, Leif Sawyer <lsawyer@gci.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: FW: i386 Linux kernel DoS
Message-ID: <20021114030541.GU31697@dualathlon.random>
References: <BF9651D8732ED311A61D00105A9CA3150B45FB3C@berkeley.gci.com> <20021112233150.A30484@infradead.org> <1037146219.10083.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037146219.10083.15.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 12:10:19AM +0000, Alan Cox wrote:
> On Tue, 2002-11-12 at 23:31, Christoph Hellwig wrote:
> > On Tue, Nov 12, 2002 at 02:28:55PM -0900, Leif Sawyer wrote:
> > > This was posted on bugtraq today...
> > 
> > A real segfaulting program?  wow :)
> 
> Looks like the TF handling bug which was fixed a while ago

Program received signal SIGSEGV, Segmentation fault.
0xc01097d9 in restore_all ()
(gdb) bt
#0  0xc01097d9 in restore_all ()
#1  0xbfffe4b7 in ?? ()

c01097d9:       cf                      iret   

it's the NT not the TF. iret is called with NT set and the cpu
follows the back link which is zero (we never use hardware task
switching and nt is artificially set so it would lead to kernel
malfunction anyways).

the TF was fixed a while ago as you said and that's fine now.

we just can't allow userspace to set NT or iret will crash at ret from
userspace, furthmore there's no useful thing the userspace can do with
the NT flag.

here the fix, it applies to all 2.4 and 2.5:

--- 2.4.20rc1aa2/arch/i386/kernel/ptrace.c.~1~	Fri Aug  9 14:52:06 2002
+++ 2.4.20rc1aa2/arch/i386/kernel/ptrace.c	Thu Nov 14 03:56:00 2002
@@ -28,7 +28,7 @@
 
 /* determines which flags the user has access to. */
 /* 1 = access 0 = no access */
-#define FLAG_MASK 0x00044dd5
+#define FLAG_MASK 0x00040dd5
 
 /* set's the trap flag. */
 #define TRAP_FLAG 0x100


Andrea
