Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVC1O6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVC1O6M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 09:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVC1O6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 09:58:12 -0500
Received: from host-216-252-217-242.interpacket.net ([216.252.217.242]:32985
	"EHLO forof.hylink.am") by vger.kernel.org with ESMTP
	id S261840AbVC1O6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 09:58:02 -0500
Message-ID: <00ae01c533a6$85ddf1f0$1000000a@araavanesyan>
From: "Ara Avanesyan" <araav@hylink.am>
To: <linux-kernel@vger.kernel.org>, <avila@lists.unixstudios.net>
References: <006b01c5047e$1efc78a0$1000000a@araavanesyan> <20050127144441.GB4848@home.fluff.org>
Subject: Strange memory problem with Linux booted from U-Boot
Date: Mon, 28 Mar 2005 19:57:52 +0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.0
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I need some help on solving this strange problem.
Here is what I have,
I have a loadable module (linux.2.4.20) which contains a 2 mb static gloabal
array.
When I load it from linux booted via U-Boot the system crashes.
Everything works ok if I do the same thing with the same linux booted with
RedBoot.
Before loading the module I check the current meminfo and get the same
result both times.

Additional information:
The same error occurs if I just run depmod -a.

system: Avila board 64 MB RAM, ixdp425 architecture, U-Boot: 1.1.2.
Linux is MontaVista(R) Linux(R) Professional Edition 3.1.

Ok, now an amazing reproduction of the same problem from user mode:
the code below works for val = (~0), but not for 0, or even (~ff).
Again, it works fine for linux booted from RedBoot.

Some glue or something where and what to look?
Any ideas of what potentially could cause this problem?

Please CC me on reply.

Thanks!
Ara

Several days ago I posted this question to U-boot mailing list but got not
much help there:)

____
error message:
Unable to handle kernel paging request at virtual address e59f30f8
mm = c000a320 pgd = c3e60000
*pgd = 00000000, *pmd = 00000000
Internal error: Oops: 0
CPU: 0
pc 2 [<c0054f64>]    lr : [<00000000>]    Tainted: GF
sp : c3e45e94  ip : c3e45eb4  fp : c3e45eb0
r10: 00000000  r9 : c3e45f04  r8 : 00000004
r7 : 00000004  r6 : c016a000  r5 : c3e44000  r4 : e59f3054
r3 : e91ba870  r2 : c019cc70  r1 : 00000000  r0 : 00000000
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32 Control: 39FF  Table: 03E60000
DAC: 00000015
Process klogd (pid: 89, stack limit = 0xc3e443a0)
Stack: (0xc3e45e94 to 0xc3e46000)

___
Now the (user level) code:

#include <iostream>

using namespace std;

const int pass = 64;
const int size = 2 * 1024 * 1024;
const int val = 0xffffff00;
int main()
{
    cout << "starting val == " << hex << val << endl;
    char *buf = new char[size];
    cout << "allocated memory of " << size << " bytes. buf == " << (int)buf
<< endl;

    for (int j = 0; j < pass; j++)
    {
        cout << "passing " << j << endl;
        for (int i = 0; i < size; i++)
        {
            buf[i] = val;
        }
        cout << "passed" << endl;
    }

    cout << "freeing" << endl;
    delete []buf;
    cout << "finished!" << endl;
    return 0;
}

