Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbTENMk6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 08:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbTENMk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 08:40:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22357 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S262023AbTENMk4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 08:40:56 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: andyp@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [KEXEC][2.5.69] Re: Updated kexec diffs...
References: <3EBA626E.6040205@cyberone.com.au>
	<20030508121211.532dcbcf.akpm@digeo.com>
	<3EBC37C4.9090602@cyberone.com.au>
	<20030509162911.2cd5321e.akpm@digeo.com>
	<m1u1c37d2o.fsf@frodo.biederman.org>
	<20030509201327.734caf9e.akpm@digeo.com>
	<m1of2978ao.fsf@frodo.biederman.org>
	<20030511121753.7a883afb.akpm@digeo.com>
	<m1fznl57ss.fsf_-_@frodo.biederman.org>
	<1052861167.1324.15.camel@andyp.pdx.osdl.net>
	<m1k7cu3yey.fsf@frodo.biederman.org>
	<20030513222343.74a3d817.akpm@digeo.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 May 2003 06:50:18 -0600
In-Reply-To: <20030513222343.74a3d817.akpm@digeo.com>
Message-ID: <m1el314rqt.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> ebiederm@xmission.com (Eric W. Biederman) wrote:
> >
> > And Andrew has it in 2.5.69-mm4 and is busy pestering me about compile
> >  errors. 
> 
> I'm like that.

And I appreciate it.  This was mostly an observation there was
something reminding me to get back and fix the issue.
 
> I've dropped out a lot of the NORET stuff.  It generates warnings on all
> other architectures, because their machine_restart, machine_halt and
> machine_power_off definitions don't have necessary attributes and don't
> have the while(1); at the end.

Yes there is a big const correctness type problem here.

First for machine_restart it is 100% correct.  And at least sys_reboot
assumes that machine_restart will not return, even before my patch.

And I don't know of a case where it makes sense for machine_halt and
machine_power_off to return.  Hence I deliberately made those cases
the same.  Especially as every real implementation I traced does not
return.  It is only the stupid cases like on x86 where we don't do
anything that these routines actually return.

In the context of my patch stop_this_cpu needs to be marked noreturn.
As long as the fundamental routines get marked I don't expect to see
a lot of routines getting a while(1);  I admit stop_apics also
needs a while(1); but only because gcc cannot trace it.

And since this also generates warnings on other architectures
it looks like someone (me) needs to go through the various
architectures and add a bunch of noreturn attributes to
the appropriate functions.

The basic question is for documenting and enforcing the noreturn
dependency.  Is it more of a help or a hindrance to use gcc noreturn
tag?

And while I am pretty certain this is the correct thing to do I
should break this out from the reboot_on_bsp patch.  With the
other architectures involved this is enough of a separate issue that a
second set of patches is needed to maintain this cleanly.

Eric
