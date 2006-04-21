Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWDUS6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWDUS6J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 14:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWDUS6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 14:58:08 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:57000 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750807AbWDUS6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 14:58:06 -0400
Date: Fri, 21 Apr 2006 20:57:30 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Greg KH <greg@kroah.com>, Arjan van de Ven <arjan@infradead.org>,
       James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation
 of LSM hooks)
In-Reply-To: <1145636755.21749.165.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.61.0604212039100.4602@yvahk01.tjqt.qr>
References: <200604142301.10188.edwin@gurde.com> 
 <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> 
 <20060417162345.GA9609@infradead.org>  <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
  <20060417173319.GA11506@infradead.org>  <Pine.LNX.4.64.0604171454070.17563@d.namei>
  <20060417195146.GA8875@kroah.com>  <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
  <1145462454.3085.62.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.61.0604192102001.7177@yvahk01.tjqt.qr>  <20060419201154.GB20545@kroah.com>
  <Pine.LNX.4.61.0604211528140.22097@yvahk01.tjqt.qr>
 <1145636755.21749.165.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>The bulk of the first patch appears to be capable -> capable_x changes.
>What is the purpose of that?
>
When you grant CAP_SYS_ADMIN to a user, he can do _a lot_ of things. I wanted
to have the sub-admin have read rights in most places (e.g. nvram to pick a
random example), but not to have write rights. Unfortunately, read rights and
write rights for nvram both fall under CAP_SYS_ADMIN.

capable_x will call out to security_cap_extra(), passing it the current
function name as a string. An LSM module can then provide security_cap_extra
via the security_operations vector and decide whether to allow the request. I
primarily did this because it reduces the amount of recompiling needed. For
example, instead of having to add a ->nvram_allow_read and ->nvram_allow_write
hooks in include/linux/security.h -- which requires compilation of a lot of
parts -- I can simply use strcmp(func, "nvram_read") in the LSM. I agree that
this is not optimal, but having 1000 pointers in the security_ops vector is not
a solution either (-> code bloat).

>What's the rationale for the int->gid_t and int->uid_t changes in sys?
>

I don't know, but there must be a reason uid_t and gid_t exist in the kernel in
the first place.

>From a technical point, gid_t and uid_t are unsigned, while int is not.

>Some of the hooks used to exist in LSM patches but didn't have a real
>user for merging at the time.  But it isn't clear whether you actually
>need separate hooks for each of them or if they are being mapped to the
>same check in many cases - can it be abstracted to a common hook?

Not without passing a handful of useless parameters (NULL or 0) to each
function.
As much as I would like to combine for example mt_sb_mount and mt_sb_pivotroot,
the prototypes are just too different.
Suggestions welcome.

>Seems like you are duplicating a lot of the base DAC logic in the
>process; would be nice to encapsulate that in the core kernel, and then
>just use a common helper in both cases?

The problem is that the base DAC logic is done after security_*(). Sometimes
that's good, most of the times, it leads to duplicated DAC logic because the
"usual DAC decision" is part of how multiadm decides.

Suggestions welcome too.



Jan Engelhardt
-- 
