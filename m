Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314702AbSE2SfR>; Wed, 29 May 2002 14:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314748AbSE2SfQ>; Wed, 29 May 2002 14:35:16 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:38406 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S314702AbSE2SfP>; Wed, 29 May 2002 14:35:15 -0400
Date: Wed, 29 May 2002 14:34:21 -0400 (EDT)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: linux-kernel@vger.kernel.org, Paul.Clements@steeleye.com
cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [RESEND] [OOPS & PATCH 2.4.18] NULL pointer dereference in ide.c,
 ide_revalidate_disk()
In-Reply-To: <Pine.LNX.4.10.10205081106060.31335-200000@clements.sc.steeleye.com>
Message-ID: <Pine.LNX.4.10.10205291357080.28649-200000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="296485894-999928714-1022697261=:28649"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--296485894-999928714-1022697261=:28649
Content-Type: TEXT/PLAIN; charset=US-ASCII


Resending this patch. Looks like it did not make 2.4.19-pre9. Is there some problem in the patch 
or in my analysis, or has the problem been fixed in some other (better) way?

Thanks,
Paul


On Wed, 8 May 2002, Paul Clements wrote:

> 
> Looking back at LKML archives, I think this issue was reported by someone back in
> November 01, and I just saw the same issue on a system a few days ago. I think I
> have tracked down the cause of the oops. I looked to see if it had been fixed in
> 2.4.19-pre8 and it had not, so I have attached a patch against 2.4.18. Please apply.
> 
> The kernel oops was this:
> 
> ----
> 
> May  3 23:20:07 liono kernel: hda: ATAPI 32X CD-ROM drive, 256kB Cache, UDMA(33)
> May  3 23:20:07 liono kernel: Uniform CD-ROM driver Revision: 3.12
> May  3 23:20:07 liono kernel: hda: ide_cdrom_setup failed to register device with the cdrom driver.
> May  3 23:20:07 liono kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000028
> May  3 23:20:07 liono kernel:  printing eip:
> May  3 23:20:07 liono kernel: c019b54a
> May  3 23:20:07 liono kernel: *pde = 00000000
> May  3 23:20:07 liono kernel: Oops: 0000
> May  3 23:20:07 liono kernel: CPU:    0
> May  3 23:20:07 liono kernel: EIP:    0010:[ide_revalidate_disk+250/304]    Not tainted
> May  3 23:20:07 liono kernel: EIP:    0010:[<c019b54a>]    Not tainted
> May  3 23:20:07 liono kernel: EFLAGS: 00010212
> May  3 23:20:07 liono kernel: EIP is at ide_revalidate_disk [kernel] 0xfa
> May  3 23:20:07 liono kernel: eax: 00000000   ebx: 00000300   ecx: 00000000   edx: 00000000
> May  3 23:20:07 liono kernel: esi: c03bdba0   edi: 00001100   ebp: 00000040   esp: c90e3ee0
> May  3 23:20:07 liono kernel: ds: 0018   es: 0018   ss: 0018
> May  3 23:20:07 liono kernel: Process modprobe (pid: 2028, stackpage=c90e3000)
> May  3 23:20:07 liono kernel: Stack: 00000300 00000000 00000000 00000000 00000000 c03bde7c c019b5d2 00000300
> May  3 23:20:07 liono kernel:        cd3ce200 00000000 cd3ce348 00000002 c019dba5 d0972aa7 d09759e0 d096f000
> May  3 23:20:07 liono kernel:        00000001 00000001 00000001 c011c685 d09758dc c903e000 000067d8 c91cd000
> May  3 23:20:07 liono kernel: Call Trace: [revalidate_drives+82/112] revalidate_drives [kernel] 0x52
> May  3 23:20:07 liono kernel: Call Trace: [<c019b5d2>] revalidate_drives [kernel] 0x52
> May  3 23:20:07 liono kernel: [ide_register_module+53/64] ide_register_module [kernel] 0x35
> May  3 23:20:07 liono kernel: [<c019dba5>] ide_register_module [kernel] 0x35
> May  3 23:20:07 liono kernel: [aic7xxx_mod:aic7xxx_verbose+1171231/206116241] ide_cdrom_init [ide-cd] 0x187
> May  3 23:20:07 liono kernel: [<d0972aa7>] ide_cdrom_init [ide-cd] 0x187
> May  3 23:20:07 liono kernel: [aic7xxx_mod:aic7xxx_verbose+1183320/206104152] __insmod_ide-cd_S.data_L192 [ide-cd] 0xa0
> May  3 23:20:07 liono kernel: [<d09759e0>] __insmod_ide-cd_S.data_L192 [ide-cd] 0xa0
> May  3 23:20:07 liono kernel: [sys_init_module+1365/1616] sys_init_module [kernel] 0x555
> May  3 23:20:07 liono kernel: [<c011c685>] sys_init_module [kernel] 0x555
> May  3 23:20:07 liono kernel: [aic7xxx_mod:aic7xxx_verbose+1183060/206104412] sense_data_texts [ide-cd] 0x107c
> May  3 23:20:07 liono kernel: [<d09758dc>] sense_data_texts [ide-cd] 0x107c
> May  3 23:20:07 liono kernel: [aic7xxx_mod:aic7xxx_verbose+1156312/206131160] __insmod_ide-cd_O/lib/modules/2.4.9-21smp/kernel/drivers/ide/ide-cd.o_M3C472201_V132105 [ide-cd] 0x60
> May  3 23:20:07 liono kernel: [<d096f060>] __insmod_ide-cd_O/lib/modules/2.4.9-21smp/kernel/drivers/ide/ide-cd.o_M3C472201_V132105 [ide-cd] 0x60
> May  3 23:20:07 liono kernel: [system_call+51/56] system_call [kernel] 0x33
> May  3 23:20:07 liono kernel: [<c010719b>] system_call [kernel] 0x33
> May  3 23:20:07 liono kernel: [__put_unused_buffer_head+107/416] __put_unused_buffer_head [kernel] 0x6b
> May  3 23:20:07 liono kernel: [<c014002b>] __put_unused_buffer_head [kernel] 0x6b
> May  3 23:20:07 liono kernel:
> May  3 23:20:07 liono kernel:
> May  3 23:20:07 liono kernel: Code: 8b 40 28 85 c0 74 04 56 ff d0 5a 80 a6 b6 00 00 00 fb 8d 86
> 
> ----
> 
> So what this tells me is that (probably) a NULL pointer was dereferenced while looking for a structure 
> member with an offset of 40 (0x28) bytes. Looking through the ide_revalidate_disk function (ide.c) I find
> that the only structure member being referenced, which also has an offset of 40 is drive->driver->revalidate 
> (via the DRIVER macro):
> 
>     if (DRIVER(drive)->revalidate)
> 
> But there is no check for driver != NULL before it is dereferenced. In many other places throughout ide.c 
> these explicit checks are present.
> 
> The attached patch (against 2.4.18) adds this explicit check.
> 
> --
> Paul Clements
> SteelEye Technology
> Paul.Clements@SteelEye.com
> 

--296485894-999928714-1022697261=:28649
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ide_driver_null_2_4_18.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10205291434210.28649@clements.sc.steeleye.com>
Content-Description: 
Content-Disposition: attachment; filename="ide_driver_null_2_4_18.diff"

LS0tIGxpbnV4LTIuNC4xOC5QUklTVElORS9kcml2ZXJzL2lkZS9pZGUuYwlN
b24gQXByIDI5IDEwOjQ0OjEyIDIwMDINCisrKyBsaW51eC0yLjQuMTguYWx0
L2RyaXZlcnMvaWRlL2lkZS5jCVR1ZSBNYXkgIDcgMTc6MTY6NTMgMjAwMg0K
QEAgLTE4OTIsNyArMTg5Miw3IEBADQogCQlkcml2ZS0+cGFydFtwXS5ucl9z
ZWN0cyAgID0gMDsNCiAJfTsNCiANCi0JaWYgKERSSVZFUihkcml2ZSktPnJl
dmFsaWRhdGUpDQorCWlmIChEUklWRVIoZHJpdmUpICYmIERSSVZFUihkcml2
ZSktPnJldmFsaWRhdGUpDQogCQlEUklWRVIoZHJpdmUpLT5yZXZhbGlkYXRl
KGRyaXZlKTsNCiANCiAJZHJpdmUtPmJ1c3kgPSAwOw0K
--296485894-999928714-1022697261=:28649--
