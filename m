Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbTHYGfL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 02:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbTHYGfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 02:35:11 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:52632 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261548AbTHYGfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 02:35:04 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200308250023.39596.bzolnier@elka.pw.edu.pl>
References: <1061730317.31688.10.camel@gaston>
	 <200308250023.39596.bzolnier@elka.pw.edu.pl>
Message-Id: <1061793253.779.27.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 25 Aug 2003 08:34:14 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: [PATCH] Fix ide unregister vs. driver model
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-25 at 00:23, Bartlomiej Zolnierkiewicz wrote:
> On Sunday 24 of August 2003 15:05, Benjamin Herrenschmidt wrote:
> > Hi Bart !
> 
> Hi,
> 
> > This patch seem to have been lost, so here it is again. It fixes
> > an Ooops on unregistering hwifs due to the device model now having
> > mandatory release() functions. It also close the possible race we
> > had on release if the entry was in use (by or /sys typically) by
> > using a semaphore waiting for the release() to be called after
> > doing an unregister.
> 
> I can't see the race - all references to struct device should be dropped
> by driver model before finally calling ->release() function...

We have no race with the patch, that is we have no race when we wait
for the semaphore after calling unregister(). We have a race if we
don't as unregister() will drop a reference, but we may have pending
ones from sysfs still... so if we don't wait for release() to be
called, we may overwrite a struct device currently beeing used by
sysfs.

Ben.


