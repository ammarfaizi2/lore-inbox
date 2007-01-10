Return-Path: <linux-kernel-owner+w=401wt.eu-S965273AbXAKAOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965273AbXAKAOt (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 19:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965276AbXAKAOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 19:14:49 -0500
Received: from secure.tummy.com ([66.35.36.132]:34059 "EHLO secure.tummy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965273AbXAKAOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 19:14:48 -0500
X-Greylist: delayed 1876 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jan 2007 19:14:48 EST
Date: Wed, 10 Jan 2007 16:42:38 -0700
From: Sean Reifschneider <jafo@tummy.com>
To: linux-kernel@vger.kernel.org
Subject: select() setting ERESTARTNOHAND (514).
Message-ID: <20070110234238.GB10791@tummy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-Hashcash: 1:26:070110:linux-kernel@vger.kernel.org::w59L5oQkmXiGL1jP:000000000
	000000000000000000000002vSlJ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been looking at an issue in Python where a "time.sleep(1)" will
sporadically raise an IOError exception with errno=514.  time.sleep() is
implemented with select(), to get sub-second resolution.

In looking at the Linux code for ERESTARTNOHAND, I see that
include/linux/errno.h says this errno should never make it to the user.
However, in this instance we ARE seeing it.  Looking around on google shows
others are seeing it as well, though hits are few.

In looking at the select() code, I see that there are definitely cases
where sys_select() or sys_pselect7() can return -ERESTARTNOHAND.  However,
I don't know if this is expected to be caught elsewhere, or if returning it
here would send it back to user-space.  Worse, I don't fully understand
what the impact would be of trapping the ERESTARTNOHAND in the
sys_select/sys_pselect7 functions would be.

Is this something that's intended to be retrned back to the user, in which
case the message in include/linux/errno.h should be corrected and people
using time.sleep() in python will just have to live with it sometimes
raising an exception?  Or is it something that definitely should never
reach the user-space code, and there's some leak.

Just to be clear, this is happening only on one machine out of at least 4
where this has been tested.  The machine where it's happening is a dual
processor, dual core Xeon 2GHz 51xx series system.  The other systems where
it's not happening are single CPU Celeron or P4 class systems, though one
is a 2-year-old quad CPU Xeon running something <2GHz, IIRC.

More details on my investigation are at:

   http://www.tummy.com/journals/entries/jafo_20070110_154659

Thoughts?

Thanks,
Sean
(Not subscribed, I'll use the list archive to follow-up)
-- 
 Electricity travels a foot in a nanosecond.
                 -- Commodore Grace Murray Hopper
Sean Reifschneider, Member of Technical Staff <jafo@tummy.com>
tummy.com, ltd. - Linux Consulting since 1995: Ask me about High Availability

