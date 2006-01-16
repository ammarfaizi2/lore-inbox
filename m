Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWAPSmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWAPSmc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 13:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWAPSmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 13:42:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55769 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751156AbWAPSma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 13:42:30 -0500
Subject: Re: wireless: recap of current issues (configuration)
From: Dan Williams <dcbw@redhat.com>
To: Stuffed Crust <pizza@shaftnet.org>
Cc: Sam Leffler <sam@errno.com>, Jeff Garzik <jgarzik@pobox.com>,
       Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060116172817.GB8596@shaftnet.org>
References: <20060113195723.GB16166@tuxdriver.com>
	 <20060113212605.GD16166@tuxdriver.com>
	 <20060113213011.GE16166@tuxdriver.com>
	 <20060113221935.GJ16166@tuxdriver.com> <1137191522.2520.63.camel@localhost>
	 <20060114011726.GA19950@shaftnet.org> <43C97605.9030907@pobox.com>
	 <20060115152034.GA1722@shaftnet.org> <43CAA853.8020409@errno.com>
	 <20060116172817.GB8596@shaftnet.org>
Content-Type: text/plain
Date: Mon, 16 Jan 2006 13:39:58 -0500
Message-Id: <1137436799.19714.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 (2.5.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-16 at 12:28 -0500, Stuffed Crust wrote:
> Scans should be specified as "non-distruptive" so the hardware driver
> has to twiddle whatever bits are necessary to return the hardware to the
> same state that it was in before the scan kicked in.  Beyond that, the
> scanning smarts are all in the 802.11 stack.  The driver should be as
> dumb as possible.  :)

This is quite important... from a user perspective, it might be 2, 5, or
15 seconds before the card can actually scan all channels.
Unfortunately, background (passive) scanning by definition can't find
all access points, so you're going to need to do active scanning.
However, that active scanning should be controlled by userspace, not the
driver.  Only userspace knows what policies the user him/herself has set
on powersaving mode.

> Background scanning, yes -- but there are all sorts of different
> thresholds and types of 'scanning' to be done, depending on how
> disruptive you are willing to be, and how capable the hardware is.  Most
> thin MACs don't filter out foreign BSSIDs on the same channel when
> you're joined, which makes some things a lot easier.

Scanning has the tradeoff of updated network list vs. saving power +
network disruption.  The user, or programs delegated by the user, need
to make that choice, not the stack or the driver.

-------------

Furthermore, and this is also extremely important, user apps need to
know when the scan is done.  From my look at drivers, _all_ cards know
when the hardware is in scanning states, and when its done.  What many
don't do is communicate that information to userspace via wireless
events.  The userspace app that requested scanning is then stuck
busy-waiting for the SIOCGIWSCAN to return success, which just sucks.
Much better if all drivers had the wireless event so that the userspace
app could just fire off the scan with SIOCSIWSCAN, and parse the results
when the event comes back rather than spinning.

In the netlink world, this would of course be done by multicasting the
"Scan Done" message to all interested clients, which would be just as
good.

Dan

