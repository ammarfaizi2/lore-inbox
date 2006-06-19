Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWFSEoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWFSEoa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 00:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWFSEoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 00:44:30 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:8369 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750831AbWFSEoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 00:44:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kpVHRzaI9zv1jp06BWnHbNxnRmCjp0udWcvMAxujUzoPYqvnrbPbMIQK/oK6ZqIdbO4ZolBmGDPHJR+9EPchpN4UP1fZjmPuEqq1i3eU5ncAclX3/d1D1Bt38zixjJyFwUp3iukb/NSExT8ZOdPAKo+7tx11w1InNZ3bygHH0e0=
Message-ID: <787b0d920606182144q9e4fe00re909df57dd520f39@mail.gmail.com>
Date: Mon, 19 Jun 2006 00:44:29 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: linux-kernel@vger.kernel.org, roland@redhat.com, 76306.1226@compuserve.com,
       cwright@cs.sunysb.edu, renzo@cs.unibo.it, blaisorblade@yahoo.it,
       jdike@addtoit.com
Subject: Re: [RFC PATCH 0/4] utrace: new modular infrastructure for user debug/tracing
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath writes:

> This series of patches revamps the support for user process debugging
> from the ground up, replacing the old ptrace support completely.
>
> Two major problems with ptrace are its interface and its implementation.

Yay!

Having written a debugger for Linux, I can assure everyone that
this is long overdue. We've been putting it off for years because
the code is so horrible and nasty, yet not normally used prior to
the creation of user-mode Linux.

Doing serious work with ptrace() is a horrible joke involving
interfaces that are crufty, undocumented, and insufficient.

BTW: debuggers can't get and set the signal context (with cr2!),
can't get and set LDT entries, don't get events when unshare()
succeeds, can't call ptrace() from any desired thread, can't do
a stop or start that affects more than one task, can't adjust the
target's signal data (handlers,blocked,ignored,etc.), can't adjust
file pointers and flags in the target, etc.

With great difficulty, some of the above can be hacked around by
inserting code into the target and running it. This is horribly
painful. It puts writing a debugger out of reach of many people
who might otherwise have only very basic code insertion needs
or none at all.

> system call interface is clunky to use and to extend, and makes it
> difficult to reduce the overhead of doing several operations and of
> transferring large amounts of data.

See the FreeBSD ptrace() man page. We're just being dumb.

> There is no way for more than one
> party to trace a process.  The reporting model using SIGCHLD and wait4
> is tricky to use reliably from userland, and especially hard to
> integrate with other kinds of event loop.

We needlessly make wait4/waitid/waitpid fail to accept
equivalent flags. (some may need to be inverted sense)

We don't appear to have any way to get these events into a
select() or poll(). We could use this even for non-debugger apps.
