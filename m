Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269468AbUINQNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269468AbUINQNc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 12:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269505AbUINQLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 12:11:46 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:45530 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S269453AbUINQDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 12:03:00 -0400
Date: Tue, 14 Sep 2004 18:01:50 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Albert Cahalan <albert@users.sf.net>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040914160150.GB13978@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Andrew Morton OSDL <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Albert Cahalan <albert@users.sourceforge.net>,
	Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
	Chris Wright <chrisw@osdl.org>
References: <1094760065.22014.328.camel@moss-spartans.epoch.ncsc.mil> <20040909205531.GA17088@k3.hellgate.ch> <20040909212507.GA32276@k3.hellgate.ch> <1094942212.1174.20.camel@cube> <20040914064403.GB20929@k3.hellgate.ch> <20040914071058.GH9106@holomorphy.com> <20040914075508.GA10880@k3.hellgate.ch> <20040914080132.GJ9106@holomorphy.com> <20040914092748.GA11238@k3.hellgate.ch> <20040914153758.GO9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914153758.GO9106@holomorphy.com>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 08:37:58 -0700, William Lee Irwin III wrote:
> On Tue, 14 Sep 2004 01:01:32 -0700, William Lee Irwin III wrote:
> >> That expectation can't be entirely relied upon, as the restrictions may
> >> not be predictable.
> 
> On Tue, Sep 14, 2004 at 11:27:48AM +0200, Roger Luethi wrote:
> > They should be. For the simple design I described the access restrictions
> > are part of the field ID, so a tool can deduce the exact type of access
> > restrictions even if it doesn't know the field. There's plenty of space
> > left for additional access control flags in the field ID.
> 
> No, in general races of the form "permissions were altered after I
> checked them" can happen.

Can you make an example? Some scenario where this would be important?

> On Tue, Sep 14, 2004 at 11:27:48AM +0200, Roger Luethi wrote:
> > If it gets much more complex, the application (let alone the kernel)
> > has to have some knowledge of the security model anyway, so we could have
> > simple operations that allow a tool to discover how access restrictions
> > apply to the supported fields.
> 
> Checking that system calls succeeded is a minimum requirement at all
> times. Misinterpreting error returns is the app's fault.

It's async. You can't rely on return values. They'd have to be in
netlink messages.

> On Tue, Sep 14, 2004 at 11:27:48AM +0200, Roger Luethi wrote:
> > It cannot easily, and I don't think it wants to. The reason it's hard to
> > just reply with a subset is that the kernel does not send any description
> > of the reply content other than the serial number of the request --
> > it's up to the tool to know what it asked for. So if you remove a field,
> > you'd have to let user-space know which field you removed. Sending only
> > the allowed subset makes handling on both sides more complicated --
> > the kernel needs to build different kinds of messages in answer to one
> > request, and user-space tool need to be able to parse that.
> 
> Irritating. That must mean you can't ask for specific fields.

How so? For process fields, the request block is one u32 indicating the
number of field IDs to follow, then a bunch of u32 containing field IDs.
Any subset of field IDs, in any order of the tool's choosing.

The kernel replies with one message per process, each message containing
all the fields the tool requested, in the same order.

> On Tue, Sep 14, 2004 at 11:27:48AM +0200, Roger Luethi wrote:
> >   We could also send an error message ("some tasks omitted") or send a
> >   complete reply with the restricted fields zeroed and a special flag set
> >   ("some fields in this reply zeroed due to access control").
> > I'm really afraid of over-engineering something here, though. The fields
> > requested by tools like ps and top by default are all world readable
> > in /proc. I showed that solutions fit right in should we ever need
> > access control for real-world applications. For now, I'd rather not
> > extend the interface significantly unless the current semantics are
> > clearly insufficient.
> 
> Well, "return this set of fields" means there's only one type of
> request necessary, and userspace merely iterates through the subsets
> obtained by striking out fields to which accesses caused errors until
> either the set is empty or the call succeeds. One field at a time at
> all times also means there's only one type of request necessary. So I

One field at a time at all times is unnecessarily slow.

Roger
