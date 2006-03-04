Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751772AbWCDACk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbWCDACk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 19:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWCDACk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 19:02:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46269 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751772AbWCDACj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 19:02:39 -0500
Date: Fri, 3 Mar 2006 16:03:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Peterson <dsp@llnl.gov>
Cc: dthompson@lnxi.com, arjan@infradead.org,
       bluesmoke-devel@lists.sourceforge.net, hch@lst.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/15] EDAC: switch to kthread_ API
Message-Id: <20060303160358.57197d23.akpm@osdl.org>
In-Reply-To: <200603031520.29855.dsp@llnl.gov>
References: <4408050A0200003600000CC8@zoot.lnxi.com>
	<200603031520.29855.dsp@llnl.gov>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Peterson <dsp@llnl.gov> wrote:
>
> On Friday 03 March 2006 07:57, Doug Thompson wrote:
> > Currently the timer event code performs two operations:
> >
> >   1) ECC polling and
> >   2) PCI parity polling.
> >
> > I want to split those from each other, so each can have a seperate cycle
> > rate (also adding a sysfs cycle control for the PCI parity timing in
> > addition to the existing ECC cycle control).
> 
> Yes, this sounds like a good idea.  Using schedule_delayed_work() to
> independently implement each polling cycle, we should be able to get
> rid of the EDAC kernel thread.

That would suit.  One needs to be quite careful about killing everything
off in the close->rmmod side of things, especially if the delayed work
handler re-arms itself.  We have a pending (and possibly executing) timer
handler to worry about, then a pending (and possibly executing) keventd
handler to worry about.

We've got this cancel_rearming_delayed_work() thing - I was never terribly
happy about it, but I think it works.

