Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268442AbTGOPPO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268435AbTGOPO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:14:57 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:5262 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S268442AbTGOPFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:05:52 -0400
Message-ID: <3F141BAD.7010700@portrix.net>
Date: Tue, 15 Jul 2003 17:20:13 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030524 Debian/1.3.1-1.he-1
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: 'NFS stale file handle' with 2.5
References: <3F1068C9.1070900@portrix.net> <16145.53527.749969.347814@gargle.gargle.HOWL>
In-Reply-To: <16145.53527.749969.347814@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Saturday July 12, j.dittmer@portrix.net wrote:
> 
>>Hi,
>>
>>I'm experiencing really big problems with nfs on 2.5 - and I'm a bit 
>>stuck debugging.
>>
> 
> This makes me a bit suspicious of hardware, probably networking.  It
> really looks like data is getting corrupted between client and server.
> 

Ok, to rule out hardware I mounted the filesystem on the same machine I 
exported it. So no real network hardware is involved only lo.
I ran nhfsstone (which btw is a great tool to reproduce it, just type nhfsrun) 
and got this nearly immediatly:

17:16:32.706611 localhost.3772543495 > localhost.nfs: 148 remove fh Unknown/1 
"012abcdefghijklmn" (DF) [ttl 0]
17:16:32.707305 localhost.3789320711 > localhost.nfs: 116 fsstat fh Unknown/1 
(DF) [ttl 0]
17:16:32.707602 localhost.3806097927 > localhost.nfs: 136 access fh Unknown/1 
000d (DF) [ttl 0]
17:16:32.709633 localhost.3822875143 > localhost.nfs: 116 fsstat fh Unknown/1 
(DF) [ttl 0]
17:16:32.709822 localhost.3839652359 > localhost.nfs: 144 commit fh Unknown/1 
2048 bytes @ 0x000000000 (DF) [ttl 0]
17:16:32.725623 localhost.3806097927 > localhost.nfs: 136 access fh Unknown/1 
000d (DF) [ttl 0]
17:16:32.733637 localhost.nfs > localhost.3772543495: reply ok 120 remove (DF) 
[ttl 0]
17:16:32.735074 localhost.nfs > localhost.3789320711: reply ok 84 fsstat 
tbytes 0x189b948000 fbytes 0x173616c000 abytes 0x15f616c000 (DF) [ttl
  0]
17:16:32.743608 localhost.3806097927 > localhost.nfs: 136 access fh Unknown/1 
000d (DF) [ttl 0]
17:16:32.750618 localhost.3839652359 > localhost.nfs: 144 commit fh Unknown/1 
2048 bytes @ 0x000000000 (DF) [ttl 0]
17:16:32.756246 localhost.nfs > localhost.3302781447: reply ok 144 setattr 
(DF) [ttl 0]
17:16:32.756467 localhost.nfs > localhost.3806097927: reply ok 120 access c 
000d (DF) [ttl 0]
17:16:32.759073 localhost.3856429575 > localhost.nfs: 168 setattr fh Unknown/1 
(DF) [ttl 0]
17:16:32.759632 localhost.nfs > localhost.3822875143: reply ok 84 fsstat 
tbytes 0x189b948000 fbytes 0x1736172000 abytes 0x15f6172000 (DF) [ttl
  0]
17:16:32.759815 localhost.3873206791 > localhost.nfs: 148 lookup fh Unknown/1 
"012abcdefghijklmn" (DF) [ttl 0]
17:16:32.760182 localhost.nfs > localhost.3839652359: reply ok 128 commit (DF) 
[ttl 0]
17:16:32.760574 localhost.3889984007 > localhost.nfs: 148 lookup fh Unknown/1 
"032abcdefghijklmn" (DF) [ttl 0]
17:16:32.760703 localhost.nfs > localhost.3806097927: reply ok 120 access c 
000d (DF) [ttl 0]
17:16:32.760942 localhost.3906761223 > localhost.nfs: 148 lookup fh Unknown/1 
"007abcdefghijklmn" (DF) [ttl 0]
17:16:32.761071 localhost.nfs > localhost.3806097927: reply ok 120 access c 
000d (DF) [ttl 0]
17:16:32.769785 localhost.3873206791 > localhost.nfs: 148 lookup fh Unknown/1 
"012abcdefghijklmn" (DF) [ttl 0]
17:16:32.778592 localhost.3889984007 > localhost.nfs: 148 lookup fh Unknown/1 
"032abcdefghijklmn" (DF) [ttl 0]
17:16:32.797611 localhost.3906761223 > localhost.nfs: 148 lookup fh Unknown/1 
"007abcdefghijklmn" (DF) [ttl 0]
17:16:32.830371 localhost.nfs > localhost.3839652359: reply ok 128 commit (DF) 
[ttl 0]
17:16:32.831099 localhost.nfs > localhost.3856429575: reply ok 36 setattr 
ERROR: Stale NFS file handle (DF) [ttl 0]
17:16:32.831728 localhost.nfs > localhost.3873206791: reply ok 32 lookup 
ERROR: Stale NFS file handle (DF) [ttl 0]
17:16:32.832699 localhost.nfs > localhost.3889984007: reply ok 32 lookup 
ERROR: Stale NFS file handle (DF) [ttl 0]
17:16:32.832862 localhost.3923538439 > localhost.nfs: 132 getattr fh Unknown/1 
(DF) [ttl 0]
17:16:32.833612 localhost.nfs > localhost.3906761223: reply ok 32 lookup 
ERROR: Stale NFS file handle (DF) [ttl 0]
17:16:32.834058 localhost.nfs > localhost.3873206791: reply ok 32 lookup 
ERROR: Stale NFS file handle (DF) [ttl 0]
17:16:32.834416 localhost.3940315655 > localhost.nfs: 164 setattr fh Unknown/1 
(DF) [ttl 0]
17:16:32.834940 localhost.nfs > localhost.3889984007: reply ok 32 lookup 
ERROR: Stale NFS file handle (DF) [ttl 0]
17:16:32.835896 localhost.nfs > localhost.3906761223: reply ok 236 lookup fh 
Unknown/1 (DF) [ttl 0]
17:16:32.836910 localhost.nfs > localhost.3923538439: reply ok 112 getattr REG 
100666 ids 1000/1000 sz 0x000000000  (DF) [ttl 0]
17:16:32.837481 localhost.nfs > localhost.3940315655: reply ok 144 setattr 
(DF) [ttl 0]
17:16:32.841279 localhost.3957092871 > localhost.nfs: 132 getattr fh Unknown/1 
(DF) [ttl 0]
17:16:32.843429 localhost.nfs > localhost.3957092871: reply ok 112 getattr REG 
100666 ids 1000/1000 sz 0x000000000  (DF) [ttl 0]
17:16:32.844561 localhost.3973870087 > localhost.nfs: 132 getattr fh Unknown/1 
(DF) [ttl 0]
17:16:32.844918 localhost.3990647303 > localhost.nfs: 148 lookup fh Unknown/1 
"012abcdefghijklmn" (DF) [ttl 0]

I'll try to reproduce this on my other (UP) machines.

Thanks,

Jan

-- 
Linux rubicon 2.6.0-test1-jd2 #1 SMP Mon Jul 14 17:37:41 CEST 2003 i686

