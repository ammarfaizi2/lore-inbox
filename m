Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265656AbSKFGAJ>; Wed, 6 Nov 2002 01:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265657AbSKFGAJ>; Wed, 6 Nov 2002 01:00:09 -0500
Received: from packet.digeo.com ([12.110.80.53]:32942 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265656AbSKFGAI>;
	Wed, 6 Nov 2002 01:00:08 -0500
Message-ID: <3DC8B16E.EAFC854@digeo.com>
Date: Tue, 05 Nov 2002 22:06:38 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lev Makhlis <mlev@despammed.com>
CC: linux-kernel@vger.kernel.org, ricklind@us.ibm.com
Subject: Re: [PATCH] 2.5.46: overflow in disk stats
References: <200211060009.51684.mlev@despammed.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2002 06:06:38.0832 (UTC) FILETIME=[AB5C9F00:01C2855A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lev Makhlis wrote:
> 
> Hi,
> 
> I see that the SARD changes have been merged, but MSEC() still has
> the overflow problem.  This takes care of it:
> 
> --------------------------------------------------------------------------------------------------
> 
> diff -urN linux-2.5.46.orig/drivers/block/genhd.c
> linux-2.5.46/drivers/block/genhd.c
> --- linux-2.5.46.orig/drivers/block/genhd.c     Tue Nov  5 15:15:07 2002
> +++ linux-2.5.46/drivers/block/genhd.c  Tue Nov  5 16:14:35 2002
> @@ -326,7 +326,13 @@
>  }
>  static inline unsigned MSEC(unsigned x)
>  {
> -       return x * 1000 / HZ;
> +#if 1000 % HZ == 0
> +       return x * (1000 / HZ);
> +#elif HZ % 1000 == 0
> +       return x / (HZ / 1000);
> +#else
> +       return (x / HZ) * 1000 + (x % HZ) * 1000 / HZ;
> +#endif
>  }

My brain just fell out.   Why don't we just do

	return (x / HZ) * 1000;

?

Yes, it'll return zero for the first second of disk activity.
I don't think that matters?

	return ((x + HZ / 2) / HZ) * 1000;

would be more accurate too, and reduces it to half a second ;)



--- 25/drivers/block/genhd.c~msec-fix	Tue Nov  5 21:59:35 2002
+++ 25-akpm/drivers/block/genhd.c	Tue Nov  5 22:02:17 2002
@@ -324,10 +324,12 @@ static ssize_t disk_size_read(struct gen
 {
 	return off ? 0 : sprintf(page, "%llu\n",(unsigned long long)get_capacity(disk));
 }
-static inline unsigned MSEC(unsigned x)
+
+static unsigned jiffies_to_msec(unsigned jif)
 {
-	return x * 1000 / HZ;
+	return ((jif + HZ / 2) / HZ) * 1000;
 }
+
 static ssize_t disk_stat_read(struct gendisk * disk,
 			      char *page, size_t count, loff_t off)
 {
@@ -338,11 +340,11 @@ static ssize_t disk_stat_read(struct gen
 		"%8u %8u %8u"
 		"\n",
 		disk->reads, disk->read_merges, (u64)disk->read_sectors,
-		MSEC(disk->read_ticks),
+		jiffies_to_msec(disk->read_ticks),
 		disk->writes, disk->write_merges, (u64)disk->write_sectors,
-		MSEC(disk->write_ticks),
-		disk->in_flight, MSEC(disk->io_ticks),
-		MSEC(disk->time_in_queue));
+		jiffies_to_msec(disk->write_ticks),
+		disk->in_flight, jiffies_to_msec(disk->io_ticks),
+		jiffies_to_msec(disk->time_in_queue));
 }
 static struct disk_attribute disk_attr_dev = {
 	.attr = {.name = "dev", .mode = S_IRUGO },

_
