Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbVLGLQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbVLGLQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 06:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbVLGLQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 06:16:29 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:49339 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750867AbVLGLQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 06:16:28 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Date: Wed, 7 Dec 2005 12:17:41 +0100
User-Agent: KMail/1.9
Cc: Andy Isaacson <adi@hexapodia.org>,
       Nigel Cunningham <ncunningham@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20051205081935.GI22168@hexapodia.org> <200512070205.37414.rjw@sisk.pl> <20051207011019.GA2233@elf.ucw.cz>
In-Reply-To: <20051207011019.GA2233@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512071217.41814.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 7 December 2005 02:10, Pavel Machek wrote:
> > > I'm suggesting that rather than writing the clean pages out to the
> > > image, simply make their metadata available to a post-resume userland
> > > helper.  Something like
> > > 
> > > % head -2 /dev/swsusp-helper
> > > /bin/sh 105-115 192 199-259
> > > /lib/libc-2.3.2.so 1-250
> > > 
> > > where the userland program is expected to use the list of page numbers
> > > (and getpagesize(2)) to asynchronously page in the working set in an
> > > ionice'd manner.
> > 
> > The helper is not necessary, I think.
> 
> Actually, I like the helper. It is safest solution,

No, it's not.

Let me explain what I have in mind.

For starters, please observe that the addresses we use are page-aligned,
so the least significant bit is always zero.  Thus it can be used as a marker.

Now before we save the image we can mark blank pages by setting
the least significant bit of .orig_address to 1 in the coresponding PBEs.
We save the "marked" .orig_address values to the image.

Then, when we are about to save the page, we check the least
significant bit of its .orig_address, and save it only if this bit is zero.

When we are about to load a page, we first get a _zeroed_ page for it.
Next, we check if its .orig_address has the least significant bit set.
If not, we load the page, and otherwise we only clear that bit
(the page is already zero).

> and list of cached 
> pages in memory is going to be usefull for other stuff, too.
> 
> Imagine:
> 
> cat /dev/give-me-list-of-pages-in-page-cache > /tmp/delme.suspend
> echo disk > /sys/power/state
> nice ( cat /tmp/delme.suspend | read-those-pages-back ) &
> 
> Result is quite obviously safe (unless you mess up locking while
> dumping pagecache), and it is going to be rather easy to test. Just
> load the system as  much as you can while doing
> 
> while true; do cat /dev/give-me-list-of-pages-in-page-cache >
> /dev/null; done
> 
> . Still, limiting image size to 500MB is probably easier solution. I'm
> looking forward to that page.

This is in the works.

Greetings,
Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin
