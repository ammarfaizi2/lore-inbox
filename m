Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264688AbTANR7G>; Tue, 14 Jan 2003 12:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264867AbTANR7G>; Tue, 14 Jan 2003 12:59:06 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:52096 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S264688AbTANR7E>; Tue, 14 Jan 2003 12:59:04 -0500
Message-Id: <200301141807.h0EI7srO012993@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: ivangurdiev@attbi.com
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.58 Oops when booting from initrd - kobject_del 
In-Reply-To: Your message of "Tue, 14 Jan 2003 02:47:40 MST."
             <200301140247.40861.ivangurdiev@attbi.com> 
From: Valdis.Kletnieks@vt.edu
References: <200301140247.40861.ivangurdiev@attbi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-773281870P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Jan 2003 13:07:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-773281870P
Content-Type: text/plain; charset=us-ascii

On Tue, 14 Jan 2003 02:47:40 MST, "Ivan G." <ivangurdiev@attbi.com>  said:
> Kernel: 2.5.58 (everything but the tag changeset)
> 
> My attempt to boot an initrd resulted in the following oops:
> (scribbled down important parts)
> =======================================================
> unable to handle kernel NULL pointer at virtual address 00000064

> Call Trace:
> ==========
> kobject_del+0x13/0x30
> kobject_unregister+0x13/0x30
> elv_unregister_queue+0x1c/0x30
> unlink_gendisk+0x13/0x40
> del_gendisk+0x80/0x140
> initrd_release+0x4e/0x90
> __fput+0xf1/0x100
> filp_close+0x74/0xa0
> sys_close+0x62/0xa0
> syscall_call+0x7/0xb
> prepare_namespace+0x13a/0x1b0
> init+0x3a/0x160
> init+0x0/0x160
> kernel_thread_helper+0x5/0x18
> ...
> Code: 8b 70 28 85 f6 0f 84 1e 01 00 00 8b 06 85 c0 75 08 0f 0b 02

I got bit by this one too.  Just for grins, I did a 'make clean' and then
rebuilt - same compiler and config - and the bzImage ended up one byte shorter.

A diff of the System.map files is interesting:

 diff -c  /boot/System.map-2.5.58 System.map
*** /boot/System.map-2.5.58     2003-01-14 01:47:27.000000000 -0500
--- System.map  2003-01-14 12:57:30.000000000 -0500
***************
*** 1,5 ****
  0000002a A snd_minor_info_done
! 00000080 A _binary_usr_initramfs_data_cpio_gz_size
  000000dd A snd_card_info_done
  000000fc A snd_memory_info_done
  0000011b A snd_info_done
--- 1,5 ----
  0000002a A snd_minor_info_done
! 0000007f A _binary_usr_initramfs_data_cpio_gz_size
  000000dd A snd_card_info_done
  000000fc A snd_memory_info_done
  0000011b A snd_info_done
***************
*** 21863,21872 ****
  c044d940 A __initcall_end
  c044e000 A __initramfs_start
  c044e000 T _binary_usr_initramfs_data_cpio_gz_start
! c044e080 A __initramfs_end
  c044e080 A __per_cpu_end
  c044e080 A __per_cpu_start
- c044e080 T _binary_usr_initramfs_data_cpio_gz_end
  c044f000 A __bss_start
  c044f000 A __init_end
  c044f000 B rows
--- 21863,21872 ----
  c044d940 A __initcall_end
  c044e000 A __initramfs_start
  c044e000 T _binary_usr_initramfs_data_cpio_gz_start
! c044e07f A __initramfs_end
! c044e07f T _binary_usr_initramfs_data_cpio_gz_end
  c044e080 A __per_cpu_end
  c044e080 A __per_cpu_start
  c044f000 A __bss_start
  c044f000 A __init_end
  c044f000 B rows

After a 'make clean', the size dropped from 0x80 to 0x7f - this cleaned
up the one-byte overlap between per_cpu_start and cpio_gz_end, which looks
suspicious to me.  I'll try booting the new kernel when I get a chance.
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-773281870P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+JFH6cC3lWbTT17ARAiZlAKChYP7Rikw1iyLGFhAFCZVL2/U80QCfSqLj
13rBwauUkX0DCIScLh2jl68=
=qiEt
-----END PGP SIGNATURE-----

--==_Exmh_-773281870P--
