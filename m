Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132435AbRASQld>; Fri, 19 Jan 2001 11:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135444AbRASQlX>; Fri, 19 Jan 2001 11:41:23 -0500
Received: from colorfullife.com ([216.156.138.34]:17164 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132435AbRASQlK>;
	Fri, 19 Jan 2001 11:41:10 -0500
Message-ID: <3A686E14.B76DE561@colorfullife.com>
Date: Fri, 19 Jan 2001 17:40:52 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: mojomofo@mojomofo.com, linux-kernel@vger.kernel.org
CC: paulus@linuxcare.com, linux-ppp@vger.kernel.org
Subject: [2.4.1-pre8] MPP related OPPS
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Paul Mackerras and linux-ppp added to the cc list]

It seems that the MPPP reconstruction queue got corrupted:

ppp_mp_reconstruct() called kfree_skb(), and within kfree_skb() the call
to skb->destructor() crashed:
skb->destructor was 0x01010101.


> 
> 
> I reported this a few months ago without much details and the machine
> involved died shortly after which made me think that
> this oops was merely bad hardware. This is a brand new machine and the opps
> popped up again. Thankfully I armed myself
> with a serial console and captured this beast.
> 
> Definitely bad mojo involved in the MPPP code, this only occurs when 2
> modems are bonded together over serial lines
> connected to a 3com TotalControl PPP server.
>
> I can recreate it with a bare-minimum kernel up to a full featured kernel,
> going all the way back into 2.3.x land.
> It isn't limited to this machine either. :)
> 
> Master link is on COM1 using an oldie but goodie USR Dual Standard
> V.Everything
> Slave link is on a USR PCI controller-full 56k modem
> 
> With the master link configured with MPP without the slave attached, I can
> run it for days.
> With the master link having the slave attached, I can run it for 5 minutes
> to 30 minutes.
> 
> I've even switched master/slave configurations and tried different modems.
> 
> Details to follow:
> 
> [1.] One line summary of the problem:
>  After a few minutes of heavy load, MPPP over serial lines oops's.
> 
> [2.] Full description of the problem/report:
> See above.
> 
> [4.] Kernel version (from /proc/version):
> Linux version 2.4.1-pre8 (root@usr1-ip031-cs.wmis.net) (gcc version 2.95.3
> 20010101 (prerelease)) #1 Thu Jan 18 21:15:51 EST 2001
> 
> Note that this happens with egcs also, and gcc 2.95.2
> 
> [5.] Output of Oops.. message (if applicable) with symbolic information
>      resolved (see Documentation/oops-tracing.txt)
> 
> Script started on Fri Jan 19 00:17:52 2001
> root@usr1-ip028-cs ~]# ksymoops -v /usr/src/linux/vmlinux -k /proc/ksyms -l
> /proc/modules -m /usr/src/linux/System.map <oops.txt
> ksymoops 2.3.7 on i586 2.4.1-pre8.  Options used
>               -v /usr/src/linux/vmlinux (specified)
>               -k /proc/ksyms (specified)
>               -l /proc/modules (specified)
>               -o /lib/modules/2.4.1-pre8/ (default)
>               -m /usr/src/linux/System.map (specified)
> 
>          Unable to handle kernel paging request at virtual address 01010101
>          01010101
>          *pde = 00000000
>          Oops: 0000
>          CPU:    0
>          EIP:    0010:[<01010101>]
>          Using defaults from ksymoops -t elf32-i386 -a i386
>          EFLAGS: 00010282
>          eax: 01010101   ebx: c1ce7eb4   ecx: c209c000   edx: 00000000
>          esi: 00003fd2   edi: 00000000   ebp: c3d839e0   esp: c209de44
>          ds: 0018   es: 0018   ss: 0018
>          Process dnetc (pid: 695, stackpage=c209d000)
>          Stack: c01accd2 c1ce7eb4 c1ce7eb4 00000000 c49c95b3 c1ce7eb4 00003fd2
>          c2e5d1e0
>                 fffffffe c1ce7e44 000005bd 00000000 c2e5d1e0 c2e5d1e0 c1ce7eb4
>          00003fd2
>                 c49c9270 c1ce7e00 c1ce7e00 000005c3 c20a3be0 00000001 c1ce7eb4
>          c49c8b04
>          Call Trace: [<c01accd2>] [<c49c95b3>] [<c49c9270>] [<c49c8b04>] [<c49c8a1b>]
>          [<c49ccf86>] [<c49cc383>]
>                 [<c01726e5>] [<c0172774>] [<c0181487>] [<c0181766>] [<c0109f3c>]
>          [<c010a09e>] [<c0108e00>]
>          Code:  Bad EIP value.
> 
>          >>EIP; 01010101 Before first symbol   <=====
>          Trace; c01accd2 <__kfree_skb+7e/134>
>          Trace; c49c95b3 <[ppp_generic]ppp_mp_reconstruct+2bf/2d8>
>          Trace; c49c9270 <[ppp_generic]ppp_receive_mp_frame+1cc/20c>
>          Trace; c49c8b04 <[ppp_generic]ppp_receive_frame+30/7c>
>          Trace; c49c8a1b <[ppp_generic]ppp_input+12f/164>
>          Trace; c49ccf86 <[ppp_async]ppp_async_input+3ae/458>
>          Trace; c49cc383 <[ppp_async]ppp_asynctty_receive+27/58>
>          Trace; c01726e5 <flush_to_ldisc+dd/e4>
>          Trace; c0172774 <tty_flip_buffer_push+14/5c>
>          Trace; c0181487 <receive_chars+1f3/200>
>          Trace; c0181766 <rs_interrupt_single+42/88>
>          Trace; c0109f3c <handle_IRQ_event+30/5c>
>          Trace; c010a09e <do_IRQ+6e/b0>
>          Trace; c0108e00 <ret_from_intr+0/20>
> 
>          Kernel panic: Aiee, killing interrupt handler!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
