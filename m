Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262490AbSJIX34>; Wed, 9 Oct 2002 19:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262495AbSJIX3z>; Wed, 9 Oct 2002 19:29:55 -0400
Received: from packet.digeo.com ([12.110.80.53]:27546 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262490AbSJIX3v>;
	Wed, 9 Oct 2002 19:29:51 -0400
Message-ID: <3DA4BC7B.EC8D65A3@digeo.com>
Date: Wed, 09 Oct 2002 16:32:11 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mala Anand <manand@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       Bill Hartner <bhartner@us.ibm.com>
Subject: Re: 2.5.40-mm1
References: <OF13BF2DC5.95D8249D-ON87256C4C.00509A83@boulder.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Oct 2002 23:32:11.0013 (UTC) FILETIME=[1716CB50:01C26FEC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mala Anand wrote:
> 
> ...
> P4 Xeon CPU 1.50 GHz 4-way - hyperthreading disabled
> Src is aligned and dst is misaligned as follows:
> 
>  Dst      2.5.40       2.5.40+patch     2.5.40+patch++
> Align    throughout     throughput      throughput
> (bytes)   KB/sec          KB/sec        KB/sec
>   0       1360071         1314783        912359
>   1       323674           340447
>   2       329202           336425
>   4       512955           693170
>   8       523223           615097        506641
>  12       517184           558701        553700
>  16       966598           872080        932736
>  32       846937           838514        845178

Note the tremendous slowdown which the P4 suffers when you're not
cacheline aligned.  Even 32-byte-aligned is down a lot.

 
> I see too much variance in the test results so I ran
> each test 3 times. I tried increasing the iterations
> but it did not reduce the variance.
> 
> Dst is aligned and src is misaligned as follows:
> 
>  Dst      2.5.40       2.5.40+patch
> Align    throughout     throughput
> (bytes)   KB/sec          KB/sec
>   0       1275372       1029815
>   1        529907        511815
>   2        534811        530850
>   4        643196        627013
>   8        568000        626676
>  12        574468        658793
>  16        631707        635979
>  32        741485        592938

This differs a little from my P4 testing - the rep;movsl approach
seemed OK for 8,16,32 alignment.

But still, that's something we can tune later.
 
> 
> However I have seen using floating point registers instead of integer
> registers on Pentium IV improves performance to a greater extent on
> some alignments. I need to do more testing and then I will create a
> patch for pentium IV.

I believe there are "issues" using those registers in-kernel. Related
to the need to save/restore them, or errata; not too sure about that.
