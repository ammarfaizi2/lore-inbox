Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264559AbTFEKcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 06:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbTFEKcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 06:32:41 -0400
Received: from conure.mail.pas.earthlink.net ([207.217.120.54]:8627 "EHLO
	conure.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264559AbTFEKch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 06:32:37 -0400
Date: Thu, 5 Jun 2003 06:47:04 -0400
To: akpm@digeo.com, piggin@cyberone.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] AIM7 fserver regressed in 2.5.70*
Message-ID: <20030605104704.GA14450@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jun 2003 20:35:09 -0700 Andrew Morton wrote;
> I'd assume that the improvements would be wholly due to the
> IO controller changes?  Are you saying that there is something
> else involved?

I don't know.  The IO controller changes could be for redundancy,
or for performance.  It may be the kernel too.  I mention 
the controller changes because it's a real hardware difference.

On Thu, 05 Jun 2003 15:00:22 +1000 Nick Piggin wrote:
> I don't know what sort of disk IO fserver does, but it
> could be the same problem.

AIM7 dbase (improved in 2.5.70*) is about 11% synchronous IO, 
AIM7 fserver is about 2.5% synchronous IO.  
AIM7 dbase is about 15% regular IO, fserver is 30% regular IO.
AIM7 fserver has the additional creat-clo, dir_rtns_1 loads.
AIM7 fserver may be more seeky than the dbase load.

dbase workload:
load                    percentage of workload
add_int                 3.636
add_long                3.636
add_short               3.636
disk_rd                 7.273
disk_rr                 7.273
div_int                 1.818
div_long                1.818
div_short               1.818
jmp_test                1.818
mem_rtns_1              7.273
mem_rtns_2              7.273
mul_int                 1.818
mul_long                1.818
mul_short               1.818
page_test               7.273
ram_copy                3.636
shared_memory           7.273
sieve                   5.455
sort_rtns_1             5.455
stream_pipe             1.818
string_rtns             5.455
sync_disk_rw            5.455
sync_disk_update        5.455

fserver workload
load                    percentage of workload
add_int                 3.361
add_long                3.361
add_short               3.361
creat-clo               3.361
dir_rtns_1              3.361
disk_cp                 5.042
disk_rd                 5.042
disk_rr                 5.042
disk_rw                 5.042
disk_src                5.042
disk_wrt                5.042
div_int                 1.681
div_long                1.681
div_short               1.681
jmp_test                1.681
link_test               3.361
mem_rtns_1              6.723
mem_rtns_2              1.681
misc_rtns_1             3.361
mul_int                 1.681
mul_long                1.681
mul_short               1.681
ram_copy                3.361
signal_test             1.681
sort_rtns_1             5.042
string_rtns             5.042
sync_disk_cp            0.840
sync_disk_rw            0.840
sync_disk_wrt           0.840
tcp_test                1.681
udp_test                6.723




> If you could share the jobfile and means-to-reproduce I can
> take a look, thanks.

The underlying filesystem was ext2.


This is the AIM7 fserver workload:
# @(#) workfile.fserver:1.3 1/22/96 00:00:00
# Fileserver Mix
FILESIZE: 10M
POOLSIZE: 20M
20  add_int
20  add_long
20  add_short
20  creat-clo
20  dir_rtns_1
30  disk_cp
30  disk_rd
30  disk_rr
30  disk_rw
30  disk_src
30  disk_wrt
10  div_int
10  div_long
10  div_short
10  jmp_test
20  link_test
40  mem_rtns_1
10  mem_rtns_2
20  misc_rtns_1
10  mul_int
10  mul_long
10  mul_short
20  ram_copy
10  signal_test
30  sort_rtns_1
30  string_rtns
5   sync_disk_cp
5   sync_disk_rw
5   sync_disk_wrt
10  tcp_test
40  udp_test


The script to run AIM7 looks like this:

#!/bin/bash
# Run fserver once with load 4-32 increment by 4
export input=input.fserver
cat >$input<<EOF
$(hostname)
$(uname -r)-4xP3/3.75GB/SCSI-raid5
1
4
2
32
4
EOF



for n in fserver
do
        echo "AIM7 $w workload"
        cp -p workfile.${w} workfile
        # suite7.ss is appended to by default.
        # zero it out before run
        >suite7.ss
        # -N newtonian adapter for crossover
        # -t normal timing adapter
        # -nl no log
        # multitask -N -nl < $input
        SECONDS=0
        multitask -t < input.${w}
        echo "AIM7 $w completed in $SECONDS seconds"
        cp -p suite7.ss aimresults/suite7-${w}-$(uname -r).ss
done


iozone writes for a 64 k file has a small regression in 2.5.70.
rewrite, read, reread are improved in 2.5.70.

              KB  reclen   write rewrite    read    reread
2.5.70        64       4  227773  504003   695900   876083
2.5.70        64       8  309248  556588   810228   914439
2.5.70        64      16  321593  587073   790141   864828
2.5.70        64      32  304694  604016   820049   876206
2.5.70        64      64  239686  537800   842702   941127

              KB  reclen   write rewrite    read    reread
2.5.69-bk1    64       4  292251  488642   659659   820706
2.5.69-bk1    64       8  316922  547154   810303   913709
2.5.69-bk1    64      16  328129  586978   770969   877370
2.5.69-bk1    64      32  316906  621315   809981   941515
2.5.69-bk1    64      64  287051  639902   852688   970454


For a 5 MB file, iozone write regression is smaller.

                KB    reclen   write rewrite    read    reread
2.5.70        524288       4  153271  236749   311157   320316
2.5.70        524288       8  174955  241503   326604   336004
2.5.70        524288      16  180028  242359   342079   352546
2.5.70        524288      32  176625  235474   350006   360833
2.5.70        524288      64  165770  215484   354577   365812
2.5.70        524288     128  152281  191098   357021   368434
2.5.70        524288     256  141154  173406   353768   365583
2.5.70        524288     512  137654  168346   294428   302423
2.5.70        524288    1024  136510  167359   229127   233676
2.5.70        524288    2048  136923  167848   187121   190085
2.5.70        524288    4096  136880  167633   175851   178419
2.5.70        524288    8192  136938  167755   174985   177523
2.5.70        524288   16384  136868  167449   174699   177208


                KB    reclen   write rewrite    read    reread
2.5.69-bk1    524288       4  162156  229090   301785   310414
2.5.69-bk1    524288       8  172918  236818   321115   330003
2.5.69-bk1    524288      16  175961  238366   337755   348203
2.5.69-bk1    524288      32  172919  229970   346889   357655
2.5.69-bk1    524288      64  163741  211673   351416   362329
2.5.69-bk1    524288     128  150270  188487   354342   365391
2.5.69-bk1    524288     256  138487  170444   354947   366019
2.5.69-bk1    524288     512  136009  166210   288743   296204
2.5.69-bk1    524288    1024  134791  164132   222318   226508
2.5.69-bk1    524288    2048  134851  163984   184880   187753
2.5.69-bk1    524288    4096  134929  164422   173763   176235
2.5.69-bk1    524288    8192  134810  164287   173071   175598
2.5.69-bk1    524288   16384  134854  164087   173027   175449



-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

