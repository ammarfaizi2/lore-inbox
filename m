Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270471AbTHQS0y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 14:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270483AbTHQS0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 14:26:54 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:19584 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270471AbTHQS0x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 14:26:53 -0400
Date: Sun, 17 Aug 2003 19:26:32 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>
Subject: Re: Scheduler activations (IIRC) question
Message-ID: <20030817182632.GB2822@mail.jlokier.co.uk>
References: <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net> <20030815235431.GT1027@matchmail.com> <200308160149.29834.kernel@kolivas.org> <20030815230312.GD19707@mail.jlokier.co.uk> <20030815235431.GT1027@matchmail.com> <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net> <5.2.1.1.2.20030817072115.0198f398@pop.gmx.net> <5.2.1.1.2.20030817100457.019d0c70@pop.gmx.net> <20030817171224.GA2822@mail.jlokier.co.uk> <1061140547.29559.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061140547.29559.2.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> > > Oh.  You just want to dispatch N syscalls from one entry to the kernel?
> > 
> > No, not at all.  I want to schedule cooperative state machines in
> > userspace, in the classical select-loop style, but without idling the
> > CPU when there's unpredictable blocking on disk I/O.
> 
> eg you want AIO stat().....

Plus AIO link(), unlink(), rename(), open() (especially open),
msync(), mlock(), mmap(), sendfile(), readdir(), readlink(), ioctl()
and a few more.

These are too complicated to re-implement using explicit state
machines in the kernel.  That would require rewriting huge amounts of
code in all the individual filesystems.  You could never really trust
all the blocking corner cases were removed - fetching metadata,
reading directory blocks, allocating memory etc.

That's why the kernel would implement AIO stat() et al. by creating a
set of task contexts to handle queue of these requests.

Even that's at least as complicated as doing it in userspace.

Also with current AIO interface there will always be operations things
that it doesn't support, while the scheduler method works with
anything that blocks, including VM paging.

That said, a generalised "async syscall" interface would be very nice.
It could automatically dispatch things which AIO supports using AIO,
and everything else using task contexts.

-- Jamie

