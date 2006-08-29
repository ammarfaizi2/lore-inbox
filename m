Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965255AbWH2ShS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965255AbWH2ShS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965254AbWH2ShS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:37:18 -0400
Received: from 82-69-39-138.dsl.in-addr.zen.co.uk ([82.69.39.138]:4534 "EHLO
	ty.sabi.co.UK") by vger.kernel.org with ESMTP id S965258AbWH2ShQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:37:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17652.35152.661745.96581@base.ty.sabi.co.UK>
Date: Tue, 29 Aug 2006 19:37:04 +0100
X-Face: SMJE]JPYVBO-9UR%/8d'mG.F!@.,l@c[f'[%S8'BZIcbQc3/">GrXDwb#;fTRGNmHr^JFb
 SAptvwWc,0+z+~p~"Gdr4H$(|N(yF(wwCM2bW0~U?HPEE^fkPGx^u[*[yV.gyB!hDOli}EF[\cW*S
 H<GG"+i\3#fp@@EeWZWBv;]LA5n1pS2VO%Vv[yH?kY'lEWr30WfIU?%>&spRGFL}{`bj1TaD^l/"[
 msn( /TH#THs{Hpj>)]f><W}Ck9%2?H"AEM)+9<@D;3Kv=^?4$1/+#Qs:-aSsBTUS]iJ$6
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: The 3G (or nG) Kernel Memory Space Offset
In-Reply-To: <44F46E8C.1000308@goop.org>
References: <a2ebde260608290715o627c631uca67e5b84b8c0777@mail.gmail.com>
	<Pine.LNX.4.61.0608291634380.16371@yvahk01.tjqt.qr>
	<a2ebde260608290901w73575e18hffd8a9d6c989f523@mail.gmail.com>
	<44F46E8C.1000308@goop.org>
X-Mailer: VM 7.17 under 21.4 (patch 19) XEmacs Lucid
From: pg_lkm@lkm.for.sabi.co.UK (Peter Grandi)
X-Disclaimer: This message contains only personal opinions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ ... ]

df> My question is actually why there is a 3G offset from linear
df> kernel to physical kernel. Why not simply have kernel memory
df> linear space located on 0-1G linear address, and therefore the
df> physical kernel and linear kernel just coincide?

First of all there are _three_ mapping regions:

* for the per-process address space	(x86 default 3GiB at address 0);
* the kernel address space		(x86 default 128MiB at address 3Gib);
* the real memory address space		(x86 default the last 896MiB).

The kernel address space is small and does not matter much in this
discussionm except for stealing 128MiB. What really matter are the
other two. Note also that the memory resident pages of a process
are necessarily mapped twice, once in the per-process address
space and once in the real memory space.

There are actually three possible cases:

1) per-process mapped low, real memory mapped high (e.g. 3GiB+128MiB+896MiB).
2) real memory mapped low, per-process mapped high (e.g. 896MiB+128MiB+3GiB).
3) both per-process and real memory mapped low (e.g. 3.9GiB+128MiB), with 
   real memory/per process flipping or something else.

jeremy> If kernel virtual addresses were low, you would either
jeremy> need to do an address-space switch (=TLB flush)

This is case #3, which was the norm on many platforms, e.g. UNIX
PDP-11. To be practical it requires special instructions to
load/store from unmapped address spaces. Linus prefers to map
both kernel and physical memory in every address space.

jeremy> on every user-kernel switch,

Not on every user-kernel switch, because there are two (or
three) possibilities:

* Only the real-memory address space has the 128MiB kernel
  address space map, which seems what this phrase assumes.

* Each address space, including both per-process ones and the
  real memory one, have a 128MiB mapping for the kernel address
  space.

If the 128MiB kernel address space were still to be mapped in
every process address space *and* the real memory space, one would
need a switch only when the kernel wants to access per-process
space and real memory in short time. Unless there is some special
way that allows the kernel to address real memory directly, but
then that gets a bit cumbersome.

jeremy> or require userspace to be at some high address.

This is case #2.

jeremy> and the latter very strange (the standard x86 ABI
jeremy> requires low addresses).

Strange does not matter a lot; but it is somewhat surprising
that the x86 ABI, which includes shared libs all over the place,
does require low addresses. But if that is the case it must have
been an important point in the past, when layout compatibility
might have mattered for iBCS (anybody remembers that? :->).

What I suspect is more likely as a reason to avoid mapping
per-process address space at high addresses is that would have
broken many incorrect programs... :-)

jeremy> The clean solution is to map the kernel to the high part
jeremy> of the address space,

Not necessarily clean, but perhaps required by ABI compatibility.

jeremy> but it is easier to load the kernel into low physical
jeremy> memory at boot, thus leading to a physical-virtual
jeremy> offset.

Odd, because this is an argument to have case #2 or #3: because
then one loads the kernel code at low physical addresses, and
then maps them 1-1 onto virtual addresses.

jeremy> The selection of 3G is a reasonable tradeoff of physical
jeremy> memory size vs user virtual address space size, but of
jeremy> course it can be adjusted, or you can use highmem.

Probably this was a bit dumb, because of the missing 128MiB
syndrome. I would set the default for per-process space to
2GiB-128MiB, leaving only those users who want more per-process
address space and don't want to move to 64-bit to move the
boundary back. Some reflections on this in:

  http://WWW.sabi.co.UK/Notes/#060821c
