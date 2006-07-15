Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161023AbWGOU26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbWGOU26 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 16:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161027AbWGOU26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 16:28:58 -0400
Received: from [212.76.85.233] ([212.76.85.233]:51464 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1161023AbWGOU26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 16:28:58 -0400
From: Al Boldi <a1426z@gawab.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCHSET] 0/15 IO scheduler improvements
Date: Sat, 15 Jul 2006 23:27:56 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200607132350.47388.a1426z@gawab.com> <200607151535.04042.a1426z@gawab.com> <20060715174559.GF22724@suse.de>
In-Reply-To: <20060715174559.GF22724@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200607152327.56763.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Sat, Jul 15 2006, Al Boldi wrote:
> > Jens Axboe wrote:
> > > On Fri, Jul 14 2006, Al Boldi wrote:
> > > > Jens Axboe wrote:
> > > > > On Thu, Jul 13 2006, Al Boldi wrote:
> > > > > > Jens Axboe wrote:
> > > > > > > This is a continuation of the patches posted yesterday, I
> > > > > > > continued to build on them. The patch series does:
> > > > > > >
> > > > > > > - Move the hash backmerging into the elevator core.
> > > > > > > - Move the rbtree handling into the elevator core.
> > > > > > > - Abstract the FIFO handling into the elevator core.
> > > > > > > - Kill the io scheduler private requests, that require
> > > > > > > allocation/free for each request passed through the system.
> > > > > > >
> > > > > > > The result is a faster elevator core (and faster IO
> > > > > > > schedulers), with a nice net reduction of kernel text and code
> > > > > > > as well.
> > > > > >
> > > > > > Thanks!
> > > > > >
> > > > > > Your efforts are much appreciated, as the current situation is a
> > > > > > bit awkward.
> > > > >
> > > > > It's a good step forward, at least.
> > > > >
> > > > > > > If you have time, please give this patch series a test spin
> > > > > > > just to verify that everything still works for you. Thanks!
> > > > > >
> > > > > > Do you have a combo-patch against 2.6.17?
> > > > >
> > > > > Not really, but git let me generate one pretty easily. It has a
> > > > > few select changes outside of the patchset as well, but should be
> > > > > ok. It's not tested though, should work but the rbtree changes
> > > > > needed to be done additionally. If it boots, it should work :-)
> > > >
> > > > patch applies ok
> > > > compiles ok
> > > > panics on boot at elv_rb_del
> > > > patch -R succeeds with lot's of hunks
> > >
> > > So I most likely botched the rbtree conversion, sorry about that. Oh,
> > > I think it's a silly reverted condition, can you try this one?
> >
> > Thanks!
> >
> > patch applies ok
> > compiles ok
> > boots ok
> > patch -R succeeds with lot's of hunks
> >
> > Tried it anyway, and found an improvement only in cfq, where :
> > echo 512 > /sys/block/hda/queue/max_sectors_kb
> > gives full speed for 5-10 sec then drops to half speed
> > other scheds lock into half speed
> > echo 192 > /sys/block/hda/queue/max_sectors_kb
> > gives full speed for all scheds
>
> Not sure what this all means (full speed for what?)

full speed = max HD thruput

> The patchset mainly
> focuses on optimizing the elevator core and schedulers, it wont give a
> speedup unless your storage hardware is so fast that you are becoming
> CPU bound. Since you are applying to 2.6.17, there are some CFQ changes
> that do introduce behavioural changes.
>
> You should download
>
> http://brick.kernel.dk/snaps/blktrace-git-20060706102503.tar.gz
>
> and build+install it, then do:
>
> - blktrace /dev/hda
> - run shortest test that shows the problem
> - ctrl-c blktrace
>
> tar up the hda.* output from blktrace and put it somewhere where I can
> reach it and I'll take a look.

The output is a bit large, so here is a summary:
# echo 192 > /sys/block/hda/queue/max_sectors_kb
# cat /dev/hda > /dev/null &
# blktrace /dev/hda ( doesn't work; outputs zero trace)
# blktrace /dev/hda -w 1 -o - | blkparse -i - > 
/mnt/nfs/10.1/tmp/hdtrace.cfq.192

  3,0    0        1     0.000000000  1200  Q   R 927456 + 8 [cat]
  3,0    0        2     0.000009840  1200  G   R 927456 + 8 [cat]
  3,0    0        3     0.000012910  1200  I   R 927456 + 8 [cat]
  3,0    0        4     0.000017537  1200  Q   R 927464 + 8 [cat]
(alot of the same)
  3,0    0       95     0.000070248  1200  M   R 927824 + 8 [cat]
  3,0    0       96     0.000070932  1200  Q   R 927832 + 8 [cat]
  3,0    0       97     0.000071166  1200  M   R 927832 + 8 [cat]
  3,0    0       98     0.000074233  1200  U   R [cat] 2
  3,0    0       99     0.000130449  1206  C  RB 927072 + 384 [0]
  3,0    0      100     0.000179860  1206  D  RB 927456 + 384 [blktrace]
  3,0    0      101     0.000615062  1200  Q   R 927840 + 8 [cat]
  3,0    0      102     0.000623531  1200  G   R 927840 + 8 [cat]
  3,0    0      103     0.000625642  1200  I   R 927840 + 8 [cat]
  3,0    0      104     0.000630142  1200  Q   R 927848 + 8 [cat]
  3,0    0      105     0.000631079  1200  M   R 927848 + 8 [cat]
  3,0    0      106     0.000632693  1200  Q   R 927856 + 8 [cat]
(alot of the same)
  3,0    0      195     0.000687875  1200  M   R 928208 + 8 [cat]
  3,0    0      196     0.000688709  1200  Q   R 928216 + 8 [cat]
  3,0    0      197     0.000688916  1200  M   R 928216 + 8 [cat]
  3,0    0      198     0.000692628  1200  U   R [cat] 2
  3,0    0      199     0.003454920     0  C  RB 927456 + 384 [0]
  3,0    0      200     0.003497750     0  D  RB 927840 + 384 [swapper]
  3,0    0      201     0.003728434  1200  Q   R 928224 + 8 [cat]
  3,0    0      202     0.003735266  1200  G   R 928224 + 8 [cat]
  3,0    0      203     0.003737399  1200  I   R 928224 + 8 [cat]
  3,0    0      204     0.003741069  1200  Q   R 928232 + 8 [cat]
  3,0    0      205     0.003741640  1200  M   R 928232 + 8 [cat]
  3,0    0      206     0.003743141  1200  Q   R 928240 + 8 [cat]
  3,0    0      207     0.003743349  1200  M   R 928240 + 8 [cat]
  3,0    0      208     0.003744289  1200  Q   R 928248 + 8 [cat]
  3,0    0      209     0.003744512  1200  M   R 928248 + 8 [cat]
  3,0    0      210     0.003746801  1200  Q   R 928256 + 8 [cat]
  3,0    0      211     0.003747006  1200  M   R 928256 + 8 [cat]
  3,0    0      212     0.003747787  1200  Q   R 928264 + 8 [cat]
  3,0    0      213     0.003748011  1200  M   R 928264 + 8 [cat]
  3,0    0      214     0.003748831  1200  Q   R 928272 + 8 [cat]
(alot of the same)
  3,0    0    23893     0.995735914  1200  M   R 1019112 + 8 [cat]
  3,0    0    23894     0.995736546  1200  Q   R 1019120 + 8 [cat]
  3,0    0    23895     0.995736754  1200  M   R 1019120 + 8 [cat]
  3,0    0    23896     0.995737386  1200  Q   R 1019128 + 8 [cat]
  3,0    0    23897     0.995737593  1200  M   R 1019128 + 8 [cat]
  3,0    0    23898     0.995738222  1200  Q   R 1019136 + 8 [cat]
  3,0    0    23899     0.995738433  1200  M   R 1019136 + 8 [cat]
  3,0    0    23900     0.995739224  1200  Q   R 1019144 + 8 [cat]
  3,0    0    23901     0.995739432  1200  M   R 1019144 + 8 [cat]
  3,0    0    23902     0.995740223  1200  Q   R 1019152 + 8 [cat]
  3,0    0    23903     0.995740434  1200  M   R 1019152 + 8 [cat]
  3,0    0    23904     0.995741072  1200  Q   R 1019160 + 8 [cat]
  3,0    0    23905     0.995741280  1200  M   R 1019160 + 8 [cat]
  3,0    0    23906     0.995742116  1200  Q   R 1019168 + 8 [cat]
  3,0    0    23907     0.995742324  1200  M   R 1019168 + 8 [cat]
  3,0    0    23908     0.995742959  1200  Q   R 1019176 + 8 [cat]
  3,0    0    23909     0.995743170  1200  M   R 1019176 + 8 [cat]
  3,0    0    23910     0.995744240  1200  Q   R 1019184 + 8 [cat]
  3,0    0    23911     0.995744447  1200  M   R 1019184 + 8 [cat]
  3,0    0    23912     0.995745268  1200  Q   R 1019192 + 8 [cat]
  3,0    0    23913     0.995745475  1200  M   R 1019192 + 8 [cat]
  3,0    0    23914     0.995746240  1200  Q   R 1019200 + 8 [cat]
  3,0    0    23915     0.995746448  1200  M   R 1019200 + 8 [cat]
  3,0    0    23916     0.995747317  1200  Q   R 1019208 + 8 [cat]
  3,0    0    23917     0.995747524  1200  M   R 1019208 + 8 [cat]
  3,0    0    23918     0.995748280  1200  Q   R 1019216 + 8 [cat]
  3,0    0    23919     0.995748490  1200  M   R 1019216 + 8 [cat]
  3,0    0    23920     0.995749113  1200  Q   R 1019224 + 8 [cat]
  3,0    0    23921     0.995749320  1200  M   R 1019224 + 8 [cat]
  3,0    0    23922     0.995751713  1200  U   R [cat] 2
CPU0 (3,0):
 Reads Queued:      11,472,   90,788KiB	 Writes Queued:           0,        
0KiB
 Read Dispatches:      246,   45,696KiB	 Write Dispatches:        0,        
0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:      246,   45,696KiB	 Writes Completed:        0,        
0KiB
 Read Merges:       11,225        	 Write Merges:            0
 Read depth:             1        	 Write depth:             0
 IO unplugs:           231        	 Timer unplugs:           0

Throughput (R/W): 45,925KiB/s / 0KiB/s
Events (3,0): 23,922 entries
Skips: 0 forward (0 -   0.0%)


# echo 512 > /sys/block/hda/queue/max_sectors_kb
# cat /dev/hda > /dev/null &
# blktrace /dev/hda -w 1 -o - | blkparse -i - > 
/mnt/nfs/10.1/tmp/hdtrace.cfq.512

  3,0    0        1     0.000000000  1221  Q   R 2853984 + 8 [cat]
  3,0    0        2     0.000008174  1221  G   R 2853984 + 8 [cat]
  3,0    0        3     0.000010985  1221  I   R 2853984 + 8 [cat]
  3,0    0        4     0.000014953  1221  Q   R 2853992 + 8 [cat]
  3,0    0        5     0.000016010  1221  M   R 2853992 + 8 [cat]
(alot of the same)
  3,0    0       94     0.000067068  1221  Q   R 2854352 + 8 [cat]
  3,0    0       95     0.000067292  1221  M   R 2854352 + 8 [cat]
  3,0    0       96     0.000068080  1221  Q   R 2854360 + 8 [cat]
  3,0    0       97     0.000068303  1221  M   R 2854360 + 8 [cat]
  3,0    0       98     0.000071050  1221  U   R [cat] 3
  3,0    0       99     0.006566892  1232  C  RB 2853600 + 384 [0]
  3,0    0      100     0.006623669  1232  D  RB 2853984 + 384 [blkparse]
  3,0    0      101     0.007166110  1221  Q   R 2854368 + 8 [cat]
  3,0    0      102     0.007175772  1221  G   R 2854368 + 8 [cat]
  3,0    0      103     0.007178625  1221  I   R 2854368 + 8 [cat]
  3,0    0      104     0.007182866  1221  Q   R 2854376 + 8 [cat]
  3,0    0      105     0.007184072  1221  M   R 2854376 + 8 [cat]
  3,0    0      106     0.007185670  1221  Q   R 2854384 + 8 [cat]
  3,0    0      107     0.007185923  1221  M   R 2854384 + 8 [cat]
  3,0    0      108     0.007186789  1221  Q   R 2854392 + 8 [cat]
  3,0    0      109     0.007187003  1221  M   R 2854392 + 8 [cat]
(alot of the same)
  3,0    0      193     0.007234987  1221  M   R 2854728 + 8 [cat]
  3,0    0      194     0.007235671  1221  Q   R 2854736 + 8 [cat]
  3,0    0      195     0.007235882  1221  M   R 2854736 + 8 [cat]
  3,0    0      196     0.007236579  1221  Q   R 2854744 + 8 [cat]
  3,0    0      197     0.007236790  1221  M   R 2854744 + 8 [cat]
  3,0    0      198     0.007239481  1221  U   R [cat] 3
  3,0    0      199     0.011350831     0  C  RB 2853984 + 384 [0]
  3,0    0      200     0.011399039     0  D  RB 2854368 + 384 [swapper]
  3,0    0      201     0.011647468  1221  Q   R 2854752 + 8 [cat]
  3,0    0      202     0.011654575  1221  G   R 2854752 + 8 [cat]
  3,0    0      203     0.011657003  1221  I   R 2854752 + 8 [cat]
  3,0    0      204     0.011660028  1221  Q   R 2854760 + 8 [cat]
  3,0    0      205     0.011661105  1221  M   R 2854760 + 8 [cat]
  3,0    0      206     0.011662431  1221  Q   R 2854768 + 8 [cat]
  3,0    0      207     0.011662658  1221  M   R 2854768 + 8 [cat]
  3,0    0      208     0.011663608  1221  Q   R 2854776 + 8 [cat]
  3,0    0      209     0.011663815  1221  M   R 2854776 + 8 [cat]
  3,0    0      210     0.011664610  1221  Q   R 2854784 + 8 [cat]
(alot of the same)
  3,0    0    13184     0.990888789  1221  Q   R 2904584 + 8 [cat]
  3,0    0    13185     0.990889013  1221  M   R 2904584 + 8 [cat]
  3,0    0    13186     0.990890008  1221  Q   R 2904592 + 8 [cat]
  3,0    0    13187     0.990890216  1221  M   R 2904592 + 8 [cat]
  3,0    0    13188     0.990891110  1221  Q   R 2904600 + 8 [cat]
  3,0    0    13189     0.990891337  1221  M   R 2904600 + 8 [cat]
  3,0    0    13190     0.990892083  1221  Q   R 2904608 + 8 [cat]
  3,0    0    13191     0.990892291  1221  M   R 2904608 + 8 [cat]
  3,0    0    13192     0.990893198  1221  Q   R 2904616 + 8 [cat]
  3,0    0    13193     0.990893429  1221  M   R 2904616 + 8 [cat]
  3,0    0    13194     0.990894845  1221  Q   R 2904624 + 8 [cat]
  3,0    0    13195     0.990895056  1221  M   R 2904624 + 8 [cat]
  3,0    0    13196     0.990895844  1221  Q   R 2904632 + 8 [cat]
  3,0    0    13197     0.990896071  1221  M   R 2904632 + 8 [cat]
  3,0    0    13198     0.990896852  1221  Q   R 2904640 + 8 [cat]
  3,0    0    13199     0.990897057  1221  M   R 2904640 + 8 [cat]
  3,0    0    13200     0.990897828  1221  Q   R 2904648 + 8 [cat]
  3,0    0    13201     0.990898068  1221  M   R 2904648 + 8 [cat]
  3,0    0    13202     0.990898956  1221  Q   R 2904656 + 8 [cat]
  3,0    0    13203     0.990899164  1221  M   R 2904656 + 8 [cat]
  3,0    0    13204     0.990899952  1221  Q   R 2904664 + 8 [cat]
  3,0    0    13205     0.990900176  1221  M   R 2904664 + 8 [cat]
  3,0    0    13206     0.990902565  1221  U   R [cat] 2
CPU0 (3,0):
 Reads Queued:       6,336,   50,152KiB	 Writes Queued:           0,        
0KiB
 Read Dispatches:      133,   25,152KiB	 Write Dispatches:        1,        
4KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:      133,   25,152KiB	 Writes Completed:        1,        
4KiB
 Read Merges:        6,202        	 Write Merges:            0
 Read depth:             1        	 Write depth:             1
 IO unplugs:           130        	 Timer unplugs:           0

Throughput (R/W): 25,406KiB/s / 4KiB/s
Events (3,0): 13,206 entries
Skips: 0 forward (0 -   0.0%)


Does this help?

Thanks!

--
Al

