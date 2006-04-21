Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWDUNzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWDUNzR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 09:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWDUNzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 09:55:17 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:17835 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S932310AbWDUNzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 09:55:15 -0400
Subject: Re: [RFC][PATCH 11/11] security: AppArmor - Export
	namespace	semaphore
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Linda Walsh <lkml@tlinx.org>
Cc: Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org
In-Reply-To: <44480228.3060009@tlinx.org>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <20060419175034.29149.94306.sendpatchset@ermintrude.int.wirex.com>
	 <1145536742.16456.35.camel@moss-spartans.epoch.ncsc.mil>
	 <44480228.3060009@tlinx.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 21 Apr 2006 09:59:13 -0400
Message-Id: <1145627953.21749.126.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 14:50 -0700, Linda Walsh wrote:
> 
> Stephen Smalley wrote:
> > The alternative I would recommend is to not use LSM. It isn't suitable
> > for your path-based approach.  If your path-based approach is deemed
> > legitimate, then introduce new hooks at the proper point in processing
> > where the information you need is available.
> >   
> ---
>     I thought LSM was supposed to provide the hooks to allow virtually
> any access control scheme to be implemented?

The first question is whether a path-based mechanism is suitable for the
kernel at all.  Not my call to make, but seems to run counter to the
Unix and more so the Linux model, and to past discussions on
linux-fsdevel and linux-kernel.

If a path-based mechanism is suitable, then the next question is whether
LSM is suitable as a means of implementing such a mechanism.  At
present, I would argue that it is not - the hook placement and
interfaces are not well suited to it (despite being originally proposed
by the WireX folks who worked on SubDomain/AppArmor), and the current
AppArmor implementation requires significant contortions to work around
the interface mismatch.  Which would suggest that they need to propose
changes to LSM (e.g. new hooks at more suitable locations) first.

>   I've seen complaints
> before on either here or the LSM list that one of the hurdles for
> "legitimacy" was whether or not it fit on top of the current set of
> LSM hooks.

I don't recall that one; submitting new hook proposals is ok as long as
there is a user that will also be submitted.  SELinux itself has needed
to extend the LSM interface over time.

>   I also saw it asked whether or not LSM had been
> designed around, primarily, the needs of SELinux and if it was
> going to remain so. 

SELinux was and remains the primary user, so that obviously has
influence, but as I've noted before, the original VFS hooks were first
proposed by the WireX folks, and they were active participants during
LSM development.

>  If it was, then why not remove all non-SELinux
> hooks?

That is actually a good idea.  They can always be added back if a
genuine user comes along.  SELinux also has some stubs that should be
dropped at the same time.

>   If LSM is to support alternate security methods, it is
> logical to believe that LSM was not implemented with calls to
> support every desired security model people might want.  There
> are known, insecure, race conditions in linux auditing, for
> example, due to lack of LSM hooks.  This was a conscious
> design decision made by the LSM majority over objections
> of people who wanted greater flexibility to support security
> mechanisms not supportable with the current set of hooks.

I think you haven't looked at the native Linux 2.6 audit implementation
very closely.  LSM wasn't suitable for audit.  The namei code and other
parts of the kernel have been hooked to call into the audit system to
collect information as needed.

>     In regards to "legitimacy", while I share the reservations
> of many people in using a path based approach to security, I
> might point out that this model is a basic one integrated into
> Windows NT (XP & later, 2k?).  That doesn't mean it is "good",
> but it certainly should add some weight to the claim of
> "legitimacy".  I.e. - it provides a "comfortable", known
> security mechanism for people switching to Linux servers from
> from "Windows Server 2003".
> 
>     In the Windows approach, you can specify allowed and disallowed
> paths by unique name and using wildcards.  This allowed/disallowed
> hash is checked before every program execution.

Do you know how they implement it?  The question is not whether
path-based configuration in userspace is ok; it is whether the kernel
mechanism should be relying on pathnames.  There are also much saner
implementation approaches for name-based schemes than calling d_path to
generate the full path and checking that against a profile on each open;
DTE was one example.

>     If you start with a large, multi-user system, and allow no
> user-level mounts (they just sign in and can pick from a
> limited menu of choices, the pathname approach can have some
> merit.  For example, one might have a security policy only
> allowing execution of binaries in "/usr/bin".  The employer
> puts all of his "reservation-system" or "database-access" routines
> in "/usr/bin" (or adds the app path(s) to the allowed hash).  
> The end users run the allowed binaries and that's it.

SELinux can express such restrictions via its TE configuration already.
Or you can implement this kind of mechanism in other ways, but it
doesn't require the kernel to be generating and checking pathnames.

>     I'm not saying it's an approach I would find useful to control
> security on my systems, but I can see a potential usefulness
> for it, in that it is relatively easy for people to understand,
> setup and use.

Which is fine for userspace tools, but doesn't justify it as the kernel
mechanism.

-- 
Stephen Smalley
National Security Agency

