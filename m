Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWDYGlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWDYGlE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 02:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWDYGlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 02:41:04 -0400
Received: from fc-cn.com ([218.25.172.144]:26641 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S932121AbWDYGlC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 02:41:02 -0400
Date: Tue, 25 Apr 2006 14:43:10 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: Neil Brown <neilb@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [patch 1/2] raid6_end_write_request() spinlock fix
Message-ID: <20060425064310.GA29950@localhost.localdomain>
References: <20060425033542.GA4087@localhost.localdomain> <17485.45069.692725.551853@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17485.45069.692725.551853@cse.unsw.edu.au>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 03:13:49PM +1000, Neil Brown wrote:
> On Tuesday April 25, qiyong@fc-cn.com wrote:
> > Hello,
> > 
> > Reduce the raid6_end_write_request() spinlock window.
> 
> Andrew: please don't include these in -mm.  This one and the
> corresponding raid5 are wrong, and I'm not sure yet the unplug_device
> changes.

I am sure with the unplug_device. Just look follow the path...

> 
> In this case, the call to md_error, which in turn calls "error" in
> raid6main.c, requires the lock to be held as it contains:
> 	if (!test_bit(Faulty, &rdev->flags)) {
> 		mddev->sb_dirty = 1;
> 		if (test_bit(In_sync, &rdev->flags)) {
> 			conf->working_disks--;
> 			mddev->degraded++;
> 			conf->failed_disks++;
> 			clear_bit(In_sync, &rdev->flags);
> 			/*
> 			 * if recovery was running, make sure it aborts.
> 			 */
> 			set_bit(MD_RECOVERY_ERR, &mddev->recovery);
> 		}
> 		set_bit(Faulty, &rdev->flags);
> 
> which is fairly clearly not safe without some locking.

Yes. Let's fix the error(). In any case, the current code is broken. (see raid5/6_end_read_request)
Comments? Thanks.

Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
---

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 9c24377..192de19 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -638,7 +638,7 @@ static void error(mddev_t *mddev, mdk_rd
 	raid5_conf_t *conf = (raid5_conf_t *) mddev->private;
 	PRINTK("raid5: error called\n");
 
-	if (!test_bit(Faulty, &rdev->flags)) {
+	if (!test_and_set_bit(Faulty, &rdev->flags)) {
 		mddev->sb_dirty = 1;
 		if (test_bit(In_sync, &rdev->flags)) {
 			conf->working_disks--;
@@ -650,7 +650,6 @@ static void error(mddev_t *mddev, mdk_rd
 			 */
 			set_bit(MD_RECOVERY_ERR, &mddev->recovery);
 		}
-		set_bit(Faulty, &rdev->flags);
 		printk (KERN_ALERT
 			"raid5: Disk failure on %s, disabling device."
 			" Operation continuing on %d devices\n",
diff --git a/drivers/md/raid6main.c b/drivers/md/raid6main.c
index d3deedb..fc0b31d 100644
--- a/drivers/md/raid6main.c
+++ b/drivers/md/raid6main.c
@@ -527,7 +527,7 @@ static void error(mddev_t *mddev, mdk_rd
 	raid6_conf_t *conf = (raid6_conf_t *) mddev->private;
 	PRINTK("raid6: error called\n");
 
-	if (!test_bit(Faulty, &rdev->flags)) {
+	if (!test_and_set_bit(Faulty, &rdev->flags)) {
 		mddev->sb_dirty = 1;
 		if (test_bit(In_sync, &rdev->flags)) {
 			conf->working_disks--;
@@ -539,7 +539,6 @@ static void error(mddev_t *mddev, mdk_rd
 			 */
 			set_bit(MD_RECOVERY_ERR, &mddev->recovery);
 		}
-		set_bit(Faulty, &rdev->flags);
 		printk (KERN_ALERT
 			"raid6: Disk failure on %s, disabling device."
 			" Operation continuing on %d devices\n",

> 
> Coywolf:  As I think I have already said, I appreciate your review of
> the md/raid code and your attempts to improve it - I'm sure there is
> plenty of room to make improvements.  
> However posting patches with minimal commentary on code that you don't
> fully understand is not the best way to work with the community.
> If you see something that you think is wrong, it is much better to ask
> why it is the way it is, explain why you think it isn't right, and
> quite possibly include an example patch.  Then we can discuss the
> issue and find the best solution.
> 
> So please feel free to post further patches, but please include more
> commentary, and don't assume you understand something that you don't
> really.
> 
> Thanks,
> NeilBrown
> 
> 
> 
> > 
> > Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
> > ---
> > 
> > diff --git a/drivers/md/raid6main.c b/drivers/md/raid6main.c
> > index bc69355..820536e 100644
> > --- a/drivers/md/raid6main.c
> > +++ b/drivers/md/raid6main.c
> > @@ -468,7 +468,6 @@ static int raid6_end_write_request (stru
> >   	struct stripe_head *sh = bi->bi_private;
> >  	raid6_conf_t *conf = sh->raid_conf;
> >  	int disks = conf->raid_disks, i;
> > -	unsigned long flags;
> >  	int uptodate = test_bit(BIO_UPTODATE, &bi->bi_flags);
> >  
> >  	if (bi->bi_size)
> > @@ -486,16 +485,14 @@ static int raid6_end_write_request (stru
> >  		return 0;
> >  	}
> >  
> > -	spin_lock_irqsave(&conf->device_lock, flags);
> >  	if (!uptodate)
> >  		md_error(conf->mddev, conf->disks[i].rdev);
> >  
> >  	rdev_dec_pending(conf->disks[i].rdev, conf->mddev);
> > -
> >  	clear_bit(R5_LOCKED, &sh->dev[i].flags);
> >  	set_bit(STRIPE_HANDLE, &sh->state);
> > -	__release_stripe(conf, sh);
> > -	spin_unlock_irqrestore(&conf->device_lock, flags);
> > +	release_stripe(sh);
> > +
> >  	return 0;
> >  }
> >  
-- 
Coywolf Qi Hunt
