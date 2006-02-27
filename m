Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751736AbWB0VRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbWB0VRo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 16:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbWB0VRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 16:17:44 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18643 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751720AbWB0VRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 16:17:43 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, Linus Torvalds <torvalds@osdl.org>,
       Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Andrey Savochkin <saw@sawoct.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Stanislav Protassov <st@sw.ru>,
       serue@us.ibm.com, frankeh@watson.ibm.com, clg@fr.ibm.com,
       mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
       Herbert Poetzl <herbert@13thfloor.at>, Andrew Morton <akpm@osdl.org>
Subject: Re: Which of the virtualization approaches is more suitable for
 kernel?
References: <43F9E411.1060305@sw.ru>
	<m1oe0wbfed.fsf@ebiederm.dsl.xmission.com>
	<1141062132.8697.161.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 27 Feb 2006 14:14:20 -0700
In-Reply-To: <1141062132.8697.161.camel@localhost.localdomain> (Dave
 Hansen's message of "Mon, 27 Feb 2006 09:42:12 -0800")
Message-ID: <m1ek1owllf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Fri, 2006-02-24 at 14:44 -0700, Eric W. Biederman wrote:
>> We can start on a broad front, looking at several different things.
>> But I suggest the first thing we all look at is SYSVIPC.  It is
>> currently a clearly recognized namespace in the kernel so the scope is
>> well defined.  SYSVIPC is just complicated enough to have a
>> non-trivial implementation while at the same time being simple enough
>> that we can go through the code in exhausting detail.  Getting the
>> group dynamics working properly. 
>
> Here's a quick stab at the ipc/msg.c portion of this work.  The basic
> approach was to move msg_ids, msg_bytes, and msg_hdrs into a structure,
> put a pointer to that structure in the task_struct and then dynamically
> allocate it.
>
> There is still only one system-wide one of these for now.  It can
> obviously be extended, though. :)
>
> This is a very simple, brute-force, hack-until-it-compiles-and-boots
> approach.  (I just realized that I didn't check the return of the alloc
> properly.)
>
> Is this the form that we'd like these patches to take?  Any comments
> about the naming?  Do we want to keep the _namespace nomenclature, or
> does the "context" that I used here make more sense

I think from 10,000 feet the form is about right.

I like the namespace nomenclature.  (It can be shorted to _space  or _ns).
In part because it shortens well, and in part because it emphasizes that
we are *just* dealing with the names.

You split the resolution at just ipc_msgs.  When I really think it should
be everything ipcs deals with.

Performing the assignment inside the tasklist_lock is not something we
want to do in do_fork().

So it looks like a good start.  There are a lot of details yet to be filled
in, proc, sysctl, cleanup on namespace release.  (We can still provide
the create destroy methods even if we don't hook the up).

I think in this case I would put the actual namespace structure
definition in util.h, and just put a struct ipc_ns in sched.h.
sysvipc is isolated enough that nothing outside of the ipc/
directory needs to know the implementation details.

It probably makes sense to have a statically structure and
to set the pointer initially in init_task.h

Until we reach the point where we can multiple instances that
even removes the need to have a pointer copy in do_fork()
as that happens already as part of the structure copy.


Eric
