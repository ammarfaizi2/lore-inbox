Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269484AbUINRXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269484AbUINRXO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269598AbUINRUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:20:18 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:28645 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S269581AbUINRQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:16:31 -0400
Date: Tue, 14 Sep 2004 19:15:25 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Albert Cahalan <albert@users.sf.net>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040914171525.GA14031@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Andrew Morton OSDL <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Albert Cahalan <albert@users.sourceforge.net>,
	Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
	Chris Wright <chrisw@osdl.org>
References: <20040909212507.GA32276@k3.hellgate.ch> <1094942212.1174.20.camel@cube> <20040914064403.GB20929@k3.hellgate.ch> <20040914071058.GH9106@holomorphy.com> <20040914075508.GA10880@k3.hellgate.ch> <20040914080132.GJ9106@holomorphy.com> <20040914092748.GA11238@k3.hellgate.ch> <20040914153758.GO9106@holomorphy.com> <20040914160150.GB13978@k3.hellgate.ch> <20040914163712.GT9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914163712.GT9106@holomorphy.com>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 09:37:12 -0700, William Lee Irwin III wrote:
> On Tue, 14 Sep 2004 08:37:58 -0700, William Lee Irwin III wrote:
> >> No, in general races of the form "permissions were altered after I
> >> checked them" can happen.
> 
> On Tue, Sep 14, 2004 at 06:01:50PM +0200, Roger Luethi wrote:
> > Can you make an example? Some scenario where this would be important?
> 
> Not particularly. It largely means poorly-coded apps may report gibberish.

If we are still talking about the same thing here, gibberish is a rather
strong word. In the design I proposed access control affects the subset
of tasks returned as a result -- the tool would still display meaningful
information for the tasks it got replies for.

Anyway, if the access restrictions are hard-coded into the field ID,
then it's only the credentials that can change, and I can't see a race
there at the moment.

> On Tue, 14 Sep 2004 08:37:58 -0700, William Lee Irwin III wrote:
> >> Checking that system calls succeeded is a minimum requirement at all
> >> times. Misinterpreting error returns is the app's fault.
> 
> On Tue, Sep 14, 2004 at 06:01:50PM +0200, Roger Luethi wrote:
> > It's async. You can't rely on return values. They'd have to be in
> > netlink messages.
> 
> That's fine. Do these error messages specify which field access(es)
> caused the error?

They don't, because the access control I had in my dev tree silently
skipped tasks containing fields the process had no permission to read.
IOW, access control works as an implicit task selector. And security
wise that's clean because the kernel does not reveal any information
about other processes to the querying task (not even evidence of their
existence).

> Then assuming the error messages indicate which field access(es) caused
> the error(s), you're already done; userspace must merely retry the
> request with the offending fields cast out. Otherwise, you're still
> done: userspace can merely retry the field accesses one at a time
> (though it's nicer to say which ones caused the errors).

Agreed on every point.

The question I am pondering is: Does nproc need access control right now?
It's more work in kernel and user space and adds new opportunities to
introduce bugs. The merits seem rather dubious right now, considering
that all the fields used by current process info tools (files
/proc/pid{cmdline, stat, statm, status, wchan}) are world readable.
So my preference is to wait with access control until we know where
and how it is necessary.

Roger
