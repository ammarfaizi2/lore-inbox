Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbUCSHlW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 02:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbUCSHlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 02:41:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:11167 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261703AbUCSHkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 02:40:05 -0500
Date: Fri, 19 Mar 2004 08:39:58 +0100
From: Jens Axboe <axboe@suse.de>
To: markw@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm2
Message-ID: <20040319073958.GZ22234@suse.de>
References: <20040318192707.GV22234@suse.de> <200403182338.i2INcgE05434@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403182338.i2INcgE05434@mail.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18 2004, markw@osdl.org wrote:
> On 18 Mar, Jens Axboe wrote:
> > On Thu, Mar 18 2004, Andrew Morton wrote:
> >> > Comparing one pair of readprofile results, I find it curious that
> >> > dm_table_unplug_all and dm_table_any_congested show up near the top of a
> >> > 2.6.4-mm2 profile when they haven't shown up before in 2.6.3.
> >> 
> >> 14015190 poll_idle                                241641.2069
> >> 175162 generic_unplug_device                    1317.0075
> >> 165480 __copy_from_user_ll                      1272.9231
> >> 161151 __copy_to_user_ll                        1342.9250
> >> 152106 schedule                                  85.0705
> >> 142395 DAC960_LP_InterruptHandler               761.4706
> >> 113677 dm_table_unplug_all                      1386.3049
> >>  65420 __make_request                            45.5571
> >>  64832 dm_table_any_congested                   697.1183
> >>  37913 try_to_wake_up                            32.2939
> >> 
> >> That's broken.  How many disks are involve in the DM stack?
> >> 
> >> The relevant code was reworked subsequent to 2.6.4-mm2.  Maybe we fixed
> >> this, but I cannot immediately explain what you're seeing here.
> > 
> > Ugh that looks really bad, I wonder how it could possibly ever be this
> > bad. Mark, please do do a run with 2.6.5-rc1-mm2, I'd very much like to
> > see the profile there. If things get this bad, I need to think some more
> > about how to best handle the 'when to invoke request_fn on unplug calls'
> > logic again.
> > 
> > Actually, please also do a run with 2.6.5-rc1-mm2 + inlined patch. For
> > non-stacked dm on dm it should work and could make a lot of difference
> > for you.
> > 
> > --- drivers/block/ll_rw_blk.c~	2004-03-18 20:26:17.088531084 +0100
> > +++ drivers/block/ll_rw_blk.c	2004-03-18 20:26:44.773554953 +0100
> > @@ -1134,11 +1134,8 @@
> >  	if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags))
> >  		return;
> >  
> > -	/*
> > -	 * always call down, since we can race now with setting the plugged
> > -	 * bit outside of the queue lock
> > -	 */
> > -	blk_remove_plug(q);
> > +	if (!blk_remove_plug(q))
> > +		return;
> >  
> >  	/*
> >  	 * was plugged, fire request_fn if queue has stuff to do
> > 
> 
> http://developer.osdl.org/markw/dbt2-pgsql/409/
> 
> There are the results with 2.6.5-rc1-mm2 with your patch with a 512kb
> stripe width.  The throughput didn't improve but it did cut the ticks
> for dm_table_unplug_all in half.  Should I continue with smaller stripe
> widths?

Wait for a real patch first, I'll have one for you in an hour or two.

-- 
Jens Axboe

