Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbUKEK5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbUKEK5Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 05:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbUKEK5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 05:57:25 -0500
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:51658 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261593AbUKEK5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 05:57:15 -0500
Message-ID: <418B5C70.7090206@kolivas.org>
Date: Fri, 05 Nov 2004 21:56:48 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm3
References: <20041105001328.3ba97e08.akpm@osdl.org>
In-Reply-To: <20041105001328.3ba97e08.akpm@osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig167006BD1BE457BF1601A081"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig167006BD1BE457BF1601A081
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

It's life Jim but not as we know it...


This happened during modprobe of alsa modules. Keyboard still alive, 
everything else dead; not even sysrq would do anything, netconsole had 
no output, luckily this made it to syslog:

Nov  5 21:39:27 pc kernel: Unable to handle kernel paging request at 
virtual address f8c00000
Nov  5 21:39:27 pc kernel:  printing eip:
Nov  5 21:39:27 pc kernel: c02bddce
Nov  5 21:39:27 pc kernel: *pde = 00000000
Nov  5 21:39:27 pc kernel: Oops: 0002 [#1]
Nov  5 21:39:27 pc kernel: PREEMPT SMP
Nov  5 21:39:27 pc kernel: Modules linked in: soundcore intel_agp 
agpgart bttv video_buf firmware_class i2c_algo_bit btcx_risc i2c_core us
blp ehci_hcd uhci_hcd
Nov  5 21:39:27 pc kernel: CPU:    0
Nov  5 21:39:27 pc kernel: EIP:    0060:[<c02bddce>]    Not tainted VLI
Nov  5 21:39:27 pc kernel: EFLAGS: 00010246   (2.6.10-rc1-mm3)
Nov  5 21:39:27 pc kernel: EIP is at __lock_text_end+0xbe3/0x119a
Nov  5 21:39:27 pc kernel: eax: 00000000   ebx: 000a151a   ecx: 0002851a 
   edx: b7c82008
Nov  5 21:39:27 pc kernel: esi: b7cfb008   edi: f8c00000   ebp: f6c1c000 
   esp: f6c1cf14
Nov  5 21:39:27 pc kernel: ds: 007b   es: 007b   ss: 0068
Nov  5 21:39:27 pc kernel: Process modprobe (pid: 955, 
threadinfo=f6c1c000 task=f76ef530)
Nov  5 21:39:27 pc kernel: Stack: 00000002 0002851a f8b87000 b7c82008 
c01d2a10 b7c82008 000a151a 08049410
Nov  5 21:39:27 pc kernel:        c012f697 00000000 00000001 00008000 
00000000 00000000 c1707400 f6a41580
Nov  5 21:39:27 pc kernel:        f58c4ac4 f58c4ac4 00000046 00000000 
f6a41580 00000246 00000246 00000000
Nov  5 21:39:27 pc kernel: Call Trace:
Nov  5 21:39:27 pc kernel:  [<c01d2a10>] copy_from_user+0x29/0x4d
Nov  5 21:39:27 pc kernel:  [<c012f697>] load_module+0x73/0x916
Nov  5 21:39:27 pc kernel:  [<c0142007>] do_munmap+0x10e/0x11c
Nov  5 21:39:27 pc kernel:  [<c012ff87>] sys_init_module+0x4d/0x207
Nov  5 21:39:27 pc kernel:  [<c0104b31>] sysenter_past_esp+0x52/0x71
Nov  5 21:39:27 pc kernel: Code: 88 00 51 50 31 c0 f3 aa 58 59 e9 75 4b 
f1 ff 01 c1 e9 a9 4b f1 ff 8d 4c 88 00 e9 a0 4b f1 ff 01 c1 eb 04
8d 4c 88 00 51 50 31 c0 <f3> aa 58 59 e9 d1 4b f1 ff ba f2 ff ff ff e9 
60 96 f1 ff b9 f2

*__lock_text_end+0xbe3: hidden in inlined functions

*copy_from_user+0x29: hidden in inlined functions

*load_module+0x73:
0xc012f697 is in load_module (kernel/module.c:1457).
1452            /* Suck in entire file: we'll want most of it. */
1453            /* vmalloc barfs on "unusual" numbers.  Check here */
1454            if (len > 64 * 1024 * 1024 || (hdr = vmalloc(len)) == NULL)
1455                    return ERR_PTR(-ENOMEM);
1456            if (copy_from_user(hdr, umod, len) != 0) {
1457                    err = -EFAULT;

*do_munmap+0x10e:
0xc0142007 is in do_munmap (mm/mmap.c:1753).
1748            spin_unlock(&mm->page_table_lock);
1749
1750            /* Fix up all other VM information */
1751            unmap_vma_list(mm, mpnt);
1752
1753            return 0;

*sys_init_module+0x4d: inlined

*sysenter_past_esp+0x52:
0xc0104b31 is at arch/i386/kernel/entry.S:243.
238             testb 
$(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
239             jnz syscall_trace_entry
240             cmpl $(nr_syscalls), %eax
241             jae syscall_badsys
242             call *sys_call_table(,%eax,4)
243             movl %eax,EAX(%esp)


Con

--------------enig167006BD1BE457BF1601A081
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBi1xyZUg7+tp6mRURAqvlAJ9ZWEn5Ap19xvTnIif3DZEyjQsjWwCeL2C0
OOt4zWPgIcz1VoVw3c3d9a4=
=dFqw
-----END PGP SIGNATURE-----

--------------enig167006BD1BE457BF1601A081--
