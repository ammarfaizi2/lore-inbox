Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbTFJXUW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 19:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTFJXUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 19:20:21 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:10989 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S261787AbTFJXUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 19:20:19 -0400
Subject: Re: 2.5.70-mm7
From: Christophe Saout <christophe@saout.de>
To: Shane Shrybman <shrybman@sympatico.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Joe Thornber <joe@fib011235813.fsnet.co.uk>
In-Reply-To: <1055286765.2371.4.camel@mars.goatskin.org>
References: <1055286765.2371.4.camel@mars.goatskin.org>
Content-Type: text/plain
Message-Id: <1055288033.27439.4.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jun 2003 01:33:53 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mit, 2003-06-11 um 01.12 schrieb Shane Shrybman:

> Yeah, I got the same. The message is something like 
> "ioctl cmd 2 No such address or device".

Ok, I think I found the problem.

In dm-ioctl.c in the function create this got changed:

-       int minor;
+       unsigned int minor = 0;

...

-       minor = (param->flags & DM_PERSISTENT_DEV_FLAG) ?
-               minor(to_kdev_t(param->dev)) : -1;
+       if (param->flags & DM_PERSISTENT_DEV_FLAG)
+               minor = minor(to_kdev_t(param->dev));

So, the variable minor is 0 now instead of -1 when the device shouldn't
be persistent. That's bad because 0 is a valid minor.

And now, in dm.c in alloc_dev, called by dm_create

        /* get a minor number for the dev */
-       minor = (minor < 0) ? next_free_minor() : specific_minor(minor);
-       if (minor < 0) {
+       r = (minor < 0) ? next_free_minor(&minor) :
specific_minor(minor);
+       if (r < 0) {

Here the minor is tested for being < 0 (which by the way can't be with
minor being unsigned, so this cleanup is bogus). The kernel always tries
to bind the new logical volume devices to the same minor, which of
course fails after the first one.

> Joe, do we need to upgrade some tools or something here?

No, because there are no new tools and the ioctl interface hasn't
changed (same dm-ioctl.h)

-- 
Christophe Saout <christophe@saout.de>

