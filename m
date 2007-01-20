Return-Path: <linux-kernel-owner+w=401wt.eu-S965284AbXATTGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965284AbXATTGL (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 14:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965297AbXATTGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 14:06:11 -0500
Received: from mail.cbxnet.de ([212.87.33.16]:34895 "EHLO mail1.combox.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965284AbXATTGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 14:06:10 -0500
Subject: BUG: incorrect MD5 hash value on x86_64 with TCP-MD5
From: Torsten Luettgert <t.luettgert@pressestimmen.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 20 Jan 2007 20:07:53 +0100
Message-Id: <1169320073.3654.40.camel@murdegern.cbxnet.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

There's still a bug in the new TCP-MD5 feature.

On x86_64, the hash function is fed wrong TCP payload content.
The same kernel, same conf (except arch -> x86) on an Athlon
doesn't have the problem. Kernel is a vanilla 2.6.20-rc5.

I put debugging printk()s into tcp_v4_do_calc_md5_hash() and logged
every byte fed into MD5. Here's one packet sniffed from the wire:

0000  00 30 05 27 38 90 00 04  23 d7 af ed 08 00 45 00
0010  00 69 b8 3c 40 00 40 06  86 a1 d4 57 21 04 d4 57
0020  31 fe a3 be 00 b3 bd b9  3f 14 5b e1 17 5e a0 18
0030  16 d0 2e 0b 00 00 01 01  13 12 13 e2 0e db db e0
0040  46 e3 67 02 17 38 ca e7  1f 1f ff ff ff ff ff ff
0050  ff ff ff ff ff ff ff ff  ff ff 00 2d 01 04 30 e0
0060  00 b4 d4 57 21 04 10 02  06 01 04 00 01 00 01 02
0070  02 80 00 02 02 02 00

The TCP payload starts at all those FFs. Here's what the hash
function sees:

dump of tcp pseudo-header (12 byte):
  d4 57 21 04 d4 57 31 fe 00 06 00 55
that's correct: 212.87.33.4 -> 212.87.49.254,
protocol 6=TCP, 0x55 bytes

dump of tcp header without options (20 byte):
  a3 be 00 b3 bd b9 3f 14 5b e1 17 5e a0 18 16 d0
  00 00 00 00
also correct: copied verbatim from the packet, except
the checksum is set to zero.

dump of data (45 byte):
  02 00 01 00 01 00 00 00 01 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 30 37 ea 7f 00 81 ff ff
  00 00 2d 00 03 00 00 00 01 00 00 00 00
TOTAL RUBBISH! I don't know where this comes from,
or why it is found after the TCP header. It doesn't
appear in the packet either.

dump of password (13 byte):
  73 63 68 6e 61 62 65 6c 74 61 73 73 65
that's my test password all right.

dump of md5 hash result (16 byte):
  13 e2 0e db db e0 46 e3 67 02 17 38 ca e7 1f 1f
same as sniffed, so I didn't mix up packets.

I tried passing the whole skb* into tcp_v4_do_calc_md5_hash
and dumping stuff from various locations in the packet, but
didn't find the real payload.

Please help, I'm at my wits end here...

Regards,
Torsten

