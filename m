Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbUKPLB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbUKPLB7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 06:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbUKPLB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 06:01:59 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:18048 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S261948AbUKPLAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 06:00:15 -0500
Date: Tue, 16 Nov 2004 12:00:12 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: x86_64: Asynchronous IPI broken
Message-ID: <20041116110012.GA18824@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,
  can you revert change below and/or make it safe?

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/11/02 15:04:23-08:00 ak@suse.de 
#   [PATCH] x86_64: Don't wait on panic
#   
#   Don't wait for a response from other CPUs on panic
#   
#   Signed-off-by: Andi Kleen <ak@suse.de>
#   Signed-off-by: Andrew Morton <akpm@osdl.org>
#   Signed-off-by: Linus Torvalds <torvalds@osdl.org>
# 
# arch/x86_64/kernel/smp.c
#   2004/11/02 06:40:36-08:00 ak@suse.de +6 -5
#   x86_64: Don't wait on panic
# 

After this change asynchronous IPIs are unusable, as 'data' is local
variable for __smp_call_function, but __smp_call_function does not
wait anymore for other processor(s) to fetch this data.

Due to this smp_call_function_interrupt in better case just modifies
random memory in atomic_inc(&call_data->started), in worse case (as
happened to me) 'data' on stack is overwritten with other data and
bogus function is called, triggering some fault in IPI interrupt and
killing whole system.

If you cannot guarantee that other processor will accept IPI,
I'm afraid that you'll have to create much more complicated change
than simple change you did in the change above.

Due to this change you cannot run VMware on these kernels, as sooner
or later kernel will die as vmmon is big source of async IPIs.

It would be nice if you could insmod attached 'rhtest' module to check
your eventual fix (it was originally written to prove that RHAS2.1 
kernels are broken when it comes to async IPI, but it works nice for 
this case too).  It should print:

Test done. ASYNC was ASYNC, SYNC was SYNC, nesting did not happen.
Test passed.

and not:

Test done. ASYNC was ASYNC, SYNC was SYNC, nesting occured.
Test failed.
ASYNC IPI was completely lost!

					Thanks,
						Petr Vandrovec

[pasted from serial console]
...
CPU 1
Modules linked in: vmnet vmmon ide_disk sg floppy sr_mod ipx p8022 psnap llc esp6 ah6 ipcomp esp4 ah4 xfrm_user wp512 tea sha512 michael_mic md4 khazad cast6 c...
Pid: 27622, comm: vmware-vmx Tainted: P      2.6.10-rc1-c2606
RIP: 0010:[<000001007c509eb8>] [<000001007c509eb8>]                    <<<< bogus call_data->func overwritten with some data pointer
RSP: 0000:000001007ff93fa0  EFLAGS: 00011006
RAX: 000001001bf5ffd8 RBX: 000000008026a796 RCX: 0000000000000000
RDX: 000001007c509eb8 RSI: 00000000000000fa RDI: 0000000000000000
RBP: 000001001bf5f938 R08: 0000000000000010 R09: 000000005991b9f8
R10: 000001001bf5e000 R11: 0000000000000000 R12: 0000010033595368
R13: 0000002a95dc6090 R14: ffffffff8056bd00 R15: 00000000000006e0
FS:  0000002a95dc6090(0000) GS:ffffffff8056bd00(005b) knlGS:000000005991bbb0
CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
CR2: 000001007c509eb8 CR3: 000000003ff96000 CR4: 00000000000006e0
Process vmware-vmx (pid: 27622, threadinfo 000001001bf5e000, task 000001006fd71030)
Stack: ffffffff8011a790 ffffff0001565000 ffffffff8010f5cd 000001001bf5f938  <EOI>
       00000000000006e0 ffffffff8056bd00 0000002a95dc6090 0000010033595368
       ffffff00015655b8 ffffff0001565000
Call Trace:<IRQ> <ffffffff8011a790>{smp_call_function_interrupt+64}
       <ffffffff8010f5cd>{call_function_interrupt+133}  <EOI> <ffffffffa0345dd7>{:vmmon:Task_Switch+2695}
       <ffffffffa034566b>{:vmmon:Task_Switch+795} <ffffffffa0347ed2>{:vmmon:Vmx86_RunVM+82}
       <ffffffffa03400d3>{:vmmon:LinuxDriver_Ioctl+403} 
       <ffffffffa033f079>{:vmmon:LinuxDriver_Ioctl32_Handler+89}
       <ffffffff801a497d>{compat_sys_ioctl+189} <ffffffff8012a2ab>{sys32_sigreturn+219}
       <ffffffff80122a81>{ia32_sysret+0}

Code: 00 00 00 00 00 00 00 00 d0 87 b0 7e 00 01 00 00 30 2a 13 80

--CE+1k2dSO48ffgeK
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="rhtest.tar.gz"
Content-Transfer-Encoding: base64

H4sIANnbmUEAA+1XbVPjNhDma/wrFu64Bpo4Ti6BgRxt74UPtBxzQ8rc3ExnfMaWE4EsuZJM
ynT4713JznsCYVroXOsdHGNptbva59m1LAeaKN3YeErxPK+13+mYuxF7b7bbo2c71sSRvded
zn4T55utTsvbgM6TRlVIpnQgATakEPp+PSLVPfPTmzP3b0Rkjv/H4JrElJEn8WHysTfBewH/
9n5ngr/XRPzbzb32BjxLEv/n+L+AEfQQCwl6QOCU8uwPuKERERBJeoP7dp0X0IG3WR+aBwcH
Nfg5SIiCHk0SwVUN3iQBZVocXql85CcS9UmficuAuaFIfsDV52QoqdaEgxaAuQRGlVZAudIk
iEDEQOM6QqFJQrhGh05E4iBj+tCpJBgh1N9Dg9HLRiKijBHV+JpxDALq8mvjMqMsgt7Fuw8n
572jly8/ff4AhZrjiMuregLfH0HOdFc4TshIwNGuTHB5DKGQBHZdgVeAl8Lr2jygCTcEt1i3
64ZJBK5OUt9khOI2nX8bvH9AivovNhk+iY8H6r/Tab8e1/9eq23qv+XtlfX/HPKC8pBlEYE3
zJR9IxQ8pn13gDU7N5NX1LIZFQ5ItGyCSMnFsgnKqV42HhEW3C51kaRm2DEdgobYNjRgz+F+
KkVIlBKyOz2lWHBDfMNoEnXHi24Ewzs2OqMiMukH6paHfkL0QES+oQGqwxF43fVWxLgLNXho
yaN9PM5FHpE17Nv26Q8HhOdGtKT9PpEPL8/dPLR+YoBGC9momtFdSLXcgT+dSmMXzoTGRu+6
Luw2nAqNoYogTgDzaVTdgc2jGbDs2ookOpO861TurKGPgbyGIYEieyOL9yDY7NqFnwNkWaGd
WWpVW563052xGmDzjwQnK81OYYB27xbT8AxZWBflVTnpjkysgfTKBHQfQuNpwFgHC0NlJoIo
IRYBm8CMK9rnqMsE78MVjW1I6G/C+2Gg8q0WowuD5uwx3WXQ7yJ8Vg83cRKPtjDR92ogM25y
CiefTsDgq0DwKY1mzakAgMCTlxxSPBgZfXxIZtW8CYHmQ8LizBkzzaEi8XdAGNpcMuvlzDIG
N8M08wXHTkuqMzzMzaYSc3Nd/eX4/Mw/Pj+HrZ6Q8rY2Fdx2BlQBR6rnVtzf+FZtltLdMaOh
fvzuovdlufvZvf3NAOaMrQih4KY9/iJLYkrMsTSU9iAKdcT0O8ZgIFKCsAQaveRggcUNI8O3
XJYirEOKeiIMEevfMxpes1sIYpwFTRP8HWtaIEd8RCQKpxjNcGD6cnUyN57cAZw21AsDxvw4
46HGE2h1vlZrcHZxeloztLOlNUdzdLawZKqmjvJFy90s8dLEP7tgqZN7fTiLoP6KRMmLH972
vpy9B7QI2/h1MfPAUYtiPW8rizFCurDJH2HLGtiCQ6SK+ceqrae1ZpvE1RG2f8O4QZCmhFsz
FnwSbZkdGmYvpB+LEl69ssSBxTlvPLdus0Z7K0rEZjMNlMIWjYname0Fy9Vj/IqbUp8tDWxf
yny75UFNv9BWvXTyyApOb67kXa5WsYdIPGDafmqc3xduThDTUQ0v8BMzZUQTLDgmlN6cbGAU
3lrRPSo4Z76V4MsoPyH75nBbzd9GqA7/ha/EUkoppZRSSimllFJKKaWUUkoppZRSSinlW5S/
ALJzNM0AKAAA

--CE+1k2dSO48ffgeK--
