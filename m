Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWDVSwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWDVSwn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 14:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWDVSwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 14:52:42 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:40626 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750921AbWDVSwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 14:52:41 -0400
Subject: Re: [PATCH] 'make headers_install' kbuild target.
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
In-Reply-To: <20060422144433.GE5010@stusta.de>
References: <1145672241.16166.156.camel@shinybook.infradead.org>
	 <20060422093328.GM19754@stusta.de>
	 <1145707384.16166.181.camel@shinybook.infradead.org>
	 <20060422123835.GA5010@stusta.de>
	 <1145710123.11909.241.camel@pmac.infradead.org>
	 <20060422132032.GB5010@stusta.de>
	 <1145712964.11909.258.camel@pmac.infradead.org>
	 <20060422141134.GC5010@stusta.de>
	 <1145715974.11909.272.camel@pmac.infradead.org>
	 <20060422144433.GE5010@stusta.de>
Content-Type: text/plain
Date: Sat, 22 Apr 2006 15:56:31 +0100
Message-Id: <1145717791.11909.305.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-22 at 16:44 +0200, Adrian Bunk wrote:
> The problem is you need #ifdef's everywhere.

No. You don't need ifdefs _anywhere_. Go and take a look at the MTD
headers which I already cleaned up.

You can split the messy files into two (or more) files and _keep_ them
in the same directory structure, although admittedly I did move the
user-visible parts out into include/mtd/ -- with the 'headers_install'
make target I didn't need to do that though.

> If part of a header file is part of the userspace ABI, this often means 
> that you need #ifdef __KERNEL__'s for the #include's of headers that 
> will not be part of the userspace ABI (like linux/compiler.h).

Er, if you're including those headers in a _purely_ user-visible file
then they're an error and should be removed altogether.

And if you're including those headers in a file which already _has_ some
ifdef __kernel__ in it, then you can just move the inclusion so that it
lands within the existing ifdefs. Like this, for example:
http://git.infradead.org/?p=users/dwmw2/headers-2.6.git;a=commitdiff;h=90a333de75b3f5efdc332f34f53768286967c306

> And how do you express that in header foo.h, the userspace part requires 
> the userspace part of bar.h, while the kernel-internal part of foo.h 
> also requires the kernel-internal part of bar.h?

You use foo-user.h, and foo-kernel.h. Or you include <kabi/foo.h> from
linux/foo.h if you can get Linus to take the patches. Nothing prevents
you from doing that. Please do that if that's what you want.

> I'm sorry, but I don't like your approach.

OK. This approach lets you send patches to Linus to move user-visible
stuff into a kabi/ directory if you can actually get him to accept such
patches. It allows you to move stuff over to a kabi/ directory
incrementally, without having to move everything in one go -- the export
process can pick files from wherever they happen to be, and put them in
the appropriate place in the exported header tree.

This approach _also_ allows those of us who are being more realistic to
do slightly less ambitious work which is just as useful but more likely
to get accepted, because we do the same cleanups to the _code_ but
without mucking around with new directories. 

But we're open to alternative plans -- what approach would you prefer?

-- 
dwmw2

