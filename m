Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbVCBS2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbVCBS2a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 13:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbVCBS0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 13:26:47 -0500
Received: from hermes.uci.kun.nl ([131.174.93.58]:50428 "EHLO
	hermes.uci.kun.nl") by vger.kernel.org with ESMTP id S262416AbVCBSZM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 13:25:12 -0500
Date: Wed, 02 Mar 2005 19:24:37 +0100
From: Sebastian =?iso-8859-1?q?K=FCgler?= <lists@vizZzion.org>
Subject: PCMCIA breaks suspend-to-(disk|ram) with 2.6.11
To: linux-kernel@vger.kernel.org
Message-id: <200503021924.42531.lists@vizZzion.org>
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

2.6.10 and earlier worked fine for me, apart from the occasional failure I can 
somewhat live with, but 2.6.11 seems to have horribly broken the combination 
between suspend (disk|ram) and PCMCIA. 2.6.9 and earlier is very flaky WRT 
S3, S4 via suspend2 is working fine for me for ages, apart from occasional 
driver problems.

Unloading orincoco_cs and then yenta_socket hangs rmmod in D state. If I then 
send the machine to S3 it will hang on resume, right after having switched 
the display back on, leaving me with funny colors and a not-responding system 
(no SYSRQ, no reaction on CAPS lock, whatsoever).

Both, S3 and S4 work fine without the PCMCIA adapter inserted. My suspend 
scripts unload PCMCIA and related stuff and are supposed to stop cardmgr. (I 
have problems resuming without the PCMCIA card plugged in when I suspended 
with it inserted, making swsusp hang about at the end of resuming with 
"orinoco_lock() called with hw_unavailable (dev=de08f800)".) It does seem to 
work if I leave the modules alone and just initiating S3, but then I'd better 
not remove the card in the meantime.

Hardware is a Asus L3800C notebook and a Lucent Silver PCMCIA WLAN adapter. 

Here's the output you're probably after (please let me know if it's 
incomplete):

0000:02:07.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 1624
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at 20001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
        Memory window 0: 20c00000-20fff000 (prefetchable)
        Memory window 1: 21000000-213ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

I am getting this oops if I try to rmmod -f orinoco_cs while the card is 
inserted, the problem seems to boil down to that (This oops obviously renders 
the PCMCIA card unusable until I reboot):

Oops: 0000 [#1]
Modules linked in: ipv6 ipt_state ipt_limit ipt_REJECT ipt_LOG ipt_MASQUERADE 
iptable_mangle iptable_nat ip_conntrack iptable_filter ip_tables joydev 
ide_cd eth1394 ohci1394 ieee1394 snd_intel8x0 snd_ac97_codec snd_pcm 
snd_timer snd snd_page_alloc i2c_i801 usbhid intel_agp evdev orinoco_cs 
pcmcia orinoco hermes yenta_socket rsrc_nonstatic pcmcia_core radeon drm 
agpgart
CPU:    0
EIP:    0060:[<e09c7eb5>]    Tainted: GF     VLI
EFLAGS: 00010293   (2.6.11-vanilla)
EIP is at unbind_request+0x55/0xb0 [pcmcia]
eax: c1599930   ebx: fffffff4   ecx: df5b8d88   edx: c1599930
esi: df5b8d80   edi: c1599900   ebp: c1599930   esp: df66bf04
ds: 007b   es: 007b   ss: 0068
Process pccardd (pid: 2313, threadinfo=df66a000 task=df57e020)
Stack: 00000008 c1599900 00000008 df50e82c 00000001 e09c7659 c1599900 00000008
       00000001 df50e82c df66a000 00000080 df50e974 e099f746 df50e82c 00000008
       00000001 df50e82c df66a000 e099f7b1 df50e82c 00000008 00000001 e099f7d3
Call Trace:
 [<e09c7659>] ds_event+0xd9/0xf0 [pcmcia]
 [<e099f746>] send_event+0x56/0xa0 [pcmcia_core]
 [<e099f7b1>] socket_remove_drivers+0x21/0x30 [pcmcia_core]
 [<e099f7d3>] socket_shutdown+0x13/0x40 [pcmcia_core]
 [<e099fcc3>] socket_remove+0x13/0x50 [pcmcia_core]
 [<e099fd6a>] socket_detect_change+0x6a/0x80 [pcmcia_core]
 [<e099ff2b>] pccardd+0x1ab/0x200 [pcmcia_core]
 [<c0152ae9>] filp_close+0x59/0x90
 [<c0117850>] default_wake_function+0x0/0x20
 [<c0117850>] default_wake_function+0x0/0x20
 [<e099fd80>] pccardd+0x0/0x200 [pcmcia_core]
 [<c01012fd>] kernel_thread_helper+0x5/0x18
Code: 8b 51 04 8d 71 f8 8b 01 89 50 04 89 02 c7 41 04 00 02 20 00 c7 01 00 01 
10 00 83 4e 20 10 53 9d 8b 9e b4 00 00 00 83 eb 0c 74 20 <8b> 4b 04 85 c9 74 
07 8b 46 10 85 c0 75 2d 8b 43 08 85 c0 74 0b

Replugging the adapter results in a kernel panic.

Is this info useful enough for someone to have a closer look at it? If not, 
can I provide more? If you want me to try something else, please also drop me 
an email.

On a different note, is there a split out version of the PCMCIA hotplug stuff 
recently merged into -mm? I'd like to try it and see if it fixes my issues, 
but I'd rather not introduce too much new deltas.

I've put my config and dmesg from a clean boot here:

http://vizzzion.org/~sebas/tmp/lkml/config.txt
http://vizzzion.org/~sebas/tmp/lkml/dmesg.txt

CC:'ing me on replies would be cool, although I'm trying to keep up with LKML. 

Thanks in advance for having a look at it,

sebas
- -- 
  http://vizZzion.org   |   GPG Key ID: 9119 0EF9 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Accident, n.: A condition in which presence of mind is good, but absence of 
body is better.  - Foolish Dictionary

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iQEVAwUBQiYE6mdNh9WRGQ75AQINJQgA2P9pexCE+Fx5xFuNBHIJ6nMGQfA29jOh
1zF1L6UlLgiZHPXuiRMaJZ6SzspatixmZulnpAEQe8aJ7qhQSzlfTyIGrsanohdf
Gfsxf+0U8tsMQlX098mY9Jk8xkQvbYQDVCqvNwxU7Hxk2ZJ09Dq1drfzmGCr8YU1
8i1TGXLyjqOQoyMdHlN2IZCAXggoBBG/MYCT3iWxhWGHMyr0lMM8R8AjMNoibLdZ
4XSkFzYk7N9l9H6Z1+sIfnUZxBUaTpS79i7gM5tiiIrZBpJjIg5pW8kNM+9P4g70
xNEKERzN4YGvcnAlBhh+yHLRM3iZgrXs+YKCnka0rfhO246KkESv2g==
=a0+u
-----END PGP SIGNATURE-----
