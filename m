Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbUAJA1h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 19:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUAJA1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 19:27:33 -0500
Received: from stud.fbi.fh-darmstadt.de ([141.100.40.65]:17298 "EHLO
	stud.fbi.fh-darmstadt.de") by vger.kernel.org with ESMTP
	id S264488AbUAJA1Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 19:27:24 -0500
From: Sergio Vergata <vergata@stud.fbi.fh-darmstadt.de>
To: Andrew Morton <akpm@osdl.org>, Valdis.Kletnieks@vt.edu
Subject: Re: 2.6.1-mm1 - OOPs and hangs during modprobe
Date: Sat, 10 Jan 2004 01:22:52 +0100
User-Agent: KMail/1.5.93
Cc: linux-kernel@vger.kernel.org
References: <200401091733.i09HXEQa003372@turing-police.cc.vt.edu> <20040109145534.5a6ca6bd.akpm@osdl.org>
In-Reply-To: <20040109145534.5a6ca6bd.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200401100123.17303.vergata@stud.fbi.fh-darmstadt.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hey cool,
I build the 2.6.2-mm1 and just got the same problem with the modules, went out 
for lunch and now works fine again. 

THX sergio


On Friday 09 January 2004 23:55, Andrew Morton wrote:
> Valdis.Kletnieks@vt.edu wrote:
>
> >
> > Summary: 2.6.1-mm1 gives an OOPs while doing a modprobe.  Subsequent
> > references to /proc/modules hang (causing hangs while doing a 'shutdown'
> > because of scripts trying to rmmod modules.  lsmod and 'cat
> > /proc/modules' hang as well after the oops.
> > 
> > This one's from trying to load ip_conntrack_ftp:
> > 
> > Module len 6897 truncated
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 00000004 printing eip:
> > c013040b
> > *pde = 00000000
> > Oops: 0002 [#1]
> > PREEMPT
> > CPU:    0
> > EIP:    0060:[<c013040b>]    Not tainted VLI
> > EFLAGS: 00010002
> > EIP is at sys_init_module+0x90/0x225
> > eax: 00000004   ebx: 0807a3e8   ecx: c03d5c30   edx: d187b104
> > esi: 00000000   edi: cf220000   ebp: cf221fbc   esp: cf221fb0
> > ds: 007b   es: 007b   ss: 0068
> > Process modprobe (pid: 172, threadinfo=cf220000 task=cf4606c0)
> > Stack: 0807a3e8 00000002 080573a0 cf220000 c03548de 0807a3e8 00001af1
> > 0807a088 00000002 080573a0 bfffe8c0 00000080 0000007b 0000007b 00000080
> > ffffd41a 00000073 00000287 bfffe8c0 0000007b
> > Call Trace:
> >  [<c03548de>] sysenter_past_esp+0x43/0x65
> > 
> > Code: d8 57 3d c0 ff 05 d8 57 3d c0 0f 8e ac 06 00 00 89 c2 e9 9f 01 00
> > 00 fa bf 00 e0 ff ff 21 e7 ff 47 14 8b 15 e8 57 3d c0 8d 40 04 <89> 56 04
> > 89 42 04 a3 e8 57 3d c0 c7 40 04 e8 57 3d c0 fb 8b 47 <6>note:
> > modprobe[172] exited with preempt_count 1
> > Debug: sleeping function called from invalid context at
> > include/linux/rwsem.h:43 in_atomic():1, irqs_disabled():0
> > Call Trace:
> >  [<c011b50f>] __might_sleep+0xa4/0xac
> >  [<c011f16f>] do_exit+0xd9/0x389
> >  [<c010c5d2>] do_divide_error+0x0/0xad
> >  [<c011893d>] do_page_fault+0x35f/0x4b2
> >  [<c014576f>] unmap_vm_area+0x2c/0x73
> >  [<c0145a81>] vfree+0x25/0x27
> >  [<c0130354>] load_module+0x790/0x7b7
> >  [<c01185de>] do_page_fault+0x0/0x4b2
> >  [<c035535f>] error_code+0x2f/0x38
> >  [<c013040b>] sys_init_module+0x90/0x225
> >  [<c03548de>] sysenter_past_esp+0x43/0x65
> > 
> > My original thought was that the ip_conntrack_ftp.ko got corrupted,
>
> 
> My original thought is about Rusty. 
> 
> The `check for truncated module' patch is clearly triggering when it
> should not be.  It then incorrectly returns "success" from load_module()
> even though load_module() failed.
> 
> A `patch -R' of
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-m
>m1/broken-out/check-for-truncated-modules.patch 
> should fix it up.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

- -- 
Vodka without beer is like money on the wind.
PGP-Key http://vergata.it/GPG/F17FDB2F.asc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE//0XqVP5w5vF/2y8RAlImAJ9d8goXFVOMXe+pwyydhMUQTkqPYwCfR8Vp
GPoYo9Y+pE6MF4TMUHhlibE=
=73Mx
-----END PGP SIGNATURE-----
