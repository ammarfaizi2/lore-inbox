Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbSLYWo6>; Wed, 25 Dec 2002 17:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261486AbSLYWo6>; Wed, 25 Dec 2002 17:44:58 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:46223 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S261463AbSLYWo5>;
	Wed, 25 Dec 2002 17:44:57 -0500
Date: Wed, 25 Dec 2002 23:53:10 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.20-aa1+glibc-2.3.1: AT_PLATFORM on PIV ?
Message-ID: <20021225225310.GA1604@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I have problems running glibc-2.3.1 with a (patched) version of 2.4.20-aa1.
Before anybody says, I an going to try with unpatched 2.4.20-aa1, and even
with plain 2.4.20. But I ask to see if it happens to somebody else...
What I would like is to have somebody using 2.4.20 or 2.4.20-aa1 _and_
glibc-2.3.1 try this things on his box and tell me about the results
(just to see if it is a mainlie bug or _my_ bug).

Long story:
It is supposed that /lib/ld-2.3.1.so is able to use special (optimized) versions
of libraries, placed in dirs like /lib/i686, /lib/sse2, /lib/sse or /lib/mmx,
instead of standard /lib libraries. The selection of which places to look in
is done based on the architechture reported by kernel. Quoting s mail with
Mandrake's glibc packager:
  "AT_PLATFORM is passed through the auxv_t table given to the target 
   program from the kernel."
And all this is done in binfmt_elf.c.

Building the kernel for PII and running it on a (SMP) PII box:

werewolf:~> uname -m
i686
werewolf:~> LD_SHOW_AUXV=1 /bin/true
AT_HWCAP:    fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat p 
se36 mmx fxsr
AT_PAGESZ:      4096
AT_CLKTCK:      100
AT_PHDR:        0x8048034
AT_PHENT:       32
AT_PHNUM:       6
AT_BASE:        0x15556000
AT_FLAGS:       0x0
AT_ENTRY:       0x8048920
AT_UID:         3001
AT_EUID:        3001
AT_GID:         3000
AT_EGID:        3000
AT_PLATFORM:    i686               <====================

So the path used by glibc (after removing /etc/ld.so.cache) is:

werewolf:~> LD_DEBUG=libs /bin/true
01893:  find library=libc.so.6; searching
01893:   search cache=/etc/ld.so.cache
01893:   search path=/lib/i686/mmx:/lib/i686:/lib/mmx:/lib:/usr/lib/i686/mmx:/usr/lib/i686:/usr/lib/mmx:/usr/lib         (system search path)


With the same kernel, built for PIII and run on a SMP P4 system (yup, built
for PIII to use the same kernel along a beowulf), with high mem, it gives:

annwn:~> uname -m
i686
annwn:~> LD_SHOW_AUXV=1 /bin/true
AT_HWCAP:    fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
AT_PAGESZ:      4096
AT_CLKTCK:      100
AT_PHDR:        0x8048034
AT_PHENT:       32
AT_PHNUM:       6
AT_BASE:        0x40000000
AT_FLAGS:       0x0
AT_ENTRY:       0x8048920
AT_UID:         3001
AT_EUID:        3001
AT_GID:         3000
AT_EGID:        3000
AT_PLATFORM:                    <====== empty ?????

So glibc does not include i686 on the search path:

annwn:~> LD_DEBUG=libs /bin/true
16204:  find library=libc.so.6; searching
16204:   search cache=/etc/ld.so.cache
16204:   search path=/lib/sse2/sse/mmx:/lib/sse2/sse:/lib/sse2/mmx:/lib/sse2:/lib/sse/mmx:/lib/sse:/lib/mmx:/lib:/usr/lib/sse2/sse/mmx:/usr/lib/sse2/sse:/usr/lib/sse2/mmx:/usr/lib/sse2:/usr/lib/sse/mmx:/usr/lib/sse:/usr/lib/mmx:/usr/lib   (system search path)

Any idea ?  Is there any easy way (simple C code snippet) to check what
kernel esports as AT_PLATFORM ?

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-jam2 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))
