Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWDUOUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWDUOUQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 10:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWDUOUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 10:20:16 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:30129 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751033AbWDUOUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 10:20:14 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nix <nix@esperi.org.uk>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       casey@schaufler-ca.com, James Morris <jmorris@namei.org>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
In-Reply-To: <87y7xzu4hj.fsf@hades.wkstn.nix>
References: <20060419014857.35628.qmail@web36606.mail.mud.yahoo.com>
	 <CD11FD59-4E2E-4AD7-9DD0-5811CE792B24@mac.com>
	 <200604190656.k3J6uSGW010288@turing-police.cc.vt.edu>
	 <32851499-DA27-46AF-A1A4-E668BBE0771D@mac.com>
	 <1145536803.3313.32.camel@moss-spartans.epoch.ncsc.mil>
	 <87y7xzu4hj.fsf@hades.wkstn.nix>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 21 Apr 2006 10:24:37 -0400
Message-Id: <1145629477.21749.146.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 02:00 +0100, Nix wrote:
> On 20 Apr 2006, Stephen Smalley yowled:
> > - Approved tools/libraries are instrumented to specify the desired label
> > for passwd vs. shadow (and backup files), since the same code re-creates
> > both on a transaction (at least when adding/removing users), so the
> > kernel can't make that distinction automatically; only the tool knows
> > that.  This is consistent with how DAC mode is handled for passwd vs.
> > shadow. 
> 
> So... every program which may modify labelled entities (e.g., for files,
> by unlink()/creat()) needs modification for SELinux?

No.  In the common case, you just configure policy to ensure that files
created by the program are labeled properly.  That works as long as the
same process doesn't end up creating two separate files in the same
directory that need to be protected in different ways (as with programs
that re-create both passwd and shadow for e.g. adding and removing
users).  At that point, you are dealing with application level knowledge
of the difference between those two files, and that application has to
maintain the difference (it already has to maintain separation of the
actual data, so it is the right place to do the labeling at that point).
This is the same for file modes or ACLs as well as SELinux attributes.
You can still use SELinux policy in that case to ensure that the default
label is the most restrictive one, so that you don't accidentally leak
or permit modification of the information, but the application has to
deal with the finer granularity of identifying which file has which
security label.  Other option is to split the program into helpers, with
each helper specialized to updating one of those files, and then just
configure policy to label them differently automatically.

> This strikes me as rather impractical if you want to be able to label
> files that users may edit: there are a lot of programs users run that
> `modify' files in that way. For starters, every web browser, every text
> editor...  is it really sensible to require modification of *almost
> everything* that can overwrite files lest you magically lose labels that
> you thought you had?

A few points:
- The label is supposed to reflect the security properties of the
object.  So it is typically based on the creating process' label and a
related object (parent directory label).  Consequently, if files live in
different subdirectories or if they are edited by different processes
(e.g. user logs in or newrole's to different roles/domains/levels), then
they would get different labels anyway, without the editor needing to be
aware.
- In the case where the same process is allowed to edit multiple files
that live in the same parent directory and the files are supposed to
have different labels (i.e. different protection requirements), then
yes, the editor has to preserve the label.  No different than file
modes, ACLS, whatever.  That is then an application-level distinction;
the application knows what data is being written where, and thus what it
should be labeled.  Not the job of the kernel.
- The label preservation problem will gradually diminish over time as
more programs become aware and as policy becomes more complete in its
coverage.  Much of the current pain is due to a combination of
incomplete policy coverage (in particular, targeted policy doesn't deal
with users and user apps at present, vs. strict policy) and incomplete
integration with applications.  Same issue will apply to any new
security model, whether ACLs or MAC.

> (With AppArmor, of course, you never lose labels at all, because there
> aren't any.)

But you do lose preservation of security properties, e.g. renaming a
file suddenly moves it under different protection.  Same end result.
Their labels just happen to be pathnames, which also suffer from being
ambiguous.

> (I may be missing something, but I know that when I've tried to use
> SELinux to constrain what such programs could manipulate, I was
> losing labels to unlink()/creat() left right and centre.)

As above, this reflects incomplete policy coverage and application
integration, and that will diminish over time.

-- 
Stephen Smalley
National Security Agency

