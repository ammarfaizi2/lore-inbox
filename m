Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVA1AM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVA1AM0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 19:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVA1ALs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 19:11:48 -0500
Received: from hera.kernel.org ([209.128.68.125]:200 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261303AbVA1AKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 19:10:42 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: Patch 4/6  randomize the stack pointer
Date: Fri, 28 Jan 2005 00:10:23 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <ctbvtf$305$1@terminus.zytor.com>
References: <20050127101117.GA9760@infradead.org> <20050127101322.GE9760@infradead.org> <41F94462.7080108@francetelecom.REMOVE.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1106871023 3078 127.0.0.1 (28 Jan 2005 00:10:23 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 28 Jan 2005 00:10:23 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <41F94462.7080108@francetelecom.REMOVE.com>
By author:    Julien TINNES <julien.tinnes.NOSPAM@francetelecom.REMOVE.com>
In newsgroup: linux.dev.kernel
>
> Not very important but ((get_random_int() % 4096) << 4) could be 
> optimized into get_random_int() & 0xFFF0. Because 4096 is a power of 2 
> you won't loose any entropy by doing  & 0xFFF instead of %4096
> 

.. and gcc knows that.

: tazenda 8 ; cat testme.c
extern unsigned int get_random_int(void);

unsigned int test(void)
{
  return (get_random_int() % 4096) << 4;
}
: tazenda 9 ; objdump -dr testme.o

testme.o:     file format elf64-x86-64

Disassembly of section .text:

0000000000000000 <test>:
   0:   48 83 ec 08             sub    $0x8,%rsp
   4:   e8 00 00 00 00          callq  9 <test+0x9>
                        5: R_X86_64_PC32
   get_random_int+0xfffffffffffffffc
   9:   25 ff 0f 00 00          and    $0xfff,%eax
   e:   48 83 c4 08             add    $0x8,%rsp
  12:   c1 e0 04                shl    $0x4,%eax
  15:   c3                      retq
: tazenda 10 ; gcc -m32 -O2 -fomit-frame-pointer -g -c testme.c
: tazenda 11 ; objdump -dr testme.o

testme.o:     file format elf32-i386

Disassembly of section .text:

00000000 <test>:
   0:   83 ec 0c                sub    $0xc,%esp
   3:   e8 fc ff ff ff          call   4 <test+0x4>
                        4: R_386_PC32   get_random_int
   8:   25 ff 0f 00 00          and    $0xfff,%eax
   d:   83 c4 0c                add    $0xc,%esp
  10:   c1 e0 04                shl    $0x4,%eax
  13:   c3                      ret
: tazenda 12 ;
