Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966262AbWKTRrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966262AbWKTRrw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966261AbWKTRrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:47:52 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:34449 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S966252AbWKTRrv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:47:51 -0500
Message-ID: <4561EA27.8050203@gmail.com>
Date: Mon, 20 Nov 2006 18:47:19 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>
CC: Greg KH <gregkh@suse.de>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kobject_add failed with -EEXIST
References: <4561E290.7060100@gmail.com> <20061120173116.GA27160@suse.de> <200611201842.22551.oliver@neukum.org>
In-Reply-To: <200611201842.22551.oliver@neukum.org>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> Am Montag, 20. November 2006 18:31 schrieb Greg KH:
>> On Mon, Nov 20, 2006 at 06:14:56PM +0100, Jiri Slaby wrote:
>>> Hi!
>>>
>>> Does anybody have some clue, what's wrong with the attached module?
>>> Kernel complains when the module is insmoded second time (DRIVER_DEBUG
>>> enabled):
>> I just tried this with 2.6.19-rc6 and it worked just fine, no problems.
>> Perhaps you have some userspace program keeping the
>> /sys/class/cls_class/cls_device/ files open?
> 
> If this is the case, we'd have a denial of service security problem.

Unlikely, only (insmod, rmmod) x2 (and no entries in lsof). I've just killed
udevd and got this:
BUG: unable to handle kernel NULL pointer dereference at virtual address 00000078
 printing eip:
c01994cd
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: cls battery nfs lockd sunrpc ipv6 eth1394 parport ehci_hcd
ohci1394 ipw2200 ide_cd ieee1394 c
drom
CPU:    0
EIP:    0060:[<c01994cd>]    Not tainted VLI
EFLAGS: 00210292   (2.6.19-rc6 #117)
EIP is at create_dir+0x1d/0x200
eax: d26895c0   ebx: d26895c4   ecx: d26895c4   edx: 00000070
esi: d26895c4   edi: d26895c4   ebp: 00000070   esp: dc57ddf4
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 14387, ti=dc57d000 task=c2a66a70 task.ti=dc57d000)
Stack: c2dcddcc c01982d9 d26895c0 d26895c0 d26895c4 de9f603f 00000000 c0199e9a
       dc57de18 00000000 d26895c0 c01c7b74 d26895c4 d26895c4 dc57de60 d26895c0
       c170ee80 d26895c0 ffffffea de9f603f d875c0a4 c01c7d81 d26895c0 c170ee80
Call Trace:
 [<c01982d9>] sysfs_new_inode+0xb9/0xe0
 [<c0199e9a>] sysfs_create_dir+0x2a/0x70
 [<c01c7b74>] kobject_add+0x94/0x1c0
 [<c01c7d81>] kobject_register+0x21/0x50
 [<c01c7e12>] kobject_add_dir+0x62/0x90
 [<c0231f76>] virtual_device_parent+0x56/0x80
 [<c022fd81>] device_add+0x461/0x4b0
 [<c01c791f>] kobject_get+0xf/0x20
 [<c0232ae0>] class_create_release+0x0/0x10
 [<c01c791f>] kobject_get+0xf/0x20
 [<c01c7cfb>] kobject_init+0x2b/0x40
 [<c02300b0>] device_create_release+0x0/0x10
 [<c022fe69>] device_create+0x89/0xc0
 [<de9fd047>] cls_init+0x47/0x93 [cls]
 [<c0137d85>] sys_init_module+0x155/0x1920
 [<c010314b>] syscall_call+0x7/0xb
 [<c031007b>] packet_set_ring+0x4b/0x390
 =======================
Code: e8 c9 24 f8 ff e8 94 b2 f6 ff eb b4 66 90 83 ec 1c 89 5c 24 0c 89 cb 89 74
24 10 89 7c 24 14 89 df 89 6c 2
4 18 89 d5 89 44 24 08 <8b> 42 08 83 c0 6c e8 e8 fc 17 00 31 c0 b9 ff ff ff ff
f2 ae f7
EIP: [<c01994cd>] create_dir+0x1d/0x200 SS:ESP 0068:dc57ddf4

I'm going to reboot and try fresh boot. (The 2.6.19-rc5-mm2 kernel was on an
another machine, althought both are FC6s).

I tried it now on
$ cat /etc/debian_version
testing/unstable
(I don't know exactly what it is)
with the same result (BUG in kobject_add) -- 2.6.19-rc5.

The -mm has
# CONFIG_SYSFS_DEPRECATED is not set

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
