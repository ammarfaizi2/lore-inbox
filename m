Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbTAIGko>; Thu, 9 Jan 2003 01:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbTAIGko>; Thu, 9 Jan 2003 01:40:44 -0500
Received: from egil.codesourcery.com ([66.92.14.122]:27535 "EHLO
	egil.codesourcery.com") by vger.kernel.org with ESMTP
	id <S261693AbTAIGkm>; Thu, 9 Jan 2003 01:40:42 -0500
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Set TIF_IRET in more places
From: Zack Weinberg <zack@codesourcery.com>
Date: Wed, 08 Jan 2003 22:49:22 -0800
In-Reply-To: <20030108162906.GA5995@bjl1.asuk.net> (Jamie Lokier's message
 of "Wed, 8 Jan 2003 16:29:07 +0000")
Message-ID: <87hecig6ml.fsf@egil.codesourcery.com>
User-Agent: Gnus/5.090011 (Oort Gnus v0.11) Emacs/21.2 (i386-pc-linux-gnu)
References: <87isx2dktj.fsf@egil.codesourcery.com>
	<20030107111905.GA949@bjl1.asuk.net>
	<87of6s3gm3.fsf@egil.codesourcery.com>
	<20030107172128.A9592@twiddle.net>
	<20030108162906.GA5995@bjl1.asuk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <lk@tantalophile.demon.co.uk> writes:

>
> It would be quite nice just to have dwarf2 unwind information, with an
> unwind handler, for the classic non-vsyscall restorer in Glibc.

A trivial routine that just calls another routine,

extern void g(void);

void f(void) { g(); asm volatile (""); }

[the asm is to prevent sibcall optimization from kicking in] produces
the assembly dump appended to this message when compiled with -O2
-fexceptions -fomit-frame-pointer.  I do not know what the stuff put
in .eh_frame means, and it probably isn't exactly right for __restore
or __restore_rt, but it's a start.

> Then MD_FALLBACK_FRAME_STATE_FOR could be removed from GCC on all
> Linux targets, regardless of kernel version.

I think we'd need to keep it around for the sake of older libcs; it
shouldn't do any harm.

zw

        .text
        .p2align 2,,3
.globl f
        .type   f,@function
f:
.LFB1:
        subl    $12, %esp
.LCFI0:
        call    g
        addl    $12, %esp
.LCFI1:
        ret
.LFE1:
.Lfe1:
        .size   f,.Lfe1-f
        .section        .eh_frame,"aw",@progbits
.Lframe1:
        .long   .LECIE1-.LSCIE1
.LSCIE1:
        .long   0x0
        .byte   0x1
        .string ""
        .uleb128 0x1
        .sleb128 -4
        .byte   0x8
        .byte   0xc
        .uleb128 0x4
        .uleb128 0x4
        .byte   0x88
        .uleb128 0x1
        .align 4
.LECIE1:
.LSFDE1:
        .long   .LEFDE1-.LASFDE1
.LASFDE1:
        .long   .LASFDE1-.Lframe1
        .long   .LFB1
        .long   .LFE1-.LFB1
        .byte   0x4
        .long   .LCFI0-.LFB1
        .byte   0xe
        .uleb128 0x10
        .byte   0x4
        .long   .LCFI1-.LCFI0
        .byte   0xe
        .uleb128 0x4
        .align 4
.LEFDE1:
        .ident  "GCC: (GNU) 3.2.2 20021231 (Debian prerelease)"
