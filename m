Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbWD1JTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbWD1JTn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 05:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbWD1JTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 05:19:43 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:472 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965195AbWD1JTm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 05:19:42 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Fri, 28 Apr 2006 11:19:01 +0200
User-Agent: KMail/1.9.1
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <nigel@suspend2.net>
References: <200604242355.08111.rjw@sisk.pl> <200604271727.39194.rjw@sisk.pl> <20060427205533.GA10737@elf.ucw.cz>
In-Reply-To: <20060427205533.GA10737@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604281119.02575.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 27 April 2006 22:55, Pavel Machek wrote:
> > On Tuesday 25 April 2006 12:31, Rafael J. Wysocki wrote:
> > > On Tuesday 25 April 2006 12:04, Pavel Machek wrote:
> > > > > > Okay, so it can be done, and patch does not look too bad. It still
> > > > > > scares me. Is 800MB image more responsive than 500MB after resume?
> > > > > 
> > > > > Yes, it is, slightly, but I think 800 meg images are impractical for
> > > > > performance reasons (like IMO everything above 500 meg with the current
> > > > > hardware).  However this means we can save 80% of RAM with the patch
> > > > > and that should be 400 meg instead of 250 on a 500 meg machine, or
> > > > > 200 meg instead of 125 on a 250 meg machine.
> > > > 
> > > > Could we get few people trying it on such small machines to see if it
> > > > is really that noticeable?
> > > 
> > > OK, I'll try to run some tests on a machine with smaller RAM (and slower CPU).
> > 
> > Done, although it was not so easy to find the box.  This was a PII 350MHz w/
> > 256 MB of RAM.
> > 
> > I invented the following test:
> > - ran KDE with 4 desktops,
> > - ran Firefox, OpenOffice.org 1.1 (with a simple spreadsheet), and GIMP (with
> > 2 pictures) each on its own desktop,
> > - ran the memory meter from the KDE's Info Center and two konsoles
> > on the remaining desktop - one konsole with a kernel compilation and the
> > other with a root session used for suspending the box (the built-in swsusp
> > was used),
> > so the box's RAM was almost fully occupied with ~30% taken by the page cache.
> > 
> > Then I suspended the box and measured the time from the start of resume
> > (ie. leaving GRUB) to the point at which I had all of the application windows
> > fully rendered on their respective desktops (I always switched the desktops
> > in the same order, starting from the memory meter's one, through the OOo's
> > and Firefox's, finishing on the GIMP's one and I always switched the
> > desktop as soon as the window(s) on it were fully rendered).
> > 
> > I ran it a couple of times on the 2.6.17-rc1-mm2 kernel with and without
> > the patch and the results (on the average) are the following:
> > 
> > (a) 25-28s with the patch
> > (b) 30-33s without it
> 
> Ook, thanks for testing. I guess it is ready for -mm when Nick is
> happy with it ...

OK, I'm waiting for Nick to respond, then. :-)

Still I'd like to change one more thing in the final patch.  Namely,
instead of this:

@@ -153,6 +153,10 @@ static int snapshot_ioctl(struct inode *
        case SNAPSHOT_UNFREEZE:
                if (!data->frozen)
                        break;
+               if (data->ready && in_suspend) {
+                       error = -EPERM;
+                       break;
+               }
                down(&pm_sem);
                thaw_processes();
                enable_nonboot_cpus();

I'd like to do:

 	case SNAPSHOT_UNFREEZE:
 		if (!data->frozen)
 			break;
+               	if (data->ready)
+			swsusp_free();
 		down(&pm_sem);
		thaw_processes();
		enable_nonboot_cpus();

so unfreeze() won't return the error.

Greetings,
Rafael
