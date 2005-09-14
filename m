Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932730AbVINLQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932730AbVINLQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 07:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932728AbVINLQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 07:16:26 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:53055 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S932727AbVINLQZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 07:16:25 -0400
Date: Wed, 14 Sep 2005 13:16:20 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: "David S. Miller" <davem@davemloft.net>
cc: linux-kernel@vger.kernel.org, davem@redhat.com, sparclinux@vger.kernel.org,
       aurora-sparc-devel@lists.auroralinux.org
Subject: Re: [2.6.13-rc6-git13/sparc64]: Slab corruption (possible stack or
 buffer-cache corruption)
In-Reply-To: <20050913.130842.52078742.davem@davemloft.net>
Message-ID: <Pine.BSO.4.62.0509141252050.5000@rudy.mif.pg.gda.pl>
References: <Pine.BSO.4.62.0509121604360.5000@rudy.mif.pg.gda.pl>
 <20050912.161326.131841878.davem@davemloft.net>
 <Pine.BSO.4.62.0509131148020.5000@rudy.mif.pg.gda.pl>
 <20050913.130842.52078742.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1816641569-1126695664=:5000"
Content-ID: <Pine.BSO.4.62.0509141301180.5000@rudy.mif.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1816641569-1126695664=:5000
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.BSO.4.62.0509141301181.5000@rudy.mif.pg.gda.pl>

On Tue, 13 Sep 2005, David S. Miller wrote:

> From: Tomasz K³oczko <kloczek@rudy.mif.pg.gda.pl>
> Date: Tue, 13 Sep 2005 12:12:22 +0200 (CEST)
>
>> # grep "^Sep 12" /var/log/messages | grep kernel: | uniq | cut -d " " -f 6- | sort | uniq -c | sort -n | tail -n 2
>>      509 svc: bad direction 268435456, dropping request
>>      653 eth0: Happy Meal out of receive descriptors, packet dropped.
>>
>> As you see one of this two messagess occures avarange one time per ~two
>> minutes.
>> Second looks like some error in sunhme.c. eth0 it is:
>
> It's not a bug, per se, your system is simply receiving more
> network traffic than the kernel can receive.
> So the network adapter runs out of receive descriptors in which to receive
> new packets, and starts dropping them until the kernel catches
> up again.  That's what that message means.

Dave you touch core of problems .. messages occures constantly but 
high network activity occures only at night on this interface (backup). In 
attachment is weekly graph network acivity measured on SNMP agent on 
switch on this port.
At day usualaly on this interface activity is is very low (5-40Kb/s 
in/out).

> The "svc: " one I've seen before, it looks like something is
> clobbering the sunrpc message, for example a freed up buffer is having
> some bit set in one of it's words.  This 268435456 value is
> "0x10000000" hexadecimal.  The code expects the value zero, and we
> have a stray bit being set in there, bit 28 to be exact.  This would
> actually be expected after you trigger something like that
> destroy_inode() bug as a buffer is being free'd up twice.

Good news. After switch to kernel 2.6.13-1.1552sp1 from corona with your 
patch I don't see "svc: .." messages, but "eth0: Happy Meal .." still 
occures (seems less but still).
After ~half of day (and pass one time backup at night):

[root@boss ~]# grep "^Sep 14" /var/log/kernel | grep kernel: | uniq | cut -d " " -f 6- | sort | uniq -c | sort -n | tail -n 3
       2 udp v4 hw csum failure.
      15 eth0: Happy Meal out of receive descriptors, packet dropped.
      22 hw tcp v4 csum failed
[root@boss ~]# LANG= date
Wed Sep 14 13:15:01 CEST 2005

I'll try count of this for compare again at ~12:00 pm.

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-1816641569-1126695664=:5000
Content-Type: APPLICATION/OCTET-STREAM; NAME=sunset163_2-week.png
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.BSO.4.62.0509141301040.5000@rudy.mif.pg.gda.pl>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=sunset163_2-week.png

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
rxPURSJ1sj63ow5rZVehSaKe2utkfe6R8EVhV+Hp6doJH2paZIQP3ZM9LeGL
oraqgFOnKMYm/Iv+Qh08R6l7s7moSxDhXrfOVYjn70nUY3v9pL9M6XVXsEsQ
/pn99Xb18XH0kkMh/tNua/31efVxj8Vp9QvMndC/d/QnUJ8yEMe7BOGfh9ct
dN4cvut1k/TPx+Oe6JUFFofq9WYP9eZtnCMJr+1DCd82TdQliKiEN/u7aNKo
kwm/T6POQFPdboTvqA9HuP3xhFEXNhUjhJ6iTs4W9yPUrzWHl7UqiuEQ93I6
NYg9RVE2CRaf7HWCuhihztfeI+2uTEx4Rb3nK16WpyfMbKTXo6jrJ/+m9HpY
Jia8pN4MGf+yBG+pBXHOoz7TL96dlPDhpdv0hG9qNiQ8Tp3q9VUidTmcYdRX
49RDp2mmJfzscDB/eY+tWurgoVgjBPWMoP4O2FeQ+h6nngH7L1p5XsKvyiB1
dmAvNevHoaylDp4DN3FeEqm/4NRXFPUXmnrS5UYzQ8l66jnr/4huLybUS09d
1S07lYq6vlKU66odDfVngymbBKeu7HvcgbqkaFOv+zhD/DxEHcxi3ClNzpqi
e49BURVZe7CS+6685ljlRdUt1ODRq3ipDuzb6dTXbXVsqctiI6vUtKKqlh1P
w/GpaNodpHtcudmWrd6hXleSurKv5J+JfWKFol6oOGosyRvW/N1oBB0/r9jD
e4e6I9hTEBx5uPmzpILpTbE8nY6tlbEviTjYw9OU/k9Hr7+Q9TH2X9++jaeO
D3CdUPvID6x/CFDHnoL4P5GH4TGC14e94oQTs11qcdfaoxkDL+Raol6i4Ket
92IJG3daPdN6XT0L5VVEjoTyPaVeRTjr/sC81yTSRfjv6ZB2a8H9+CqS9y4b
hevr4+o5gbrfpvIxddnBGHX12BxCBZ0kCXkfJ9LFgojDUX1cPdOpIzms3g/A
sW7squZVgaDeG3urCaVPpB6s5+sw9zPK7+zXu7404Z7yP3JaSWL9dWIIAAAA
AElFTkSuQmCC

--0-1816641569-1126695664=:5000--
