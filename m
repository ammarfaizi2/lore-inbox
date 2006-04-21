Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWDUTwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWDUTwF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 15:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWDUTwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 15:52:04 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:25256 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751264AbWDUTwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 15:52:01 -0400
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]
	implementation of LSM hooks)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Greg KH <greg@kroah.com>, Arjan van de Ven <arjan@infradead.org>,
       James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0604212039100.4602@yvahk01.tjqt.qr>
References: <200604142301.10188.edwin@gurde.com>
	 <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417162345.GA9609@infradead.org>
	 <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417173319.GA11506@infradead.org>
	 <Pine.LNX.4.64.0604171454070.17563@d.namei>
	 <20060417195146.GA8875@kroah.com>
	 <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
	 <1145462454.3085.62.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0604192102001.7177@yvahk01.tjqt.qr>
	 <20060419201154.GB20545@kroah.com>
	 <Pine.LNX.4.61.0604211528140.22097@yvahk01.tjqt.qr>
	 <1145636755.21749.165.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.61.0604212039100.4602@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 21 Apr 2006 15:56:22 -0400
Message-Id: <1145649382.21749.286.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 20:57 +0200, Jan Engelhardt wrote:
> When you grant CAP_SYS_ADMIN to a user, he can do _a lot_ of things. I wanted
> to have the sub-admin have read rights in most places (e.g. nvram to pick a
> random example), but not to have write rights. Unfortunately, read rights and
> write rights for nvram both fall under CAP_SYS_ADMIN.
> 
> capable_x will call out to security_cap_extra(), passing it the current
> function name as a string. An LSM module can then provide security_cap_extra
> via the security_operations vector and decide whether to allow the request. I
> primarily did this because it reduces the amount of recompiling needed. For
> example, instead of having to add a ->nvram_allow_read and ->nvram_allow_write
> hooks in include/linux/security.h -- which requires compilation of a lot of
> parts -- I can simply use strcmp(func, "nvram_read") in the LSM. I agree that
> this is not optimal, but having 1000 pointers in the security_ops vector is not
> a solution either (-> code bloat).

- Where is the user of the cap_extra hook?  I don't see it in multiadm.
If you aren't using it, it isn't a requirement for multiadm, obviously;
you should drop those diffs out and just focus on what you need for
multiadm itself.
- Writing a security module based on function names in other modules is
obviously very fragile; some kind of abstraction would be required.

> >Some of the hooks used to exist in LSM patches but didn't have a real
> >user for merging at the time.  But it isn't clear whether you actually
> >need separate hooks for each of them or if they are being mapped to the
> >same check in many cases - can it be abstracted to a common hook?
> 
> Not without passing a handful of useless parameters (NULL or 0) to each
> function.
> As much as I would like to combine for example mt_sb_mount and mt_sb_pivotroot,
> the prototypes are just too different.
> Suggestions welcome.

I wasn't suggesting passing the union of their parameters, just the ones
that are actually used by your module (plus any parameters used by any
other in-tree user, i.e. capability and SELinux).  And trying to
abstract a higher level conceptual operation as the hook rather than
making them per-syscall/operation.  I know that LSM currently does
things the other way, but I'd much rather see it move toward more
general permission checking interfaces (ala the internal SELinux ones,
although I understand those specific interfaces aren't what you would
use).  Others may have a different POV.

> >Seems like you are duplicating a lot of the base DAC logic in the
> >process; would be nice to encapsulate that in the core kernel, and then
> >just use a common helper in both cases?
> 
> The problem is that the base DAC logic is done after security_*(). Sometimes
> that's good, most of the times, it leads to duplicated DAC logic because the
> "usual DAC decision" is part of how multiadm decides.
> 
> Suggestions welcome too.

At least for common cases like permission(9) and ipcperms(9), the
security hook call comes after the DAC checking.  But not always.
Sounds like you want authoritative hooks, which were discussed and
experimented with during LSM development, see archives.  You could
attempt to revive that for the cases where you need it, moving the
checking into the commoncap functions (defining new ones where needed,
and making sure that existing modules call them so that they still apply
those checks) and calling those functions rather than duplicating the
logic in your own module.  You presumably don't want to have to maintain
the duplicated logic in your own module.

-- 
Stephen Smalley
National Security Agency

