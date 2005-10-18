Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVJRJRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVJRJRW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 05:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbVJRJRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 05:17:22 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:48581 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750786AbVJRJRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 05:17:21 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/4] swsusp: clean up resume error path
Date: Tue, 18 Oct 2005 11:17:26 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
References: <200510172336.53194.rjw@sisk.pl> <200510172350.05415.rjw@sisk.pl> <20051017234723.GB13148@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20051017234723.GB13148@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510181117.27068.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 18 of October 2005 01:47, Pavel Machek wrote:
> Hi!
> 
> > The following patch removes an incorrect call to restore_highmem() from
> > the resume error path (there's no saved highmem in that case) and makes
> > swsusp touch the softlockup watchdog if there's no error (currently it only
> > touches the watchdog if an error occurs).
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Index: linux-2.6.14-rc4-mm1/kernel/power/swsusp.c
> > ===================================================================
> > --- linux-2.6.14-rc4-mm1.orig/kernel/power/swsusp.c	2005-10-17 23:28:34.000000000 +0200
> > +++ linux-2.6.14-rc4-mm1/kernel/power/swsusp.c	2005-10-17 23:28:47.000000000 +0200
> > @@ -628,7 +629,6 @@
> >  	 */
> >  	swsusp_free();
> >  	restore_processor_state();
> > -	restore_highmem();
> >  	touch_softlockup_watchdog();
> >  	device_power_up();
> >  	local_irq_enable();
> 
> I don't like this one. restore_highmem() does freeing of allocated
> pages. If swsusp_arch_suspend() fails in specific way, I suspect it
> could leak highmem.

The pages to be freed are only allocated in suspend_prepare_image()
(now swsusp_save()), which is on suspend, and this is the resume
error path.

The boot kernel that performs the resume does not save highmem,
so it need not and IMO it should not call restore_highmem() in the
error path (if nothing more, it's misleading).  OTOH if the resume
succeeds, restore_highmem() will be called from swsusp_suspend().

Gretings,
Rafael
