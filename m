Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422684AbWIGXCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422684AbWIGXCt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422687AbWIGXCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:02:49 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:58325 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422684AbWIGXCr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:02:47 -0400
Date: Thu, 7 Sep 2006 18:02:45 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: David Madore <david.madore@ens.fr>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060907230245.GB21124@sergelap.austin.ibm.com>
References: <20060905212643.GA13613@clipper.ens.fr> <20060906182531.GA24670@sergelap.austin.ibm.com> <20060906222731.GA10675@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906222731.GA10675@clipper.ens.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Madore (david.madore@ens.fr):
> On Wed, Sep 06, 2006 at 01:25:31PM -0500, Serge E. Hallyn wrote:
> > The fact that you're changing the inheritance rules is a bit scary, so
> > I'm going to (and I hope others will) take some time to look it over.
> 
> Thanks!  I'd appreciate it.  Don't hesitate to ask me if some
> decisions I made are unclear.

Ok, so to be clear, in terms of inheritability of capabilities, your
three main changes are:

	1. When creating a bprm, it's inheritable and effective
	capability sets are set full on, whereas they used to be
	cleared.  The permitted set is treated as before (always
	cleared)

	2. When computing a process' new capabilities, the new
	inheritable come from the new permitted, rather than the old
	inheritable.

	3. You change half the computation of p'E to replace fE by
	pE in one half.

Here is one apparent change in behavior:

If I currently do

	cp /bin/sh /bin/shsetuid
	chmod u+s /bin/shsetuid

then log in as uid 1000 and run

	/bin/shsetuid
	# whoami
	hallyn
	# ls /root
	ls: /root: Permission denied

With your patch I believe it will succeed, since the sh process'
inheritable set will be set to it's permitted set.

Put another way:

	cap_set_proc("=i");
	execve("/bin/shsetuid");

I obviously wanted my inheritable set to be cleared, but running the
setuid binary will end up resetting my inheritable set to a larger
set.  Your goal of allowing the inheritable caps to be truly
inheritable may make sense, but this part of it feels wrong, and
changes current setuid behavior.

So in other words, it may make sense for the process to be able to
say "I want these caps to persist across exec" (*1), but it shouldn't
happen automatically based on the file's attributes.

In any case, perhaps it would be worthwhile making this a part of
a capability_plusplus module?  That would be less controversial,
given that I believe many people use the capability module who
really just want classic setuid behavior. 

thanks,
-serge
