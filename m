Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262826AbSKUEkQ>; Wed, 20 Nov 2002 23:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262884AbSKUEkQ>; Wed, 20 Nov 2002 23:40:16 -0500
Received: from zok.SGI.COM ([204.94.215.101]:27273 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S262826AbSKUEkP>;
	Wed, 20 Nov 2002 23:40:15 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Compiling x86 with and without frame pointer
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 21 Nov 2002 15:47:13 +1100
Message-ID: <19005.1037854033@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The conventional wisdom is that compiling x86 without frame pointer
results in smaller code.  It turns out to be the opposite, compiling
with frame pointers results in a smaller kernel.  gcc version 3.2
20020822 (Red Hat Linux Rawhide 3.2-4).

# size 2.4.20-rc2-*/vmlinux
   text    data     bss     dec     hex filename
2669584  337972  402697 3410253  34094d 2.4.20-rc2-fp/vmlinux
2676919  337972  402697 3417588  3425f4 2.4.20-rc2-nofp/vmlinux

Without frame pointers, vmlinux is 7K bigger.  The difference is that
code with frame pointers can use ebp to directly access the stack,
without frame pointers it has to use esp with an index.

With frame pointers:

00000c10 <inet_dgram_connect>:
     c10:       55                      push   %ebp
     c11:       89 e5                   mov    %esp,%ebp
     c13:       83 ec 14                sub    $0x14,%esp
     c16:       89 75 fc                mov    %esi,0xfffffffc(%ebp)
     c19:       8b 45 08                mov    0x8(%ebp),%eax
     c1c:       8b 75 0c                mov    0xc(%ebp),%esi
     c1f:       89 5d f8                mov    %ebx,0xfffffff8(%ebp)
     c22:       8b 58 18                mov    0x18(%eax),%ebx
     c25:       66 83 3e 00             cmpw   $0x0,(%esi)
     c29:       74 3d                   je     c68 <inet_dgram_connect+0x58>

Without frame pointers:

00000c10 <inet_dgram_connect>:
     c10:       83 ec 14                sub    $0x14,%esp
     c13:       8b 44 24 18             mov    0x18(%esp,1),%eax
     c17:       89 74 24 10             mov    %esi,0x10(%esp,1)
     c1b:       8b 74 24 1c             mov    0x1c(%esp,1),%esi
     c1f:       89 5c 24 0c             mov    %ebx,0xc(%esp,1)
     c23:       8b 58 18                mov    0x18(%eax),%ebx
     c26:       66 83 3e 00             cmpw   $0x0,(%esi)
     c2a:       74 44                   je     c70 <inet_dgram_connect+0x60>

The difference is that stack accesses via ebp are 3 bytes, stack
accesses via esp+index are 4 bytes.  On any function with a large
number of stack accesses, this quickly outweighs the extra prologue
code for frame pointers.

The smaller instruction set will improve icache usage.  Whether this is
offset by the increased register pressure is something for
benchmarking.  Any of the benchmarkers care to test x86 kernels with
and without frame pointers?

