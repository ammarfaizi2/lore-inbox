Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265040AbUGSMMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265040AbUGSMMt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 08:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUGSMMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 08:12:48 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:61335 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265040AbUGSMMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 08:12:37 -0400
Message-ID: <40FBBAAE.5060405@comcast.net>
Date: Mon, 19 Jul 2004 08:12:30 -0400
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040708)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: audio cd writing causes massive swap and crash
References: <40F9854D.2000408@comcast.net> <20040718071830.GA29753@suse.de>
In-Reply-To: <20040718071830.GA29753@suse.de>
Content-Type: multipart/mixed;
 boundary="------------000503060109010705000700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000503060109010705000700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The patch does not work.  I've just had the chance to try it out and the 
same exact problem occurs with no difference.  I ran vmstat while this 
was going on, but not being the very first run, it'll probably be hard 
to tell what's going on .  The moment free mem drop is when i started 
the cdrecord process.  the cdrecord command line looks something like this:

/usr/local/bin/cdrecord
-v
-eject
-pad
speed=48
dev=/dev/hdc
-dao
fs=12m
driveropts=burnproof
-audio
-swab





Jens Axboe wrote:

>On Sat, Jul 17 2004, Ed Sweetman wrote:
>  
>
>>Both with 2.6.7-rc3 and 2.6.8-rc1-mm1 I get the same behavior when 
>>writing an audio cd on my plextor px-712a.  DMA is enabled and normal 
>>data cds write as expected, but audio cds will cause (at any speed) the 
>>box to start using insane amounts of swap (>150MB) and eventually cause 
>>the box to crash before finishing the cd.  CPU usage during the write is 
>>very low, but the feeling of lagginess begins after the first few tracks 
>>(and as the memory begins to be sucked away).   I've used both cdrecord 
>>from cdrtools in debian and from the site and both have the same 
>>behavior.  I dont know how i'd go about finding out what the problem is, 
>>so far I've coastered over 10 cds trying different ways of burning an 
>>audio cd but it appears that burnfree, speed have nothing to do with the 
>>problem. 
>>
>>Here's some drive info if it helps. 
>>
>>Linux sg driver version: 3.5.27
>>Using libscg version 'schily-0.8'.
>>Device type    : Removable CD-ROM
>>Version        : 0
>>Response Format: 1
>>Vendor_info    : 'PLEXTOR '
>>Identifikation : 'DVDR   PX-712A  '
>>Revision       : '1.01'
>>Device seems to be: Generic mmc2 DVD-R/DVD-RW.
>>cdrecord: This version of cdrecord does not include DVD-R/DVD-RW support 
>>code.
>>cdrecord: See /usr/share/doc/cdrecord/README.DVD.Debian for details on 
>>DVD support.
>>Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
>>Driver flags   : MMC-3 SWABAUDIO BURNFREE VARIREC FORCESPEED SPEEDREAD 
>>SINGLESESSION HIDECDR
>>Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
>>
>>
>>now in cdrecord i use the option -swab not sure if that counters the 
>>driver flags or what, either way I doubt it would be causing this problem. 
>>
>>the drive by the way is mmc4 compliant, so it's weird that it says mmc2.
>>any more info that's needed just tell me.
>>    
>>
>
>Sounds like it's leaking all the pages, vmstat 1 during rip will show
>for sure. Can you check if this makes a difference, against
>2.6.8-rc-mm1 (should apply with offsets, I'm on the road so cannot test
>myself)?
>
>--- /mnt/kscratch/linux-2.6.5/mm/highmem.c	2004-04-04 05:37:25.000000000 +0200
>+++ linux-2.6.5-SUSE-20040713/mm/highmem.c	2004-07-15 10:28:12.142262512 +0200
>@@ -309,12 +309,10 @@ static void bounce_end_io(struct bio *bi
> {
> 	struct bio *bio_orig = bio->bi_private;
> 	struct bio_vec *bvec, *org_vec;
>-	int i;
>+	int i, err = 0;
> 
> 	if (!test_bit(BIO_UPTODATE, &bio->bi_flags))
>-		goto out_eio;
>-
>-	set_bit(BIO_UPTODATE, &bio_orig->bi_flags);
>+		err = -EIO;
> 
> 	/*
> 	 * free up bounce indirect pages used
>@@ -327,8 +325,7 @@ static void bounce_end_io(struct bio *bi
> 		mempool_free(bvec->bv_page, pool);	
> 	}
> 
>-out_eio:
>-	bio_endio(bio_orig, bio_orig->bi_size, 0);
>+	bio_endio(bio_orig, bio_orig->bi_size, err);
> 	bio_put(bio);
> }
> 
>--- /mnt/kscratch/linux-2.6.5/fs/bio.c	2004-07-14 23:12:42.000000000 +0200
>+++ linux-2.6.5-SUSE-20040713/fs/bio.c	2004-07-15 10:30:53.263775247 +0200
>@@ -549,7 +549,6 @@ static struct bio *__bio_map_user(reques
> 		bio->bi_rw |= (1 << BIO_RW);
> 
> 	bio->bi_flags |= (1 << BIO_USER_MAPPED);
>-	blk_queue_bounce(q, &bio);
> 	return bio;
> out:
> 	kfree(pages);
>--- /mnt/kscratch/linux-2.6.5/drivers/block/scsi_ioctl.c	2004-07-14 23:12:42.000000000 +0200
>+++ linux-2.6.5-SUSE-20040713/drivers/block/scsi_ioctl.c	2004-07-15 10:26:39.089364958 +0200
>@@ -167,6 +167,13 @@ static int sg_io(request_queue_t *q, str
> 	rq->flags |= REQ_BLOCK_PC;
> 	bio = rq->bio;
> 
>+	/*
>+	 * bounce this after holding a reference to the original bio, it's
>+	 * needed for proper unmapping
>+	 */
>+	if (rq->bio)
>+		blk_queue_bounce(q, &rq->bio);
>+
> 	rq->timeout = (hdr->timeout * HZ) / 1000;
> 	if (!rq->timeout)
> 		rq->timeout = q->sg_timeout;
>--- /mnt/kscratch/linux-2.6.5/drivers/cdrom/cdrom.c	2004-07-14 23:12:42.000000000 +0200
>+++ linux-2.6.5-SUSE-20040713/drivers/cdrom/cdrom.c	2004-07-15 10:27:17.219225057 +0200
>@@ -1975,6 +1975,9 @@ static int cdrom_read_cdda_bpc(struct cd
> 		rq->timeout = 60 * HZ;
> 		bio = rq->bio;
> 
>+		if (rq->bio)
>+			blk_queue_bounce(q, &rq->bio);
>+
> 		if (blk_execute_rq(q, cdi->disk, rq)) {
> 			struct request_sense *s = rq->sense;
> 			ret = -EIO;
>--- /mnt/kscratch/linux-2.6.5/drivers/block/ll_rw_blk.c	2004-07-14 23:12:42.000000000 +0200
>+++ linux-2.6.5-SUSE-20040713/drivers/block/ll_rw_blk.c	2004-07-15 10:34:51.152967583 +0200
>@@ -1807,6 +1807,12 @@ EXPORT_SYMBOL(blk_insert_request);
>  *
>  *    A matching blk_rq_unmap_user() must be issued at the end of io, while
>  *    still in process context.
>+ *
>+ *    Note: The mapped bio may need to be bounced through blk_queue_bounce()
>+ *    before being submitted to the device, as pages mapped may be out of
>+ *    reach. It's the callers responsibility to make sure this happens. The
>+ *    original bio must be passed back in to blk_rq_unmap_user() for proper
>+ *    unmapping.
>  */
> struct request *blk_rq_map_user(request_queue_t *q, int rw, void __user *ubuf,
> 				unsigned int len)
>
>
>  
>


--------------000503060109010705000700
Content-Type: text/plain;
 name="testing"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="testing"

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0   9424  17540  14060 378248    0    0   297   202   20   235  4  2 91  4
 6  0   9424  17540  14068 378248    0    0     0    30 1336   405  1  1 98  0
 0  0   9424  17940  14068 378248    0    0     0     0 1494  1590  9  1 90  0
 0  0   9424  17940  14068 378248    0    0     0     0 1415   334  0  0 100  0
 0  0   9424  17940  14068 378248    0    0     0     0 1441   377  1  0 99  0
 0  0   9424  17928  14076 378248    0    0     0     8 1450   700  7  2 91  0
 0  0   9424  17928  14084 378248    0    0     0     8 1388   349  1  1 98  0
 0  0   9424  17964  14084 378248    0    0     0     0 1284   245  1  0 99  0
 0  0   9424  17964  14084 378248    0    0     0     0 1229   213  1  0 99  0
 0  0   9424  17964  14084 378248    0    0     0     0 1241   224  0  0 100  0
 0  0   9424  17968  14084 378248    0    0     0    14 1322   240  1  1 98  0
 0  0   9424  18016  14088 378248    0    0     0     8 1268   223  1  1 98  0
 2  0   9424   5384  14088 390540    0    0     0     0 1375   767 10  5 85  0
 0  0   9424   4812  14084 390288    0    0  4608     0 1388  2761 10  4 69 17
 0  0   9424   4828  14084 390288    0    0     0     0 1377   593  2  4 94  0
 0  0   9424   3156  14060 391876    0    0  4092    18 1433   710  4  9 77 10
 0  0   9424   3584  14068 391876    0    0     0    26 1503  1284 14  4 82  0
 0  0   9424   3580  14068 391876    0    0     0     0 1375   594 10  0 90  0
 0  0   9424   3572  14076 391876    0    0     0    20 1465   703 10  1 89  0
 0  0   9424   3576  14076 391876    0    0     0     0 1285   549  7  2 91  0
 0  0   9424   3568  14076 391876    0    0     0     0 1365   411  5  0 95  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0   9424   3576  14084 391876    0    0     0     8 1463   507 11  0 89  0
 0  0   9424   3576  14084 391876    0    0     0     0 1218   330  1  0 99  0
 0  0   9424   3576  14084 391876    0    0     0     0 1229   316  2  0 98  0
 0  0   9424   3572  14084 391876    0    0     0     0 1232   319  1  0 99  0
 0  0   9424   3596  14084 391876    0    0     0     0 1228   341  3  1 96  0
 0  0   9424   3532  14088 391876    0    0     0    16 1300   420  2  1 97  0
 0  0   9424   2848  14088 391876    0    0     0     0 1293   338  1  0 99  0
 0  0   9424   4780  14088 389316    0    0     0     0 1245   353  0  0 98  2
 0  0   9424   4144  14088 389316    0    0     0     0 1263   348  1  1 98  0
 0  0   9424   3496  14092 389316    0    0     0     6 1262   359  1  1 98  0
 0  0   9424   2860  14096 389316    0    0     0     8 1427   482  2  0 98  0
 0  0   9424   4808  14084 386808    0    0     0     0 1497   513  5  0 93  2
 0  0   9424   4172  14084 386808    0    0     0     0 1399   430  4  0 96  0
 0  0   9424   3500  14084 386808    0    0     0     0 1267  1041  3  2 95  0
 0  0   9424   2856  14084 386808    0    0     0     4 1438  1132  6  3 91  0
 0  0   9460   4580  14092 384424    0   40     0    48 1350   428  1  0 99  0
 0  0   9460   4012  14092 384424    0    0     0     0 1247   350  1  0 99  0
 0  0   9460   3432  14092 384424    0    0     0     0 1264   355  0  0 100  0
 0  0   9460   2768  14092 384424    0    0     0     0 1257   342  1  1 98  0
 3  1   9460   4076  14072 380900    0    0     0     6 1431   152  1 96  4  0
 6  3   9464   4116  14000 378028    0   64  4102    88 1876   187  1 97  0  2
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0   9464   2724  13736 376512    0    0  4240     2 2369   641  3 97  1  0
 0  6   9464   3956  13676 372872    0    0   140     0 1618   342  2 94  3  2
 6  3   9464   3996  12828 369832    0    0  4360    20 2742   457  0 86  6  7
 1  7   9464   4060  12392 367736    0    0  3740     8 1754   175  1 98  0  1
 1  0   9464   3360  12320 366144    0    0     0     0 1513   293  3 96  2  0
 1  0   9464   4044  11724 363572    0    0     0    12 1481   595  4 95  2  0
 0  6   9464   4036  11720 361888    0    0     0     0 1433   162  1 75 24  0
 3  6   9464   4036   8416 361224    0    0  2048     0 2780   151  1 97  0  3
 0  2   9464   3972   7920 359576   64    0  4168    14 1350   230  2 96  0  2
 3  2   9464   4188   7816 357884   32    0  6192     0 1842   297  1 98  1  0
 5  3   9464   4060   7776 354732    0    8  4100    20 2500   330  3 84 12  2
 1  1   9464   3588   7708 352336   28    0  4534     0 1983   196  1 96  0  3
 0  0   9464   3208   7700 350540    0    0     0     8 1345   315  3 94  3  0
 1  1   9464   4040   7648 347776    0    0  4100     6 1447   219  1 94  3  2
 3  5   9464   4036   7648 345984    0    0     0     0 1396   194  1 79 19  2
 3  5   9464   3980   7512 342692    0    0  4124     0 2141   205  1 97  0  2
 2  0   9464   4176   7456 340328    8    0  4108    12 1474   284  2 95  2  2
 2  0   9464   4048   7460 338280    0    0     0     8 1577   317  3 95  3  0
 0  4   9464   4044   7436 336400    0    0  1936     0 1429   170  1 79 19  1
 6  1   9464   4044   7396 332604    0    0     0    12 2125   180  0 99  0  1
 3  0   9464   3996   7388 330440    0    0    12     0 1368   309  3 95  2  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  2   9464   3956   7188 328216    0    0  2048     0 1564   500  5 93  1  2
 1  2   9464   4084   6916 326356    0    0  2056     8 1517  1363  4 83 11  3
 0  4   9464   4084   6580 322508    0    0  2048     8 1531   465  2 95  0  3
 2  0   9464   3252   6572 323040    0    0  6160     4 1636   279  3 97  0  0
 2  0   9464   3420   6552 321144    0    0  4100    14 1494   485  3 97  0  0
11  3   9464   4116   6552 316784   36    0    36     6 2268   451  2 86 10  2
 2  0   9468   4140   6556 312612   28   16  8240    36 4190   535  2 98  0  0
 0  0   9468   4108   6556 312600    0    0     0     6 1328  3161 11 15 74  0
 1  0   9468   4108   6556 312600    0    0     0     0 1534  1201  5 15 80  0
 0  0   9468   4556   6556 312600   32    0    32     0 1380  1397  8  7 85  0
 0  0   9468   4556   6556 312600    0    0     0     0 1239   213  0  0 100  0
 0  0   9468   4556   6572 312600    0    0     0    24 1227   247  1  0 99  0
 0  0   9468   4580   6572 312600    0    0     0     4 1225   241  3  3 94  0
 0  0   9468   4580   6572 312600    0    0     0     0 1234   221  1  0 99  0
 1  0   9468  17332   6572 300308   36    0    36     0 1276   573  6  1 93  0
 0  0   9428  17844   6572 300308    0    0     0     0 1247   867  4  1 95  0
 0  0   9428  17844   6576 300308    0    0     0     8 1259   347  2  0 98  0
 0  0   9428  17844   6584 300308    4    0     4     6 1260   339  2  2 96  0
 0  0   9428  17860   6584 300308    0    0     0     0 1261   368  2  0 98  0
 0  0   9428  17860   6584 300308    0    0     0     0 1243   219  1  0 99  0
 0  0   9428  17860   6584 300308    0    0     0     0 1234   216  1  1 98  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0   9428  17860   6592 300308    0    0     0     8 1244   223  0  0 99  1
 0  0   9428  17900   6592 300308    0    0     0     0 1234   223  1  0 99  0
 0  0   9428  17900   6592 300308    0    0     0     0 1227   224  0  0 100  0
 0  0   9428  17900   6592 300308    0    0     0     0 1240   241  2  0 98  0
 0  0   9428  17900   6592 300308    0    0     0     0 1239   221  0  0 100  0
 0  0   9428  17932   6596 300308    0    0     0     8 1229   228  1  1 98  0
 0  0   9428  17932   6596 300308    0    0     0     0 1225   220  1  1 98  0
 0  0   9428  17932   6596 300308    0    0     0     0 1223   214  0  0 100  0
 0  0   9428  17932   6596 300308    0    0     0     0 1222   225  1  0 99  0
 0  0   9428  17924   6596 300308    0    0     0     0 1438   954  7  1 92  0
 0  0   9428  17924   6604 300312    0    0     0    14 1282   366  3  1 96  0
 0  0   9428  17924   6604 300312    0    0     0     0 1407   372  3  1 96  0
 0  0   9428  17924   6608 300312    0    0     0     6 1526   468  2  0 98  0
 0  0   9428  17932   6608 300312    0    0     0     0 1226   217  1  0 99  0
 0  0   9428  17740   6612 300560    0    0   252     0 1262   350  2  0 94  4
 0  0   9428  17740   6616 300560    0    0     0     8 1473   677  4  1 95  0
 0  0   9428  17740   6616 300560    0    0     0     4 1241   263  1  0 99  0
 0  0   9428  19404   6616 300560    0    0     0     0 1326  1142 12  2 86  0
 0  0   9428  19404   6616 300560    0    0     0     0 1275   245  2  0 98  0

--------------000503060109010705000700--
