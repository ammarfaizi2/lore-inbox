Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269319AbUJKW7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269319AbUJKW7j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 18:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269325AbUJKW7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 18:59:04 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:40303 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269319AbUJKW6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:58:52 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Totally broken PCI PM calls
Date: Mon, 11 Oct 2004 17:58:48 -0500
User-Agent: KMail/1.6.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Brownell <david-b@pacbell.net>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>
References: <1097455528.25489.9.camel@gaston> <200410110947.38730.david-b@pacbell.net> <1097533687.13642.30.camel@gaston>
In-Reply-To: <1097533687.13642.30.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200410111758.48441.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 October 2004 05:28 pm, Benjamin Herrenschmidt wrote:
> > A "hang" sounds like the pmcore bug I reported about a year ago...
> > 
> > It's rather foolish of the PM core to use the same semaphore to
> > protect system-wide suspend/resume operations that it uses to
> > for mutual exclusion on the device add/remove (which suspend
> > and resume callbacks did happily in 2.4) ... since it's routine to
> > unplug peripherals on suspended systems!
> 
> Definitely. One thing is: how to do it instead ? I've been thinking
> about it for a while and am still wondering... do we want a list
> mecanism with add/remove notifiers so the PM walk can keep in sync
> with devices added/removed ? or should addition/removal be simply
> postponed until the end of the sleep/wakeup process (I tend to vote
> for that).
> 

Yes, I think that devices that failed to resume (and all their children)
have to be moved by the core resume function into a separate list and
then destroyed (again by the driver core). For that we might need to add
bus_type->remove_device() handler as it seems that all buses do alot
of work outside of driver->remove handlers. The remove_device should
accept additional argument - something like dead_device that would
suggest that driver should not be alarmed by any errors during unbind/
removal process as the device (or rather usually its parent) is simply
not there anynore.

Just my $.02

-- 
Dmitry
