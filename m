Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRACWTi>; Wed, 3 Jan 2001 17:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbRACWT3>; Wed, 3 Jan 2001 17:19:29 -0500
Received: from du-224-128.nat.dialup.freesurf.fr ([212.43.224.128]:8455 "EHLO
	wild-wind.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S129267AbRACWTL>; Wed, 3 Jan 2001 17:19:11 -0500
To: linux-kernel@vger.kernel.org
Cc: linux-irda@pasta.cs.UiT.No
Subject: [IrDA+SMP] Lockup in handle_IRQ_event
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: Loën 12 juin 1996 13:10
X-Baby-2: None
Reply-to: mzyngier@freesurf.fr
From: Marc ZYNGIER <mzyngier@freesurf.fr>
Date: 03 Jan 2001 23:20:47 +0100
Message-ID: <wrpzoh89t1c.fsf@hina.wild-wind.fr.eu.org>
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Capitol Reef"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Having just started playing with IrDA on my dual celeron (Abit "APIC
error..." BP6), I managed to kill it every single time (NMI watchdog
in handle_IRQ_event) while connecting to my mobile phone (in fact,
when closing the connection to the phone. even 'cat /dev/ircomm0' will
do...). This is perfectly repeatable.

This is with 2.4.0-prerelease (with prerelease-diff as of Wed Jan  3
15:31 UTC 2001), but also crashes with test13-pre7. Didn't test
previous kernel yet, but will do if asked.

hina:~$ ksymoops irda_oops-1
ksymoops 2.3.5 on i686 2.4.0-prerelease.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-prerelease/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

activating NMI Watchdog ... done.
cpu: 0, clocks: 1002414, slice: 334138
cpu: 1, clocks: 1002414, slice: 334138
NMI Watchdog detected LOCKUP on CPU0, registers:
CPU:    0
EIP:    0010:[<c010a5e5>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000002
eax: 00000001   ebx: c15bc1e0   ecx: 00000000   edx: 00000000
esi: c02d1860   edi: 00000003   ebp: 00000003   esp: cd9e9d10
ds: 0018   es: 0018   ss: 0018
Process gsmctl (pid: 271, stackpage=cd9e9000)
Stack: c02eed00 c02d1860 00000003 cd9e9d48 c010a7f6 00000003 cd9e9d50 c15bc1e0 
       cdbe2da0 cdbe2da0 00000000 00000000 00000000 c15bc1e0 00000000 c0108fbc 
       cdbe2da0 00000000 cfab8d20 cdbe2da0 00000000 00000000 cfab8d2c cfab0018 
Call Trace: [<c010a7f6>] [<c0108fbc>] [<d0836181>] [<d082f84e>] [<d0837299>] [<d0878d58>] [<d0878767>] 
       [<d08787c0>] [<d0878467>] [<d0838438>] [<d087d2eb>] [<d087d36c>] [<d087c92a>] [<d087bfac>] [<d087b8fa>] 
       [<c017e960>] [<c017efc9>] [<c0132af1>] [<c0131aa2>] [<c01184fb>] [<c0118cd3>] [<c0118e4a>] [<c0108efb>] 
Code: a1 44 cd 2e c0 a8 01 75 f7 be 01 00 00 00 f6 43 07 20 75 01 

>>EIP; c010a5e5 <handle_IRQ_event+21/78>   <=====
Trace; c010a7f6 <do_IRQ+a6/f4>
Trace; c0108fbc <ret_from_intr+0/20>
Trace; d0836181 <[irda]hashbin_remove+121/13c>
Trace; d082f84e <[irda]irlmp_disconnect_request+66/98>
Trace; d0837299 <[irda]irttp_disconnect_request+f1/f8>
Trace; d0878d58 <[ircomm]ircomm_ttp_disconnect_request+14/18>
Trace; d0878767 <[ircomm]ircomm_state_conn+83/b8>
Trace; d08787c0 <[ircomm]ircomm_do_event+24/2c>
Trace; d0878467 <[ircomm]ircomm_disconnect_request+17/20>
Trace; d0838438 <[irda]__irias_delete_attrib+0/30>
Trace; d087d2eb <[ircomm-tty]ircomm_tty_state_ready+47/a4>
Trace; d087d36c <[ircomm-tty]ircomm_tty_do_event+24/2c>
Trace; d087c92a <[ircomm-tty]ircomm_tty_detach_cable+72/a8>
Trace; d087bfac <[ircomm-tty]ircomm_tty_shutdown+88/b8>
Trace; d087b8fa <[ircomm-tty]ircomm_tty_close+c2/16c>
Trace; c017e960 <release_dev+244/514>
Trace; c017efc9 <tty_release+2d/68>
Trace; c0132af1 <fput+39/e8>
Trace; c0131aa2 <filp_close+b2/bc>
Trace; c01184fb <put_files_struct+4f/b8>
Trace; c0118cd3 <do_exit+127/274>
Trace; c0118e4a <sys_exit+e/10>
Trace; c0108efb <system_call+33/38>
Code;  c010a5e5 <handle_IRQ_event+21/78>
00000000 <_EIP>:
Code;  c010a5e5 <handle_IRQ_event+21/78>   <=====
   0:   a1 44 cd 2e c0            mov    0xc02ecd44,%eax   <=====
Code;  c010a5ea <handle_IRQ_event+26/78>
   5:   a8 01                     test   $0x1,%al
Code;  c010a5ec <handle_IRQ_event+28/78>
   7:   75 f7                     jne    0 <_EIP>
Code;  c010a5ee <handle_IRQ_event+2a/78>
   9:   be 01 00 00 00            mov    $0x1,%esi
Code;  c010a5f3 <handle_IRQ_event+2f/78>
   e:   f6 43 07 20               testb  $0x20,0x7(%ebx)
Code;  c010a5f7 <handle_IRQ_event+33/78>
  12:   75 01                     jne    15 <_EIP+0x15> c010a5fa <handle_IRQ_event+36/78>

activating NMI Watchdog ... done.
cpu: 0, clocks: 1002374, slice: 334124
cpu: 1, clocks: 1002374, slice: 334124

1 warning issued.  Results may not be reliable.
hina:~$ grep c02ecd44 /usr/src/linux/System.map 
c02ecd44 B global_irq_lock

Irk... CPU1 stuck in an interrupt, or global_irq_lock not released ?
Any idea anyone ? .config upon request.

	M.

PS: if you reply to this mail from the IrDA ML, please CC to me as I'm
only subscribed to linux-kernel...
-- 
Places change, faces change. Life is so very strange.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
