Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932679AbVLGBKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbVLGBKi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 20:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbVLGBKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 20:10:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4067 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932679AbVLGBKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 20:10:37 -0500
Date: Wed, 7 Dec 2005 02:10:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andy Isaacson <adi@hexapodia.org>,
       Nigel Cunningham <ncunningham@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Message-ID: <20051207011019.GA2233@elf.ucw.cz>
References: <20051205081935.GI22168@hexapodia.org> <20051206121835.GN1770@elf.ucw.cz> <20051206181520.GA21501@hexapodia.org> <200512070205.37414.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512070205.37414.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm suggesting that rather than writing the clean pages out to the
> > image, simply make their metadata available to a post-resume userland
> > helper.  Something like
> > 
> > % head -2 /dev/swsusp-helper
> > /bin/sh 105-115 192 199-259
> > /lib/libc-2.3.2.so 1-250
> > 
> > where the userland program is expected to use the list of page numbers
> > (and getpagesize(2)) to asynchronously page in the working set in an
> > ionice'd manner.
> 
> The helper is not necessary, I think.

Actually, I like the helper. It is safest solution, and list of cached
pages in memory is going to be usefull for other stuff, too.

Imagine:

cat /dev/give-me-list-of-pages-in-page-cache > /tmp/delme.suspend
echo disk > /sys/power/state
nice ( cat /tmp/delme.suspend | read-those-pages-back ) &

Result is quite obviously safe (unless you mess up locking while
dumping pagecache), and it is going to be rather easy to test. Just
load the system as  much as you can while doing

while true; do cat /dev/give-me-list-of-pages-in-page-cache >
/dev/null; done

. Still, limiting image size to 500MB is probably easier solution. I'm
looking forward to that page.
								Pavel
-- 
Thanks, Sharp!
