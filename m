Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTDQA1v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 20:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbTDQA1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 20:27:51 -0400
Received: from fmr01.intel.com ([192.55.52.18]:51682 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S261928AbTDQA1u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 20:27:50 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C262E20@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'root@chaos.analogic.com'" <root@chaos.analogic.com>,
       "'lkml (linux-kernel@vger.kernel.org)'" 
	<linux-kernel@vger.kernel.org>
Subject: RE: System Call parameters
Date: Wed, 16 Apr 2003 17:39:36 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Richard B. Johnson [mailto:root@chaos.analogic.com]
>
> Some functions like mmap() take 6 parameters!
> Does anybody know how these parameters get passed?
> I have an "ultra-light" 'C' runtime library I have
> been working on and, so-far, I've got everything up
> to mmap()  (in syscall.h) (89 functions) working.
> I thought, maybe ebp was being used, but it doesn't
> seem to be the case.

I use %ebp, it seemed to work last time I played with it:

static inline
int st_mmap (void *addr, size_t len, int protection, int flags, int fd,
off_t offset)
{
  int result;
  asm volatile (
    "pushl %%ebp	\n"
    "movl  %6, %%ebp	\n"
    "movl  %7, %%eax	\n"
    "int   $0x80	\n"
    "popl  %%ebp	\n"
    : "=a" (result)
    : "b" (addr), "c" (len), "d" (protection),
      "S" (flags), "D" (fd), "m" ((offset >> PAGE_SHIFT)),
      "i" (__NR_mmap2)
    : "memory");
  return result;
}

I thing I got it from an straight disassemble dump of glibc's
mmap().

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
