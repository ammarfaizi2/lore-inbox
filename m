Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424615AbWLBXzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424615AbWLBXzQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 18:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424616AbWLBXzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 18:55:16 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:54368 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1424615AbWLBXzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 18:55:14 -0500
Message-ID: <45721258.1070802@tls.msk.ru>
Date: Sun, 03 Dec 2006 02:55:04 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: kernel NULL pointer deref in pipe() - hotplug in initramfs
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When /sbin/hotplug is present in initramfs, and it's a shell
script, kernel OOPSes on every hotplug invocation.  Here's an
example:

<4> <1>BUG: unable to handle kernel NULL pointer dereference at virtual address 00000014
<1> printing eip:
<4>c015c80a
<1>*pde = 00000000
<0>Oops: 0000 [#2]
<4>Modules linked in:
<0>CPU:    0
<0>EIP:    0060:[<c015c80a>]    Not tainted VLI
<0>EFLAGS: 00010282   (2.6.19-c3 #2.6.19.0)
<0>EIP is at create_write_pipe+0x1a/0x1c0
<0>eax: 00000000   ebx: bfb07cfc   ecx: 00000000   edx: c13915a0
<0>esi: cf739820   edi: ffffffff   ebp: c13a2fa8   esp: c13a2f40
<0>ds: 007b   es: 007b   ss: 0068
<0>Process hotplug (pid: 34, ti=c13a2000 task=c13915a0 task.ti=c13a2000)
<0>Stack: 00001fff c1382da0 c137fba0 c1387b7c 00000000 c12b2ce0 080dfd04 080dfd04
<0>       00000003 c015a27f 00000000 c1382da0 b7f64d30 00000004 c011412a 00000000
<0>       bfb07cfc 00000004 ffffffff c015cfde c137fba0 bfb07cfc 00000004 ffffffff
<0>Call Trace:
<0> [<c015cfde>] do_pipe+0xe/0xa0
<0> [<c0107cac>] sys_pipe+0xc/0x40
<0> [<c0102eb7>] syscall_call+0x7/0xb
<0> [<b7f6607d>] 0xb7f6607d
<0> =======================
<0>Code: 00 00 00 89 b3 74 01 00 00 89 d8 5b 5e c3 8d 76 00 57 56 53 83 ec 40 e8 35 bb ff ff 89 c6 85 c0 0f 84 7b 01 00 00 a1 c0 85 2d c0 <8b> 40 14 e8 de d0 00 00 89 c3 85 c0 0f 84 44 01 00 00 e8 8f ff
<0>EIP: [<c015c80a>] create_write_pipe+0x1a/0x1c0 SS:ESP 0068:c13a2f40
<4> <1>BUG: unable to handle kernel NULL pointer dereference at virtual address 00000014
<1> printing eip:
...[more entries like this follows]...

(note also the formatting is a bit wrong here -- that <4> prefix in front of <1>BUG..)

The only pipe() call in my hotplug script is this:

case "$ACTION:$SUBSYSTEM" in
add:block)
  ...
  usage="$(/bin/blkid $dev 2>/dev/null | cut -d\  -f2-)"
...


This is 2.6.19 running on an x86 machine (VIA C3 "Ezra" CPU if that matters).
The same thing happens on 2.6.18, but the error was slightly different (due
to introduction of create_write_pipe() routine in 2.6.19).

Are pipes disallowed in hotplug fired off initramfs?
(Even if they are, kernel probably still should not OOPS like that ;)

The error seems to be harmful however.  That is, hotplug script does not
run, but the kernel continues running.

Thanks.

/mjt
