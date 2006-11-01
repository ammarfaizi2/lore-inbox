Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752572AbWKAXhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572AbWKAXhd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbWKAXhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:37:32 -0500
Received: from smtp-out.google.com ([216.239.45.12]:17728 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1752572AbWKAXhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:37:32 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=L2L1N9RQ1CFjzAOZjW0tHGqmrJJpxuiSLePfvTHmQsO/f1gS/wcinwOMOi8gHkjXw
	nRDJ/5lg0ZdgZ4L8qiUew==
Message-ID: <6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com>
Date: Wed, 1 Nov 2006 15:37:12 -0800
From: "Paul Menage" <menage@google.com>
To: vatsa@in.ibm.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Cc: "Paul Jackson" <pj@sgi.com>, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
In-Reply-To: <20061101172540.GA8904@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030103356.GA16833@in.ibm.com>
	 <20061030031531.8c671815.pj@sgi.com>
	 <6599ad830610300404v1e036bb7o7ed9ec0bc341864e@mail.gmail.com>
	 <20061030042714.fa064218.pj@sgi.com>
	 <6599ad830610300953o7cbf5a6cs95000e11369de427@mail.gmail.com>
	 <20061030123652.d1574176.pj@sgi.com>
	 <6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com>
	 <20061031115342.GB9588@in.ibm.com>
	 <6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com>
	 <20061101172540.GA8904@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/06, Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
>
> I suspect we can avoid maintaining separate hierarchies if not required.
>
>         mkdir /dev/res_groups
>         mount -t container -o cpu,mem,io none /dev/res_groups
>         mkdir /dev/res_groups/A
>         mkdir /dev/res_groups/B
>
> Directories A and B would now contain res ctl files associated with all
> resources (viz cpu, mem, io) and also a 'members' file listing the tasks
> belonging to those groups.
>
> Do you think the above mechanism is implementable? Even if it is, I dont know
> how the implementation will get complicated because of this requirement.

Yes, certainly implementable, and I don't think it would complicate
the code too much. I alluded to it as a possibility when I first sent
out my patches  - I think my main issue with it was the fact that it
results in multiple container pointers per process at compile time,
which could be wasteful.

>
> This requirement that each process should be exactly in one process container
> is perhaps not good, since it will not give the fleixibility to define groups
> unique to each resource (see my reply earlier to David Rientjes).

I saw your example, but can you give a concrete example of a situation
when you might want to do that?

For simplicity combined with flexibility, I think I still favour the
following model:

- all processes are a member of one container
- for each resource type, each container is either in the same
resource node as its parent or a freshly child node of the parent
resource node (determined at container creation time)

This is a subset of my more complex model, but it's pretty easy to
understand from userspace and to implement in the kernel.

>
> > the child task is either entirely in the new resource limits or
> > entirely in the old limits - if userspace has to update several
> > hierarchies at once non-atomically then a freshly forked child could
> > end up with a mixture of resource nodes.
>
> If the user intended to have a common grouping hierarchy for all
> resources, then this movement of tasks can be "atomic" as far as user is
> concerned, as per the above example:
>
>         echo task_pid > /dev/res_groups/B/members
>
> should cause the task transition to the new group in one shot?
>

Yes, if we took that model. But if someone does want to have
non-identical hierarchies, then in that model they're still forced
into a non-atomic update situation.

What objections do you have to David's suggestion hat if you want some
processes in a container to be in one resource node and others in
another resource node, then you should just subdivide into two
containers, such that all processes in a container are in the same set
of resource nodes?

Paul
