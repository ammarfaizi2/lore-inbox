Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131968AbQKVXn2>; Wed, 22 Nov 2000 18:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131724AbQKVXnS>; Wed, 22 Nov 2000 18:43:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55049 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S131968AbQKVXnL>;
        Wed, 22 Nov 2000 18:43:11 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011222312.eAMNCQ613184@flint.arm.linux.org.uk>
Subject: Modutils 2.3.14 / Kernel 2.4.0-test11 incompatibility
To: linux-kernel@vger.kernel.org
Date: Wed, 22 Nov 2000 23:12:25 +0000 (GMT)
Cc: kaos@ocs.com.au
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There appears to be an incompatibility between modutils 2.3.14 and kernel
2.4.0-test11.

This occurs because modutils knows only of an 84-byte struct module, but
the kernel knows about a 96-byte struct module.

Unfortunately, the kernel "forgets" about the 12 bytes, which are part of
the loading module text because in sys_init_module():

        if ((error = get_user(mod_user_size, &mod_user->size_of_struct)) != 0)
                goto err1;
/* mod_user_size == 84 */
	/* ... */
        error = copy_from_user(mod, mod_user, mod_user_size);
/* we copy byte 0 to byte 83 of struct module */
	/* ... */
        if (copy_from_user(mod+1, mod_user+1, mod->size-sizeof(*mod))) {
/* we copy byte 96 to <end of module> */

And guess what?  We missed bytes 84 to 95!  Oh dear, the result is one
of these:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c1e90000
*pgd = 01e94001, *pmd = 01e94001, *pte = 0000308b, *ppte = 0000300a
Internal error: Oops: 0
CPU: 0
pc : [<c280007c>]    lr : [<c00251f8>]
sp : c1e97f08  ip : c1e97ec0  fp : c1e97f14
r10: c1e96000  r9 : 00000004  r8 : ffffffea
r7 : 02029220  r6 : c1e37000  r5 : c2800000  r4 : 00000000
r3 : ef9f0000  r2 : 00000000  r1 : 00000000  r0 : 000001db
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment user
Control: 1E9117D  Table: 01E9117D  DAC: 00000015
Process insmod (pid: 9, stackpage=c1e97000)
Stack:
c1e97ee0:                                                        c00251f8 c280007c
c1e97f00: 60000013 ffffffff c1e97fac c1e97f18  c0026194 c280006c c1e37000 c1e38000
c1e97f20: c01f3680 00000060 c011d48c c2800060  00005e00 00000000 00000000 00000000
c1e97f40: 00000000 00000000 00000000 00000000  00000000 00000000 00000000 00000000
c1e97f60: 00000000 00000000 00000000 00000000  00000000 00000000 00000000 00000000
c1e97f80: 00000000 bfffec64 02021928 60000010  c2800000 c00169e4 00000080 0201bbe8
c1e97fa0: 00000000 c1e97fb0 c0016860 c0025acc  bfffec64 c001bb54 0201bbe8 02029220
c1e97fc0: 00000000 00000038 bfffec64 02021928  02019f10 c2800000 00005e00 0201bbe8
c1e97fe0: 0201bbe8 bffffe60 400e4c90 bfffec28  020031e8 400e4c9c 60000010 0201bbe8
Backtrace:
Function entered at [<c2800060>] from [<c0026194>]
Function entered at [<c0025ac0>] from [<c0016860>]
Code: e51f2024 e5923000 (e5813000) e3a00000 e51f3030

because both r2 and r1 are loaded from the first two words of module text
which forgot to be copied.  Therefore, please reverse the following change
in 2.4.0-test11 because it is NOT a security problem but a much needed
subtlety:


-       error = copy_from_user(mod, mod_user, sizeof(struct module));
+       error = copy_from_user(mod, mod_user, mod_user_size);
        if (error) {

Better still, place a comment before it describing why it is so!
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
