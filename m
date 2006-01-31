Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWAaK5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWAaK5l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 05:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWAaK5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 05:57:41 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:15086 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750746AbWAaK5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 05:57:40 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [ 06/23] [Suspend2] Disable usermode helper invocations when the freezer is on.
Date: Tue, 31 Jan 2006 11:58:16 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
References: <20060126034518.3178.55397.stgit@localhost.localdomain> <200601302305.18202.rjw@sisk.pl> <200601311324.38149.nigel@suspend2.net>
In-Reply-To: <200601311324.38149.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601311158.16882.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 31 January 2006 04:24, Nigel Cunningham wrote:
> On Tuesday 31 January 2006 08:05, Rafael J. Wysocki wrote:
> > On Thursday 26 January 2006 04:45, Nigel Cunningham wrote:
> > > Disable usermode helper invocations when the freezer is on. This avoids
> > > deadlocks due to hotplug events occuring while processes are frozen.
> > >
> > > Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
> > >
> > >  kernel/kmod.c |    4 ++++
> > >  1 files changed, 4 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/kernel/kmod.c b/kernel/kmod.c
> > > index 51a8920..12afa2c 100644
> > > --- a/kernel/kmod.c
> > > +++ b/kernel/kmod.c
> > > @@ -36,6 +36,7 @@
> > >  #include <linux/mount.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/init.h>
> > > +#include <linux/freezer.h>
> > >  #include <asm/uaccess.h>
> > >
> > >  extern int max_threads;
> > > @@ -249,6 +250,9 @@ int call_usermodehelper_keys(char *path,
> > >  	if (!khelper_wq)
> > >  		return -EBUSY;
> > >
> > > +	if (freezer_is_on())
> > > +		return 0;
> > > +
> > >  	if (path[0] == '\0')
> > >  		return 0;
> >
> > Disabling the usermode helper while freeze_processes() is executed seems to
> > be a good idea to me, but I think it should be done with a mutex or
> > something like that.
> 
> With the refrigerator code you guys are using at the moment, ouldn't that 
> result in deadlocks when we later try to freeze the process in preparation 
> for the atomic restore? (Or perhaps you don't freeze processes at that 
> point?)

I'm not sure what you mean.  I said "mutex" because you seem to have a race
here (the freezer may be started right after the freezer_is_on() check).  IMO
the freezer should disable the invocations of new usermode helpers and
wait util all of the already running helpers are finished.  For this purpose
two variables would be needed and a lock.

Greetings,
Rafael
