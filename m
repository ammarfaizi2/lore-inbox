Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWILQEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWILQEg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 12:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWILQEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 12:04:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32446 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030243AbWILQEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 12:04:34 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       containers@lists.osdl.org
Subject: Re: [patch -mm] update mq_notify to use a struct pid
References: <45019CC3.2030709@fr.ibm.com>
	<m18xktkbli.fsf@ebiederm.dsl.xmission.com>
	<450537B6.1020509@fr.ibm.com>
	<m1u03eacdc.fsf@ebiederm.dsl.xmission.com>
	<45056D3E.6040702@fr.ibm.com>
	<m14pve9qip.fsf@ebiederm.dsl.xmission.com>
	<4505DADD.4080007@fr.ibm.com>
	<m1ejuh98vn.fsf@ebiederm.dsl.xmission.com>
	<4506D438.6090804@fr.ibm.com>
Date: Tue, 12 Sep 2006 10:03:32 -0600
In-Reply-To: <4506D438.6090804@fr.ibm.com> (Cedric Le Goater's message of
	"Tue, 12 Sep 2006 17:37:28 +0200")
Message-ID: <m1u03d3wdn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater <clg@fr.ibm.com> writes:

> Eric W. Biederman wrote:
>
> [ ... ]
>
>> There is also the case that should not come up with signals where
>> we have a pid from a child namespace, that we should also be able to
>> compute the pid for.
>
> I don't understand how a signal can come from a child pid namespace ?

SIG_CHLD is the only case where I think we will be sending a signal
from the child pid namespace.

Reading pids from the status files in /proc, from a parent namespace,
is another example where we need to deal with the pid of children.

>> In essence I intend to have a list of pid_namespace, pid_t pairs connected
>> to a struct pid that we can look through to find the appropriate pid.
>
> yes, that's the purpose of pid_nr() I guess.
>
> This list would contain in nearly all cases a single pair (current pid
> namespace, pid value). It will contain 2 pairs for a task that has unshared
> its pid namespace : a pair for the current pid namespace, that needs to
> allocated when unshare() is called, and one pair for the ancestor pid
> namespace which is already allocated.
>
> Do you see more ?

I don't see the list getting longer until we get into a nested pid namespaces.

As long as the interface is well defined for the container in a container
case I don't mind having additional restrictions.

I will note that you can get some extremely weird interactions if
you do things like open a file descriptor in the parent pid namespace.
Fork two children each child in a different  pid_namespaces.
fcntl(F_SETOWN) is called in one child, and fcntl(F_GETOWN) is called
in the other child.

So we can't just call BUG_ON, if we have can't find the namespace.
But returning 0 from pid_nr should be fine.

Eric
