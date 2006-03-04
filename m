Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751774AbWCDDSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbWCDDSM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 22:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWCDDSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 22:18:12 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:19927 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750834AbWCDDSL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 22:18:11 -0500
Subject: sysctls inside containers
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, serue@us.ibm.com,
       frankeh@watson.ibm.com, clg@fr.ibm.com
In-Reply-To: <m1ek1owllf.fsf@ebiederm.dsl.xmission.com>
References: <43F9E411.1060305@sw.ru>
	 <m1oe0wbfed.fsf@ebiederm.dsl.xmission.com>
	 <1141062132.8697.161.camel@localhost.localdomain>
	 <m1ek1owllf.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 19:17:25 -0800
Message-Id: <1141442246.9274.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trimming the cc list down, because the scope has narrowed
significantly...

On Mon, 2006-02-27 at 14:14 -0700, Eric W. Biederman wrote: 
> So it looks like a good start.  There are a lot of details yet to be filled
> in, proc, sysctl, cleanup on namespace release.  (We can still provide
> the create destroy methods even if we don't hook the up). 

Well, I at least got to the point of seeing how the sysctls interact
when I tried to containerize them.  Eric, I think the idea of the sysv
code being nicely and completely isolated is pretty much gone, due to
their connection to sysctls.  I think I'll go back and just isolate the
"struct ipc_ids" portion.  We can do the accounting bits later.

The patches I have will isolate the IDs, but I'm not sure how much sense
that makes without doing the things like the shm_tot variable.  Does
anybody think we need to go after sysctls first, perhaps?  Or, is this a
problem graph with cycles in it? :)

I don't see an immediately clear solution on how to containerize sysctls
properly.  The entire construct seems to be built around getting data
from in and out of global variables and into /proc files.

We obviously want to be rid of many of these global variables.  So, does
it make sense to introduce different classes of sysctls, at least
internally?  There are probably just two types: global, writable only
from the root container and container-private.  Does it make sense to
have _both_?  Perhaps a sysadmin 

Eric, can you think of how you would represent these in the hierarchical
container model?  How would they work?

On another note, after messing with putting data in the init_task for
these things, I'm a little more convinced that we aren't going to want
to clutter up the task_struct with all kinds of containerized resources,
_plus_ make all of the interfaces to share or unshare each of those.
That global 'struct container' is looking a bit more attractive.

-- Dave

