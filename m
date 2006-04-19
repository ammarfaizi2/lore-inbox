Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWDSMYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWDSMYo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 08:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWDSMYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 08:24:44 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:63404 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750726AbWDSMYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 08:24:43 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Crispin Cowan <crispin@novell.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@namei.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
In-Reply-To: <44454DA4.90902@novell.com>
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com>
	 <1145381250.19997.23.camel@jackjack.columbia.tresys.com>
	 <44453E7B.1090009@novell.com>
	 <1145391252.16632.231.camel@moss-spartans.epoch.ncsc.mil>
	 <44454DA4.90902@novell.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 19 Apr 2006 08:22:55 -0400
Message-Id: <1145449375.24289.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-18 at 13:35 -0700, Crispin Cowan wrote:
> Agreed, with the caveat that mediating all those things comes with
> expense, and AppArmor doesn't mediate them by design, because our goal
> is to keep the host from being compromised by a hacked application, not
> to control all information flow. Different goals produce different designs.

It isn't just a matter of information flow control, although that is
foundational to higher level confidentiality _and_ integrity guarantees.
Perhaps a more specific example would be helpful.  Attacker compromises
network-exposed client or server program on your system that you are
"confining" via AppArmor.  Assume that the attacker knows that your
system is protected by AppArmor, and has studied the AppArmor
implementation and default configurations (no security through
obscurity).  Knowing that AppArmor does nothing to control inter-process
operations or IPC beyond capability checks (which are only applied when
the base DAC checks fail or for "privileged" ops), he proceeds to
subvert another local process via such an inter-process mechanism,
completely unrestricted by AppArmor.  As that other local process wasn't
"confined" by AppArmor (or protected by it against such subversion),
attacker now has unrestricted access to the machine.  Now go back to
your thunderbird profile that you posted elsewhere and think hard about
the real implications of your having given it cap_setuid, without even
knowing why. 

> Also agreed, and also caveated that the general purpose system emulating
> the simple system is much more complex than the simple system itself,
> and simplicity is a critical part of secure design. In this case, the
> most expensive impact on simplicity is the complexity of the policy that
> users have to manage.

Assurance in the base mechanism is crucial, and it isn't possible when
the base mechanism is relying on incomplete and inaccurate information.
Ala pathnames.  Policy does get complex, but that is just because what
is happening on the system is complex, and SELinux policy is analyzable,
with open source tools available to perform extensive analysis of it.
At the end of the day, you can say that a SELinux policy does or does
not achieve a higher level security goal.  You can never do that with
the AppArmor mechanism; you just never know.

> Mediating by file names rather than inodes is the fundamental place
> where we disagree. I am delighted with LSM, because it allows us to
> disagree without having to fight about it.

Here I fear you will be disappointed, as I have looked at the LSM hook
interfaces, and I have looked at AppArmor's implementation, and it is
clear that LSM is the wrong implementation approach for AppArmor, even
assuming that AppArmor's technical approach is sound.  LSM just doesn't
fit with your needs, because the hooks are at the wrong places and take
the wrong inputs for pathname-based control.  You don't get the
(vfsmount, dentry) pairs you need from the LSM inode hooks.  What I find
particularly puzzling about this is that your team was involved in LSM
development, and could have sought at the time to get that information,
either by putting the hooks at different locations or by seeking to
propagate the information down to the callers (although there are issues
there).  But they didn't.  Instead, AppArmor goes through great
contortions to get pathnames (often having to iterate through all
possibilities) for its purposes.

-- 
Stephen Smalley
National Security Agency

