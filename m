Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269657AbUINULL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269657AbUINULL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 16:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269747AbUINUKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 16:10:11 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:42969 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S269737AbUINTcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:32:51 -0400
Date: Tue, 14 Sep 2004 21:31:39 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Albert Cahalan <albert@users.sf.net>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040914193139.GA30827@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Andrew Morton OSDL <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Albert Cahalan <albert@users.sourceforge.net>,
	Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
	Chris Wright <chrisw@osdl.org>
References: <20040914075508.GA10880@k3.hellgate.ch> <20040914080132.GJ9106@holomorphy.com> <20040914092748.GA11238@k3.hellgate.ch> <20040914153758.GO9106@holomorphy.com> <20040914160150.GB13978@k3.hellgate.ch> <20040914163712.GT9106@holomorphy.com> <20040914171525.GA14031@k3.hellgate.ch> <20040914174325.GX9106@holomorphy.com> <20040914184517.GA2655@k3.hellgate.ch> <20040914190747.GA9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914190747.GA9106@holomorphy.com>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 12:07:47 -0700, William Lee Irwin III wrote:
> On Tue, Sep 14, 2004 at 08:45:18PM +0200, Roger Luethi wrote:
> > I suppose you are thinking of a request that lists a number of PIDs along
> > with a number of field IDs. In that case yes, I agree that it makes sense
> > to provide some explicit feedback to the tool once we add access control
> > (before that, there is no ambiguity: a missing answer means ESRCH).
> > The most common request, though, won't provide a list of pids, it will
> > only provide a list of field IDs and select all processes in the system
> > (NPROC_SELECT_ALL). There is no ambiguity here, either: The tool didn't
> > ask for any specific process to begin with, ESRCH doesn't make sense
> > here. And for a system that looks anything like /proc does today,
> > fields that are capable of triggering EPERM are few and far between,
> > certainly not something you are hitting unexpectedly in the fast path
> > of a process monitoring tool.
> 
> Okay, so what kinds of errors are returned in this case, if any, or
> (worst case) are the offending tasks completely silently dropped?

In published code: No access control whatsoever. In dev tree: Silently
dropped. Possible: Any kind of error and additional information that
makes sense (we have netlink messages as a transport, after all).

That said, I don't think dropping tasks silently is a "worst case"
in this scenario. Whatever your error report is going to be, it will
boil down to saying "some tasks that may or may not live by the time
you read this have been skipped because some fields that you knew had
access restrictions prevented providing the information in those cases,
and I must be cautious about not revealing any sensitive information
to you so sorry I can't be more helpful". What's a tool going to do
with that? If it cares to get a complete snapshot, it can simply send
two requests: One with and one without restricted fields.

So the tool would, say, request PID/VmSize in the first message and
environ in the second message. Since only the owner can read the
environment, the second request would yield answers only for a subset
of the total process table.

Roger
