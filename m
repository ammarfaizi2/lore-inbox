Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbWFAUhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWFAUhm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 16:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWFAUhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 16:37:42 -0400
Received: from mail.gmx.de ([213.165.64.20]:13486 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030258AbWFAUhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 16:37:41 -0400
X-Flags: 0001
Message-ID: <20060601203740.168720@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMX168721149194260329962"
Date: Thu, 01 Jun 2006 22:37:40 +0200
from: Gerhard Pircher <gerhard_pircher@gmx.net>
subject: BUG/OOPS in rmap.c with ppc/kernel/dma-mapping.c compiled in
 (page_add_file_rmap() in mm/rmap.c:387).
to: linux-kernel@vger.kernel.org
X-Authenticated: #6097454
X-GMX-UID: bjYaNIAgZCEESEBwOGwhVBV4IGhpZcbE
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
x-priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--========GMX168721149194260329962
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

I have an AmigaOne, which is a PowerPC desktop computer with a G4 CPU, a custom PPC northbridge (ArticiaS) and a VIA82C686 southbridge. The northbridge doesn't support cache coherency properly, therefore I had to compile in support for not cache coherent DMA (arch/ppc/kernel/dma-mapping.c - NOT_COHERENT_CACHE config option).
Unfortunately the system now outputs a kernel oops whenever I try to view a movie for example in totem or VLC. The following log snipped (2.6.8 Debian sarge kernel) is the only debug information I could extract, because most of the time the system hard locks and can only be reactivated with a hardware reset.

May 12 00:04:17 localhost kernel: kernel BUG in page_add_file_rmap at
mm/rmap.c:387!
May 12 00:04:17 localhost kernel: Oops: Exception in kernel mode, sig: 5
[#1]
May 12 00:04:17 localhost kernel: NIP: C004968C LR: C0044CB8 SP: D2C77E20
REGS: d2c77d70 TRAP: 0700    Not tainted
May 12 00:04:17 localhost kernel: MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1
IR/DR: 11
May 12 00:04:17 localhost kernel: TASK = d4918000[2900] 'totem' THREAD:
d2c76000Last syscall: 246
May 12 00:04:17 localhost kernel: GPR00: 00000001 D2C77E20 D4918000 C0D02720
00000000 D27B02A0 02000000 D4FE4400
May 12 00:04:17 localhost kernel: GPR08: C03D0000 38139785 00000000 38139785
24048444 10054698 00000000 10171158
May 12 00:04:17 localhost kernel: GPR16: 00000000 00000000 0EADDD7C 00015F90
000001F6 315B1970 33CA8000 D4D6BBA0
May 12 00:04:17 localhost kernel: GPR24: 00000000 00000000 02000000 D4B7D33C
33CA8000 C0D02720 38139785 D2888220
May 12 00:04:17 localhost kernel: NIP [c004968c] page_add_file_rmap+0x8/0x78
May 12 00:04:17 localhost kernel: LR [c0044cb8] do_no_page+0x1cc/0x37c
May 12 00:04:17 localhost kernel: Call trace:
May 12 00:04:17 localhost kernel:  [c004503c] handle_mm_fault+0xf4/0x174
May 12 00:04:17 localhost kernel:  [c0012100] do_page_fault+0x140/0x398
May 12 00:04:17 localhost kernel:  [c0008178] handle_page_fault+0xc/0x80

I tested this with kernel 2.6.8 and 2.6.14.2 (source form www.kernel.org). Both show the same behavior (well, the source code line is different for kernel 2.6.14.2, but the oops occurs in the same function). I applied Hugh Dickins's debug patch (http://lkml.org/lkml/2005/11/27/33) to the 2.6.14.2 kernel and the kernel outputs hundreds of thousands "Bad rmap" mappings, so that it would take to long to fully boot the system.

Kernel 2.6.16.16 seems to have this problem too, but the problem is triggered in another function, as it can be seen in the log snipped below:

May 31 23:23:57 localhost kernel: [  414.038867] Oops: kernel access of bad area, sig: 11 [#1]
May 31 23:23:57 localhost kernel: [  414.038894] NIP: E22690A8 LR: E2269064 CTR: E2268FF0
May 31 23:23:57 localhost kernel: [  414.038904] REGS: d0677d40 TRAP: 0600   Not tainted  (2.6.16.16-a1-1)
May 31 23:23:57 localhost kernel: [  414.038909] MSR: 00009032 <EE,ME,IR,DR>  CR: 44048444  XER: 00000000
May 31 23:23:57 localhost kernel: [  414.038922] DAR: 99A9999D, DSISR: 00000160
May 31 23:23:57 localhost kernel: [  414.038927] TASK = d09053a0[4296] 'totem' THREAD: d0676000
May 31 23:23:57 localhost kernel: [  414.038932] GPR00: 99A9999D D0677DF0 D09053A0 C0C826A0 00000000 D0677E18 D0063000 D1B41C00
May 31 23:23:57 localhost kernel: [  414.038946] GPR08: FFFFFFFF 99A99999 DF964860 00004000 84048444 10054698 00000000 10196A58
May 31 23:23:57 localhost kernel: [  414.038959] GPR16: 00000000 00000000 0EADDD7C 00015F90 02000000 D1A41328 00000000 DC250958
May 31 23:23:57 localhost kernel: [  414.038972] GPR24: DF4026A0 00000000 329FE000 D021A6A4 329FE000 D00637F8 00000328 D0677E18
May 31 23:23:57 localhost kernel: [  414.038986] NIP [E22690A8] snd_pcm_mmap_data_nopage+0xb8/0xf4 [snd_pcm]
May 31 23:23:57 localhost kernel: [  414.039073] LR [E2269064] snd_pcm_mmap_data_nopage+0x74/0xf4 [snd_pcm]
May 31 23:23:57 localhost kernel: [  414.039096] Call Trace:
May 31 23:23:57 localhost kernel: [  414.039101] [D0677DF0] [C000FCB8] update_mmu_cache+0xdc/0xf0 (unreliable)
May 31 23:23:57 localhost kernel: [  414.039130] [D0677E10] [C004A10C] do_no_page+0xec/0x6a4
May 31 23:23:57 localhost kernel: [  414.039151] [D0677E60] [C004A99C] __handle_mm_fault+0x1bc/0x31c
May 31 23:23:57 localhost kernel: [  414.039160] [D0677E90] [C000F3EC] do_page_fault+0x16c/0x378
May 31 23:23:57 localhost kernel: [  414.039169] [D0677F40] [C0004AA0] handle_page_fault+0xc/0x80
May 31 23:23:57 localhost kernel: [  414.039184] Instruction dump:
May 31 23:23:57 localhost kernel: [  414.039189] 3d60c031 800b6354 7d292214 3d294000 5529c9f4 7c604a14 80030000 7c691b78
May 31 23:23:57 localhost kernel: [  414.039202] 700b4000 41a20008 8123000c 38090004 <7d600028> 316b0001 7d60012d 40a2fff4

Is it possible that the not cache coherent DMA implementation in dma-mapping.c is incompatible with the reverse memory mapping or is there a bug in rmap.c? (as already noted: the oops occurs only, when dma-mapping.c is compiled in).

Thanks in advance!

regards,

Gerhard

BTW: please put me on CC, because I'm not subscribed to this mailing list.


-- 


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
      Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
    

--========GMX168721149194260329962
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
--========GMX168721149194260329962--
