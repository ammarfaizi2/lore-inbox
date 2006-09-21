Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWIUWsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWIUWsS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWIUWsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:48:18 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:7075 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932096AbWIUWsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:48:17 -0400
Date: Thu, 21 Sep 2006 15:48:04 -0700
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: sekharan@us.ibm.com, npiggin@suse.de, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, devel@openvz.org,
       clameter@sgi.com
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060921154804.25dce6ba.pj@sgi.com>
In-Reply-To: <6599ad830609211507m1f5965d8ucfcb58dd86c97c74@mail.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609201252030.32409@schroedinger.engr.sgi.com>
	<1158798715.6536.115.camel@linuxchandra>
	<20060920173638.370e774a.pj@sgi.com>
	<6599ad830609201742h71d112f4tae8fe390cb874c0b@mail.google.com>
	<1158803120.6536.139.camel@linuxchandra>
	<6599ad830609201852k12cee6eey9086247c9bdec8b@mail.google.com>
	<1158869186.6536.205.camel@linuxchandra>
	<6599ad830609211310s4e036e55h89bab26432d83c11@mail.google.com>
	<20060921145946.8d9ace73.pj@sgi.com>
	<6599ad830609211507m1f5965d8ucfcb58dd86c97c74@mail.google.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M wrote:
> Page allocation and task scheduling are resource controller issues,
> not generic process container issues.

But when a process is moved to a different container, its page
allocation and task scheduling constraints and metrics move too.

One of the essential differences, for example, between the two memory
constraint mechanisms we have now, mempolicy.c and cpuset.c, is that
mempolicy only affects the current task, so has an easier time of
the locking and its hooks in the page allocation code path, whereas
cpusets allows any task to change any other tasks memory constraints.

This made the cpuset hooks in the page allocation code path more
difficult -- and as you have recently shown, we aren't done working
that code path yet ;).

This is likely true in general for resource controllers.  One of
their more challenging design aspects are the hooks they require in
the code paths that handle the various controlled resources.

One has to use these hooks to access the container on these fairly
hot code paths.  And since the container can be changing in parallel
at the same time, it can be challenging to handling the necessary
locking without forcing a system-wide lock there.

Doable, I presume.  But challenging.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
