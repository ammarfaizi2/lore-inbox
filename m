Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753489AbWKLXV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489AbWKLXV1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 18:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753492AbWKLXV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 18:21:27 -0500
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:28305 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1753489AbWKLXV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 18:21:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=JyY01TtVema7L4oe6Z8mGChff0BYEIIGHPp3jG/O/mJBTkCUG6c2JLIZ/6i+RIfkCrfIVU8sV45F33Ze3zaqHyrVkxd0vnek3qIYpQUzWhWIqEfrcQCqk9tVhml8zP788R23FSSGIs9adZVOPRJMION9fQ2YtgnpylqTbUublZw=  ;
X-YMail-OSG: AfZIpLgVM1nPZ1oCPiNv7FFlySUKpobcwqUOA327iIdfLv6rYJM2KRYEZa_BhycNVkhvw.BiSMDDLHcPMAiYI2xGv0jX4Tw.0MzJ.k23sGhIaBlkkvj2FzKKvqj_onOJZFqMEU2fcb2urd6oEbn4hMSSkFqoqlIgrrw-
From: David Brownell <david-b@pacbell.net>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.19-rc5 regression: can't disable OHCI  wakeup via sysfs
Date: Sun, 12 Nov 2006 15:21:21 -0800
User-Agent: KMail/1.7.1
Cc: arvidjaar@mail.ru, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0611121647490.8422-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0611121647490.8422-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611121521.22105.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > That's why the original OHCI autosuspend code initialized the "can this
> > root hub autosuspend" by testing the root hub wakeup flag:
> > 
> >         can_suspend = device_may_wakeup(&hcd->self.root_hub->dev);
> > 
> > and then cleared it if any enabled port wasn't suspended, any schedule
> > was active, or any deletions were pending.
> 
> But the silicon or board-level implementation bug you mentioned wouldn't 
> cause any of those tests to succeed, would it?  Hence it wouldn't prevent 
> an unwanted root-hub suspend.
> 
> Or are you trying to say that the original device_may_wakeup() value would 
> be 0 if the bug were detected?

The latter:  device_may_wakeup() never returns true.  There are three paths
for that:

  (a) userspace workaround, which is the regression that was reported;
  (b) the AMD 756 workaround, and
  (c) that board-specific quirk code.

Of course (c) hasn't been submitted yet because it didn't work ... evidently
because of the regression where device_may_wakeup(root_hub) was ignored.


> >   A quick glance at your new
> > "autostop" code shows that it only checks whether ports are enabled;
> > those other important constraints have been removed.
> 
> No, you must have misread the code.  It retains the checks for active 
> schedules or pending deletions.  There's no need to check for unsuspended 
> enabled ports, since autostop kicks in only when no ports are enabled.

Well, there are at least two regressions then.  One is the one in $SUBJECT,
and the other is for suspended-but-enabled ports.  (You've argued the latter
would be handled by a separate mechanism; fair enough, but I'm pointing
out that it's still a regression.)


> If you think autostop should also check for device_may_wakeup(), I'll make 
> it do so.  Remember though that autostop is intended to work even when 
> CONFIG_PM is off.

The original autosuspend logic would never kick in without PM; after all,
it's purely a power saving mechanism!  And testing device_may_wakeup() will
be restoring that behavior, since without PM that's always false.

- Dave
