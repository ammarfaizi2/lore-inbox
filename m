Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276102AbRI1PA2>; Fri, 28 Sep 2001 11:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276100AbRI1PAL>; Fri, 28 Sep 2001 11:00:11 -0400
Received: from ns.caldera.de ([212.34.180.1]:59561 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S276099AbRI1O7p>;
	Fri, 28 Sep 2001 10:59:45 -0400
Date: Fri, 28 Sep 2001 17:00:04 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: Joachim Weller <JoachimWeller@web.de>
Cc: Joachim Weller <joachim_weller@hsgmed.com>, axboe@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: cat /proc/partitions endless loop
Message-ID: <20010928170004.A14892@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>,
	Joachim Weller <JoachimWeller@web.de>,
	Joachim Weller <joachim_weller@hsgmed.com>, axboe@suse.de,
	linux-kernel@vger.kernel.org
In-Reply-To: <200109281448.f8SEmvh08284@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109281448.f8SEmvh08284@mailgate5.cinetic.de>; from JoachimWeller@web.de on Fri, Sep 28, 2001 at 04:48:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 04:48:57PM +0200, Joachim Weller wrote:
> Christoph Hellwig <hch@ns.caldera.de> schrieb am 28.09.01:
> > In article <200109281315.f8SDFpA01669@bmdipc2c.germany.agilent.com> you wrote:
> > >  I traced the problem down to drivers/block/genhd.c, 
> > > where the function get_partition_list() outer loop does not 
> > > terminate due to the last element in the structured list starting 
> > > with gendisk_head is not initialized to NULL, by whatever reason.
> > > My fix does not cure the pointered endless loop, but prevents
> > > from looping when stepping thru the pointered list.
> > 
> > I think the fix could be simpler.  What about:
> [...] 
> 
> > + for (gp = gendisk_head; gp != gendisk_head; gp = gp->next) {
> 
> This will break your for loop immedeately, because the loop criteria
> is already violated by the initialization !
> 
> But I tried another solution:
>   for (gp = gendisk_head; gp && (gp->next != gendisk_head); gp = gp->next) {
> 
> with no success - the cat /proc/partition only printed the heading line.
> This proofed to me, that the pointered list is created the wrong way,
> in other words, gendisk_head->next is a pointer to itself.
> It looks to me, that the "next" field in 
> /*static*/ struct gendisk *gendisk_head;
> is not initialized (by the compiler ?) correctly to NULL. 

That's odd, could you try initilazing gendisk_head to NULL explicitly and try
my proposed fix?  The gendisk list handling starts to smell _really_ funny.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
