Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbVIJCXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbVIJCXz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 22:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbVIJCXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 22:23:55 -0400
Received: from ppp59-167.lns1.cbr1.internode.on.net ([59.167.59.167]:28947
	"EHLO triton.bird.org") by vger.kernel.org with ESMTP
	id S932601AbVIJCXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 22:23:54 -0400
Message-ID: <432243AA.4000508@acquerra.com.au>
Date: Sat, 10 Sep 2005 12:23:38 +1000
From: Anthony Wesley <awesley@acquerra.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nate.diller@gmail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.13 buffer strangeness
References: <432151B0.7030603@acquerra.com.au>	 <EXCHG2003Zi71mrvoGd00000659@EXCHG2003.microtech-ks.com>	 <5c49b0ed05090914394dba42bf@mail.gmail.com>	 <432225E0.9030606@acquerra.com.au>	 <5c49b0ed0509091735436260bb@mail.gmail.com>	 <432231B7.2060200@acquerra.com.au> <5c49b0ed0509091847135834c0@mail.gmail.com>
In-Reply-To: <5c49b0ed0509091847135834c0@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------030809020601070605040806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030809020601070605040806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nate, this test was done with the cfq scheduler, but I've tried them 
all, and they didn't seem to make any real difference. Let
me know if you want me to re-run this with one of the other schedulers. 
The default scheduler is anticipatory, and that's where
the problem first showed up.

Attached is the output of "vmstat -S K 1". I started the capture a 
couple of seconds after starting this trace and stopped it after 2 minutes.

If I'm interpreting it correctly, this shows a disk throughput averaging 
about 15-16MBytes/sec.

I saw the video write speed sustain 25Mbytes/sec for about 75 seconds 
and then it dropped.

dirty_background_ratio is set to 1
dirty_ratio is set to 95


Assuming that these numbers are ok, that indicates a deficit of about 
10MBytes/sec between my video in and disk out, so
for 1.3Gb of ram as buffer I should see about 130 seconds at full speed 
before it drops. Instead I see this happen after
about 75 seconds.

Thanks again,

Anthony

Nate Diller wrote:

>On 9/9/05, Anthony Wesley <awesley@acquerra.com.au> wrote:
>  
>
>>Okay, just tested a couple of things, here's what I see...
>>
>>I tested the write speed to the usb2 hard disk and got 21MBytes/sec. It's a
>>laptop 
>>hard drive, only 5400rpm so this is not surprising.
>>
>>I did this test with my video capture app running, but just displaying data
>>and not writing,
>>
>>I have another laptop usb2 hard drive here which I just tested and got
>>17MBytes/sec - it's
>>a 4200rpm drive so again not surprising numbers.
>>
>>The video data is written as individual frames, so the efficiency is a bit
>>below the raw throughput,
>>but my tests were transferring 1.5Gb of data as raw frames - exactly the
>>same way that Coriander would
>>write its data.
>>
>>I'd bet a large sum of money that these hard disk figures are correct to
>>within a few percent.
>>
>>Also, when I am actually capturing I have timed by stopwatch how long the
>>disk activity light
>>is on, and reached about the same conclusion.
>>
>>Working the problem from the other direction, the only way to explain the
>>early throttling that
>>I see would be if *almost no data* is being written to the disk, and this is
>>plainly not the case. Even if
>>the disk were running at a greatly reduced rate of (say) 10MBytes/sec I
>>would still see 86 seconds
>>of buffering before the throttle kicks in, and so far I have managed only to
>>get to about 65 or 70.
>>
>>regards, Anthony
>>
>>    
>>
>i need a vmstat trace ('vmstat 1 > logfile', then run the test, then
>^c)  before i can comment further.  also, your filesystem and
>scheduler would be interesting to know.  you can find out the
>scheduler with 'cat /sys/block/[drive]/queue/scheduler'.
>
>NATE
>
>  
>
>>Nate Diller wrote:
>>
>>
>>    
>>
>>>>Setting dirty_ratio and dirty_background_ratio to 90/10 puts me back at
>>>>around 50 seconds, i.e. where I started.
>>>>
>>>>        
>>>>
>>>this setting should do the trick, so there's something going on here
>>>that isn't expected.
>>>
>>>
>>>      
>>>
>>>>So as far as I can see there is *no way* to get 3 minutes worth of
>>>>        
>>>>
>>buffering
>>    
>>
>>>>by adjusting these parameters.
>>>>
>>>>Just to remind everyone - I have video data coming in at 25MBytes/sec and
>>>>        
>>>>
>>I
>>    
>>
>>>>am writing it out to a usb2 hard disk that can sustain 17MBytes/sec. I
>>>>        
>>>>
>>want
>>    
>>
>>>>my video capture to run at full speed as long as possible by having the
>>>>7MBytes/sec deficit slowly eat up the available RAM in the machine. I
>>>>        
>>>>
>>have
>>    
>>
>>>>1.5Gb of RAM, 1.3Gb available for buffers, so this should take 3 minutes
>>>>        
>>>>
>>to
>>    
>>
>>>>consume at 7MBytes/sec.
>>>>
>>>>So, I've tried all the combinations on dirty_ratio and
>>>>dirty_background_ratio and they *do not help*.
>>>>
>>>>        
>>>>
>>>dirty_ratio is the tubable you want, if it's not working correctly,
>>>either there's a problem with your setup, or a bug
>>>
>>>
>>>      
>>>
>>>>Can anyone suggest something else that I might try? The goal is to have
>>>>25MBytes/sec streaming video for about 3 minutes. 
>>>>
>>>>        
>>>>
>>>how sure are you that you're getting 17MB/s during this test?  can you
>>>run "vmstat 1" while this is running to verify?  which FS and
>>>scheduler?
>>>
>>>just for interest, what's the raw disk bandwidth (use hdparm, or run a
>>>dd, or something)?  it would obviously be much better to sustain
>>>25MB/s to disk
>>>
>>>
>>>      
>>>
>>>>Or is this simply not possible with the current kernel I/O setup? Do I
>>>>        
>>>>
>>have
>>    
>>
>>>>to do something elaborate myself, like build a big RAM buffer, mount the
>>>>disk synchronous, do the buffering myself in userland...??
>>>>
>>>>        
>>>>
>>>this should be possible, although it could be considered a bit risky WRT
>>>      
>>>
>>OOM.
>>    
>>
>>>NATE
>>>      
>>>
>>-- 
>>Anthony Wesley
>>Director and IT/Network Consultant
>>Smart Networks Pty Ltd
>>Acquerra Pty Ltd
>>
>>Anthony.Wesley@acquerra.com.au
>>Phone: (02) 62595404 or 0419409836
>>
>>    
>>
>
>  
>


--------------030809020601070605040806
Content-Type: text/plain;
 name="logfile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="logfile"

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 4  0    144 1314396  29440  67444    0    0    16   407  290    17 30 30 38  2
 0  0    144 1314396  29440  67436    0    0     0     0  405  1062 26  4 70  0
 0  0    144 1314388  29440  67436    0    0     0     0  721  1397 27  4 69  0
 0  0    144 1314388  29440  67436    0    0     0     0  732  1554 30  3 67  0
 0  0    144 1300624  29548  80220    0    0    24     0  426  1207 26 13 40 21
 0  0    144 1275444  29744 105148    0    0     8 20752  933  2262 31 21 49  0
 3  2    144 1250396  29912 130076    0    0     4 15286 1004  2357 31 22  0 47
 0  3    144 1225224  30076 155004    0    0     0 14008 1030  2439 28 22  0 49
 1  3    144 1200788  30244 179324    0    0     8 13772 1049  2526 29 21  0 50
 0  3    144 1175616  30412 204256    0    0     4 15964 1102  2696 20 18  0 62
 0  5    144 1150552  30584 229184    0    0     0 15980 1100  2724 21 17  0 62
 2  1    144 1125836  30756 253504    0    0    12 14672 1106  2715 20 19  0 62
 0  7    144 1100788  30920 278432    0    0     0 15380 1079  2665 19 18  0 63
 2  6    144 1075616  31092 303360    0    0     8 15440 1112  2731 21 18  0 61
 0  8    144 1049948  31264 328900    0    0     4 14832 1063  2685 18 22  0 60
 2  8    144 1024776  31436 353828    0    0     0 15620 1117  2815 19 17  0 64
 0  2    144 1001588  31600 376932    0    0    12 15828 1093  2677 18 20  0 62
 2  6    144 976432  31764 401860    0    0     0 14724 1085  2604 21 19  0 60
 0  5    144 950764  31932 427396    0    0     0 15844 1093  2734 21 18  0 61
 1  4    144 924964  32112 452936    0    0    12 15028 1044  2583 22 18  0 61
 0  4    144 899792  32292 477864    0    0     8 14788 1071  2670 18 18  0 64
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  2    144 880200  32432 497320    0    0    12 15228 1103  2676 18 18  0 64
 0  5    144 855152  32596 522248    0    0     0 14604 1053  2598 19 20  0 61
 0  6    144 829980  32760 547176    0    0     0 16004 1124  2741 21 17  0 63
 0  6    144 804188  32932 572716    0    0     4 15896 1081  2704 19 18  0 63
 1  4    144 779116  33112 597644    0    0     8 15020 1094  2722 19 19  0 62
 0 11    144 755672  33272 620840    0    0     4 15876 1076  2750 17 20  0 63
 1 11    144 733104  33416 643244    0    0     0 16220 1110  2795 19 16  0 65
 0  2    144 708056  33580 668172    0    0     0 15836 1074  2668 20 18  0 63
 0  8    144 682884  33744 693104    0    0     0 15952 1115  2758 20 16  0 64
 1  4    144 657216  33920 718640    0    0     0 15908 1115  2765 18 18  0 64
 0  6    144 632664  34088 742960    0    0     8 14928 1080  2663 21 17  0 62
 0  3    144 609972  34252 765456    0    0    16 14888 1055  2606 20 19  0 61
 1  2    144 584320  34432 790992    0    0    12 15044 1094  2709 18 20  0 62
 0  1    144 559768  34600 815316    0    0     8 14948 1069  2634 20 19  0 61
 0  6    144 534596  34772 840244    0    0     0 16188 1092  2645 20 20  0 60
 1  5    144 508928  34944 865780    0    0     4 14832 1063  2625 21 20  0 60
 0  2    144 489972  35080 884628    0    0    12 13700 1057  2515 21 18  0 61
 1  3    144 464800  35256 909556    0    0    12 17008 1101  2728 23 15  0 62
 1  1    144 439008  35432 935096    0    0     8 13692 1109  2708 22 18  0 60
 0  3    144 413960  35604 960024    0    0     0 17072 1096  2676 19 20  0 61
 1  5    144 388804  35776 984952    0    0     8 14484 1082  2640 22 20  0 59
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  2    144 366112  35936 1007448    0    0    12 15324 1078  2626 20 21  0 59
 2  2    144 341064  36108 1032376    0    0     8 14544 1060  2551 22 18  0 60
 1  3    144 315272  36276 1057912    0    0     0 15836 1057  2639 22 20  0 59
 0  5    144 290100  36448 1082844    0    0     0 15420 1130  2764 21 19  0 60
 1  5    144 264060  36616 1108384    0    0     0 14836 1078  2648 23 18  0 59
 0  5    144 238640  36780 1133312    0    0     0 16124 1109  2725 20 20  0 60
 2  4    144 215544  36932 1155808    0    0     4 14768 1058  2613 21 18  0 61
 0  9    144 189504  37104 1181344    0    0     4 14064 1125  2823 21 21  0 58
 1  6    144 164084  37276 1206276    0    0     0 16040 1071  2728 19 20  0 61
 1  9    144 138664  37440 1231204    0    0     0 16020 1136  2822 20 20  0 60
 1  1    144 113120  37608 1256132    0    0     4 14604 1070  2734 18 20  0 62
 2  6    144  89560  37764 1279236    0    0     4 14896 1081  2612 17 22  0 61
 0  9    144  64140  37928 1304164    0    0     0 17184 1092  2818 18 21  0 61
 0  9    144  38572  38100 1329096    0    0     0 15784 1126  2833 22 19  0 59
 2  3    144  32628  27604 1345272    0    0     0 14780 1101  2675 21 23  0 56
 1  9    144  32628  16548 1356284    0    0     0 16024 1100  2740 21 22  0 57
 3  9    144  32628  16712 1356028    0    0     4 14852 1069  2729 19 19  0 62
 0  4    144  32628  16880 1355844    0    0     8 15044 1082  2692 19 21  0 60
 1  9    144  32132  17052 1356200    0    0     0 16100 1090  2776 21 20  0 59
 2  6    144  32504  17216 1355784    0    0     0 14712 1097  2719 20 22  0 58
 0  9    144  32628  17384 1355368    0    0     4 14908 1037  2690 22 20  0 58
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  5    144  32380  17536 1355528    0    0    12 13812 1060  2593 24 17  0 59
 0  9    144  32752  17704 1354952    0    0     0 14932 1063  2654 22 23  0 55
 0  9    144  32256  17880 1355244    0    0     0  7228 1113  2881 22 21  0 57
 0  2    144  32008  18044 1355388    0    0     8 14892 1090  2761 23 22  0 56
 1  3    144  32008  18220 1355052    0    0     8 13996 1050  2585 20 22  0 58
 1  9    144  32504  18360 1354524    0    0     8 13252 1021  2530 19 19  0 62
 1  8    144  32876  18516 1353884    0    0     0 15956 1120  2771 22 18  0 60
 1  6    144  32804  18700 1353760    0    0     8 14120 1079  2738 23 22  0 56
 0  8    144  32628  18868 1353748    0    0     4 12808 1221  3006 21 22  0 57
 1  8    144  33052  19024 1353080    0    0     0  6320  989  2631 21 21  0 58
 0  8    144  32756  19192 1353224    0    0     0  6308 1099  2833 21 22  0 57
 0  2    144  32628  19300 1353296    0    0    12 10540 1019  2564 20 18  0 62
 2  8    144  31992  19428 1353644    0    0     4 20276  973  2448 20 19  0 61
 0  8    144  32256  19520 1353376    0    0     4  9816 1103  2694 19 20  0 62
 1  4    144  32028  19600 1353384    0    0     4 18116 1114  2643 19 16  0 65
 1  5    144  33000  19740 1352244    0    0     4 12424 1055  2593 19 21  0 60
 0  8    144  33076  19848 1352068    0    0     4 22344 1111  2682 18 17  0 65
 2  3    144  32480  19964 1352520    0    0    12  9428 1078  2709 18 17  0 65
 1  8    144  32224  20080 1352584    0    0     4 17816 1071  2622 17 21  0 62
 0 11    144  32224  20184 1352604    0    0     4 14052 1054  2643 19 17  0 64
 1 13    144  32052  20292 1352540    0    0     4 15940 1110  2752 21 17  0 63
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1 13    144  32596  20384 1351948    0    0     4 14792 1041  2631 21 14  0 65
 2 14    144  32720  20456 1351652    0    0     4 18476 1077  2676 19 14  0 67
 0  5    144  32720  20604 1351568    0    0     0 13072 1078  2692 21 18  0 61
 0 10    144  32720  20724 1351336    0    0     4 19720 1106  2690 20 18  0 62
 1 13    144  31976  20816 1352016    0    0     4 11964 1065  2639 19 15  0 66
 0 14    144  32596  20876 1351476    0    0     8 19012 1092  2702 19 17  0 65
 1 14    144  31976  21012 1351784    0    0     8 13204 1084  2805 20 19  0 61
 0  2    144  31976  21100 1351776    0    0     0 14896 1078  2706 20 16  0 64
 0  9    144  32476  21240 1351048    0    0     4 18760 1069  2603 20 23  0 58
 1 13    144  32100  21344 1351392    0    0     0 14720 1126  2774 20 17  0 63
 0 14    144  32596  21460 1350860    0    0     4 18992 1095  2735 22 18  0 60
 0 14    144  33096  21576 1350072    0    0     0 14660 1118  2860 22 17  0 61
 1 13    144  31976  21656 1351056    0    0     4 13764 1074  2674 20 18  0 63
 0  4    144  32724  21788 1350176    0    0     0 19236 1089  2710 20 20  0 60
 1  9    144  32720  21888 1350128    0    0     4 12440 1079  2604 20 20  0 61
 0 14    144  32348  21996 1350320    0    0     8 24964 1111  2753 21 15  0 64
 0 13    144  32704  22112 1349948    0    0     4  7960 1088  2791 17 22  0 61
 2 14    144  32208  22196 1350360    0    0     0 22596 1136  2790 20 21  0 60
 0  2    144  32456  22328 1349764    0    0     4  9816 1049  2681 21 19  0 60
 0  8    144  32084  22448 1350124    0    0     0 17024 1105  2668 19 21  0 60
 2 13    144  32084  22544 1350000    0    0     0 19064 1102  2740 18 20  0 62
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  4    144  32828  22668 1349180    0    0     8 18948 1106  2710 18 17  0 65
 1  7    144  31960  22768 1349892    0    0     8 10664 1068  2580 18 21  0 62
 1 12    144  32084  22892 1349488    0    0     0 18428 1118  2753 21 18  0 61
 0 13    144  31960  22996 1349656    0    0     4 14540 1082  2713 19 17  0 64
 0 14    144  32084  23088 1349364    0    0     4 23028 1089  2751 17 17  0 66
 1 13    144  31960  23228 1349220    0    0     0  8720 1103  2785 19 19  0 62
 0 13    144  32580  23320 1348772    0    0     4 14816 1053  2626 20 17  0 64
 0 13    144  32208  23404 1348964    0    0     4 15972 1068  2628 18 16  0 66
 1 14    144  32580  23380 1348432    0    0     0 25216 1106  2808 20 19  0 61
 0 13    144  32704  23144 1348680    0    0     4  7140 1099  2742 17 17  0 66
 0 13    144  32580  22776 1349172    0    0     4 22132 1128  2822 24 15  0 62
 2 14    144  32332  22192 1349820    0    0     0 14152 1062  2691 18 21  0 61
 0 13    144  32208  21628 1350684    0    0     0 15448 1121  2750 18 18  0 64
 1  5    144  31960  20996 1351536    0    0     4 18192 1038  2541 21 21  0 58
 0  9    144  32208  21024 1351088    0    0     0 11980 1119  2689 19 19  0 62
 1 13    144  32828  21100 1350576    0    0     0 19696 1095  2783 21 14  0 65
 0 13    144  32084  21160 1351156    0    0     4 18324 1097  2769 22 16  0 62
 1 13    144  32832  21276 1350352    0    0     4 10688 1076  2709 20 18  0 62
 0 13    144  32952  21388 1350604    0    0     4 20564 1124  2843 22 18  0 60
 2  1    144  32952  21392 1350604    0    0     4 14460 1146  2729 17 15  0 68
 0  1    144  32952  21404 1350604    0    0     4 16548 1402  3150 19 12  0 69
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  1    144  32952  21408 1350604    0    0     4 18056 1167  2657 16 14  0 70
 0  1    144  32952  21408 1350604    0    0     0 18548 1189  2675 17 17  0 67
 0  1    144  32952  21412 1350604    0    0     4 14948 1067  2490 17 12  0 71

--------------030809020601070605040806--
