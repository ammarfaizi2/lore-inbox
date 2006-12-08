Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425475AbWLHMgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425475AbWLHMgM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 07:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425485AbWLHMgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 07:36:12 -0500
Received: from twin.jikos.cz ([213.151.79.26]:52820 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425475AbWLHMgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 07:36:11 -0500
Date: Fri, 8 Dec 2006 13:35:54 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Neil Brown <neilb@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-mm2
In-Reply-To: <17784.49277.120641.30296@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.64.0612081334500.1665@twin.jikos.cz>
References: <20061128020246.47e481eb.akpm@osdl.org>
 <Pine.LNX.4.64.0611290147400.28502@twin.jikos.cz> <17780.52337.767875.963882@cse.unsw.edu.au>
 <17780.61551.896455.157225@cse.unsw.edu.au> <Pine.LNX.4.64.0612050844110.28502@twin.jikos.cz>
 <Pine.LNX.4.64.0612052305490.28502@twin.jikos.cz> <17784.49277.120641.30296@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006, Neil Brown wrote:

> > OK, so more details follow (I am not sure how valuable they are, though). 
> They do help a bit..
> I've found a possible race that could possibly be related to this BUG.  
> Can you try this patch and see if it helps?
> Signed-off-by: Neil Brown <neilb@suse.de>
> 
> ### Diffstat output
>  ./drivers/md/md.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff .prev/drivers/md/md.c ./drivers/md/md.c
> --- .prev/drivers/md/md.c	2006-12-06 14:49:20.000000000 +1100
> +++ ./drivers/md/md.c	2006-12-07 10:29:40.000000000 +1100
> @@ -222,10 +222,14 @@ static inline mddev_t *mddev_get(mddev_t
>  	return mddev;
>  }
>  
> +static DEFINE_MUTEX(disks_mutex);
>  static void mddev_put(mddev_t *mddev)
>  {
> -	if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
> +	mutex_lock(&disks_mutex);
> +	if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock)) {
> +		mutex_unlock(&disks_mutex);
>  		return;
> +	}
>  	list_del(&mddev->all_mddevs);
>  	spin_unlock(&all_mddevs_lock);
>  
> @@ -234,6 +238,7 @@ static void mddev_put(mddev_t *mddev)
>  	blk_cleanup_queue(mddev->queue);
>  	mddev->queue = NULL;
>  	kobject_unregister(&mddev->kobj);
> +	mutex_unlock(&disks_mutex);
>  }
>  
>  static mddev_t * mddev_find(dev_t unit)
> @@ -2948,7 +2953,6 @@ int mdp_major = 0;
>  
>  static struct kobject *md_probe(dev_t dev, int *part, void *data)
>  {
> -	static DEFINE_MUTEX(disks_mutex);
>  	mddev_t *mddev = mddev_find(dev);
>  	struct gendisk *disk;
>  	int partitioned = (MAJOR(dev) != MD_MAJOR);

Hi Neil,

sorry, but the BUG is still there after applying this patch.

-- 
Jiri Kosina
