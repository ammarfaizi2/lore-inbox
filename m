Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWDYIFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWDYIFY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWDYIFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:05:24 -0400
Received: from fc-cn.com ([218.25.172.144]:26638 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1751417AbWDYIFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:05:22 -0400
Date: Tue, 25 Apr 2006 16:07:31 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: Neil Brown <neilb@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [patch 1/2] raid6_end_write_request() spinlock fix
Message-ID: <20060425080731.GA31828@localhost.localdomain>
References: <20060425033542.GA4087@localhost.localdomain> <17485.45069.692725.551853@cse.unsw.edu.au> <20060425064310.GA29950@localhost.localdomain> <17485.50850.9186.130696@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17485.50850.9186.130696@cse.unsw.edu.au>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 04:50:10PM +1000, Neil Brown wrote:
> On Tuesday April 25, qiyong@fc-cn.com wrote:
> > On Tue, Apr 25, 2006 at 03:13:49PM +1000, Neil Brown wrote:
> > > On Tuesday April 25, qiyong@fc-cn.com wrote:
> > > > Hello,
> > > > 
> > > > Reduce the raid6_end_write_request() spinlock window.
> > > 
> > > Andrew: please don't include these in -mm.  This one and the
> > > corresponding raid5 are wrong, and I'm not sure yet the unplug_device
> > > changes.
> > 
> > I am sure with the unplug_device. Just look follow the path...
> > 
> 
> What path?  There are probably several.  If I follow the path, will I
> see the same things as you see?  Who knows, because you haven't
> bothered to tell us what you see.

There are only two places where handle_list is possibly re-filled:
__release_stripe() and raidX_activate_delayed().  So raidXd should only
wakeup after these two points.

> 
> > 
> > Yes. Let's fix the error(). In any case, the current code is broken. (see raid5/6_end_read_request)
> 
> What will I see in raidX_end_read_request.  Surely it isn't that hard
> to write a few more sentences?

You should see md_error() in raidX_end_read_request isn't in any spinlocks.

> conf->working_disks isn't atomic_t and so decrementing without a
> spinlock isn't safe.  So lets just leave it all inside a spinlock.

test_and_set_bit(Faulty, &rdev->flags) protects it as well imho.
It can be enter only once.

> 
> Also I have a vague memory that clearing In_sync before Faulty is
> important, but I'm not certain of that.

Maybe, but seems not apply here.

> 
> Remember: the code is there for a reason.  It might not be a good
> reason, and the code could well be wrong.  But it would be worth your
> effort trying to find out what the reason is before blithely changing
> it (as I discovered recently with a change I suggested to
> invalidate_mapping_pages).

Thanks :)
-- 
Coywolf Qi Hunt
