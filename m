Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUHaQhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUHaQhm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUHaQhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:37:42 -0400
Received: from advect.atmos.washington.edu ([128.95.89.50]:36748 "EHLO
	advect.atmos.washington.edu") by vger.kernel.org with ESMTP
	id S264153AbUHaQgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:36:20 -0400
Message-Id: <200408311636.i7VGaBWT004636@moist.atmos.washington.edu>
Date: Tue, 31 Aug 2004 09:36:11 -0700 (PDT)
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re[2]: PROBLEM: page allocation or what in 2.6.8.1
From: Harry Edmon <harry@atmos.washington.edu>
In-Reply-To: <20040826033131.2cc153a9.akpm@osdl.org>
X-Mailer: Ishmail 2.1.0-20021115-i686-pc-linux-gnu <http://ishmail.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -15.31 () AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We believe the hardware is okay.  We have run numerous memtests, all okay.  This
is a Tyan S2721-533 with dual 3.06 Xeons.

We tried taking out CONFIG_DEBUG_PAGEALLOC and still we get crashes, especially
in nfsd.  We have now gone to the 2.6.8.1-mm4 kernel and got the following
crash:

kfree_debugcheck: bad ptr f8c189fch.

------------[ cut here ]------------

kernel BUG at mm/slab.c:1833!

invalid operand: 0000 [#1]

PREEMPT SMP 

Modules linked in: nfs autofs4 nfsd exportfs lockd sunrpc capability commoncap i
pv6 eepro100 joydev tsdev usbhid uhci_hcd usbcore evdev e100 mii sd_mod 3w_xxxx 
scsi_mod ide_cd cdrom rtc unix

CPU:    0

EIP:    0060:[<c0143d0c>]    Not tainted VLI

EFLAGS: 00010086   (2.6.8.1-debug-mm) 

EIP is at kfree_debugcheck+0x4c/0x70

eax: 00000028   ebx: c1718300   ecx: c03729bc   edx: c03729bc

esi: f8c189fc   edi: f8c189fc   ebp: f2efbeac   esp: f2efbe9c

ds: 007b   es: 007b   ss: 0068

Process rpc.mountd (pid: 2529, threadinfo=f2efa000 task=f2ede0b0)

Stack: c0339fa0 f8c189fc f8c189fc f7d5124c f2efbed0 c0144cb5 f8c189fc f2efbeb4 

       f7d51bcc 00000286 f7d5124c f7d5124c efdd925d f2efbee0 f8bc7a48 f8c189fc 

       f7d51bcc f2efbf0c f8bc80d9 f7d5124c f8bddfc0 00000000 f2efa000 f8bdef28 

Call Trace:

 [<c0106f69>] show_stack+0x80/0x96

 [<c0107100>] show_registers+0x15f/0x1c3

 [<c010730a>] die+0x10d/0x1a8

 [<c010782b>] do_invalid_op+0x104/0x106

 [<c0106b81>] error_code+0x2d/0x38

 [<c0144cb5>] kfree+0x25/0x9f

 [<f8bc7a48>] ip_map_put+0x45/0x6e [sunrpc]

 [<f8bc80d9>] ip_map_lookup+0x2ce/0x3a9 [sunrpc]

 [<f8bc8215>] auth_unix_add_addr+0x61/0x9f [sunrpc]

 [<f8c02eb9>] exp_addclient+0xb2/0xbc [nfsd]

 [<f8bfa9ca>] nfsctl_transaction_write+0x6e/0x98 [nfsd]

 [<c01869cb>] sys_nfsservctl+0xc0/0x115

 [<c01060a5>] sysenter_past_esp+0x52/0x71

Code: e3 05 03 1d 90 95 48 c0 8b 03 a9 80 00 00 00 74 0a 8b 5d f8 8b 75 fc 89 ec
 5d c3 89 74 24 04 c7 04 24 a0 9f 33 c0 e8 f0 a6 fd ff <0f> 0b 29 07 d6 92 33 c0
 eb dc 89 74 24 04 c7 04 24 e0 9f 33 c0 



Andrew Morton <akpm@osdl.org> wrote:
> Harry Edmon <harry@atmos.washington.edu> wrote:
> >
> > I have had another crash on the same system as my message of 23 August:
> > 
> > Unable to handle kernel paging request at virtual address cf0b4e1c
> 
> hm.  Is the hardware known to be good?
> 
> > ...
> > 
> > Before the crash I see messages like the following:
> > 
> > oom-killer: gfp_mask=0xd0
> 
> That's because you've enabled.  It enormously
> increases the size of slab objects, which seems to cause memory reclaim to
> blow up.  (It shouldn't but it does.  It's a low-priority problem though).
> 
> It's unlikely that the oom-killing caused the oops, but it's possible I
> guess.  There's supposed to be a dump_stack() in the out_of_memory() path,
> which would help in searching for bugs, but that seems to have got lost.

-- 
 Dr. Harry Edmon			E-MAIL: harry@atmos.washington.edu
 206-543-0547				harry@u.washington.edu
 Dept of Atmospheric Sciences		FAX:	206-543-0308
 University of Washington, Box 351640, Seattle, WA 98195-1640
