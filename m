Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSGAJHP>; Mon, 1 Jul 2002 05:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314325AbSGAJHO>; Mon, 1 Jul 2002 05:07:14 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:4877 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S314278AbSGAJHN>; Mon, 1 Jul 2002 05:07:13 -0400
Message-Id: <200207010858.g618wdT17736@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Willy TARREAU <willy@w.ods.org>, <willy@meta-x.org>,
       linux-kernel@vger.kernel.org, Ronald.Wahl@informatik.tu-chemnitz.de
Subject: Re: [ANNOUNCE] CMOV emulation for 2.4.19-rc1
Date: Mon, 1 Jul 2002 11:58:14 -0200
X-Mailer: KMail [version 1.3.2]
References: <20020630043950.GA15516@pcw.home.local>
In-Reply-To: <20020630043950.GA15516@pcw.home.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 June 2002 02:39, Willy TARREAU wrote:
> Hi all,
>
> OK, I know that many people dislike this, but I know others
> who occasionally need it anyway. So I don't post it for general
> inclusion, but for interested people.

This code is performance critical.
With this in mind,

+static void *modrm_address(struct pt_regs *regs, unsigned char **from,
+                           char w, char bit32, unsigned char modrm)
+{
w seems to be unused

+                       offset = **from + (((int)*(*from+1)) << 8) +
+                               (((int)*(*from+2)) << 16) + (((int)*(*from+3)) << 24);
+                       *from += 4;
Why? i86 can do unaligned accesses:
	offset = *(u32*)(*from); *from += 4;
or even
	offset = *((u32*)(*from))++; //ugly isn't it?

+                               /* base off32 + scaled index */
+                               offset += **from + (((int)*(*from+1)) << 8) +
+                                       (((int)*(*from+2)) << 16) + (((int)*(*from+3)) << 24);
+                               *from += 4;
same

+               } else if ((modrm & 0xC0) == 0x80) { /* 32 bits unsigned offset */
+                       offset += **from + (((int)*(*from+1)) << 8) +
+                               (((int)*(*from+2)) << 16) + (((int)*(*from+3)) << 24);
+                       *from += 4;
same

+               if ((modrm & 0xC7) == 0x06) { /* 16 bits offset */
+                       offset = **from + (((int)*(*from+1)) << 8);
+                       *from += 2;
similar

+               } else if ((modrm & 0xC0) == 0x80) { /* 16 bits unsigned offset */
+                       offset += **from + (((int)*(*from+1)) << 8);
+                       *from += 2;
similar

+asmlinkage void do_invalid_op(struct pt_regs * regs, long error_code)
+{
...
+       /* we'll first read all known opcode prefixes, and discard obviously
+          invalid combinations.*/
Prefixes are rarer than plain opcodes. Maybe:
1.check opcodes
2.no? check prefixes
3.yes? check opcodes again

+                               if (prefixes & PREFIX_LOCK)
+                                       goto invalid_opcode;
Cycles burned for nothing.
What harm can be done if we managed to emulate
	lock lock lock xadd a,b
?
(same for all other prefixes)
(OTOH this way you can be sure while() will end sooner or later)

+                       case 0xF2: /* repne */
...
+                       case 0xF3: /* rep */
These prefixes are invalid for commands we emulate.
No GCC will ever generate such code, don't check for them.
(Comment them out if you like to retain the code)
This will also simplify
+               else if ((*eip & 0xfc) == 0xf0) {
+                       switch (*eip) {
+                       case 0xF0: /* lock */
down to single if().

+               reg = (modrm >> 3) & 7;
+               modrm &= 0xC7;
+
+               /* condition is valid */
+               dst = reg_address(regs, 1, reg);  <<<1
+               if ((modrm & 0xC0) == 0xC0) { /* register to register */
+                       src = reg_address(regs, 1, modrm & 0x07);
+               }
+               else {
+                       src = modrm_address(regs, &eip, 1, !(prefixes & PREFIX_A32), modrm); <<<2
eliminate 'reg = (modrm >> 3) & 7', move calculation to <<<1
eliminate 'modrm &= 0xC7', move to <<<2 or drop it
(I think modrm_adr() will work fine with unmasked modrm)
--
vda
