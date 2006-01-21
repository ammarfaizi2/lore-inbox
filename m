Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWAUDhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWAUDhf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 22:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWAUDhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 22:37:35 -0500
Received: from mxsf14.cluster1.charter.net ([209.225.28.214]:56557 "EHLO
	mxsf14.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1750886AbWAUDhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 22:37:34 -0500
X-IronPort-AV: i="4.01,207,1136178000"; 
   d="scan'208"; a="2043120325:sNHT55168796"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17361.44149.200493.916170@smtp.charter.net>
Date: Fri, 20 Jan 2006 22:37:25 -0500
From: "John Stoffel" <john@stoffel.org>
To: Neil Brown <neilb@suse.de>
Cc: "John Stoffel" <john@stoffel.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 001 of 5] md: Split disks array out of raid5 conf structure so it is easier to grow.
In-Reply-To: <17358.56490.127364.327688@cse.unsw.edu.au>
References: <20060117174531.27739.patches@notabene>
	<1060117065614.27831@suse.de>
	<17357.271.619918.45917@smtp.charter.net>
	<17358.56490.127364.327688@cse.unsw.edu.au>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Neil" == Neil Brown <neilb@suse.de> writes:

Neil> On Tuesday January 17, john@stoffel.org wrote:
>> >>>>> "NeilBrown" == NeilBrown  <neilb@suse.de> writes:
>> 
NeilBrown> Previously the array of disk information was included in
NeilBrown> the raid5 'conf' structure which was allocated to an
NeilBrown> appropriate size.  This makes it awkward to change the size
NeilBrown> of that array.  So we split it off into a separate
NeilBrown> kmalloced array which will require a little extra indexing,
NeilBrown> but is much easier to grow.

>> Instead of setting mddev->private = NULL, should you be doing a kfree
>> on it as well when you are in an abort state?

Neil> The only times I set 
mddev-> private = NULL
Neil> it is immediately after
Neil>    kfree(conf)
Neil> and as conf is the thing that is assigned to mddev->private, this
Neil> should be doing exactly what you suggest.

Neil> Does that make sense?

Now that I've had some time to actually apply your patches to
2.6.16-rc1 and look them over more carefully, I see my mistake.  I
overlooked the assignment of 

	conf = mddev->private 

In the lines just below there, and I see how you do clean it up.  I
guess I would have just done it the other way around:

	conf = kzalloc()
	if (!conf) 
		goto abort:
	.
	.	
	.
	mddev->private = conf;

Though now that I look at it, don't we have a circular reference
here?  Let me quote the code section, which starts of with where I was
confused: 

        mddev->private = kzalloc(sizeof (raid5_conf_t), GFP_KERNEL);
        if ((conf = mddev->private) == NULL)
                goto abort;
        conf->disks = kzalloc(mddev->raid_disks * sizeof(struct disk_info),
                              GFP_KERNEL);
        if (!conf->disks)
                goto abort;

        conf->mddev = mddev;

        if ((conf->stripe_hashtbl = kzalloc(PAGE_SIZE, GFP_KERNEL)) == NULL)
                goto abort;


Now we seem to end up with:

	mddev->private = conf;
	conf->mddev = mddev;

which looks a little strange to me, and possibly something that could
lead to endless loops.  But I need to find the time to sit down and
try to understand the code, so don't waste much time educating me
here.

Thanks for all your work on this Neil, I for one really appreciate it!

John
