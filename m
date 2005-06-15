Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVFOVs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVFOVs1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVFOVre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:47:34 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:53696 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261601AbVFOVn5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 17:43:57 -0400
Date: Wed, 15 Jun 2005 16:48:54 -0500
From: serue@us.ibm.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: serue@us.ibm.com, James Morris <jmorris@redhat.com>,
       Tom Lendacky <toml@us.ibm.com>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>,
       LSM <linux-security-module@wirex.com>, Chris Wright <chrisw@osdl.org>,
       Reiner Sailer <sailer@watson.ibm.com>,
       Emily Rattlif <emilyr@us.ibm.com>, Kylene Hall <kylene@us.ibm.com>
Subject: Re: [PATCH] 3 of 5 IMA: LSM-based measurement code
Message-ID: <20050615214854.GA3660@serge.austin.ibm.com>
References: <1118846413.2269.18.camel@secureip.watson.ibm.com> <Xine.LNX.4.44.0506151601310.27162-100000@thoron.boston.redhat.com> <20050615204936.GA3517@serge.austin.ibm.com> <1118869090.16874.46.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118869090.16874.46.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Wed, 2005-06-15 at 15:49 -0500, serue@us.ibm.com wrote:
> > A long, long time ago, Crispin defined LSM's purpose as:
> > 
> > >> Main goal : we have to design a generic framework to be able to use
> > >> better
> > >> security policies than the current ones (DAC and capabilities).
> > >
> > >Sort of. We have to design a generic interface that exports enough
> > >kernel
> > >functionality to allow security developers to go off and create these
> > >better
> > >security policy modules. 
> > 
> > Since IMA provides support for a new type of security policy,
> > specifically remote system integrity verification, I don't see
> > where LSM shouldn't necessarily be used.
> 
> IMA isn't an access control model.  Also, LSM is overkill for its needs
> in many ways (IMA only needs a few LSM hooks)

I don't think only needing a few of the hooks should disqualify it -
same is true of capability.  On the other hand the fact that it always
grants permission could be taken to imply LSM is overkill.  It seems
to come down to a question of aesthetics.

> and is inadequate in other
> ways (LSM lacks a hook needed by IMA for measuring modules, although one
> might argue that there could be benefit in adding such a hook to LSM
> itself for access control purposes).  

True.  In fact, since those hooks were originally dropped because there
wasn't a user for them, refusing a user because the hooks aren't there
would be hillarious!

> If you look at the inotify patch, I think that they've moved the dnotify
> hooks into a more generic set of fsnotify hooks that are leveraged by
> both dnotify and inotify to reduce duplication in the core kernel.  The

Oh, cool, I actually hadn't noticed that.  (Last I checked inotify was
in... november?)

> same approach could be used for hooks that would be co-located by audit
> and LSM or by integrity measurement and LSM.  Of course, you don't want

In that case it seems to further obfuscate the code, though.  We then
have a common update hook to just call integrity+LSM hooks, which
then call into their own subsystems...

Is there a distinct advantage to be gained by separating the two?

> to blindly place the integrity measurement hooks at the same locations
> if a different placement would be more optimal for your purposes, so
> you'd want to give it some thought.

That's true, of course.  Reiner, would any of the integrity measurement
hooks be moved to a better place than the current LSM hooks?  Is there a
preferred ordering - ie measurement should always happen before the LSM
modules, or always after?  Either of these would of course be clear
reasons to separate IMA into its own subsystem.

thanks,
-serge
