Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVAWXoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVAWXoo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 18:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVAWXnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 18:43:10 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:10693 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261388AbVAWXe3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 18:34:29 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: usbmon, usb core, ARM
Date: Sun, 23 Jan 2005 15:34:23 -0800
User-Agent: KMail/1.7.1
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       greg@kroah.com
References: <20050118212033.26e1b6f0@localhost.localdomain> <200501202228.31840.david-b@pacbell.net> <20050122001237.38596a5b@localhost.localdomain>
In-Reply-To: <20050122001237.38596a5b@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501231534.23583.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 January 2005 12:12 am, Pete Zaitcev wrote:
> On Thu, 20 Jan 2005 22:28:31 -0800, David Brownell <david-b@pacbell.net> wrote:
> 
> > By the way ... on the topic of usbmon rather than changing
> > usbcore, is there a brief writeup of what you want this
> > new version to be doing -- and how?  Like, why put the
> > spy hooks in that location, rather than any of the other
> > choices.  (Many of them would be less surprising to me!)
> 
> The main idea was to make usbmon invisible if it's not actively monitoring.
> But after thinking about your message I see that it was a misguided approach.
> I'm going to add "if (usbmon_is_running(bus)) usb_mon_hook(bus, urb);" into
> hot paths instead, approximately where current suggestion comments are.

OK ...


> I cannot figure out if you understand the nature of the problem with current
> usbmon,

Where "current" == "research project from a couple years ago, which
doesn't even compile any more"?!?  I don't think many people would,
which is why I wanted to see more info ... :)


> so let me restate it. Simply put, neither dev nor hcd are available 
> at the time urb->complete is called,

Completely untrue.  They are at a minimum provided through the URB itself,
and giveback (which is the only place that call is made!) is passed the HCD
as a parameter.  Or aren't you talking about 2.6.11 code?


> and this is what usbmon intercepts. 
> For one thing, dev is down-counted in usb_unlink_urb().

I don't see any refcounting calls in that routine.  It couldn't change
the refcounts, in any case ... the HCD owns the URB until giveback(),
and all unlinking does is accelerate getting to that giveback().


> Adding hooks explicitly has its disadvantages. Although the giveback
> path is much better, in the submit path such hook cannot inform usbmon
> if the submission fails, and an additional hook is needed. Anyhow, you'll
> see it all in the patch, please give me a couple of days.

OK.  Though I'd still like to see the usbcore hooks as a separate patch
(which can be easily reviewed), with docs (and maybe an example) to
help (idiots like) me see how it's supposed to work.  For example,
how does userspace provide a filter to say what URBs it's interested
in, and what level of information to report?  (Like, "only the first N
bytes of data", timestamping, etc.)  That is, how would a USB analogue
of tcpdump be able to say "spy on what happens with that device", or
"spy on all enumeration".

- Dave

 
> Greetings,
> -- Pete
> 
