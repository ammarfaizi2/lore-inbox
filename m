Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268214AbUJDQBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268214AbUJDQBd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 12:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268258AbUJDQBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 12:01:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62900 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268214AbUJDQBS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 12:01:18 -0400
Date: Mon, 4 Oct 2004 11:28:02 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: akpm@osdl.org
Cc: germano.barreiro@cyclades.com, linux-kernel@vger.kernel.org,
       Wanda Rosalino <wanda.rosalino@cyclades.com>
Subject: [PATCH 2.6.9-rc2 2/33] char/cyclades: replace schedule_timeout() with msleep_interruptible()
Message-ID: <20041004142802.GE16374@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew, 

Nishanth's patch is a nice cleanup.

Please apply.

Germano, we should include this patch on top of
latest Linus's changes (which are on the mainline BK repository)
to start the QA testing process.

----- Forwarded message from Nishanth Aravamudan <nacc@us.ibm.com> -----

From: Nishanth Aravamudan <nacc@us.ibm.com>
Date: Fri, 1 Oct 2004 14:09:01 -0700
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: async@cyclades.com, kernel-janitors@lists.osdl.org
In-Reply-To: <20041001190704.GB4372@logos.cnet>
Subject: Re: [Kernel-janitors] [PATCH 2.6.9-rc2 2/33] char/cyclades: replace schedule_timeout() with msleep_interruptible()
X-Authentication-Warning: localhost.localdomain: nacc set sender to nacc@us.ibm.com using -f
X-Operating-System: Linux 2.6.8.1 (i686)
X-MIMETrack: Itemize by SMTP Server on USMail/Cyclades(Release 6.5.1|January 21, 2004) at
 10/01/2004 14:11:25

On Fri, Oct 01, 2004 at 04:07:04PM -0300, Marcelo Tosatti wrote:
> On Fri, Oct 01, 2004 at 01:10:31PM -0700, Nishanth Aravamudan wrote:
> > On Thu, Sep 30, 2004 at 01:48:18PM -0300, Marcelo Tosatti wrote:
> > > Well have to convert from jiffies (char_time) to msecs, just to 
> > > convert it back again to jiffies in msleep_interruptible().
> > > 
> > > Is this patch actually fixing any problem?
> > 
> > So there are a few things here:
> > 
> > 1) I think the overhead of the conversions is very small in comparison
> > with the eventual call to schedule() and such, so I don't think it's
> > that big of a deal -- *please* correct me if I am wrong, though.
> 
> No you are right the overhead is very small - I'm just trying
> to find a good reason to apply the change.

So I would say there are some good reasons to apply this patch.
Presuming this delay is somewhat long (it's a little hard to determine
this from the code, so your input here would again be appreciated),
having most drivers delay for long times using msleep*() goes a long way
towards consistency IMO. Since your timeout values are variables,
though, this becomes a little more difficult to argue :) Then again, if
we could figure out a way to use seconds (or some other human time-unit)
to express the delays, I think using msleep*() becomes pretty obvious.
Or even if it doesn't happen now for whatever reason, down the road this
makes the change that much easier

> > 2) I am currently trying to determine if it might be possible for the
> > timeout value (char_time, and I guess by extension, timeout) to be
> > expressed in milliseconds instead of jiffies. If you have any input on
> > that, Marcelo (or anyone from the list), I would really appreciate it.
> 
> I do not like the idea very much. 

Out of curiousity, why? Would it be particularly hard to do? If that is
the case, that's fine, I'm just wondering...

> I mean, what is the problem with that piece of code right now?
> 
> ie please educate me about msleep_interruptible()

To be honest, I think the arguments for using msleep() in general are
far stronger. msleep_interruptible() was recently introduced to have the
same effect except allow for a TASK_INTERRUPTIBLE based sleep. Since you
are checking for a signal after returning from schedule_timeout(),
msleep() isn't an option here ... What can be done here, actually, I
just realized is to remove the signal_pending() check, as
msleep_interruptible() does this as well.

There is another thing my patch didn't do, though - the

	current->state = TASK_RUNNING;

call is unnecessary, because schedule_timeout() / msleep_interruptible()
takes care of this.

I have made these changes in the following patch -- please revert the
previous cyclades patch and apply this one. Let me know if this is more
satisfactory (it definitely simplifies the while-loop a bit).

-Nish



Description: Uses msleep_interruptible() instead of schedule_timeout().
This allows the removal of one conditional, as msleep_interruptible()
should only return non-zero if signal_pending(current) is true.
current->state also does not need to be set, as msleep_interruptible()
(actually, schedule_timeout) is guaranteed to return in TASK_RUNNING.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.9-rc2-vanilla/drivers/char/cyclades.c	2004-09-13 17:15:49.000000000 -0700
+++ 2.6.9-rc2/drivers/char/cyclades.c	2004-10-01 13:55:19.000000000 -0700
@@ -2717,20 +2717,16 @@ cy_wait_until_sent(struct tty_struct *tt
 #ifdef CY_DEBUG_WAIT_UNTIL_SENT
 	    printk("Not clean (jiff=%lu)...", jiffies);
 #endif
-	    current->state = TASK_INTERRUPTIBLE;
-	    schedule_timeout(char_time);
-	    if (signal_pending(current))
+	    if (msleep_interruptible(jiffies_to_msecs(char_time)))
 		break;
 	    if (timeout && time_after(jiffies, orig_jiffies + timeout))
 		break;
 	}
-	current->state = TASK_RUNNING;
     } else {
 	// Nothing to do!
     }
     /* Run one more char cycle */
-    current->state = TASK_INTERRUPTIBLE;
-    schedule_timeout(char_time * 5);
+    msleep_interruptible(jiffies_to_msecs(char_time * 5));
 #ifdef CY_DEBUG_WAIT_UNTIL_SENT
     printk("Clean (jiff=%lu)...done\n", jiffies);
 #endif
@@ -2860,8 +2856,7 @@ cy_close(struct tty_struct *tty, struct 
     if (info->blocked_open) {
 	CY_UNLOCK(info, flags);
         if (info->close_delay) {
-            current->state = TASK_INTERRUPTIBLE;
-            schedule_timeout(info->close_delay);
+            msleep_interruptible(jiffies_to_msecs(info->close_delay));
         }
         wake_up_interruptible(&info->open_wait);
 	CY_LOCK(info, flags);

