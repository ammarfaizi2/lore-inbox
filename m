Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266002AbUGEKjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266002AbUGEKjv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 06:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266005AbUGEKjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 06:39:51 -0400
Received: from david.siemens.de ([192.35.17.14]:15544 "EHLO david.siemens.de")
	by vger.kernel.org with ESMTP id S266002AbUGEKjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 06:39:42 -0400
Subject: PROBLEM: using _syscall4 to call sys_futex with -fPIC won't compile
From: Benjamin Collar <benjamin.collar@siemens.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: CT SE2 Siemens
Message-Id: <1089023944.8355.52.camel@mhpajh5c>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 05 Jul 2004 12:39:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings

[1.]
If I use _syscall4 in order to call sys_futex and compile with -fPIC, I
receive this compiler error:
"can't find a register in class `BREG' while reloading `asm'"

[2.]
I'm using futexes in a project and I have to build a shared library;
thus I need to use -fPIC when compiling. When doing so, I get the error
mentioned in [1.]. A colleague and I figured out that the problem lies
in the intermediate code generated:

int sys_futex(int *futex, int op, int val, struct timespec *rel) {
        register long __res;
        __asm__ volatile (
                "int $0x80"
        : "=a" (__res)
        : "0" (240),
          "b" ((long)(futex)),
          "c" ((long)(op)),
          "d" ((long)(val)),
          "S" ((long)(rel)));

The "b" ((long)(futex)), causes the error.
          
[3.] syscall
[4.] Linux version 2.6.7 (gcc version 3.3.3 20040412 (Gentoo Linux
3.3.3-r6, ssp-3.3.2-2, pie-8.7.6)) #2 SMP Thu Jun 17 10:38:06 CEST 2004
(I tested on a Debian based machine as well with the same result).
[5.] n/a
[6.] For example, see the futex-2.2.tar.bz2; change the Makefile to use
-fPIC
[7.]
[7.1]
Linux mhpajh5c 2.6.7 #2 SMP Thu Jun 17 10:38:06 CEST 2004 i686 Intel(R)
Pentium(R) 4 CPU 3.20GHz GenuineIntel GNU/Linux
  
Gnu C                  3.3.3
Gnu make               3.80
binutils               2.14.90.0.8
util-linux             2.12
mount                  2.12
module-init-tools      3.0
e2fsprogs              1.35
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.1.15
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         i830 ohci_hcd 3c59x ata_piix libata uhci_hcd
intel_agp agpgart snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec
snd_pcm snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_oss
snd_seq_midi_event snd_seq snd_timer snd_seq_device snd e1000 sbp2
ohci1394 ieee1394 usb_storage ehci_hcd usbcore
[7.2]
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping        : 9
cpu MHz         : 3192.159
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 6307.84
[7.3,4,5,6,7] n/a
[X.] This hand-written assembly works for the moment:
int sys_futex(int *futex, int op, int val, struct timespec *rel) {
        register long __res;
        __asm__ volatile (
                "pushl  %%ebx\n\
                movl    8(%%ebp), %%ebx\n\
                int $0x80\n\
                popl    %%ebx"
        : "=a" (__res)
        : "0" (240)/*,
          "b" ((long)(futex))*/,
          "c" ((long)(op)),
          "d" ((long)(val)),
          "S" ((long)(rel)));
          
        do {
                if ((unsigned long)(__res) >= (unsigned long)(-125)) {
                        (*__errno_location ()) = -(__res);
                        __res = -1;
                }
                return (int) (__res);
        } while (0);
}

Thanks for any help in figuring out what's wrong.

Sincerely
Ben



