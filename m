Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267107AbTAVFq7>; Wed, 22 Jan 2003 00:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267328AbTAVFq7>; Wed, 22 Jan 2003 00:46:59 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:7135 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267107AbTAVFq5>; Wed, 22 Jan 2003 00:46:57 -0500
Date: Tue, 21 Jan 2003 23:55:51 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Miles Bader <miles@gnu.org>
cc: Greg Ungerer <gerg@snapgear.com>, <linux-kernel@vger.kernel.org>
Subject: Re: common RODATA in vmlinux.lds.h (2.5.59)
In-Reply-To: <buoptqp954l.fsf@mcspd15.ucom.lsi.nec.co.jp>
Message-ID: <Pine.LNX.4.44.0301212339540.8909-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jan 2003, Miles Bader wrote:

> Yeah, the new generic RODATA stuff is way broken on the v850 too.

Yup, I actually noticed when looking things over, sorry about that.

>   (1) Separates the RODATA stuff into two macros, an input-sections-and-
>       symbols macro, RODATA_CONTENTS, which can be put into any
>       appropriate section, and a RODATA_SECTION macro, which simply
>       defines an appropriate section using that.  I guess most archs
>       could just use RODATA_SECTION in the same way they use `RODATA'
>       now, but the v850 uses RODATA_CONTENTS instead.
> 
>       This assumes that the original division into lots of little
>       output sections was gratuitous, and that putting everything into
>       a single section is OK.
> 
>       [You might notice that this follows the macro scheme already used
>       by the v850's vmlinux.lds.S file]

Yes, I saw it, but on the other hand I'd like to avoid introducing 
complexity which isn't really needed. So the important question is: Is 
there a reason that v850 does things differently, or could it just as well 
live with separate .text and .rodata sections (Note that sections 
like .rodata1 will be discarded when empty).

The idea behind the cleanup is two-fold:
o Make it easier to add e.g. special sections like __ksymtab and friends.
o Make the building of vmlinux more consistent, i.e. share a common way
  where possible and explicitly document places where archs need to do
  things differently. Today, there's a lot of differences between archs,
  most of them I think just for historical grown-with-time reasons.

A reason to use sections of their own for e.g. __ex_table, __ksymtab etc. 
is also to get alignment right without magic numbers in vmlinux.lds.S.

One example of the inconsistency is e.g. the _etext symbol. For v850 it 
includes .rodata, exception table etc. So if calculating _etext - _stext, 
one gets a wrong impression of the code size, and generic code which 
assumes that there's code between _stext and _etext (kernel/extable.c) 
obviously uses a wrong assumption.

>   (2) Adds a `CSYM' macro which is used for every symbol name that is
>       exported to C.  By default this just expands to its argument, but
>       an arch may define `C_SYMBOL_PREFIX' in order to add a prefix to
>       all C symbols.
> 
> What do you think of this?

I definitely agree with (2), with (1) only if there's a good reason.

--Kai


