Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWKGTIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWKGTIJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 14:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWKGTIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 14:08:09 -0500
Received: from smtp-out.google.com ([216.239.45.12]:44013 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750701AbWKGTIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 14:08:07 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=chNTx8UcD3DfCNEOwM575YK+Bld+vkd3L++H2C4fpNc1VQen/fNFVWtVCM/qNDq54
	KRTgZEkWqOxBmGUi0pn0A==
Message-ID: <6599ad830611071107u4226ec17h5facc7ee2ad53174@mail.gmail.com>
Date: Tue, 7 Nov 2006 11:07:46 -0800
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Cc: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
In-Reply-To: <20061107104118.f02a1114.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030031531.8c671815.pj@sgi.com>
	 <20061030123652.d1574176.pj@sgi.com>
	 <6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com>
	 <20061031115342.GB9588@in.ibm.com>
	 <6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com>
	 <20061101172540.GA8904@in.ibm.com>
	 <6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com>
	 <20061106124948.GA3027@in.ibm.com>
	 <6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com>
	 <20061107104118.f02a1114.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/06, Paul Jackson <pj@sgi.com> wrote:
>
> I see the following usage patterns -- I wonder if we can see a way to
> provide for all these.  I will speak in terms of just cpusets and
> resource groups, as examplars of the variety of controllers that might
> make good use of Paul M's containers:
>
> Could we (Paul M?) find a way to build a single kernel that supports:
>
>  1) Someone just using cpusets wants to do:
>         mount -t cpuset cpuset /dev/cpuset
>     and then see the existing cpuset API.  Perhaps other files show
>     up in the cpuset directories, but at least all the existing
>     ones provided by the current cpuset API, with their existing
>     behaviours, are all there.

This will happen if you configure CONFIG_CPUSETS_LEGACY_API

>
>  2) Someone wanting a good CKRM/ResourceGroup interface, doing
>     whatever those fine folks are wont to do, binding some other
>     resource group controller to a container hierarchy.

This works now.

>
>  3) Someone, in the future, wanting to "bind" cpusets and resource
>     groups together, with a single container based name hierarchy
>     of sets of tasks, providing both the cpuset and resource group
>     control mechanisms.  Code written for (1) or (2) should work,
>     though there is a little wiggle room for API 'refinements' if
>     need be.

That works now.

>
>  4) Someone doing (1) and (2) separately and independently on the
>     same system at the same time, with separate and independent
>     partitions (aka container hierarchies) of that systems tasks.

Right now you can't have multiple independent hierarchies - each
subsystem either has the same hierarchy as all the other subsystems,
or has just a single node and doesn't participate in the hierarchy.

>
> The initial customer needs are for (1), which preserves an existing
> kernel API, and on separate systems, for (2).  Providing for both on
> the same system, as in (3) with a single container hierarchy or even
> (4) with multiple independent hierarchies, is an enhancement.
>
> I forsee a day when user level software, such as batch schedulers, are
> written to take advantage of (3), once the kernel supports binding
> multiple controllers to a common task container hierarchy.  Initially,
> some systems will need cpusets, and some will need resource groups, and
> the intersection of these requiring both, whether bound as in (3), or
> independent as in (4), will be pretty much empty.

I don't know about group (4), but we certainly have a big need for (3).

>
> In general then, we will have several controllers (need a good way
> for user space to list what controllers, such as cpusets and resource
> groups,

I think it's better to treat resource groups as a common framework for
resource controllers, rather than a resource controller itself.
Otherwise we'll have the same issues of wanting to treat separate
resources in separate hierarchies - by treating each RG controller as
a separate entitiy sharing a common resource metaphor and user API,
you get the multiple hierarchy support for free.

>
> Perhaps the interface to binding multiple controllers to a single container
> hierarchy is via multiple mount commands, each of type 'container', with
> different options specifying which controller(s) to bind.  Then the
> command 'mount -t cpuset cpuset /dev/cpuset' gets remapped to the command
> 'mount -t container -o controller=cpuset /dev/cpuset'.

Yes, that's the aproach that I'm thinking of currently. It should
require pretty reasonably robotic changes to the existing code.

One of the issues that crops up with it is what do you put in
/proc/<pid>/container if there are multiple hierarchies?

Paul
