Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262676AbVAVIMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbVAVIMt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 03:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbVAVIMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 03:12:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27014 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262676AbVAVIMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 03:12:47 -0500
Date: Sat, 22 Jan 2005 00:12:37 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: usbmon, usb core, ARM
Message-ID: <20050122001237.38596a5b@localhost.localdomain>
In-Reply-To: <200501202228.31840.david-b@pacbell.net>
References: <20050118212033.26e1b6f0@localhost.localdomain>
	<200501190908.35210.david-b@pacbell.net>
	<20050120113545.58ce18a3@localhost.localdomain>
	<200501202228.31840.david-b@pacbell.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2005 22:28:31 -0800, David Brownell <david-b@pacbell.net> wrote:

> By the way ... on the topic of usbmon rather than changing
> usbcore, is there a brief writeup of what you want this
> new version to be doing -- and how?  Like, why put the
> spy hooks in that location, rather than any of the other
> choices.  (Many of them would be less surprising to me!)

The main idea was to make usbmon invisible if it's not actively monitoring.
But after thinking about your message I see that it was a misguided approach.
I'm going to add "if (usbmon_is_running(bus)) usb_mon_hook(bus, urb);" into
hot paths instead, approximately where current suggestion comments are.

I cannot figure out if you understand the nature of the problem with current
usbmon, so let me restate it. Simply put, neither dev nor hcd are available
at the time urb->complete is called, and this is what usbmon intercepts.
For one thing, dev is down-counted in usb_unlink_urb(). This is why I tried
to find a way to avoid using them. Your "dev == hcd->self.root_hub" is
entirely out of question. But it's probably a moot point now anyway.

Adding hooks explicitly has its disadvantages. Although the giveback
path is much better, in the submit path such hook cannot inform usbmon
if the submission fails, and an additional hook is needed. Anyhow, you'll
see it all in the patch, please give me a couple of days.

Greetings,
-- Pete
