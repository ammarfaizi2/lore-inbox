Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVBWW1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVBWW1V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 17:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVBWW0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 17:26:05 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:37436 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261628AbVBWWYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 17:24:36 -0500
Message-ID: <421D029E.8010600@zensonic.dk>
Date: Wed, 23 Feb 2005 23:24:30 +0100
From: "Thomas S. Iversen" <zensonic@zensonic.dk>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Help tracking down problem --- endless loop in __find_get_block_slow
References: <4219BC1A.1060007@zensonic.dk>	<20050222011821.2a917859.akpm@osdl.org>	<20050223120013.GA28169@zensonic.dk>	<20050223041036.5f5df2ff.akpm@osdl.org>	<20050223130251.GA31851@zensonic.dk> <20050223120928.133778a4.akpm@osdl.org>
In-Reply-To: <20050223120928.133778a4.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Something has caused the page at offset 51 (block 102) to have buffer_heads
> for blocks 128 and 129 attached to it.

Ok.

> I'd be suspecting that the sector remapping is the cause of the problem. 
> How is it implemented?

Quite simple actually. You're most welcome to see the code, but I have 
just done a test like the one below. Never mind the performance figures, 
  correctness comes as a very first priority. It does not block, cause 
endless loops or anything funny if I take the filsystem out of the 
question and access the raw devicemapped block device.

This should assert that it is not a fault in my code, right?

zensonic@www:~$ ssh 192.168.1.9 -l root
Password:
Last login: Wed Feb 23 23:30:41 2005
maibritt:~# unload
maibritt:~# modprobe dm-bde
maibritt:~# alias dmc
alias dmc='/usr/src/device-mapper.1.00.19/dmsetup/dmsetup create dmbde'
maibritt:~# dmc
maibritt:~# dd if=/dev/urandom of=/dev/mapper/dmbde
dd: skriver til '/dev/mapper/dmbde': Ikke mere plads på enheden
46721+0 blokke ind
46720+0 blokke ud
23920640 bytes transferred in 13,004132 seconds (1839465 bytes/sec)
maibritt:~# hexdump /dev/mapper/dmbde | head
0000000 f348 b77e 96b8 62cc ea69 1ddf e232 1d74
0000010 b1fe 521c 4f4f 30cd 62a0 d697 0ce9 55de
0000020 2bae ee86 53b1 c04d 88ab cc63 5826 11d7
0000030 98c5 2ee3 d81e 1658 29f2 9196 8591 fe20
0000040 7c4c 2bf4 a088 906e 23ae d327 9def 09ea
0000050 b435 75c6 3b78 d45e 16aa 038c f592 2e03
0000060 52fe 5b05 03c1 95ff 927a 84ed 6aab f0f8
0000070 a870 0797 5a82 e574 964d c633 8365 42b8
0000080 8e6e 6e60 8544 792f 597f 5065 7766 fbbb
0000090 5eb7 e6f9 9632 477b a17a 91d3 121e 8692
maibritt:~# dd if=/dev/zero of=/dev/mapper/dmbde
dd: skriver til '/dev/mapper/dmbde': Ikke mere plads på enheden
46721+0 blokke ind
46720+0 blokke ud
23920640 bytes transferred in 6,335617 seconds (3775582 bytes/sec)
maibritt:~# hexdump /dev/mapper/dmbde
0000000 0000 0000 0000 0000 0000 0000 0000 0000
*
16d0000
maibritt:~#
maibritt:~#

