Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269449AbUINPnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269449AbUINPnA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269429AbUINPkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:40:37 -0400
Received: from holomorphy.com ([207.189.100.168]:26772 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269415AbUINPiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:38:18 -0400
Date: Tue, 14 Sep 2004 08:37:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Albert Cahalan <albert@users.sf.net>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040914153758.GO9106@holomorphy.com>
References: <20040909175342.GA27518@k3.hellgate.ch> <1094760065.22014.328.camel@moss-spartans.epoch.ncsc.mil> <20040909205531.GA17088@k3.hellgate.ch> <20040909212507.GA32276@k3.hellgate.ch> <1094942212.1174.20.camel@cube> <20040914064403.GB20929@k3.hellgate.ch> <20040914071058.GH9106@holomorphy.com> <20040914075508.GA10880@k3.hellgate.ch> <20040914080132.GJ9106@holomorphy.com> <20040914092748.GA11238@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914092748.GA11238@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 01:01:32 -0700, William Lee Irwin III wrote:
>> That expectation can't be entirely relied upon, as the restrictions may
>> not be predictable.

On Tue, Sep 14, 2004 at 11:27:48AM +0200, Roger Luethi wrote:
> They should be. For the simple design I described the access restrictions
> are part of the field ID, so a tool can deduce the exact type of access
> restrictions even if it doesn't know the field. There's plenty of space
> left for additional access control flags in the field ID.

No, in general races of the form "permissions were altered after I
checked them" can happen.


On Tue, Sep 14, 2004 at 11:27:48AM +0200, Roger Luethi wrote:
> If it gets much more complex, the application (let alone the kernel)
> has to have some knowledge of the security model anyway, so we could have
> simple operations that allow a tool to discover how access restrictions
> apply to the supported fields.

Checking that system calls succeeded is a minimum requirement at all
times. Misinterpreting error returns is the app's fault.


On Tue, 14 Sep 2004 01:01:32 -0700, William Lee Irwin III wrote:
>> This kind of error reporting is better still, as the fields then won't
>> be polluted with invalid data under any circumstance (assuming the code
>> can report subsets of the fields or some such, which I presume to be
>> the case given that avoiding reporting potentially computationally
>> expensive fields was one of the original motivators of the patch).

On Tue, Sep 14, 2004 at 11:27:48AM +0200, Roger Luethi wrote:
> It cannot easily, and I don't think it wants to. The reason it's hard to
> just reply with a subset is that the kernel does not send any description
> of the reply content other than the serial number of the request --
> it's up to the tool to know what it asked for. So if you remove a field,
> you'd have to let user-space know which field you removed. Sending only
> the allowed subset makes handling on both sides more complicated --
> the kernel needs to build different kinds of messages in answer to one
> request, and user-space tool need to be able to parse that.

Irritating. That must mean you can't ask for specific fields.


On Tue, Sep 14, 2004 at 11:27:48AM +0200, Roger Luethi wrote:
> The way the interface works now, though, is that a tool can rely on
> the content of the reply to match the request. This makes the common
> case both easy to write and fast.
> Let me break it down once again:
> - If a tool asks for a field the kernel doesn't know about, that's a
>   fatal error. An error message is returned, nothing else (this can be
>   discovered before any other reply is delivered).

If you can't ask for specific fields you're dead anyway.


On Tue, Sep 14, 2004 at 11:27:48AM +0200, Roger Luethi wrote:
> - If a tool specifically asks for a process which doesn't exist,
>   nothing is returned. We could return an error indicating that. Might
>   be a good idea.

ESRCH and ENOENT sound good.


On Tue, Sep 14, 2004 at 11:27:48AM +0200, Roger Luethi wrote:
> - If a tool asks for a field it doesn't have permission to read, it usally
>   does have permission to read that field for some tasks (e.g. same owner),
>   but not for others. So for some replies to one request, all requested
>   fields will contain meaningful values.  What about the replies that
>   describe the tasks where the tool must not read at least some of the
>   requested values? I chose to simply skip those tasks.

This is the bit about being dead already if you can't request subsets
of fields and/or one field at a time.


On Tue, Sep 14, 2004 at 11:27:48AM +0200, Roger Luethi wrote:
>   We could also send an error message ("some tasks omitted") or send a
>   complete reply with the restricted fields zeroed and a special flag set
>   ("some fields in this reply zeroed due to access control").
> I'm really afraid of over-engineering something here, though. The fields
> requested by tools like ps and top by default are all world readable
> in /proc. I showed that solutions fit right in should we ever need
> access control for real-world applications. For now, I'd rather not
> extend the interface significantly unless the current semantics are
> clearly insufficient.

Well, "return this set of fields" means there's only one type of
request necessary, and userspace merely iterates through the subsets
obtained by striking out fields to which accesses caused errors until
either the set is empty or the call succeeds. One field at a time at
all times also means there's only one type of request necessary. So I
don't see overengineering happening here, merely that "either all
succeed or all fail" is a semantic that creates hardships for userspace;
both the alternatives are simple.


-- wli
