Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWHWMMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWHWMMt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 08:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWHWMMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 08:12:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62124 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932443AbWHWMMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 08:12:48 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Avi Kivity <avi@argo.co.il>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, pj@sgi.com,
       saito.tadashi@soft.fujitsu.com, ak@suse.de
Subject: Re: [RFC][PATCH] ps command race fix take2 [1/4] list token
References: <m1ac5woube.fsf@ebiederm.dsl.xmission.com>
	<44EC2600.3070006@argo.co.il>
Date: Wed, 23 Aug 2006 06:12:05 -0600
In-Reply-To: <44EC2600.3070006@argo.co.il> (Avi Kivity's message of "Wed, 23
	Aug 2006 12:55:12 +0300")
Message-ID: <m1irkjodm2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity <avi@argo.co.il> writes:

> ebiederm@xmission.com wrote:
>>
>> I almost removed the tasklist_lock from all read paths.  But as it
>> happens sending a signal to a process group is an atomic operation
>> with respect to fork so that path has to take the lock, or else
>> we get places where "kill -9 -pgrp" fails to kill every process in
>> the process group.  Which is even worse.
>>
>
> Can't that be fixed by adding a per-pgrp lock, and having both fork()/clone()
> and kill(-pgrp) take that lock?

Possibly.  The core issue though is that you still need to take a lock and
a big group can be as bad as just about anything else.  So all you do with
a per group lock is you change the odds of hitting the problem and make the
code a little more complicated.  For the small systems that most people have
I don't believe the tasklist_lock shows up at all.

If someone can find a data structure that I could use on two independent 
machines to create processes in the same process group and still allow atomic
kill behavior between those two machines I think we would have something that
could be made to scale very well.

Until the point where I see the truly better data structure or that people
who can actually see problems with the lock start to fix it.  I think
it is not to modify the data structure more than necessary, at runtime.

Modifying the global task list in the middle of readdir looks like it will
allow user space simply by running top with a fast update frequency to
cause problems for people on bigger machines.  Which is really the
wrong direction to go.

Eric
