Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVGFQfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVGFQfa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 12:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVGFQf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 12:35:29 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:40279 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S262118AbVGFMSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 08:18:25 -0400
Message-ID: <42CBCC0D.2050904@tls.msk.ru>
Date: Wed, 06 Jul 2005 16:18:21 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: rocketport module weirdness in 2.6
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since we switched to 2.6 kernel on our gateway machine, we're
seeing strange things happening with an ol'good 8-port rocketport
card (multi-serial-port card).  On a regular basis, processes
using ttyRx devices, and the devices themselves, gets stuck in
one or another way.  Here is an example of a Sysrq-T stack
trace from `login' process, which is that way for several days
now:

login         D 000CF43D     0 15170      1         25955  1643 (L-TLB)
c6aa4ea8 00000046 d90eb418 000cf43d 00000432 d937621e 000cf43d c77a7040
       c77a7164 c4852000 c6aa4edc c6aa4efc c6aa4ee8 c01b969d c6aa4000 00000000
       00000000 00000000 00000000 00000000 00000000 c77a7040 c01281b0 c6aa4ef4
Call Trace:
 [release_dev+1245/1680] release_dev+0x4dd/0x690
 [autoremove_wake_function+0/48] autoremove_wake_function+0x0/0x30
 [autoremove_wake_function+0/48] autoremove_wake_function+0x0/0x30
 [free_pte_range+50/64] free_pte_range+0x32/0x40
 [free_pgd_range+220/432] free_pgd_range+0xdc/0x1b0
 [tty_release+7/16] tty_release+0x7/0x10
 [__fput+230/256] __fput+0xe6/0x100
 [filp_close+67/112] filp_close+0x43/0x70
 [put_files_struct+105/192] put_files_struct+0x69/0xc0
 [do_exit+219/720] do_exit+0xdb/0x2d0
 [do_group_exit+39/112] do_group_exit+0x27/0x70
 [syscall_call+7/11] syscall_call+0x7/0xb

(I switched the modem from ttyR0 where the login process is stuck
to ttyR6 and it now works).  That 'login' process is in 'release_dev'
state in /proc/15170/wchan.

Another common "stuck" scenario is that, under some random cases,
the port stops responding.  Moving modem to another port, or rebooting,
does help.

And yet another one:  sometimes, characters from the modem does not
show until something is sent to it (this is another possible port
"state", only cleared by rebooting).  Like this:

<send   <receive
 to      from
 modem>  modem>
A
T
<cr>     AT
<cr>     <cr>
<cr>     O
<cr>     K
<cr>     <cr>

(it shuold echo 'A', 'T', and the first <cr> right when I type the
chars, and should respond with "OK<cr>" right after the first <cr>).

This is with 2.6.11 kernel, from kernel.org.

The controller is an old ISA card with 8 ports, it worked this way
since about 1998.  Rebooting into 2.4 fixes this problem, so the
card itself seems to be working.  I use board1=0x180 parameter for
`rocket' module (in 2.4, it detects the card automatically w/o any
parameters).

The only relevant kernel messages are:
Jun 28 16:57:11 gate kernel: RocketPort device driver module, version 2.09, 12-June-2003
Jun 28 16:57:11 gate kernel: RocketPort ISA card #0 found at 0x180 - 1 AIOPs
Jun 28 16:57:11 gate kernel: Installing RocketPort ISA, creating /dev/ttyR0 - 7

Any ideas?

Thanks.

/mjt
