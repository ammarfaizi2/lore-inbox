Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWDGU37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWDGU37 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 16:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWDGU36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 16:29:58 -0400
Received: from web52110.mail.yahoo.com ([206.190.48.113]:18093 "HELO
	web52110.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964936AbWDGU36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 16:29:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=G5h1bc+zONPpkrWUwfusYozyFW1BUXogwE3CGG6kqMCUNXTIWV20c5N5ggjL3TJjSnyrDdExE/DDl/xmT9OigHeYWFikuS4S+ITouVj5ZkmLt9ioChoKWV/BpluifEbK7DH2VuTdeYpNbWe+4wroDQAzjd6oH2i2o0Qj7ZQWVaQ=  ;
Message-ID: <20060407202955.9241.qmail@web52110.mail.yahoo.com>
Date: Fri, 7 Apr 2006 13:29:55 -0700 (PDT)
From: Mikkel Erup <mikkelerup@yahoo.com>
Subject: Re: sdhci driver produces kernel oops on ejecting the card
To: linux-kernel@vger.kernel.org
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <20060407144046.GA21049@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> So the
> only place for sane
> refcounting seems to be genhd.c, as per the patch
> below.
> 
> Comments?
> 
> diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x
> *.orig -x *.rej -x .git a/block/genhd.c
> b/block/genhd.c
> --- a/block/genhd.c	Sat Feb 18 10:31:37 2006
> +++ b/block/genhd.c	Fri Apr  7 15:22:21 2006
> @@ -262,6 +262,7 @@ static int exact_lock(dev_t dev,
> void *d
>   */
>  void add_disk(struct gendisk *disk)
>  {
> +	get_device(disk->driverfs_dev);
>  	disk->flags |= GENHD_FL_UP;
>  	blk_register_region(MKDEV(disk->major,
> disk->first_minor),
>  			    disk->minors, NULL, exact_match, exact_lock,
> disk);
> @@ -507,6 +508,7 @@ static struct attribute *
> default_attrs[
>  static void disk_release(struct kobject * kobj)
>  {
>  	struct gendisk *disk = to_disk(kobj);
> +	put_device(disk->driverfs_dev);
>  	kfree(disk->random);
>  	kfree(disk->part);
>  	free_disk_stats(disk);

I can confirm that this patch is working.
The 2.6.16-git20 kernel doesn't oops on
ejecting the card after the patch is applied.

Mikkel


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
