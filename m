Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268042AbUI1ReO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268042AbUI1ReO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 13:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268025AbUI1Rdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 13:33:46 -0400
Received: from peabody.ximian.com ([130.57.169.10]:54958 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268051AbUI1Rcw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 13:32:52 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       gamin-list@gnome.org, viro@parcelfarce.linux.theplanet.co.uk,
       iggy@gentoo.org
In-Reply-To: <1096343091.11477.5.camel@vertex>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
	 <20040927214141.688b2b2c.akpm@osdl.org>
	 <1096337698.5103.145.camel@localhost>  <1096343091.11477.5.camel@vertex>
Content-Type: text/plain
Date: Tue, 28 Sep 2004 13:31:28 -0400
Message-Id: <1096392688.4911.39.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 23:44 -0400, John McCutchan wrote:

> We need a timer to wake up any processes blocking on a read() call. The
> reason it has to be a timer is because the code paths that get run when
> an event is queued are not safe places to wake up blocked processes (But
> I a kernel amateur so I am probably wrong).

We probably don't need the timer.  wake_up_interruptible() does not
sleep; we can call it from anywhere.  Heck, timers are more atomic than
where we probably need to wake stuff up from anyhow.

But it is not easy to tell where that place is, because it looks like
the timer just runs every 250ms?  That is no good.

I suspect that we can remove all of the timer stuff and just do

	/* wake up!  you are going to miss the bus! */
	wake_up_interruptible(&dev->wait);

after

	list_add_tail(&kevent->list, &dev->events);

in inotify_dev_queue_event().

	Robert Love


