Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbTIDL6c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 07:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264932AbTIDL6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 07:58:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:7312 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264929AbTIDL60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 07:58:26 -0400
Date: Thu, 4 Sep 2003 13:58:25 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: revert to 2.6.0-test3 state
Message-ID: <20030904115824.GD24015@atrey.karlin.mff.cuni.cz>
References: <20030903190442.GA2787@elf.ucw.cz> <Pine.LNX.4.33.0309031621380.944-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0309031621380.944-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This patch reverts swsusp to known good state (before Patrick made his
> > untested changes to it). I had to do some changes to both swsusp.c and
> > power.c to keep it compilable. Please apply,
> 
> Pavel, why do you have to be so difficult? I realize you're sore that I 
> modified the code you maintain and unintentionally broke. However, it does 
> not benefit either of us for you to intentionally break my code in return, 
> especially considering I've since fixed the outstanding problems in my 
> changes. 

I did not *intentionally* break your code, and I'm sorry that you
think I did. I was trying to make minimal patch.

> > --- clean/kernel/power/main.c	2003-08-27 12:00:53.000000000 +0200
> > +++ linux/kernel/power/main.c	2003-09-03 20:57:00.000000000 +0200
> > @@ -178,25 +178,7 @@
> >  	if (pm_disk_mode == PM_DISK_FIRMWARE)
> >  		return pm_ops->enter(PM_SUSPEND_DISK);
> >  
> > -	if (!have_swsusp)
> > -		return -EPERM;
> > -
> > -	pr_debug("PM: snapshotting memory.\n");
> > -	in_suspend = 1;
> > -	if ((error = swsusp_save()))
> > -		goto Done;
> > -
> > -	if (in_suspend) {
> > -		pr_debug("PM: writing image.\n");
> > -		error = swsusp_write();
> > -		if (!error)
> > -			error = power_down(pm_disk_mode);
> > -		pr_debug("PM: Power down failed.\n");
> > -	} else
> > -		pr_debug("PM: Image restored successfully.\n");
> > -	swsusp_free();
> > - Done:
> > -	return error;
> > +	BUG();
> >  }
> 
> This is bullshit. It will not only introduce a compile warning, but it's
> not user-friendly (I can forward flames from Linus about adding gratuitous
> BUG()s to the kernel if you like). You also intentionally break my code,
> instead of doing something reasonable like
> 
> +	return 0; 

It is bug if we reach this point, because software_suspend() should be
called first, and it should have returned. But if you want return 0
there and warning fixed, no problem, you can have return 0. It should
be unreachable anyway.

> > @@ -228,6 +210,11 @@
> >  {
> >  	int error = 0;
> >  
> > +	if ((state == PM_SUSPEND_DISK) && (pm_disk_mode != PM_DISK_FIRMWARE)) {
> > +		software_suspend();
> > +		return -EAGAIN;
> > +	}
> 
> Why return -EAGAIN? 
> 
> Why even call software_suspend() at all. That's not the right thing to do, 
> nor is it what I want to do (which I implied in saying that I would not 
> use it). And, you've broken the possiblity of using the actualy ACPI S4 
> low-power state. 

I'm doing return -EAGAIN so I can call driver model myself, and so
that your code does not proceed with stopping tasks/etc after I've
done full suspend/resume cycle.

I see your point about S4. I want to use as little as power/main.c
infrastructure as possible for now, and this seems like the way to do
it.

Okay, it seems that I can move this to pm_suspend, and it will look better.

> >  static int pm_resume(void)
> 
> > +	software_resume();
> >  	return 0;
> >  }
> 
> This is just silly, from a design point of view. You now have two 
> functions that do the same thing, one just calls the other. Why? 

I wanted to leave my way back to using your code as simple as possible
(minimal changes). Anyway its okay to kill pm_resume and then readd it
I guess.

> Please resubmit the patch without this crap, and I will not argue. 

Does this diff look better to you? [Not tested yet so not good enough
for submission].

						Pavel

--- clean/kernel/power/main.c	2003-08-27 12:00:53.000000000 +0200
+++ linux/kernel/power/main.c	2003-09-04 13:48:08.000000000 +0200
@@ -172,31 +172,10 @@
 
 static int pm_suspend_disk(void)
 {
-	int error;
-
 	pr_debug("PM: Attempting to suspend to disk.\n");
 	if (pm_disk_mode == PM_DISK_FIRMWARE)
 		return pm_ops->enter(PM_SUSPEND_DISK);
-
-	if (!have_swsusp)
-		return -EPERM;
-
-	pr_debug("PM: snapshotting memory.\n");
-	in_suspend = 1;
-	if ((error = swsusp_save()))
-		goto Done;
-
-	if (in_suspend) {
-		pr_debug("PM: writing image.\n");
-		error = swsusp_write();
-		if (!error)
-			error = power_down(pm_disk_mode);
-		pr_debug("PM: Power down failed.\n");
-	} else
-		pr_debug("PM: Image restored successfully.\n");
-	swsusp_free();
- Done:
-	return error;
+	return 0;
 }
 
 
@@ -329,59 +308,17 @@
 
 int pm_suspend(u32 state)
 {
+	if ((state == PM_SUSPEND_DISK) && (pm_disk_mode != PM_DISK_FIRMWARE)) {
+		software_suspend();
+		return 0;
+	}
 	if (state > PM_SUSPEND_ON && state < PM_SUSPEND_MAX)
 		return enter_state(state);
 	return -EINVAL;
 }
 
-
-/**
- *	pm_resume - Resume from a saved image.
- *
- *	Called as a late_initcall (so all devices are discovered and 
- *	initialized), we call swsusp to see if we have a saved image or not.
- *	If so, we quiesce devices, the restore the saved image. We will 
- *	return above (in pm_suspend_disk() ) if everything goes well. 
- *	Otherwise, we fail gracefully and return to the normally 
- *	scheduled program.
- *
- */
-
-static int pm_resume(void)
-{
-	int error;
-
-	if (!have_swsusp)
-		return 0;
-
-	pr_debug("PM: Reading swsusp image.\n");
-
-	if ((error = swsusp_read()))
-		goto Done;
-
-	pr_debug("PM: Preparing system for restore.\n");
-
-	if ((error = suspend_prepare(PM_SUSPEND_DISK)))
-		goto Free;
-
-	pr_debug("PM: Restoring saved image.\n");
-	swsusp_restore();
-
-	pr_debug("PM: Restore failed, recovering.n");
-	suspend_finish(PM_SUSPEND_DISK);
- Free:
-	swsusp_free();
- Done:
-	pr_debug("PM: Resume from disk failed.\n");
-	return 0;
-}
-
-late_initcall(pm_resume);
-
-
 decl_subsys(power,NULL,NULL);
 
-
 #define power_attr(_name) \
 static struct subsys_attribute _name##_attr = {	\
 	.attr	= {				\

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
