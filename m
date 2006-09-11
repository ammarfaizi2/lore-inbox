Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWIKNk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWIKNk4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 09:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWIKNkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 09:40:55 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:29361 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750752AbWIKNky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 09:40:54 -0400
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part
	3/4: introduce new capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Madore <david.madore@ens.fr>
Cc: Joshua Brindle <method@gentoo.org>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
In-Reply-To: <20060910200337.GA24123@clipper.ens.fr>
References: <20060910133759.GA12086@clipper.ens.fr>
	 <20060910134257.GC12086@clipper.ens.fr>
	 <1157905393.23085.5.camel@localhost.localdomain>
	 <450451DB.5040104@gentoo.org>  <20060910200337.GA24123@clipper.ens.fr>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 11 Sep 2006 09:42:19 -0400
Message-Id: <1157982139.5960.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-10 at 22:03 +0200, David Madore wrote:
> On Sun, Sep 10, 2006 at 01:56:43PM -0400, Joshua Brindle wrote:
> > To expand on this a little, some of the capabilities you are looking to 
> > add are of very little if any use without being able to specify objects. 
> > For example, CAP_REG_OPEN is whether the process can open any file 
> > instead of specific ones. How many applications open no files whatsoever 
> > in practice? Even if there are some as soon as they change and need to 
> > open a file they'll need this capability and will be able to open any. 
> > CAP_REG_WRITE has the same problem. For a description of why 
> > CAP_REG_EXEC is meaningless see the digsig thread on the LSM list from 
> > earlier this year.
> 
> CAP_REG_OPEN and CAP_REG_EXEC might be useful only for demonstration
> purposes, but I've *often* wished I could run a program without
> CAP_REG_WRITE because I wasn't root and I wanted to make *sure* it
> didn't write any file anywhere.  Instead I had to run them from a
> user-mode-linux, which is horribly messy and doesn't work well (and,
> at best, with a noticeable slowdown).
> 
> Again, I ask: is SElinux useable if you aren't root?  (Assuming it's
> activated, of course: I mean, can you create new policies to make
> certain programs run with restricted privileges?)  I thought it
> wasn't, but maybe I'm wrong.

At present, you can't load new policy into the kernel without being
privileged (where privileged == root + SELinux load_policy permission),
but there is ongoing work on a policy management daemon that will enable
delegation of control of portions of the policy to others, including the
ability to enable a user to define subtypes of his own authorized types
with more limited permissions via the already existing hierarchical type
support in the policy language.

In any event, I didn't see anything in your patches to allow SELinux to
continue working with your 64-bit capabilities, and I'm not sure why you
are implementing your changes as a direct patch vs. a new security
module (with additional LSM hooks if truly required, but trying to reuse
existing hooks whenever possible), so that your changes remain optional
at least until proven useful.

I also have to question whether it is a good idea to keep these new
unprivileged "regular" capabilities in the same vectors as the existing
privileged ones, given that they have rather different semantics.  Also,
if you want capabilities to be more useful, you likely want to expand
the set of privileged capabilities in the future (e.g. to partition some
of the more coarse-grained ones), and you aren't leaving room for such
expansion.  At least for SELinux, we would split them into a separate
security class altogether rather than expanding all access vectors to 64
bits.  If you implement your changes in your own security module, then
you can store your regular capability bits in your own security
structure referenced via the security fields, and not have to touch the
base capability fields.

-- 
Stephen Smalley
National Security Agency

