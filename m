Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263779AbREYPpi>; Fri, 25 May 2001 11:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263773AbREYPpS>; Fri, 25 May 2001 11:45:18 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:43277 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S263777AbREYPpJ>; Fri, 25 May 2001 11:45:09 -0400
Date: Fri, 25 May 2001 08:45:08 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Andi Kleen <ak@suse.de>
cc: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        Keith Owens <kaos@ocs.com.au>, Andreas Dilger <adilger@turbolinux.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8
In-Reply-To: <20010525160729.B32273@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.33.0105250836400.30357-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2001, Andi Kleen wrote:

> On Fri, May 25, 2001 at 04:03:57PM +0200, Oliver Neukum wrote:
> > Is there a reason for the task structure to be at the bottom rather than the
> > top of these two pages ?
>
> This way you save one addition for every current access; which adds to
> quite a few KB over the complete kernel.

hrm, really?

i think it really depends on how you use current -- here's an alternative
usage which can fold the extra addition into the structure offset
calculations, and moves the task struct to the top of the stack.

not that this really solves anything, 'cause a stack underflow will just
trash something else rather than the task struct :)

-dean

% cat task.c
struct task {
        int a;
        int b;
};

#define current(p)      (((struct task *)(((unsigned)p | 0x1fff)+1))-1)
int foo(void *p)
{
        return current(p)->a + current(p)->b;
}
% gcc -O -c task.c
% objdump -dr task.o

task.o:     file format elf32-i386

Disassembly of section .text:

00000000 <foo>:
   0:   55                      push   %ebp
   1:   89 e5                   mov    %esp,%ebp
   3:   8b 55 08                mov    0x8(%ebp),%edx
   6:   81 ca ff 1f 00 00       or     $0x1fff,%edx
   c:   8b 42 fd                mov    0xfffffffd(%edx),%eax
   f:   03 42 f9                add    0xfffffff9(%edx),%eax
  12:   c9                      leave
  13:   c3                      ret

