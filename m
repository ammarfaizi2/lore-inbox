Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263284AbTCNIEn>; Fri, 14 Mar 2003 03:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263286AbTCNIEn>; Fri, 14 Mar 2003 03:04:43 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:29576 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id <S263284AbTCNIEm>; Fri, 14 Mar 2003 03:04:42 -0500
To: thunder7@xs4all.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.64: ioremap_nocache() failes with 1 gigabyte memory, works with 512 Mb?
References: <20030314074530.GA1673@middle.of.nowhere>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 14 Mar 2003 00:15:26 -0800
In-Reply-To: <20030314074530.GA1673@middle.of.nowhere>
Message-ID: <52hea6s6sh.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 14 Mar 2003 08:15:28.0833 (UTC) FILETIME=[DFAD2B10:01C2EA01]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    thunder7> Now I added some information to the printk, and I now
    thunder7> know:

    thunder7> fb: Can't remap 3Dfx Voodoo5 register area. (start d0000000 length 8000000)

Length 0x8000000 means the driver is trying to ioremap a 128MB.

    thunder7> If I boot my kernel with 'mem=512M' I can use the
    thunder7> framebuffer just fine (well, it doesn't work and writes
    thunder7> funky patters to the screen, but at least
    thunder7> ioremap_nocache() works fine).

    thunder7> What is the reason ioremap_nocache() fails? Is this
    thunder7> something that can be prevented? I am not entirely clear
    thunder7> on what is happening anyway (real memory, virtual
    thunder7> memory, nocache-memory, io-memory - a little bit above
    thunder7> my head :-) ).

ioremap_nocache() uses "vmalloc space".  The kernel has some address
space it uses for kernel virtual memory mappings -- that is, for
mapping vmalloc()'ed memory and ioremap()'ed memory.

On i386, the kernel uses whatever part of the top 1 GB of address space
is not used for directly mapped RAM (aka lowmem).  (There are a few
other things that take some address space but that is approximately
true).

This means with "mem=512M", you will probably have about 500M of
vmalloc space, which is more than enough to ioremap the framebuffer.

With the full 1 GB of memory, you might think that there would be no
vmalloc space available at all.  However, <asm/page.h> defines a
constant VMALLOC_RESERVE (which by default is 128 MB), and the kernel
makes sure that there is at least this much vmalloc space available.
However, by the time you load the module, at least some of this space
has been consumed, so the ioremap fails.  (If nothing else uses
vmalloc space, just loading a module will call vmalloc() to get space
for the module to be loaded into!)

One not very good way for you to proceed would be to change the
definition of VMALLOC_RESERVE from (128 << 20) to something like (256
<< 20), which should leave the driver room to ioremap the framebuffer.
This is a little ugly.  However, I don't see why a framebuffer driver
would need to ioremap _all_ of a video card's memory -- so a better
solution would be to fix the driver to only ioremap what it needs to.

Best,
  Roland
