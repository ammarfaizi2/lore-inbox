Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266888AbUHOUgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266888AbUHOUgV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 16:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUHOUgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 16:36:20 -0400
Received: from as1-2-5.han.s.bonet.se ([194.236.155.59]:7440 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S266888AbUHOUey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 16:34:54 -0400
Date: Sun, 15 Aug 2004 22:34:49 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Subject: Oops when reading cpufreq values with 2.6.8-rc4-mm1
Message-ID: <20040815203447.GB4162@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently experienced a reproducible oops when trying to read cpufreq 
variables via sysfs. I sprinkled a few printk's in the check_parm method 
of fs/sysfs/file.c (output included in oops output below).

It turns out that check_perm is called with the relevant kobj->ktype 
pointer being set to a value which seems to be quite unlikely (0x00003) 
and kobj->kset set to NULL.

The result being that when kobj->ktype->sysfs_ops is later referenced, 
the oops occurs.

Now, this is as far as I managed to get. Understanding the proper sysfs 
semantics in cpufreq and what might be wrong with it is beyond my 
knowledge. Does anyone have an idea what could be the cause?

Regards.
David Härdeman
david@2gen.com

PS
Please CC me in any replies...not subscribed


Oops message:
=============
/* Some debugging printk's I added */
check_perm - inode 5024, kobj cf410ef8, attr c0321644
/* inode = /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq */
check_perm - kobj->kset 00000000, kobj->ktype 00000003
                                  ^^^^^^^^^^^^^^^^^^^^^
				  /*   Seems weird   */
Unable to handle kernel NULL pointer dereference at virtual address 00000007
 printing eip:
c0180168
*pde = 00000000
Oops: 0000 [#2]
PREEMPT 
Modules linked in: md5 ipv6 ipt_state ip_conntrack_ftp ip_conntrack 
iptable_filter ip_tables yenta_socket pcmcia_core tg3 8250_pci 8250 
serial_core intel_agp tsdev evdev nls_utf8 ntfs aes_i586 dm_crypt dm_mod 
cpufreq_powersave cpufreq_userspace pppoatm atm p4_clockmod speedstep_lib 
ppp_generic slhc i2c_i801 i2c_core i830 snd_pcm_oss snd_mixer_oss snd_intel8x0 
snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi 
snd rtc hw_random thermal processor fan button battery ac uhci_hcd ehci_hcd 
usbcore nvram
CPU:    0
EIP:    0060:[<c0180168>]    Not tainted VLI
EFLAGS: 00010296   (2.6.8-rc4-mm1) 
EIP is at check_perm+0x141/0x2d6
eax: 00000003   ebx: cf410ef8   ecx: c02dde70   edx: 00000282
esi: 00000001   edi: 00000000   ebp: c0321644   esp: c3615f04
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 3888, threadinfo=c3614000 task=c4a8f3c0)
Stack: c02ac2f6 00000003 cf410ef8 c0321644 00008001 00000000 c4bd7480 cd593c80 
       cf6cca00 00000001 c014c5aa cd593c80 c4bd7480 411fc055 00008000 00008000 
       cf3a5000 c3614000 c014c465 cd5951f4 cf6cca00 00008000 c3615f60 cd5951f4 
Call Trace:
[<c014c5aa>] dentry_open+0x143/0x222
[<c014c465>] filp_open+0x62/0x64
[<c014c6c0>] get_unused_fd+0x37/0xd9
[<c014c821>] sys_open+0x49/0x89
[<c0105f77>] syscall_call+0x7/0xb
Code: 43 28 85 c0 74 0b 8b 70 04 85 f6 0f 85 17 01 00 00 8b 4b 2c 85 c9 0f 84 
f6 00 00 00 c7 04 24 f6 c2 2a c0 e8 7f 8e f9 ff 8b 43 2c <8b> 70 04 c7 04 24 
03 c3 2a c0 e8 6d 8e f9 ff 85 f6 0f 84 8b 00
