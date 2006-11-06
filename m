Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753013AbWKFMut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013AbWKFMut (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 07:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753014AbWKFMus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 07:50:48 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:35305 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1753000AbWKFMur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 07:50:47 -0500
Date: Mon, 6 Nov 2006 18:19:48 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: "Paul Menage" <menage@google.com>
Cc: "Paul Jackson" <pj@sgi.com>, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-ID: <20061106124948.GA3027@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061030031531.8c671815.pj@sgi.com> <6599ad830610300404v1e036bb7o7ed9ec0bc341864e@mail.gmail.com> <20061030042714.fa064218.pj@sgi.com> <6599ad830610300953o7cbf5a6cs95000e11369de427@mail.gmail.com> <20061030123652.d1574176.pj@sgi.com> <6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com> <20061031115342.GB9588@in.ibm.com> <6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com> <20061101172540.GA8904@in.ibm.com> <6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 03:37:12PM -0800, Paul Menage wrote:
> I saw your example, but can you give a concrete example of a situation
> when you might want to do that?

Paul,
	Firstly, after some more thought on this, we can use your current
proposal, if it makes the implementation simpler.

Secondly, regarding how separate grouping per-resource *maybe* usefull,
consider this scenario.

A large university server has various users - students, professors,
system tasks etc. The resource planning for this server could be on these lines:

	CPU : 		Top cpuset 
			/	\   
		CPUSet1 	CPUSet2
		   |		  |
		(Profs)		(Students)

		In addition (system tasks) are attached to topcpuset (so
		that they can run anywhere) with a limit of 20%

	Memory : Professors (50%), students (30%), system (20%)

	Disk : Prof (50%), students (30%), system (20%)

	Network : WWW browsing (20%), Network File System (60%), others (20%)
				/ \
 			Prof (15%) students (5%)

Browsers like firefox/lynx go into the WWW network class, while (k)nfsd go 
into NFS network class.

At the same time firefox/lynx will share an appropriate CPU/Memory class 
depending on who launched it (prof/student).

If we had the ability to write pids directly to these resource classes,
then admin can easily setup a script which receives exec notifications
and depending on who is launching the browser he can 
	
	# echo browser_pid > approp_resource_class

With your proposal, he now would have to create a separate container for
every browser launched and associate it with approp network and other
resource class. This may lead to proliferation of such containers.

Also lets say that the administrator would like to give enhanced network
access temporarily to a student's browser (since it is night and the user
wants to do online gaming :)  OR give one of the students simulation
apps enhanced CPU power, 

With ability to write pids directly to resource classes, its just a
matter of :

	# echo pid > new_cpu/network_class
	(after some time)
	# echo pid > old_cpu/network_class

Without this ability, he will have to split the container into a
separate one and then associate the container with the new resource
classes.

So yes, the end result is perhaps achievable either way, the big
different I see is the ease of use.

> For simplicity combined with flexibility, I think I still favour the
> following model:
> 
> - all processes are a member of one container
> - for each resource type, each container is either in the same
> resource node as its parent or a freshly child node of the parent
> resource node (determined at container creation time)
> 
> This is a subset of my more complex model, but it's pretty easy to
> understand from userspace and to implement in the kernel.

If this model makes the implementation simpler, then I am for it, until
we have gained better insight on its use.

> What objections do you have to David's suggestion hat if you want some
> processes in a container to be in one resource node and others in
> another resource node, then you should just subdivide into two
> containers, such that all processes in a container are in the same set
> of resource nodes?

One observation is the ease of use (as some of the examples above
point out). Other is that it could lead to more containers than
necessary.

-- 
Regards,
vatsa
