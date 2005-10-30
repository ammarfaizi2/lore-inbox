Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbVJ3VPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbVJ3VPz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 16:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbVJ3VPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 16:15:55 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:28338 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751122AbVJ3VPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 16:15:54 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 2/3] swsusp: move snapshot-handling functions to snapshot.c
Date: Sun, 30 Oct 2005 22:16:16 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200510301637.48842.rjw@sisk.pl> <200510301644.44874.rjw@sisk.pl> <20051030195254.GA1729@openzaurus.ucw.cz>
In-Reply-To: <20051030195254.GA1729@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510302216.17413.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 30 of October 2005 20:52, Pavel Machek wrote:
> Hi!
> 
> > This patch moves the snapshot-handling functions remaining in swsusp.c
> > to snapshot.c (ie. it moves the code without changing the functionality).
> >
> I'm sorry, but I acked this one too quickly. I'd prefer to keep "relocate" code where
> it is, and define "must not collide" as a part of interface.

That's doable, but frankly I don't like the idea.

> That will keep snapshot.c smaller/simpler, and I plan to
> eventually put responsibility for relocation to userspace.

Please note that the relocating code uses the page flags to mark the allocated
pages as well as to avoid the pages that should not be used.  In my opinion
no userspace process should be allowed to fiddle with the page flags.

Moreover, get_safe_page() is called directly by the arch code on x86-64,
so it has to stay in the kernel and hence it should be in snapshot.c.
OTOH the relocating code is nothing more than "if the page is not safe,
use get_safe_page() to allocate one" kind of thing, so I don't see a point
in taking it out of the kernel (in the future) too.

> That should simplify error handling at least: data structures
> needed for relocation can be kept in userspace memory,

Well, after the patches that are already in -mm we don't use any additional
data structures for this purpose, so that's not a problem, I think. ;-)

> and therefore we do not risk memory leak in case something goes wrong.

We don't.  All memory allocated with either get_image_page() or
get_safe_page() will eventually be released by swsusp_free(), no matter
what happens.

Greetings,
Rafael
