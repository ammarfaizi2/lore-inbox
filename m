Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWCXUas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWCXUas (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 15:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWCXUas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 15:30:48 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11993 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751058AbWCXUas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 15:30:48 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: Dave Hansen <haveblue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
       linux-kernel@vger.kernel.org, Herbert Poetzl <herbert@13thfloor.at>,
       OpenVZ developers list <dev@openvz.org>,
       "Serge E.Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] [PATCH 0/7] Some basic vserver infrastructure
References: <20060321061333.27638.63963.stgit@localhost.localdomain>
	<1142967011.10906.185.camel@localhost.localdomain>
	<m1k6anq8uq.fsf@ebiederm.dsl.xmission.com> <44241224.9000200@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 24 Mar 2006 13:28:49 -0700
In-Reply-To: <44241224.9000200@sw.ru> (Kirill Korotaev's message of "Fri, 24
 Mar 2006 18:37:08 +0300")
Message-ID: <m13bh7io3i.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:


>> I certainly have not.  I do feel that developing this just from the
>> top down is the wrong way to do this.  In some of the preliminary
>> patches we have found several pieces of code that we will have to
>> touch that is currently in need of a cleanup.  That is why I have
>> been cleaning up /proc.  sysctl is in need of similar treatment
>> but is in less bad shape.
> Eric, though I suggest to postpone proc and sysctl a bit, can you share
> me your vision of /proc and /sysctl virtualization a bit?
> A good way to handle them IMHO is to make fully virtual, i.e. each
> namespace should have an own set of sysctl or proc tree.

Roughly I agree.  Some cases are easier than others.  So let me take
just the sysvipc case as an example.

My thinking is move the calls for printing the sysvipc namespace
from fs/proc/generic.c (with all of it's cool helpers) to 
fs/proc/base.c.

So we wind up with: 
/proc/<pid>/sysvipc/msg
/proc/<pid>/sysvipc/sem
/proc/<pid>/sysvipc/shm
/proc/sysvipc -> /proc/self/sysvipc

For sysctl we add a method to fetch the address of
the variable and perhaps a few other attributes,
that method is passed a task structure.

Then we can have per process instances of:
/proc/<pid>/sys/sem
/proc/<pid>/sys/shmall
/proc/<pid>/sys/shmmax
/proc/<pid>/sys/msgmax
/proc/<pid>/sys/msgmni
/proc/<pid>/sys/shmmni
And a symlink at:
/proc/sys that points to /proc/<pid>/sys

Getting sysvipc to show up in a per process fashion is pretty
easy.  Getting the entire sys hierarchy to show up per process
is a little harder simply because I think to do it cleanly requires
help functions that I don't have yet.  I have removed all of
the internal dependence on magic inode numbers completely removing
the hard coded inode numbers and putting sys looks doable.

Does that sound like a reasonable model?

>> Part of it is that I have stopped to look more closely at what
>> other people are doing and to look at alternative implementations.
> If you need any help with it in OpenVZ, feel free to ask. We have
> broken-out patches for recent 2.6.16 kernel.


>> One interesting thing I have manged to do is by using ptrace I
>> have implemented enter for the existing filesystem namespaces without having
>> to modify the kernel.  This at least says
>> that enter and debugging are two faces of the same coin.
> Hmmm, strange claim/conclusion... /dev/kmem allows to change namespaces
> also :) and even to obtain root priviliges if needed... :)

True.  However this is much less ugly then using /dev/kmem, and it is
much closer to what applications like user mode linux do.  The primary
question in my mind was what should the permissions checks be when
performing this kind of action.  Using ptrace satisfied that.

So I now have a bounding box for what enter should be able to do
and what permissions it should take.

> Eric, let's not compare approaches with inches :)
> As you remember your PID namespaces doesn't suite us well... :(

More discussion when the time is right.  But I believe I have solved
the fundamental incompatibility that we had.  I asked you a question
to confirm that a while ago, but I have not heard anything back.

Eric
