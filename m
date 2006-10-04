Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWJDEB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWJDEB3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 00:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWJDEB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 00:01:29 -0400
Received: from 1wt.eu ([62.212.114.60]:12036 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751100AbWJDEB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 00:01:28 -0400
Date: Wed, 4 Oct 2006 05:26:56 +0200
From: Willy Tarreau <w@1wt.eu>
To: Manish Neema <Manish.Neema@synopsys.com>
Cc: Keith Mannthey <kmannth@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: System hang problem.
Message-ID: <20061004032656.GB5050@1wt.eu>
References: <C9A861D62D068643A0F4A7B1BCB38E2C0327B5FE@US01WEMBX1.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C9A861D62D068643A0F4A7B1BCB38E2C0327B5FE@US01WEMBX1.internal.synopsys.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 05:07:25PM -0700, Manish Neema wrote:
> Thanks Keith for the response.
> 
> My explanation earlier is not clear. The "automount" process dying with
> restrictive overcommit settings is not because of the OOM kill. It looks
> like some bug with "automount" binary itself causing it to exit when it
> could not service a new request.

Well, what would you expect there ?

You configured your system to avoid killing processes and return NULL to
malloc() when there's no memory left. That's the basic semantics of any
malloc() call on any system. Automount might not be able to recover from
such a condition (which for a daemon generally indicates a poor design
anyway).

What you can often do, if you have one application using much memory, is
limiting *this application's* memory usage with ulimit. If the application
correctly handles malloc()==NULL, then at least your system will behave
stably.

To better understand how the overcommit works, imagine that you have
several people who need to put eggs in the same box. By default, they
are blind and simply put their eggs there. But they don't see if the
box is overloaded or not. So once the box is full and they push new
eggs, they start to break other ones (sometimes theirs), but breaking
eggs also leaves them some room to add new ones.

Now when you set the overcommit with the ratio, you basically define
the fill limit for the box, and the people stop filling the box with
their eggs when the limit is reached. Moreover, respecting the limit
leaves room to add other components in the box (eg: packing bubbles
to protect them). On the system, this might be used by tmpfs, socket
buffers, etc...

But what will the people do with their new eggs when the box is full ?
Those who know how to refuse new eggs will simply say "no thanks" and
stop pushing new ones, while others will simply drop them on the floor
with lack of former instructions. Your automount has not been instructed
about how to proceed with new eggs it seems.

Now if you set a limit on each process, it means you will tell each
worker not to accept more than XXX eggs. If you correctly set the
limit for each worker, you can ensure that the box will never be
full. It won't mean that dumb workers will not drop new eggs on the
floor, but at least, each worker will not make other ones stop their
job. So if you can instruct smart workers to stop accepting eggs at
one limit, knowing that the dumb ones will not receive too many of
them, then you might avoid sweeping the floor at the end of the day.

If you cannot instruct any of your workers not to drop anything on
the floor, then the only solution will be to have a larger box to
be able to put all the eggs, which means more memory in your
situation.

I hope it's clear now.

Regards,
Willy

