Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbSLLWaQ>; Thu, 12 Dec 2002 17:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267535AbSLLWaP>; Thu, 12 Dec 2002 17:30:15 -0500
Received: from mg01.austin.ibm.com ([192.35.232.18]:62966 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S267534AbSLLWaO>; Thu, 12 Dec 2002 17:30:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Wil Reichert <wilreichert@yahoo.com>
Subject: Re: "bio too big" error
Date: Thu, 12 Dec 2002 15:51:16 -0600
X-Mailer: KMail [version 1.2]
Cc: Greg KH <greg@kroah.com>, kernel list <linux-kernel@vger.kernel.org>,
       lvm-devel@sistina.com
References: <20021211234557.GF16615@kroah.com> <20021212001542.51940.qmail@web40109.mail.yahoo.com> <20021212091209.GA1299@reti>
In-Reply-To: <20021212091209.GA1299@reti>
MIME-Version: 1.0
Message-Id: <02121215511604.05277@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 December 2002 03:12, Joe Thornber wrote:
> On Wed, Dec 11, 2002 at 04:15:42PM -0800, Wil Reichert wrote:
> > Ok, 2.5.51 plus dm patches result in the following:
> >
> > Initializing LVM: device-mapper: device
> > /dev/ide/host2/bus1/target0/lun0/disc too small for target
> > device-mapper: internal error adding target to table
> > device-mapper: destroying table
> >   device-mapper ioctl cmd 2 failed: Invalid argument
> >   Couldn't load device 'cheese_vg-blah'.
> >   0 logical volume(s) in volume group "cheese_vg" now active
> > lvm2.
> >
> > Was fine (minus of course the entire bio thing) in 50, did something
> > break in 51 or is it just my box?
>
> I've had a couple of reports of this problem.  The offending patch is:
>
> http://people.sistina.com/~thornber/patches/2.5-stable/2.5.51/2.5.51-dm-1/0
>0005.patch
>
> back it out if necc.
>
> All it does is:
>
> --- diff/drivers/md/dm-table.c	2002-12-11 11:59:51.000000000 +0000
> +++ source/drivers/md/dm-table.c	2002-12-11 12:00:00.000000000 +0000
> @@ -388,7 +388,7 @@
>  static int check_device_area(struct dm_dev *dd, sector_t start, sector_t
> len) {
>  	sector_t dev_size;
> -	dev_size = dd->bdev->bd_inode->i_size;
> +	dev_size = dd->bdev->bd_inode->i_size >> SECTOR_SHIFT;
>  	return ((start < dev_size) && (len <= (dev_size - start)));
>  }


Actually, this 00005.patch *is* necessary. dd->bdev->bd_inode->i_size *is* in 
bytes, and does need to be shifted to do the above comparison.

I believe we have tracked the problem down to the call to dm_get_device() in 
dm-linear.c. It is passing in an incorrect value, which winds up being the 
"start" parameter to the check_device_area() function. I've included a patch 
at the end of this email which I believe should fix the problem. I have also 
checked dm-stripe.c, and it appears to make the call to dm_get_device() 
correctly, so no worries there.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/



--- linux-2.5.51a/drivers/md/dm-linear.c	2002/11/20 20:09:22	1.1
+++ linux-2.5.51b/drivers/md/dm-linear.c	2002/12/12 21:38:32
@@ -43,7 +43,7 @@
 		goto bad;
 	}
 
-	if (dm_get_device(ti, argv[0], ti->begin, ti->len,
+	if (dm_get_device(ti, argv[0], lc->start, ti->len,
 			  dm_table_get_mode(ti->table), &lc->dev)) {
 		ti->error = "dm-linear: Device lookup failed";
 		goto bad;
