Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVAWQz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVAWQz0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 11:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVAWQzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 11:55:25 -0500
Received: from sccimhc91.asp.att.net ([63.240.76.165]:680 "EHLO
	sccimhc91.asp.att.net") by vger.kernel.org with ESMTP
	id S261328AbVAWQzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 11:55:13 -0500
From: Jay Roplekar <jay_roplekar@hotmail.com>
Reply-To: jay_roplekar@hotmail.com
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel bug: mm/rmap.c:483
Date: Sun, 23 Jan 2005 10:55:08 -0600
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501231055.08965.jay_roplekar@hotmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not sure this is a fixed problem in 2.6.11-rc2 based on my read of the 
changelog, hence this email. Here is the summary:

1. I  started with vanilla 2.6.10 where I replaced ieee1394 drivers from trunk 
rev 1251 patched in. My kernel is tainted due to ndiswrapper that loads 
windows drivers for my wireless PCI card.  One out of 4 times I actually 
booted 2.6.10  and manually brought up wlan0 I got 'reboot needed etc 
messages' .  Please note that  using similar approach in 2.6.8 does not cause 
this issue.   Following is the error in /var/log/messages ( I did not  paste 
everything to be brief):

Jan 22 08:26:58 localhost kernel: Bad page state at prep_new_page (in process 
'net_applet', page c1323a00)
Jan 22 08:26:58 localhost kernel: flags:0x20000004 mapping:00000000 mapcount:1 
count:1
Jan 22 08:26:58 localhost kernel: Backtrace:
Jan 22 08:26:58 localhost kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Jan 22 08:26:58 localhost kernel:  [<c0103cde>] dump_stack+0x1e/0x20
Jan 22 08:26:58 localhost kernel:  [bad_page+117/176] bad_page+0x75/0xb0
Jan 22 08:26:58 localhost kernel:  [<c013c1b5>] bad_page+0x75/0xb0
Jan 22 08:26:58 localhost kernel:  [prep_new_page+40/112] 
prep_new_page+0x28/0x70
Jan 22 08:26:58 localhost kernel:  [<c013c4d8>] prep_new_page+0x28/0x70
#####
Jan 22 08:26:58 localhost kernel: ------------[ cut here ]------------
Jan 22 08:26:58 localhost kernel: kernel BUG at mm/rmap.c:483!
Jan 22 08:26:58 localhost kernel: invalid operand: 0000 [#1]
Jan 22 08:26:58 localhost kernel: Modules linked in: mga md5 ipv6 snd_pcm_oss 
snd_mixer_oss snd_via82xx snd_ac97_codec snd_pcm snd_timer snd_page_alloc 
gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore af_packet 
fealnx mii eth1394 ide_cd cdrom ohci1394 ieee1394 loop ntfs nls_iso8859_1 
nls_cp437 vfat fat ndiswrapper via_agp agpgart uhci_hcd usbcore genrtc ext3 
jbd
Jan 22 08:26:58 localhost kernel: CPU:    0
Jan 22 08:26:58 localhost kernel: EIP:    0060:[page_remove_rmap+53/64]    
Tainted: P    B VLI 
Jan 22 08:26:58 localhost kernel: EIP:    0060:[<c014bec5>]    Tainted: P    B 
VLI
Jan 22 08:26:58 localhost kernel: EFLAGS: 00010286   (2.6.10jry)
Jan 22 08:26:58 localhost kernel: EIP is at page_remove_rmap+0x35/0x40
Jan 22 08:26:58 localhost kernel: eax: ffffffff   ebx: 00389000   ecx: 
c0399d54   edx: c1323a00
Jan 22 08:26:58 localhost kernel: esi: d3b06f44   edi: 003b8000   ebp: 
d39ebd2c   esp: d39ebd2c
Jan 22 08:26:58 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jan 22 08:26:58 localhost kernel: Process net_applet (pid: 9326, 
threadinfo=d39ea000 task=d6a8d060)
Jan 22 08:26:58 localhost kernel: Stack: d39ebd58 c0145a67 c1323a00 c0139256 
dffccabc d5a1af08 191d0045 c1323a00
Jan 22 08:26:58 localhost kernel:        08848000 d3b5b088 08800000 d39ebd88 
c0145c10 c0399d54 d3b5b084 08448000

2.  I patched in Hugh's patch  to 2.6.10 and recompiled. At reboot I ran 
memtest86 v 1.26, 3 times without any error.  Then rebooting  in 2.6.10 and 
doing  ifup wlan0 gave me system freeze and unfortunately nothing in the log.
Since then I have  not  seen the same error again after 3 reboots and 2-3 cold 
boots followed by ifup. I also tried cycles  of ifdown and ifup without  any 
errors.  

3. I am not sure if I should post my whole config here hence I just pasting 
DRM related entries here in reference to your original email to Jose`.  I 
have VIA motherboard and a matrox  agp card, [FWIW most of the config is same 
as for 2.6.8 kernel  that did not show the rmap sympton]

CONFIG_AGP_VIA=m
CONFIG_DRM=y
CONFIG_DRM_MGA=m


I will be glad to provide any other info needed. You may  bcc to my email if 
this is better discussed off the list. [Although I will anxiously  check 
lkml.org everyday or use RSS feed]. I am not subsribed as We are not 
worthy :-)

Thanks,

Jay
