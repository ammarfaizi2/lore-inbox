Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289002AbSAUByL>; Sun, 20 Jan 2002 20:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288999AbSAUBxv>; Sun, 20 Jan 2002 20:53:51 -0500
Received: from zok.SGI.COM ([204.94.215.101]:56709 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S289000AbSAUBxk>;
	Sun, 20 Jan 2002 20:53:40 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away? 
In-Reply-To: Your message of "Sun, 20 Jan 2002 17:30:12 -0800."
             <3C4B6F24.C2750F51@zip.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 21 Jan 2002 12:53:28 +1100
Message-ID: <32505.1011578008@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jan 2002 17:30:12 -0800, 
Andrew Morton <akpm@zip.com.au> wrote:
>I suspect none of these "Heads" spend much time in protracted
>email debug sessions.  Because the *first* thing you do is
>ask the tester to compile the relevant driver into the
>kernel.
>
>The problems which the removal of this option will cause include:
>
>1: Inability to look up symbols in the kernel elf image.
>2: Breaks the kernel profiler
>3: breaks kgdb
>4: breaks ksymoops.
>
>How often have we seen nonsensical backtraces here because
>modules were involved?   Possibly we can include a table
>of module base addresses in the Oops output and teach ksymoops
>about it.

You see nonsensical backtraces because people persist in using the oops
decode option of klogd which is broken when faced with modules.  Turn
off klogd oops (klogd -x) and you get a raw backtrace which ksymoops
can handle.  Guess why these entries are in /proc/ksyms?

c48a2300 __insmod_3c589_cs_S.bss_L4	[3c589_cs]
c48a0000 __insmod_3c589_cs_O/lib/modules/2.4.17-xfs/kernel/drivers/net/pcmcia/3c589_cs.o_M3C332CFF_V132113	[3c589_cs]
c48a22a0 __insmod_3c589_cs_S.data_L96	[3c589_cs]
c48a1820 __insmod_3c589_cs_S.rodata_L1152	[3c589_cs]
c48a0060 __insmod_3c589_cs_S.text_L6064	[3c589_cs]

ksymoops uses the __insmod entries to work out exactly where each
module is, it gives an accurate backtrace with modules.  man insmod for
details.

Kernel debuggers like kgdb and kdb use kallsyms which has full support
for modules.  kgdb can also use the __insmod entries in /proc/ksyms to
tell gdb where each module was loaded.

ksymoops has a save map option (-s) which writes out the combined
system map, including the kernel and all symbols from all modules.

Sure, a dynamic system requires a little more work, but it has all been
done.  Just kill the broken klogd code so it stops corrupting log data.

