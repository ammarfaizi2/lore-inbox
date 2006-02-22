Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWBVTrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWBVTrl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 14:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWBVTrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 14:47:40 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:30829 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751329AbWBVTrk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 14:47:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PV0022m+gdQJCpZfijUd4Dy6khbYbUV1b0CiZSM8U3SxDwCDucp4nc2wCzNqWuVuXGgohjEgq/jOvEIdg6vdVBVbp3rjiQFVqRhwMHpP0yOA2Auxn9Y7XpD0BX//JTlubsI9jkQfxDB6Dn3G1Wq7yPkE/tRVVm3qlphmYqzc0pg=
Message-ID: <cbec11ac0602221147n75e077cep9718c637f9761acd@mail.gmail.com>
Date: Thu, 23 Feb 2006 08:47:39 +1300
From: "Ian McDonald" <imcdnzl@gmail.com>
To: trivial@kernel.org,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Documentation: Update to BUG-HUNTING
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Resubmitting this to try and help others not repeat the mistakes I've made :-)

Signed-off-by: Ian McDonald: <imcdnzl@gmail.com>
----
diff --git a/Documentation/BUG-HUNTING b/Documentation/BUG-HUNTING
index ca29242..8b117de 100644
--- a/Documentation/BUG-HUNTING
+++ b/Documentation/BUG-HUNTING
@@ -1,3 +1,56 @@
+Table of contents
+=================
+
+Last updated: 20 December 2005
+
+Contents
+========
+
+- Introduction
+- Devices not appearing
+- Finding patch that caused a bug
+-- Finding using git-bisect
+-- Finding it the old way
+- Fixing the bug
+
+Introduction
+============
+
+Always try the latest kernel from kernel.org and build from source. If you are
+not confident in doing that please report the bug to your distribution vendor
+instead of to a kernel developer.
+
+Finding bugs is not always easy. Have a go though. If you can't find it don't
+give up. Report as much as you have found to the relevant maintainer. See
+MAINTAINERS for who that is for the subsystem you have worked on.
+
+Before you submit a bug report read REPORTING-BUGS.
+
+Devices not appearing
+=====================
+
+Often this is caused by udev. Check that first before blaming it on the
+kernel.
+
+Finding patch that caused a bug
+===============================
+
+
+
+Finding using git-bisect
+------------------------
+
+Using the provided tools with git makes finding bugs easy provided the bug is
+reproducible.
+
+Steps to do it:
+- start using git for the kernel source
+- read the man page for git-bisect
+- have fun
+
+Finding it the old way
+----------------------
+
 [Sat Mar  2 10:32:33 PST 1996 KERNEL_BUG-HOWTO lm@sgi.com (Larry McVoy)]

 This is how to track down a bug if you know nothing about kernel hacking.
@@ -90,3 +143,63 @@ it does work and it lets non-hackers hel
 because Linux snapshots will let you do this - something that you can't
 do with vendor supplied releases.

+Fixing the bug
+==============
+
+Nobody is going to tell you how to fix bugs. Seriously. You need to work it
+out. But below are some hints on how to use the tools.
+
+To debug a kernel, use objdump and look for the hex offset from the crash
+output to find the valid line of code/assembler. Without debug symbols, you
+will see the assembler code for the routine shown, but if your kernel has
+debug symbols the C code will also be available. (Debug symbols can be enabled
+in the kernel hacking menu of the menu configuration.) For example:
+
+    objdump -r -S -l --disassemble net/dccp/ipv4.o
+
+NB.: you need to be at the top level of the kernel tree for this to pick up
+your C files.
+
+If you don't have access to the code you can also debug on some crash dumps
+e.g. crash dump output as shown by Dave Miller.
+
+>    EIP is at ip_queue_xmit+0x14/0x4c0
+>     ...
+>    Code: 44 24 04 e8 6f 05 00 00 e9 e8 fe ff ff 8d 76 00 8d bc 27 00 00
+>    00 00 55 57  56 53 81 ec bc 00 00 00 8b ac 24 d0 00 00 00 8b 5d 08
+>    <8b> 83 3c 01 00 00 89 44  24 14 8b 45 28 85 c0 89 44 24 18 0f 85
+>
+>    Put the bytes into a "foo.s" file like this:
+>
+>           .text
+>           .globl foo
+>    foo:
+>           .byte  .... /* bytes from Code: part of OOPS dump */
+>
+>    Compile it with "gcc -c -o foo.o foo.s" then look at the output of
+>    "objdump --disassemble foo.o".
+>
+>    Output:
+>
+>    ip_queue_xmit:
+>        push       %ebp
+>        push       %edi
+>        push       %esi
+>        push       %ebx
+>        sub        $0xbc, %esp
+>        mov        0xd0(%esp), %ebp        ! %ebp = arg0 (skb)
+>        mov        0x8(%ebp), %ebx         ! %ebx = skb->sk
+>        mov        0x13c(%ebx), %eax       ! %eax = inet_sk(sk)->opt
+
+Another very useful option of the Kernel Hacking section in menuconfig is
+Debug memory allocations. This will help you see whether data has been
+initialised and not set before use etc. To see the values that get assigned
+with this look at mm/slab.c and search for POISON_INUSE. When using this an
+Oops will often show the poisoned data instead of zero which is the default.
+
+Once you have worked out a fix please submit it upstream. After all open
+source is about sharing what you do and don't you want to be recognised for
+your genius?
+
+Please do read Documentation/SubmittingPatches though to help your code get
+accepted.
