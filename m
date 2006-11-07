Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751916AbWKGSls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbWKGSls (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 13:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754244AbWKGSls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 13:41:48 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:28361 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751695AbWKGSlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 13:41:47 -0500
Date: Tue, 7 Nov 2006 10:41:18 -0800
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-Id: <20061107104118.f02a1114.pj@sgi.com>
In-Reply-To: <6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com>
References: <20061030031531.8c671815.pj@sgi.com>
	<20061030042714.fa064218.pj@sgi.com>
	<6599ad830610300953o7cbf5a6cs95000e11369de427@mail.gmail.com>
	<20061030123652.d1574176.pj@sgi.com>
	<6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com>
	<20061031115342.GB9588@in.ibm.com>
	<6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com>
	<20061101172540.GA8904@in.ibm.com>
	<6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com>
	<20061106124948.GA3027@in.ibm.com>
	<6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M. wrote:
> It does, but I'm more in favour of getting the abstractions right the
> first time if we can, rather than implementation simplicity.

Yup.

The CONFIG_CPUSETS_LEGACY_API config option is still sticking in my
craw.  Binding things at mount time, as you did, seems more useful.

Srivatsa wrote:
> Secondly, regarding how separate grouping per-resource *maybe* usefull,
> consider this scenario.

Yeah - I tend to agree that we should allow for such possibilities.

I see the following usage patterns -- I wonder if we can see a way to
provide for all these.  I will speak in terms of just cpusets and
resource groups, as examplars of the variety of controllers that might
make good use of Paul M's containers:

Could we (Paul M?) find a way to build a single kernel that supports:

 1) Someone just using cpusets wants to do:
	mount -t cpuset cpuset /dev/cpuset
    and then see the existing cpuset API.  Perhaps other files show
    up in the cpuset directories, but at least all the existing
    ones provided by the current cpuset API, with their existing
    behaviours, are all there.

 2) Someone wanting a good CKRM/ResourceGroup interface, doing
    whatever those fine folks are wont to do, binding some other
    resource group controller to a container hierarchy.

 3) Someone, in the future, wanting to "bind" cpusets and resource
    groups together, with a single container based name hierarchy
    of sets of tasks, providing both the cpuset and resource group
    control mechanisms.  Code written for (1) or (2) should work,
    though there is a little wiggle room for API 'refinements' if
    need be.

 4) Someone doing (1) and (2) separately and independently on the
    same system at the same time, with separate and independent
    partitions (aka container hierarchies) of that systems tasks.

If we found usage pattern (4) to difficult to provide cleanly, I might
be willing to drop that one.  I'm not sure yet.

Intuitively, I find (3) very attractive, though I don't have any actual
customer requirements for it in hand (we are operating a little past
our customers awareness in this present discussion.)

The initial customer needs are for (1), which preserves an existing
kernel API, and on separate systems, for (2).  Providing for both on
the same system, as in (3) with a single container hierarchy or even
(4) with multiple independent hierarchies, is an enhancement.

I forsee a day when user level software, such as batch schedulers, are
written to take advantage of (3), once the kernel supports binding
multiple controllers to a common task container hierarchy.  Initially,
some systems will need cpusets, and some will need resource groups, and
the intersection of these requiring both, whether bound as in (3), or
independent as in (4), will be pretty much empty.

In general then, we will have several controllers (need a good way
for user space to list what controllers, such as cpusets and resource
groups, are available on a live system!) and user space code should be
able to create at least one, if not multiple as in (4) above, container
hierarchies, each bound to one or more of these controllers.

Likely some, if not all, controllers will be singular - at most one such
controller of a given time on a system. Though if someone has a really
big brain, and wants to generalize that constraint, that could be
amusing.  I guess I could have added a (5) above - allow for multiple
instances of a given controller, each bound to different container
hierarchies.  But I'm guessing that is too hard, and not worth the
effort, so I didn't list it.

The notify_on_release mechanism should be elaborated, so that when
multiple controllers (e.g. cpusets and resource groups) are bound to
a common container hierarchy, then user space code can (using API's that
don't exist currently) separately control these exits hooks for each of
these bound controllers.  Perhaps simply enabling 'notify_on_release'
for a container invokes the exit hooks (user space callbacks) for -all-
the controllers bound to that container, whereas some new API's enable
picking and choosing which controllers exit hooks are active.  For
example, there might be a per-cpuset boolean flag file called
'cpuset_notify_on_release', for controlling that exit hook, separately
from any other exit hooks, and a 'cpuset_notify_on_release_path' file
for setting the path of the executable to invoke on release.

I would expect one kernel build CONFIG option for each controller type.
If any one or more of these controller options was enabled, then you
get containers in your build too - no option about it.  I guess that
means that we have a CONFIG option for containers, to mark that code as
conditionally compiled, but that this container CONFIG option is
automatically set iff one or more controllers are included in the build.

Perhaps the interface to binding multiple controllers to a single container
hierarchy is via multiple mount commands, each of type 'container', with
different options specifying which controller(s) to bind.  Then the
command 'mount -t cpuset cpuset /dev/cpuset' gets remapped to the command
'mount -t container -o controller=cpuset /dev/cpuset'.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
