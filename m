Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWFXNHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWFXNHz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 09:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752220AbWFXNHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 09:07:55 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:46079 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751448AbWFXNHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 09:07:54 -0400
Date: Sat, 24 Jun 2006 09:07:33 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Arjan van de Ven <arjan@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] ext3_clear_inode(): avoid kfree(NULL)
In-Reply-To: <1151153635.3181.41.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0606240902390.23703@gandalf.stny.rr.com>
References: <200606231502.k5NF2jfO007109@hera.kernel.org>  <449C3817.2030802@garzik.org>
 <20060623142430.333dd666.akpm@osdl.org>  <1151151104.3181.30.camel@laptopd505.fenrus.org>
  <Pine.LNX.4.58.0606240817170.23087@gandalf.stny.rr.com> 
 <1151152059.3181.37.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.58.0606240833010.23318@gandalf.stny.rr.com> 
 <1151153177.3181.39.camel@laptopd505.fenrus.org> <1151153635.3181.41.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Jun 2006, Arjan van de Ven wrote:

> > >
> > > But doesn't the unlikely help the prediction?
> >
> > nope none at all, at least not on x86/x86-64.
> > (in fact there is no way to help the prediction on those architectures
> > that actually works)
>
> ok that's not entirely accurate, there's some basic heuristics you can
> tweak to; eg often the assumption is "if you jump backwards the branch
> is taken" and stuff like that, but that's generally useful in loops, not
> so much in if () statements.... since for if () both your branches are
> forward.
>

I just tried this code:

--- code ---
extern void marker1(void);
extern void marker2(void);

extern void callme(void *p);

#define unlikely(x)     __builtin_expect(!!(x), 0)

void predictme(void *t)
{
        marker1();
        if (unlikely (t))
                callme(t);
        marker2();

        return;
}
--- end code ---


Compiled it like:

 $ gcc -O2 -c predict.c

Then did objdump and got this:

--- objdump ---
00000000 <predictme>:
   0:   55                      push   %ebp
   1:   89 e5                   mov    %esp,%ebp
   3:   53                      push   %ebx
   4:   83 ec 04                sub    $0x4,%esp
   7:   8b 5d 08                mov    0x8(%ebp),%ebx
   a:   e8 fc ff ff ff          call   b <predictme+0xb>
                        b: R_386_PC32   marker1
   f:   85 db                   test   %ebx,%ebx
  11:   75 08                   jne    1b <predictme+0x1b>
  13:   58                      pop    %eax
  14:   5b                      pop    %ebx
  15:   5d                      pop    %ebp
  16:   e9 fc ff ff ff          jmp    17 <predictme+0x17>
                        17: R_386_PC32  marker2
  1b:   89 1c 24                mov    %ebx,(%esp)
  1e:   e8 fc ff ff ff          call   1f <predictme+0x1f>
                        1f: R_386_PC32  callme
  23:   eb ee                   jmp    13 <predictme+0x13>
--- end objdump --


The jne is expected to fail, so we will always continue to 0x13. Now is
this a problem with x86/x86_64?


BTW: taking out the unlikely I get this:

--- objdump ---
00000000 <predictme>:
   0:   55                      push   %ebp
   1:   89 e5                   mov    %esp,%ebp
   3:   53                      push   %ebx
   4:   83 ec 04                sub    $0x4,%esp
   7:   8b 5d 08                mov    0x8(%ebp),%ebx
   a:   e8 fc ff ff ff          call   b <predictme+0xb>
                        b: R_386_PC32   marker1
   f:   85 db                   test   %ebx,%ebx
  11:   74 08                   je     1b <predictme+0x1b>
  13:   89 1c 24                mov    %ebx,(%esp)
  16:   e8 fc ff ff ff          call   17 <predictme+0x17>
                        17: R_386_PC32  callme
  1b:   58                      pop    %eax
  1c:   5b                      pop    %ebx
  1d:   5d                      pop    %ebp
  1e:   e9 fc ff ff ff          jmp    1f <predictme+0x1f>
                        1f: R_386_PC32  marker2
--- end objdump ---

So it seems that gcc tries to keep the likely's from jumping.

-- Steve

