Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318064AbSGLXX3>; Fri, 12 Jul 2002 19:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318065AbSGLXX2>; Fri, 12 Jul 2002 19:23:28 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:46521 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S318064AbSGLXX0>; Fri, 12 Jul 2002 19:23:26 -0400
Message-ID: <3D2F6464.60908@us.ibm.com>
Date: Fri, 12 Jul 2002 18:21:08 -0500
From: Andrew Theurer <habanero@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-lvm@sistina.com
Subject: Re: [Announce] device-mapper beta3 (fast snapshots)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >Beta3 of device-mapper is now available at:
 >
 >ftp://ftp.sistina.com/pub/LVM2/device-mapper/
 >device-mapper-beta3.0.tgz
 >
 >The accompanying LVM2 toolset:
 >
 >  ftp://ftp.sistina.com/pub/LVM2/tools/LVM2.0-beta3.0.tgz
 >
 >The main addition for this release is high performance persistent
 >snapshots, see >http://people.sistina.com/~thornber/snap_performance.html
 >for a comparison with LVM1 and EVMS.

Thanks for the results.  I tried the same thing, but with the latest 
release (beta 4) and I am not observing the same behavior.  Your results 
show very little difference in performance when using different chunk 
sizes for snapshots, but I observed a range of 10 to 24 seconds for this 
same test on beta4 (I have also included EVMS 1.1 pre4):

#### dbench with 2 clients ####
#### mem=32MB ####

               EVMS 1.1 pre4                  LVM2 Beta4.1
  chunk   ------------------------     -----------------------
   size   1st    2nd    3rd    Ave     Ave    1st    2nd   3rd
  -----   ---    ---    ---    ---     ---    ---    ---   ---
     8k   11      9      9     9.66    24.0    23     24    25
    16k    9      9      8     8.66    17.6    18     17    18
    32k    8      9      7     8.00    12.6    13     12    13
    64k    9      8      9     8.66    11.3    12     11    11
   128k    9      8      9     8.66    10.0    10      9    11
   256k    8      9      9     8.66    10.0    10     10    10
   512k    8      9      9     8.66    10.0    10     10    10
   none    7      7      6     6.66    6.66     8      6     6

results in seconds
none = baseline, no snapshot

As you can see, the smaller chunk sizes did make a difference in the 
times.  The EVMS results also now have the async option, and the results 
are generally much more consistent and faster in all cases regardless of 
chunk size.  The baselines are the same, as I expected, since we are 
disk bound and the non-snapshot IO code paths are not that much 
different.  I believe the major difference between the snapshot 
performance is the disk latency differences.  I suspect EVMS drives the 
IO more efficiently so the head movement is minimized.  FYI, this test 
used two disks, one for the original volume, and one for the snapshot.

I also wanted to run a test that concentrated on only IO, so I scrapped 
dbench in favor of plain old dd.  First I ran with all my memory:

#### time dd if=/dev/zero of=/dev/<vol> bs=4k count=25000 ####
#### mem=768MB ####

                EVMS 1.1 pre4                 LVM2 Beta4.1
  chunk   ------------------------     -----------------------
   size   1st    2nd    3rd    Ave     Ave    1st    2nd   3rd
  -----   ---    ---    ---    ---     ---    ---    ---   ---
     8k 10.773 10.271 10.752  10.599  28.076 27.581 28.065 28.582
    16k  7.621  7.785  7.557   7.684  14.926 14.672 14.856 15.251
    32k  7.676  7.747  7.537   7.653  11.947 12.082 12.026 11.734
    64k  7.534  7.889  7.873   7.765  11.407 11.548 11.436 11.238
   128k  7.803  7.660  7.511   7.658  11.248 11.216 11.130 11.399
   256k  7.629  7.677  7.631   7.646  11.122 11.256 10.973 11.137
   512k  7.677  7.593  7.920   7.730  10.813 11.104 10.736 10.601
   none  4.734  4.956  4.751   4.814   4.887  4.755  4.974  4.933

results in seconds
none = baseline, no snapshot

As you can see, again, the small chunk sizes really affected performance 
of the LVM2 snapshots.  I can tell you this extra time is not in kernel, 
we are just waiting longer for the disk to complete its transactions.  I 
am really curious why you did not experience this behaviour in your tests.

Considering what is going on during a snapshot, one read (from one disk) 
and two parallel writes (to different disks) The EVMS results show the 
the best you could possibly achieve, compared to the performance of the 
plain old write test (assuming that a disk read is a little fater than a 
disk write).  The baseline results are what I expected; nearly identical 
times, since we bottleneck on the disk throughput.

 >Please be warned that snapshots will deadlock under load on 2.4.18
 >kernels due to a bug in the VM syste, 2.4.19-pre8 works fine.

That leads me to my next test, the same as above, but with only 32 MB 
memory.  Whatever problem exists, it still may be in 2.4.19-rc1 (only 
for LVM2):

#### time dd if=/dev/zero of=/dev/<vol> bs=4k count=25000 ####
#### mem=32MB ####

                 EVMS 1.1 pre4                LVM2 Beta4.1
    chunk   ------------------------     -----------------------
     size   1st    2nd    3rd    Ave     Ave    1st    2nd   3rd
    -----   ---    ---    ---    ---     ---    ---    ---   ---
       8k  9.290  9.825  9.513 9.543   43.519 42.121 44.918  DNF
      16k  8.540  8.684  9.016 8.747     DNF    DNF    DNF   DNF
      32k  8.607  8.512  8.339 8.486   20.216   DNF    DNF  20.216
      64k  8.202  8.436  8.137 8.258   14.355 13.972 14.737  DNF
     128k  8.269  7.772  8.505 8.182   11.915 11.828   DNF  12.002
     256k  8.667  8.022  8.236 8.308   15.212 10.952 23.319 11.366
     512k  8.249  7.961  8.602 8.271   12.480 13.996   DNF  10.964
     none  4.046  4.215  4.464 4.242    4.294  4.318  4.094  4.469

results in seconds
none = no snapshot
DNF = Did Not Finish (system was unresponsive after 15 minutes)

The performance did drop off again for small chunksizes on LVM2, but 
sometimes it was very bad.  EVMS had incrementally slower performance 
overall, and IMO acceptable considering the memory available.  On the 
"DNF", I could not get the system to respond to anything; most likely 
the deadlock issue you moentioned above.

If you have any ideas why our tests results differ, please let me know. 
    I can send you my test scripts if you like.  Below are the system specs:

System: 800 Mhz PIII, 768 MB RAM, 3 x 18 GB 15k rpm SCSI
Linux: 2.4.19-rc1 with LVM2 Beta 4.1 and EVMS 1.1 pre4

Also, if anyone has any ideas how to test the "other half" of snapshots, 
reading the snapshot while writing to the original, please send me your 
ideas.  Perhaps a simulated tape backup on the snapshot while something 
is thrashing the original, and of course something we can measure.

Regards,

Andrew Theurer

