Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267342AbSKPT00>; Sat, 16 Nov 2002 14:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267343AbSKPT00>; Sat, 16 Nov 2002 14:26:26 -0500
Received: from ep09.kernel.pl ([212.87.11.162]:10284 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S267342AbSKPT0Z>;
	Sat, 16 Nov 2002 14:26:25 -0500
Date: Sat, 16 Nov 2002 20:33:08 +0100 (CET)
From: Krzysiek Taraszka <dzimi@pld.org.pl>
X-X-Sender: dzimi@ep09.kernel.pl
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Christoph Hellwig <hch@infradead.org>, Leif Sawyer <lsawyer@gci.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FW: i386 Linux kernel DoS
In-Reply-To: <1037146219.10083.15.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44L.0211162027090.4928-100000@ep09.kernel.pl>
References: <BF9651D8732ED311A61D00105A9CA3150B45FB3C@berkeley.gci.com> 
 <20021112233150.A30484@infradead.org> <1037146219.10083.15.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Nov 2002, Alan Cox wrote:

> On Tue, 2002-11-12 at 23:31, Christoph Hellwig wrote:
> > On Tue, Nov 12, 2002 at 02:28:55PM -0900, Leif Sawyer wrote:
> > > This was posted on bugtraq today...
> > 
> > A real segfaulting program?  wow :)
> 
> Looks like the TF handling bug which was fixed a while ago

It wasn't fixed for 2.2.22. 2.2 has got only syscall7, so fix should be 
trivial, isn't ?
Should be look like:


diff -urN linux.orig/arch/i386/kernel/entry.S 
linux/arch/i386/kernel/entry.S
--- linux.orig/arch/i386/kernel/entry.S Tue May 21 01:32:34 2002
+++ linux/arch/i386/kernel/entry.S      Thu Nov 14 21:39:36 2002
@@ -63,7 +63,9 @@
 OLDSS          = 0x38

 CF_MASK                = 0x00000001
+TF_MASK                = 0x00000100
 IF_MASK                = 0x00000200
+DF_MASK                = 0x00000400
 NT_MASK                = 0x00004000
 VM_MASK                = 0x00020000

@@ -139,6 +141,9 @@
        movl CS(%esp),%edx      # this is eip..
        movl EFLAGS(%esp),%ecx  # and this is cs..
        movl %eax,EFLAGS(%esp)  #
+       andl $~(NT_MASK|TF_MASK|DF_MASK), %eax
+       pushl %eax
+       popfl
        movl %edx,EIP(%esp)     # Now we move them to their "normal" places
        movl %ecx,CS(%esp)      #
        movl %esp,%ebx


or I missing somethink ?

Krzysiek Taraszka			(dzimi@pld.org.pl)

