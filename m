Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbVLQBZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbVLQBZn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 20:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbVLQBZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 20:25:43 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:59108 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751263AbVLQBZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 20:25:42 -0500
Subject: Re: [ckrm-tech] Re: [RFC][patch 00/21] PID Virtualization:
	Overview and Patches
From: Matt Helsley <matthltc@us.ibm.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, vserver@list.linux-vserver.org,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       pagg@oss.sgi.com
In-Reply-To: <1134776864.28779.19.camel@elg11.watson.ibm.com>
References: <E1En6H2-0005ok-00@w-gerrit.beaverton.ibm.com>
	 <1134754519.19403.6.camel@localhost>
	 <1134776864.28779.19.camel@elg11.watson.ibm.com>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 17:18:18 -0800
Message-Id: <1134782298.10396.337.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 18:47 -0500, Hubertus Franke wrote:
> On Fri, 2005-12-16 at 09:35 -0800, Dave Hansen wrote:
<snip>
> > I've been talking a lot lately about how important filesystem isolation
> > between containers is to implement containers properly.  Isolating the
> > filesystem namespaces makes it much easier to do things like fs-based
> > shared memory during a checkpoint/resume.  If we want to allow tasks to
> > move around, we'll have to throw out this entire concept.  That means
> > that a _lot_ of things get a notch closer to the too-costly-to-implement
> > category.
> > 
> 
> Not only that, as the example of pids already show, while at the surface
> these might seem as desirable features ( particular since they came up
> wrt to the CKRM discussion ), there are significant technical limitation
> to these. 

	Perhaps merging the container process grouping functionality is not a
good idea. 

	However, I think CKRM could be made minimally consistent with
containers using a few small modifications. I suspect all that is
necessary is:

1) Expanding the pid syntax accepted and reported when accessing the
members file to include an optional container id:

        # classify init in container 0 to a class
        echo 0:1 >> ${RCFS}/class_foo/members
        echo :1 >> ${RCFS}/class_foo/members
        
        # while in container 0 classify init in container 0 to a class
        echo 1 >> ${RCFS}/class_foo/members
        
        # while in container 0 classify init in container 3 to a class
        echo 3:1 >> ${RCFS}/class_foo/bar_class/members
        
        Then pids in container 0 would show up as cid:pid
        $ cat ${RCFS}/class_foo/members
        0:1
        5:2
        ...
        3:4
        
        Processes listing members in container n would only see the pid
        and only pids in that container.

2) Limiting the pids and container ids accepted as input to the members
file from processes doing classification from within containers:

        # classify init in the current container to a class
	echo :1 >> ${RCFS}/class_foo/members
        echo 1 >> ${RCFS}/class_foo/members

	# returns an error when not in container 0
	echo 0:1 >> ${RCFS}/class_foo/members
	# returns an error when not in container 1
	echo 1:1 >> ${RCFS}/class_foo/members
	...

(Incidentally these kind of details are what I was referring to earlier
in this thread as "visibility boundaries")

	I think this would be sufficient to make CKRM and containers play
nicely with each other. I suspect further kernel-enforced constraints
between CKRM and containers may constitute policy and not functionality.

	<shameless_plug>I also suspect that with the right userspace
classification engine a wide variety of useful container resource
management policies could be enforced based on these simple
modifications.</shameless_plug>

Cheers,
	-Matt Helsley

