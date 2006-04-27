Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWD0Chl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWD0Chl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 22:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWD0Chl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 22:37:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1510 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964900AbWD0Chl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 22:37:41 -0400
Subject: Re: Simple header cleanups
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604261917270.3701@g5.osdl.org>
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.64.0604261917270.3701@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 27 Apr 2006 03:37:37 +0100
Message-Id: <1146105458.2885.37.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-26 at 19:18 -0700, Linus Torvalds wrote:
> Hmm. Every time we've done this in the past, something has broken, so I'd 
> actually _much_ rather wait until early in the 2.6.18 cycle than do it 
> now.

OK. I've tried to be _very_ conservative with this set -- it mostly is
just a case of moving #includes from one part of a header file to
another so they aren't exposed to userspace. I figured the more
interesting stuff could come later.

But if you'd rather have it only in -mm only for now, that's fine.

> Yeah, people shouldn't include kernel headers, but if they didn't, this 
> patch wouldn't matter. And when they do, patches like this tends to show 
> some strange app that depends on the current header layout.. Gaah.

Well, yes, but we all know that people _have_ to include kernel headers.
We can't just bury our head in the sand and say "they mustn't do that".
The kernel headers contain all the juicy stuff like structure
definitions and ioctls which you _need_ in order to communicate with the
kernel.

The problem is that we don't actually have any _discipline_ about how we
throw our kernel headers over the wall. We never even _think_ about how
usable they are in userspace, or how what we're doing will affect
userspace.

That's why there are so many silly little cleanups which I had to make
just to be able to use some recent kernel headers sanely again in
userspace, instead of the ancient fork we'd taken in Fedora from a 2.4
kernel.

The answer to this lies in my other git tree, at
git://git.infradead.org/hdrinstall-2.6.git -- again in gitweb, at
http://git.infradead.org/?p=hdrinstall-2.6.git;a=summary

Based on an original implementation by Arnd Bergmann, this implements
new 'make headers_install' target for the kernel Makefiles, which
exports a selection of the contents of our include/ directories to
userspace, having run them through unifdef where appropriate.

This gives us a pristine set of headers which _are_ suitable for
userspace inclusion. I've been talking to maintainers of the
'kernel-headers' or similar packages in other distributions, and we seem
to have a consensus that this is going to be useful. All the
distributions can ship basically the _same_ set of headers, instead of
all doing their own thing to clean them up, and getting it inconsistent
across distros.

As well as achieving that laudable goal, the export step also allows us
(and in particular our janitor-types) to _read_ through the headers
which userspace gets, and start to clean them up a bit more, cleaning up
namespace pollution and removing things which are still visible but
which shouldn't be. It allows us to take a diff of the _exported_
headers between one release and the next, and see the user-visible
changes in isolation.

-- 
dwmw2

