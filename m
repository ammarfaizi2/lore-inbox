Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVAMXJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVAMXJS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 18:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVAMXFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 18:05:25 -0500
Received: from waste.org ([216.27.176.166]:65480 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261806AbVAMXDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 18:03:08 -0500
Date: Thu, 13 Jan 2005 15:03:02 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Andrew Morton <akpm@osdl.org>, "Theodore Y. Ts'o" <tytso@MIT.EDU>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] random periodicity detection fix
Message-ID: <20050113230302.GD2940@waste.org>
References: <20050113064629.GZ2940@waste.org> <20050113223437.GH2760@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113223437.GH2760@pclin040.win.tue.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 11:34:37PM +0100, Andries Brouwer wrote:
> On Wed, Jan 12, 2005 at 10:46:29PM -0800, Matt Mackall wrote:
> 
> > The input layer is now sending us a bunch of events in a row for each
> > actual event. This shows up weaknesses in the periodicity detector and
> > using the high clock rate from get_clock: each keystroke is getting
> > accounted as 10 different tmaximal-entropy events.
> > 
> > A brief touch on a trackpad will generate as much as 2000 maximal
> > entropy events which is more than 2k of /dev/random output. IOW, we're
> > WAY overestimating input entropy.
> 
> Yes, indeed. I muttered about this long ago - let me see, yes,
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106271659930542&w=3
> 
> My patch did the opposite of your patch: I removed the
> add entropy call in input.c.

Unfortunately almost all the original call sites have been dropped, so
it's now easier to do it this way.

Further, the input folks can't be relied upon to do the right thing,
so it's better to grab _all_ the relevant data in one place and do our
own filtering. 5/5 is a step in that direction, but the filtering is
currently primitive.

Eventually we can do as gendisk does and embed a pointer to an
entropy_state in the input objects and get back to all devices being
monitored independently. 

I've got a few dozen more /dev/random cleanup patches to push before
that happens though.

> Also, when there are several sources, all constant or almost constant,
> then merging the streams might cause one to see variation where
> there isn't really any.

Agreed. Not a huge problem for input as the sources are all really a
single console user (or so), but I'd like to check periodicity
per-device and globally eventually.

-- 
Mathematics is the supreme nostalgia of our time.
