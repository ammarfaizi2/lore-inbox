Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbVITMGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbVITMGO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 08:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbVITMGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 08:06:14 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:467 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964981AbVITMGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 08:06:14 -0400
Date: Tue, 20 Sep 2005 07:05:23 -0500
From: Robin Holt <holt@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: zippel@linux-m68k.org, akpm@osdl.org, torvalds@osdl.org,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
Message-ID: <20050920120523.GC21435@lnx-holt.americas.sgi.com>
References: <20050912075155.3854b6e3.pj@sgi.com> <Pine.LNX.4.61.0509121821270.3743@scrub.home> <20050912153135.3812d8e2.pj@sgi.com> <Pine.LNX.4.61.0509131120020.3728@scrub.home> <20050913103724.19ac5efa.pj@sgi.com> <Pine.LNX.4.61.0509141446590.3728@scrub.home> <20050914124642.1b19dd73.pj@sgi.com> <Pine.LNX.4.61.0509150116150.3728@scrub.home> <20050915104535.6058bbda.pj@sgi.com> <20050920005743.4ea5f224.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050920005743.4ea5f224.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

Can you give a _short_ explanation of why notify_on_release is
essential?  Could the intent be accomplished with something
like destroy on exit which then goes through and does the
remove of shildren and finally removes the cpuset?

If we can agree on that, then the exit path becomes
	if (atomic_dec_and_lock(&current->cpuset.refcount)) {
		/* Code to remove children. */
	}
which no longer needs to call a usermode helper and is _FAR_
better in my personal biased opinion.


Thanks,
Robin


PS:  For reference, here is what /sbin/cpuset_release_agent
looks like:

[holt@attica:sbin] cat cpuset_release_agent 
#!/bin/sh

# Do not modify this file /sbin/cpuset_release_agent.
#
# It is invoked directly from the kernel's call_usermodehelper()
# routine, whenever the last user of cpuset goes away, if that
# cpuset had its 'notify_on_release' option set to '1'.  This
# cpuset_release_agent script is responsible for removing the
# abandoned cpuset, whose cpuset file system path is passed
# in argv[1].

rmdir /dev/cpuset/$1

