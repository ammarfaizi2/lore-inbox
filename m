Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbVHIRRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbVHIRRP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 13:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbVHIRRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 13:17:15 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:27602 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S964890AbVHIRRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 13:17:14 -0400
Message-ID: <42F8E516.7020600@zabbo.net>
Date: Tue, 09 Aug 2005 10:17:10 -0700
From: Zach Brown <zab@zabbo.net>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: David Teigland <teigland@redhat.com>, Pekka Enberg <penberg@gmail.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
       mark.fasheh@oracle.com
Subject: Re: GFS
References: <20050802071828.GA11217@redhat.com>	 <84144f0205080203163cab015c@mail.gmail.com>	 <20050803063644.GD9812@redhat.com>	 <courier.42F768D5.000046F2@courier.cs.helsinki.fi>	 <42F7A557.3000200@zabbo.net> <1123598983.10790.1.camel@haji.ri.fi>
In-Reply-To: <1123598983.10790.1.camel@haji.ri.fi>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:

> In addition, the vma walk will become an unmaintainable mess as soon
>  as someone introduces another mmap() capable fs that needs similar 
> locking.

Yup, I suspect that if the core kernel ends up caring about this problem
then the VFS will be involved in helping file systems sort the locks
they'll acquire around IO.

> I am not an expert so could someone please explain why this cannot be
>  done with a_ops->prepare_write and friends?

I'll try, briefly.

Usually clustered file systems in Linux maintain data consistency for
normal posix IO by holding DLM locks for the duration of their
file->{read,write} methods.  A task on a node won't be able to read
until all tasks on other nodes have finished any conflicting writes they
might have been performing, etc, nothing surprising here.

Now say we want to extend consistency guarantees to mmap().  This boils
down to protecting mappings with DLM locks.  Say a page is mapped for
reading, the continued presence of that mapping is protected by holding
a DLM lock.  If another node goes to write to that page, the read lock
is revoked and the mapping is torn down.  These locks are acquired in
a_ops->nopage as the task faults and tries to bring up the mapping.

And that's the problem. Because they're acquired in ->nopage they can
be acquired during a fault that is servicing the 'buf' argument to an
outer file->{read,write} operation which has grabbed a lock for the
target file. Acquiring multiple locks introduces the risk of ABBA
deadlocks. It's trivial to construct examples of mmap(), read(), and
write() on 2 nodes with 2 files that deadlock.

So clustered file systems in Linux (GFS, Lustre, OCFS2, (GPFS?)) all
walk vmas in their file->{read,write} to discover mappings that belong
to their files so that they can preemptively sort and acquire the locks
that will be needed to cover the mappings that might be established in
->nopage. As you point out, this both relies on the mappings not
changing and gets very exciting when you mix files and mappings between
file systems that are each sorting and acquiring their own DLM locks.

I brought this up with some people at the kernel summit but no one,
including myself, considers it a high priority.  It wouldn't be too hard
to construct a patch if people want to take a look.

- z
