Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269227AbUINJ3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269227AbUINJ3M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 05:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269230AbUINJ3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 05:29:12 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:51651 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S269227AbUINJ3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 05:29:04 -0400
Date: Tue, 14 Sep 2004 11:27:48 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Albert Cahalan <albert@users.sf.net>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040914092748.GA11238@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Andrew Morton OSDL <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Albert Cahalan <albert@users.sourceforge.net>,
	Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
	Chris Wright <chrisw@osdl.org>
References: <20040909172200.GX3106@holomorphy.com> <20040909175342.GA27518@k3.hellgate.ch> <1094760065.22014.328.camel@moss-spartans.epoch.ncsc.mil> <20040909205531.GA17088@k3.hellgate.ch> <20040909212507.GA32276@k3.hellgate.ch> <1094942212.1174.20.camel@cube> <20040914064403.GB20929@k3.hellgate.ch> <20040914071058.GH9106@holomorphy.com> <20040914075508.GA10880@k3.hellgate.ch> <20040914080132.GJ9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914080132.GJ9106@holomorphy.com>
X-Operating-System: Linux 2.6.9-rc2-nproc on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 01:01:32 -0700, William Lee Irwin III wrote:
> On Tue, 14 Sep 2004 00:10:58 -0700, William Lee Irwin III wrote:
> >> The concern appears to be that the tools might interpret failed
> >> permission checks as indications of process nonexistence. I don't
> >> regard this as particularly pressing, as properly-written apps should
> >> check the specific value of errno (in particular to retry when EAGAIN
> >> is received in numerous contexts).
> 
> On Tue, Sep 14, 2004 at 09:55:08AM +0200, Roger Luethi wrote:
> > I would expect a tool to refrain from asking for fields with restricted
> > access if it needs a complete overview over existing processes. It can
> > always ask for restricted fields in a second request (the vast majority
> > of fields are world-readable anyway).
> 
> That expectation can't be entirely relied upon, as the restrictions may
> not be predictable.

They should be. For the simple design I described the access restrictions
are part of the field ID, so a tool can deduce the exact type of access
restrictions even if it doesn't know the field. There's plenty of space
left for additional access control flags in the field ID.

If it gets much more complex, the application (let alone the kernel)
has to have some knowledge of the security model anyway, so we could have
simple operations that allow a tool to discover how access restrictions
apply to the supported fields.

> > problem was based on the available information. I suppose if we wanted
> > to change that (which doesn't sound unreasonable), the proper way would
> > be to return error flags with an error message (delivered via netlink).
> 
> This kind of error reporting is better still, as the fields then won't
> be polluted with invalid data under any circumstance (assuming the code
> can report subsets of the fields or some such, which I presume to be
> the case given that avoiding reporting potentially computationally
> expensive fields was one of the original motivators of the patch).

It cannot easily, and I don't think it wants to. The reason it's hard to
just reply with a subset is that the kernel does not send any description
of the reply content other than the serial number of the request --
it's up to the tool to know what it asked for. So if you remove a field,
you'd have to let user-space know which field you removed. Sending only
the allowed subset makes handling on both sides more complicated --
the kernel needs to build different kinds of messages in answer to one
request, and user-space tool need to be able to parse that.

The way the interface works now, though, is that a tool can rely on
the content of the reply to match the request. This makes the common
case both easy to write and fast.

Let me break it down once again:

- If a tool asks for a field the kernel doesn't know about, that's a
  fatal error. An error message is returned, nothing else (this can be
  discovered before any other reply is delivered).

- If a tool specifically asks for a process which doesn't exist,
  nothing is returned. We could return an error indicating that. Might
  be a good idea.

- If a tool asks for a field it doesn't have permission to read, it usally
  does have permission to read that field for some tasks (e.g. same owner),
  but not for others. So for some replies to one request, all requested
  fields will contain meaningful values.  What about the replies that
  describe the tasks where the tool must not read at least some of the
  requested values? I chose to simply skip those tasks.

  We could also send an error message ("some tasks omitted") or send a
  complete reply with the restricted fields zeroed and a special flag set
  ("some fields in this reply zeroed due to access control").

I'm really afraid of over-engineering something here, though. The fields
requested by tools like ps and top by default are all world readable
in /proc. I showed that solutions fit right in should we ever need
access control for real-world applications. For now, I'd rather not
extend the interface significantly unless the current semantics are
clearly insufficient.

Roger
