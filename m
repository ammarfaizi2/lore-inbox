Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315536AbSGANBH>; Mon, 1 Jul 2002 09:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315539AbSGANBG>; Mon, 1 Jul 2002 09:01:06 -0400
Received: from web20506.mail.yahoo.com ([216.136.226.141]:54792 "HELO
	web20506.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315536AbSGANBE>; Mon, 1 Jul 2002 09:01:04 -0400
Message-ID: <20020701130327.38962.qmail@web20506.mail.yahoo.com>
Date: Mon, 1 Jul 2002 15:03:27 +0200 (CEST)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: [ANNOUNCE] CMOV emulation for 2.4.19-rc1
To: vda@port.imtp.ilyichevsk.odessa.ua, Willy TARREAU <willy@w.ods.org>,
       willy@meta-x.org, linux-kernel@vger.kernel.org,
       Ronald.Wahl@informatik.tu-chemnitz.de
In-Reply-To: <200207010858.g618wdT17736@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Denis,

> This code is performance critical.
> With this in mind,

Yes and no. In fact, I first wanted to code some
parts in assembler because GCC is sub-optimal
on bit-fields calculations. But then, I realized that
I could save, say 10 cycles, while the trap costs
about 400 cycles.

> +static void *modrm_address(struct pt_regs *regs,
> unsigned char **from, char w, char bit32,
> w seems to be unused

Well, you're right, it's not used anymore. It was
used to check if the instruction applies to a byte
or a word.

> Why? i86 can do unaligned accesses:
> 	offset = *(u32*)(*from); *from += 4;

that's simply because I'm not sure if the kernel
runs with AC flag on or off. I quickly checked
that it's OK from userland.

> +       /* we'll first read all known opcode
> prefixes, and discard obviously
> +          invalid combinations.*/
> Prefixes are rarer than plain opcodes. Maybe:
> 1.check opcodes
> 2.no? check prefixes
> 3.yes? check opcodes again

perhaps a good idea, I don't know. I think the
current code doesn't cost much in case there
is no prefix (only 3 failed IFs). I also wrote a
prefix bitmap to directly map opcodes to prefixes/
known instructions, but thought it was not really
usefull and costed 32 bytes, so I removed it.
 
> +                               if (prefixes &
PREFIX_LOCK)
> +                                       goto
invalid_opcode;
> Cycles burned for nothing.
> What harm can be done if we managed to emulate
> 	lock lock lock xadd a,b

simply avoid that someone filling 16Meg of code
with prefixes spends all his time in the kernel.
When I did this, I had checked and noticed that
an instruction with a repeated prefix is invalid.

> +                       case 0xF3: /* rep */
> These prefixes are invalid for commands we emulate.
> No GCC will ever generate such code, don't check for
> them.

Yes, I agree with you. The only instructions that
support these prefixes are stable and it's not likely
that others will come in the future, so we may
handle them in the general case of invalid
instruction.

> eliminate 'reg = (modrm >> 3) & 7', move calculation
> to <<<1
> eliminate 'modrm &= 0xC7', move to <<<2 or drop it
> (I think modrm_adr() will work fine with unmasked
> modrm)

I know this part can be reworked. I just need a bit
of time to check redundant calculations between
the main function and modrm_addr(), and I think
I can simplify even more.

Like I said above, I didn't insist on optimizations,
I prefered to get a clear code first. If I want to
optimize, I think most of this will be assembler.

Thanks a lot for your feedback,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
