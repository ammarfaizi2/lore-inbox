Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVBFSIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVBFSIA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 13:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVBFSH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 13:07:57 -0500
Received: from chello081018222206.chello.pl ([81.18.222.206]:50446 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S261264AbVBFSHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 13:07:33 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
Date: Sun, 6 Feb 2005 19:07:27 +0100
User-Agent: KMail/1.7.91
References: <20050206113635.GA30109@wotan.suse.de> <200502061303.12377.pluto@pld-linux.org> <20050206124701.GD30109@wotan.suse.de>
In-Reply-To: <20050206124701.GD30109@wotan.suse.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gzlBCu6cX89QLJo"
Message-Id: <200502061907.28165.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_gzlBCu6cX89QLJo
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 06 of February 2005 13:47, you wrote:
> On Sun, Feb 06, 2005 at 01:03:11PM +0100, Pawel Sikora wrote:
> > On Sunday 06 of February 2005 12:36, you wrote:
> > > Worse is that even when the program has trampolines and has
> > > PT_GNU_STACK header with an E bit on the stack it still won't get an
> > > executable heap by default  (this is what broke grub)
> > > (...)
> > > My proposal is to turn this all off at least for 2.6.11.
> >
> > My proposal is to recompile broken software with cflags +=3D
> > -Wa,--noexecstack
>
> By how do you detect broken software? There doesn't seem to be any
> fool proof way other than a extensive test on a NX capable system
> with correct kernel.

[1] glibc-2.3.4 kill buggy bins at the load time.
    (please look into: elf/dl-load.c, elf/dl-support.c, elf/rtld.c)
    This works on i386/PaX systems too (hardware NX isn't required).

[2] `readelf -Wl |grep GNU_STACK` shows RWE ;-)

Please look at this quick example.

# gcc tmp1.c tmp2-invalid.S -o tmp -s
# readelf -Wl tmp

(...)
  GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RWE 0x4
                                                                  ^ execsta=
ck?
  PAX_FLAGS      0x000000 0x00000000 0x00000000 0x00000 0x00000     0x4
(...)

Now, let's add section note to the asm. file and rebuild.

# gcc tmp1.c tmp2-valid.S -o tmp -s
# readelf -Wl tmp

(...)
  GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RW  0x4
  PAX_FLAGS      0x000000 0x00000000 0x00000000 0x00000 0x00000     0x4
(...)

The execstack req. disappeard (~99% of broken sources).
I get the same effect with fixed cflags and invalid source.

# gcc tmp1.c tmp2-invalid.S -o tmp -s -Wa,--noexecstack
# readelf -Wl tmp

(...)
  GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RW  0x4
  PAX_FLAGS      0x000000 0x00000000 0x00000000 0x00000 0x00000     0x4
(...)

I known several apps that really need executable data/stack (eg. jvm, xorg).
The rest of RWE-marked binaries have IMHO buggy sources.

> It would be fine if there was a compile time error or something,
> but there isn't.

IMHO the `as` should warn about missed (.note.GNU-stack) section.

Regards,
Pawe=C5=82.

=2D-=20
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)

--Boundary-00=_gzlBCu6cX89QLJo
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="tmp1.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="tmp1.c"

extern void test();

int main(int argc, char** argv)
{
    test();
    return 0;
}

--Boundary-00=_gzlBCu6cX89QLJo
Content-Type: text/plain;
  charset="iso-8859-1";
  name="tmp2-invalid.S"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="tmp2-invalid.S"

    .text
    .global test
test:
    ret
    .end

--Boundary-00=_gzlBCu6cX89QLJo
Content-Type: text/plain;
  charset="iso-8859-1";
  name="tmp2-valid.S"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="tmp2-valid.S"

    .section .note.GNU-stack,"",@progbits; .previous
    .text
    .global test
test:
    ret
    .end

--Boundary-00=_gzlBCu6cX89QLJo--
