Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319416AbSIFWth>; Fri, 6 Sep 2002 18:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319419AbSIFWtg>; Fri, 6 Sep 2002 18:49:36 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:8359 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319416AbSIFWtg>;
	Fri, 6 Sep 2002 18:49:36 -0400
Date: Fri, 6 Sep 2002 17:48:32 -0500
From: Amos Waterland <apw@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: pwaechtler@mac.com, golbi@mat.uni.torun.pl, linux-kernel@vger.kernel.org,
       Jakub Jelinek <jakub@redhat.com>, Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] POSIX message queues
Message-ID: <20020906174832.A25611@kvasir.austin.ibm.com>
References: <20020901015025.A10102@kvasir.austin.ibm.com> <Pine.LNX.4.44.0209041311550.4000-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209041311550.4000-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Sep 04, 2002 at 01:13:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 01:13:28PM +0200, Ingo Molnar wrote:
> 
> On Sun, 1 Sep 2002, Amos Waterland wrote:
> 
> > That is the fundamental problem with a userspace shared memory
> > implementation: write permissions on a message queue should grant
> > mq_send(), but write permissions on shared memory grant a lot more than
> > just that.
> 
> is it really a problem? As long as the read and write queues are separated
> per sender, all that can happen is that a sender is allowed to read his
> own messages - that is not an exciting capability.

Ingo:

I can see no way to keep the queues separated per sender if userspace
shared memory is used.  The data structures used to keep track of the
messages must be writable by both the senders and receivers, because of
the kernel persistent nature of message queues: messages must stay in
the queue during the interval of arbitrary length between the sender
calling mq_send() and the receiver calling mq_receive().

That is, suppose process X posts message M, and then exits.  Process Y
wants to receive message M, which means it must acquire a process-shared
lock and then remove M from the queue: so Y must be able to update the
data structures representing the queue.  I see no way to allow Y to
update the data structures in shared memory without giving Y write
permission to the pages.  If Y has write permission to the pages, it can
spoof messages/wreck the queue, etc.  If you see a way around this,
please correct me.  Thanks.

Ulrich/Jakub:

Is the above related to glibc's position that mq's will not go in until
there is kernel support?  Thanks.

Amos Waterland
