Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273983AbRJIKdv>; Tue, 9 Oct 2001 06:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273985AbRJIKdm>; Tue, 9 Oct 2001 06:33:42 -0400
Received: from s2.relay.oleane.net ([195.25.12.49]:46609 "HELO
	s2.relay.oleane.net") by vger.kernel.org with SMTP
	id <S273983AbRJIKd2>; Tue, 9 Oct 2001 06:33:28 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <paulus@samba.org>, <linux-kernel@vger.kernel.org>,
        <torvalds@transmeta.com>
Subject: Re: [PATCH] change name of rep_nop
Date: Tue, 9 Oct 2001 12:33:56 +0200
Message-Id: <20011009103356.4478@smtp.adsl.oleane.com>
In-Reply-To: <E15qjdL-0002FT-00@the-village.bc.nu>
In-Reply-To: <E15qjdL-0002FT-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>That raises the question of whether x86 should seperate the "386" "486" ..
>kernels by adding "Generic" for building a kernel that has all the work
>arounds for everyones randomly buggy processors

One approach we take on PPC that you may or may not like for this is
dynamic patching.

Basically, we have some very early init code that probes the CPU type,
and extract from a table a bit mask of "CPU features". Those can be
real features, like has an FPU or an Altivec, but can also be known
erratas.

Then, we have a a couple of macros that look like this : (to be used
in .S files or in inline assembly)

  some asm code...
BEGIN_FEATURE_SECTION()
  some asm code specific to the presence
  or absence of a CPU feature bit
END_FEATURE_SECTION(mask, value)

basically, what those macros do is to add references to the enclosed
bit of code to a separate ELF section, along with the mask & values
32 bit values.

The early CPU probe code, after having determined the feature bits mask
of the CPU will then walk that additional ELF section, and for each
entry in it (an entry is a start address, an end address, a mask and
a value), will test if (cpu_feature & mask) == value. If the result is
false, then the entire section of code referenced is replaced with nop's.

This works well for small bits of code (we use it for commenting out
some altivec code in the context switch path on non-altivec machines,
and for nop'ing out some "sync" intructions that are only necessary
on some older buggy CPUs). You still have the cost of executing a NOP
(which is pretty minimal on PPC, but other archs may want a more suitable
instruction as NOP can be context synchronising on some CPUs).

If you happen to have large code sections covered by this mecanism,
the patching code can be improved to insert a branch to the end of
the nop'ed out section on it's first instruction.

Regards,
Ben.


