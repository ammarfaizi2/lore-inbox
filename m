Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276370AbRI1W76>; Fri, 28 Sep 2001 18:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276356AbRI1W7u>; Fri, 28 Sep 2001 18:59:50 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:62097 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S276370AbRI1W7i>; Fri, 28 Sep 2001 18:59:38 -0400
Date: Sat, 29 Sep 2001 00:00:00 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Tools better than vmstat [was: 2.4.9-ac16 good perfomer?]
Message-ID: <20010929000000.G15457@flint.arm.linux.org.uk>
In-Reply-To: <200109281826.f8SIQLP06585@deathstar.prodigy.com> <Pine.LNX.4.33L.0109281535220.26495-100000@duckman.distro.conectiva> <20010928123455.B8222@mikef-linux.matchmail.com> <20010928210453.B15457@flint.arm.linux.org.uk> <20010928145324.A14801@mikef-linux.matchmail.com> <20010928230034.F15457@flint.arm.linux.org.uk> <20010928153301.A23261@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010928153301.A23261@mikef-linux.matchmail.com>; from mfedyk@matchmail.com on Fri, Sep 28, 2001 at 03:33:01PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 03:33:01PM -0700, Mike Fedyk wrote:
> Is sysrq easier to code for, or initiate-on-proc-read?

It's more to do with the framework that the debug code uses - you
effectively provide it with a function to do whatever analysis you
want on the pages, and it calls it for each and every page in each
zone.  After each zone, it calls it with NULL to allow you to
display any statistics you've gathered for the zone.

It repeats this across all nodes and all zones, so you get the full
picture.

There are currently two functions implemented - dump the raw data
for every single page in an easy to read format (but it is very
verbose, and takes a long time to dump out on large machines).
The second gives a summary of reserved, slab, ramdisk, free and
anonymous pages found in the zone.

I guess you'd need to do something like:

static unsigned int zone_age[MAX_AGE - MIN_AGE];

static void page_ages(struct page *page)
{
	int i;
	if (page) {
		zone_age[page->age - MIN_AGE]++;
		return;
	}

	for (i = MIN_AGE; i < MAX_AGE; i++) {
		printk("  Age %d: %u pages\n", i, zone_age[i]);
		zone_age[i] = 0;
	}
}

I'll dig out the patch tomorrow.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

