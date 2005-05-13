Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbVEMPtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbVEMPtu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 11:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbVEMPtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 11:49:50 -0400
Received: from agmk.net ([217.73.17.121]:58128 "EHLO mail.agmk.net")
	by vger.kernel.org with ESMTP id S262403AbVEMPt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 11:49:29 -0400
From: Pawel Sikora <pluto@agmk.net>
To: linux-kernel@vger.kernel.org
Subject: [2.6.8] OOPS and SIGSEGV on altivec instruction on PowerPC 7540.
Date: Fri, 13 May 2005 17:49:20 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AyMhC/oE5KK0LrJ"
Message-Id: <200505131749.20752.pluto@agmk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_AyMhC/oE5KK0LrJ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

simple runtime altivec detection from userspace causes an oops
on the `vand` instruction. kernel was built *without* CONFIG_ALTIVEC.
i think kernel should return a SIGILL instead of an oops ;-)

Oops: kernel access of bad area, sig: 11 [#65]
NIP: C0008B84 LR: C0007F2C SP: CF373F20 REGS: cf373e70 TRAP: 0300 Not taint=
ed
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000088, DSISR: 40000000
TASK =3D c81e04f0[12983] 'altivec' THREAD: cf372000Last syscall: 174
GPR00: C0007F2C CF373F20 C81E04F0 00000004 00000004 00030001 00000000 0FEE0=
8D0
GPR08: 0000F932 C0007F2C 00009032 C0350000 081E0788 00000000 00000000 100A3=
7D8
GPR16: 100A0000 00000000 100A0000 00000000 10070000 100A37C8 100AEF08 00000=
000
GPR24: 100A1108 00000000 100A59A8 3002AEF8 3002BB80 3002AE60 0FFEA6FC 00000=
004
Call trace: [c0007f2c]


processor =C2=A0 =C2=A0 =C2=A0 : 0
cpu =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 7450
clock =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 700MHz
revision =C2=A0 =C2=A0 =C2=A0 =C2=A0: 2.1 (pvr 8000 0201)
bogomips =C2=A0 =C2=A0 =C2=A0 =C2=A0: 696.32
machine =C2=A0 =C2=A0 =C2=A0 =C2=A0 : PowerMac4,4
motherboard =C2=A0 =C2=A0 : PowerMac4,4 MacRISC2 MacRISC Power Macintosh
detected as =C2=A0 =C2=A0 : 80 (eMac)
pmac flags =C2=A0 =C2=A0 =C2=A0: 00000001
L2 cache =C2=A0 =C2=A0 =C2=A0 =C2=A0: 256K unified
memory =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 384MB
pmac-generation : NewWorld

=2D-=20
The only thing necessary for the triumph of evil
  is for good men to do nothing.
                                           - Edmund Burke

--Boundary-00=_AyMhC/oE5KK0LrJ
Content-Type: text/x-csrc;
  charset="utf-8";
  name="altivec.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="altivec.c"

#include <setjmp.h>
#include <signal.h>

static sigjmp_buf jmpbuf;
static volatile sig_atomic_t canjump = 0;

void sigill_handler(int sig)
{
        if (!canjump)
        {
                signal(sig, SIG_DFL);
                raise(sig);
        }
        canjump = 0;
        siglongjmp(jmpbuf, 1);
}

int arch_accel()
{
        signal(SIGILL, sigill_handler);
        if (sigsetjmp(jmpbuf, 1))
        {
                signal(SIGILL, SIG_DFL);
                return 0;
        }
        canjump = 1;
        asm volatile
        (
                "mtspr 256, %0          \n\t"
                "vand %%v0, %%v0, %%v0  \n\t"
                :
                : "r" (-1)
        );
        signal(SIGILL, SIG_DFL);
        return 1;
}

int main(int argc, char** argv)
{
        return arch_accel();
}

--Boundary-00=_AyMhC/oE5KK0LrJ--
