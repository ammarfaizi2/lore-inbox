Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVAIUfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVAIUfP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 15:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVAIUfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 15:35:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:19855 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261755AbVAIUem (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 15:34:42 -0500
Date: Sun, 9 Jan 2005 12:34:41 -0800
From: Chris Wright <chrisw@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: utz lehmann <lkml@s2y4n2c.de>, LKML <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] scheduling priorities with rlimit
Message-ID: <20050109123441.O469@build.pdx.osdl.net>
References: <1105290936.24812.29.camel@segv.aura.of.mankind> <1105297598.4173.52.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1105297598.4173.52.camel@laptopd505.fenrus.org>; from arjan@infradead.org on Sun, Jan 09, 2005 at 08:06:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Arjan van de Ven (arjan@infradead.org) wrote:
> On Sun, 2005-01-09 at 18:15 +0100, utz lehmann wrote:
> > Hi
> > 
> > I really like the idea of controlling the maximum settable scheduling
> > priorities via rlimit. See the Realtime LSM thread. I want to give users
> > the right to raise the priority of previously niced jobs.
> > 
> > I have modified Chris Wright's patch (against 2.6.10):
> > (http://marc.theaimsgroup.com/?l=linux-kernel&m=110513793228776&w=2)
> > 
> > - allow always to increase nice levels (lower priority).
> > - set the default for RLIMIT_PRIO to 0.
> > - add the other architectures.
> > 
> > With this the default is compatible with the old behavior.
> > 
> > With RLIMIT_PRIO > 0 a user is able to raise the priority up to the
> > value. 0-39 for nice levels 19 .. -20, 40-139 for realtime priorities
> > (0 .. 99).
> 
> this is a bit of an awkward interface don't you think?

Yes it is.  But I didn't think of a better one.

> I much rather have the rlimit match the exact nice values we communicate
> to userspace elsewhere, both to be consistent and to not expose
> scheduler internals to userpsace.

The problem is the numbers are inconsistent between user interfaces already.
RT priorities are [0, 99], nice vaules are [-20, 19].  Perhaps it'd be
simpler to break it down to just three values for the rlimit.

0: Same as now, raise nice value only.
1: Can lower nice value.
2: Can set RT policy (this includes any priority [1, 99], or optionally
max out at something lower than 99, reserving full CAP_SYS_NICE to 99).

Each level inherits the permissions of the lower level, and none of them
allow the CAP_SYS_NICE ability to affect processes other than your own.

> Also I like the idea of allowing sysadmins to make certain users/groups
> nice levels 5 and higher (think a university machine that makes all
> students nice 5 and higher only, while giving staff 0 and higher, and
> the sysadmin -5 and higher ;)

This is a separate issue.  It's about setting the default during login
which can be done with setpriority (still could be done via pam).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
