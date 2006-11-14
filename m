Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966048AbWKNStV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966048AbWKNStV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 13:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966227AbWKNStV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 13:49:21 -0500
Received: from mail.impinj.com ([206.169.229.170]:33634 "EHLO earth.impinj.com")
	by vger.kernel.org with ESMTP id S966048AbWKNStU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 13:49:20 -0500
Subject: Re: Patch to fixe Data Acess error in dup_fd
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: sharyath@in.ibm.com, Pavel Emelianov <xemul@sw.ru>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061114181656.6328e51a.vsu@altlinux.ru>
References: <1163151121.3539.15.camel@legolas.in.ibm.com>
	 <20061114181656.6328e51a.vsu@altlinux.ru>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 10:49:14 -0800
Message-Id: <1163530154.4871.14.camel@impinj-lt-0046>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-14 at 18:16 +0300, Sergey Vlasov wrote:
> On Fri, 10 Nov 2006 15:02:01 +0530 Sharyathi Nagesh wrote:
> > --- kernel/fork.c.orig	2006-11-10 14:42:02.000000000 +0530
> > +++ kernel/fork.c	2006-11-10 14:42:30.000000000 +0530
> > @@ -687,6 +687,7 @@ static struct files_struct *dup_fd(struc
> >  		 * the latest pointer.
> >  		 */
> >  		spin_lock(&oldf->file_lock);
> > +		open_files = count_open_files(old_fdt);
> >  		old_fdt = files_fdtable(oldf);
> >  	}

Looks like your analysis of the proposed patch's side-effects agrees
with mine (call it independent verification, if you will :) ); I was
expressing the very same concerns about it introducing a race condition
on the mm-commits@ and stable@ lists. The only concern is that, although
this patch is not correct, it does fix "something" -- it would be good
to identify what exactly that "something" is.

> [...] If the stale
> open_files value was too small (some more files were opened), the copy
> would miss some files, which should be OK (except that memcpy() calls
> which copy fd_sets will copy bits for some of that missed files which
> happened to be in the last word - this would cause some fd's to be
> permanently busy, and potentially could cause problems later [...]

Nope, this logic also looks fine. The open_files value that
count_open_files() returns will always be a multiple of BITS_PER_LONG,
so no extraneous bits will ever be copied. It's a tad confusing since
count_open_files() does something a bit different than what its name
suggests.

Speaking of: does a maintainer currently exist for this part of the
kernel? Who's familiar with all the related code? :)

Also, here's some extra information from the other email thread
regarding this patch, that might aid in debugging. I'm merely
copy-pasting it here for reference:
0:mon> e
cpu 0x0: Vector: 300 (Data Access) at [c00000007ce2f7f0]
    pc: c000000000060d90: .dup_fd+0x240/0x39c
    lr: c000000000060d6c: .dup_fd+0x21c/0x39c
    sp: c00000007ce2fa70
   msr: 800000000000b032
   dar: ffffffff00000028
 dsisr: 40000000
  current = 0xc000000074950980
  paca    = 0xc000000000454500
    pid   = 27330, comm = bash

0:mon> t
[c00000007ce2fa70] c000000000060d28 .dup_fd+0x1d8/0x39c (unreliable)
[c00000007ce2fb30] c000000000060f48 .copy_files+0x5c/0x88
[c00000007ce2fbd0] c000000000061f5c .copy_process+0x574/0x1520
[c00000007ce2fcd0] c000000000062f88 .do_fork+0x80/0x1c4
[c00000007ce2fdc0] c000000000011790 .sys_clone+0x5c/0x74
[c00000007ce2fe30] c000000000008950 .ppc_clone+0x8/0xc

The PC translates to:
        for (i = open_files; i != 0; i--) {
                struct file *f = *old_fds++;
                if (f) {
                        get_file(f);       <-- Data access error
                } else {

And more info still:
        0:mon> r
R00 = ffffffff00000028   R16 = 00000000100e0000
R01 = c00000007ce2fa70   R17 = 000000000fff1d38
R02 = c00000000056cd20   R18 = 0000000000000000
R03 = c000000029f40a58   R19 = 0000000001200011
R04 = c000000029f442d8   R20 = c0000000a544a2a0
R05 = 0000000000000001   R21 = 0000000000000000
R06 = 0000000000000024   R22 = 0000000000000100
R07 = 0000001000000000   R23 = c00000008635f5e8
R08 = 0000000000000000   R24 = c0000000919c5448
R09 = 0000000000000024   R25 = 0000000000000100
R10 = 00000000000000dc   R26 = c000000086359c30
R11 = ffffffff00000000   R27 = c000000089e5e230
R12 = 0000000006bbd9e9   R28 = c00000000c8d3d80
R13 = c000000000454500   R29 = 0000000000000020
R14 = c00000007ce2fea0   R30 = c000000000491fc8
R15 = 00000000fcb2e770   R31 = c0000000b8369b08
pc  = c000000000060d90 .dup_fd+0x240/0x39c
lr  = c000000000060d6c .dup_fd+0x21c/0x39c
msr = 800000000000b032   cr  = 24242428
ctr = 0000000000000000   xer = 0000000000000000   trap =  300
dar = ffffffff00000028   dsisr = 40000000
-----------------------
0:mon> di c000000000060d90 <==PC
c000000000060d90  7d200028      lwarx   r9,r0,r0
c000000000060d94  31290001      addic   r9,r9,1
c000000000060d98  7d20012d      stwcx.  r9,r0,r0
c000000000060d9c  40a2fff4      bne     c000000000060d90        #
.dup_fd+0x240/0x39c
c000000000060da0  48000014      b       c000000000060db4        #
.dup_fd+0x264/0x39c
c000000000060da4  e93b0018      ld      r9,24(r27)
c000000000060da8  7c08482a      ldx     r0,r8,r9
c000000000060dac  7c003878      andc    r0,r0,r7
c000000000060db0  7c08492a      stdx    r0,r8,r9
c000000000060db4  3b180008      addi    r24,r24,8
c000000000060db8  7c0006ac      eieio
c000000000060dbc  380affff      addi    r0,r10,-1
c000000000060dc0  f97c0000      std     r11,0(r28)
c000000000060dc4  38c60001      addi    r6,r6,1
c000000000060dc8  3b9c0008      addi    r28,r28,8
c000000000060dcc  7c0a07b4      extsw   r10,r0

Thanks.
-- Vadim Lobanov


