Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbVHZPKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbVHZPKF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 11:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbVHZPKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 11:10:04 -0400
Received: from lux.ionium.org ([213.155.82.154]:55505 "EHLO lux.ionium.org")
	by vger.kernel.org with ESMTP id S965074AbVHZPKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 11:10:01 -0400
From: Justin Heesemann <jh@ionium.org>
To: linux-kernel@vger.kernel.org
Subject: extremely slow disk access due to mremap?
Date: Fri, 26 Aug 2005 17:09:58 +0200
User-Agent: KMail/1.8.91
Organization: ionium Technologies
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508261709.58671.jh@ionium.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello.
i've been experiencing a strange problem on two computers.
disk access is sometimes very slow. e.g.
copying files or downloading them via http first is quite fast, then 
stalls at a certain points (after 1 min or so it starts again..)

finally i found a good reproducable way to test this behavior:

# time grep ^....$ /usr/share/dict/words > /dev/null

real    0m7.728s
user    0m7.713s
sys     0m0.011s


the words file size is 400k.

since these two computers are supposed to be fast (2GB Ram, one has a 
Adaptec Smartraid V raid controller, the other one a  Mylex DAC960PG) 
and the same operation takes only 

# time grep ^....$ /usr/share/dict/words > /dev/null

real    0m0.223s
user    0m0.197s
sys     0m0.024s


on another much slower computer, i was wondering.

stracing the whole process shed some light:

....
open("/usr/share/dict/words", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=408865, ...}) = 0
read(3, "Aarhus\nAaron\nAbaba\naback\nabaft\na"..., 32768) = 32768
brk(0)                                  = 0x8086000
brk(0x80b9000)                          = 0x80b9000
fstat64(1, {st_mode=S_IFCHR|0666, st_rdev=makedev(1, 3), ...}) = 0
ioctl(1, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbfddaf24) = -1 ENOTTY 
(Inappropriate ioctl for device)
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0x40177000
read(3, "ions\navert\naverted\naverting\naver"..., 32768) = 32768
mmap2(NULL, 135168, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0x40178000
mremap(0x40178000, 135168, 131072, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 131072, 131072, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 131072, 131072, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 131072, 131072, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 131072, 131072, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 131072, 131072, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 131072, 131072, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 131072, 131072, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 131072, 131072, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 131072, 131072, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 131072, 131072, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 131072, 131072, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 131072, 131072, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 131072, 131072, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 131072, 131072, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 131072, 131072, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 131072, 131072, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 131072, 131072, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 131072, 126976, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 126976, 126976, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 126976, 126976, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 126976, 126976, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 126976, 122880, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 122880, 122880, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 122880, 122880, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 122880, 122880, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 122880, 122880, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 122880, 122880, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 122880, 122880, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 122880, 122880, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 122880, 122880, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 122880, 122880, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 122880, 122880, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 122880, 122880, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 122880, 118784, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 118784, 118784, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 118784, 118784, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 118784, 118784, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 118784, 118784, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 118784, 118784, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 118784, 114688, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 114688, 114688, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 114688, 114688, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 114688, 114688, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 114688, 114688, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 114688, 114688, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 114688, 114688, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 114688, 114688, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 114688, 110592, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 110592, 110592, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 110592, 110592, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 110592, 110592, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 110592, 110592, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 110592, 110592, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 110592, 110592, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 110592, 110592, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 110592, 106496, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 106496, 106496, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 106496, 106496, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 106496, 106496, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 106496, 106496, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 106496, 106496, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 106496, 106496, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 106496, 106496, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 106496, 102400, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 102400, 102400, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 102400, 102400, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 102400, 102400, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 102400, 102400, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 102400, 102400, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 102400, 102400, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 102400, 102400, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 102400, 98304, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 98304, 98304, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 98304, 98304, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 98304, 98304, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 98304, 94208, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 94208, 94208, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 94208, 94208, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 94208, 94208, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 94208, 90112, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 90112, 90112, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 90112, 90112, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 90112, 90112, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 90112, 90112, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 90112, 90112, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 90112, 86016, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 86016, 86016, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 86016, 86016, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 86016, 86016, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 86016, 86016, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 86016, 86016, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 86016, 86016, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 86016, 86016, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 86016, 86016, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 86016, 86016, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 86016, 81920, MREMAP_MAYMOVE) = 0x40178000
mremap(0x40178000, 81920, 81920, MREMAP_MAYMOVE) = 0x40178000
... (this goes on, until it has reached 4096, then another read starts, 
again lots of lots of mremaps...)



whilest should look something like this (straced from the epia box):
....
open("/usr/share/dict/words", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2486824, ...}) = 0
read(3, "A\na\naa\naal\naalii\naam\nAani\naardva"..., 32768) = 32768
fstat64(1, {st_mode=S_IFCHR|0777, st_rdev=makedev(1, 3), ...}) = 0
ioctl(1, SNDCTL_TMR_TIMEBASE, 0xbfffdb24) = -1 ENOTTY (Inappropriate 
ioctl for device)
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7e62000
read(3, "tasia\naerial\naerialist\naeriality"..., 32768) = 32768
read(3, "ulancer\nambulant\nambulate\nambula"..., 32768) = 32768
read(3, "ize\nanthology\nantholysis\nAntholy"..., 32768) = 32768
write(1, "Aani\nAaru\nabac\nabas\nAbba\nAbby\nab"..., 1024) = 1024
read(3, "rborator\narboreal\narboreally\narb"..., 32768) = 32768
...


why all those mremap calls?
i've tried different kernels (2.4.31, 2.6.12.4 and 2.6.5) with highmem 
support and without. same results.


the funny thing is: if i don't grep for a regexp, it's working fine:
# grep asdf /usr/share/dict/words
...
open("/usr/share/dict/words", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=408865, ...}) = 0
read(3, "Aarhus\nAaron\nAbaba\naback\nabaft\na"..., 32768) = 32768
read(3, "ions\navert\naverted\naverting\naver"..., 32768) = 32768
read(3, "ton\ncartons\ncartoon\ncartoons\ncar"..., 32768) = 32768
read(3, "\ncreators\ncreature\ncreatures\ncre"..., 32768) = 32768
read(3, "\nEisner\neither\nejaculate\nejacula"..., 32768) = 32768
read(3, "\ngangling\ngangplank\ngangrene\ngan"..., 32768) = 32768
read(3, "ormant\ninformants\nInformatica\nin"..., 32768) = 32768
read(3, "ker\nmarkers\nmarket\nmarketability"..., 32768) = 32768
read(3, "overhangs\noverhaul\noverhauling\no"..., 32768) = 32768
read(3, "purse\npursed\npurser\npurses\npursu"..., 32768) = 32768
read(3, "hweitzer\nscience\nsciences\nscient"..., 32768) = 32768
read(3, "sidize\nsubsidized\nsubsidizes\nsub"..., 32768) = 32768
read(3, "cuous\nvacuously\nvacuum\nvacuumed\n"..., 32768) = 15649
read(3, "", 20480)                      = 0
close(3)                                = 0
...


since right now i'm out of ideas what to look for next, could you please 
help me?

-- 
Justin Heesemann
