Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946855AbWKAMYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946855AbWKAMYS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 07:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946856AbWKAMYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 07:24:18 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:59069 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1946855AbWKAMYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 07:24:18 -0500
Date: Wed, 1 Nov 2006 04:23:41 -0800
From: Paul Jackson <pj@sgi.com>
To: balbir@in.ibm.com
Cc: menage@google.com, dev@openvz.org, vatsa@in.ibm.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] RFC: Memory Controller
Message-Id: <20061101042341.83cbd77e.pj@sgi.com>
In-Reply-To: <45485046.6080508@in.ibm.com>
References: <20061030103356.GA16833@in.ibm.com>
	<4545D51A.1060808@in.ibm.com>
	<6599ad830610300304l58e235f7td54ef8744e462a55@mail.gmail.com>
	<4545FDCD.3080107@in.ibm.com>
	<6599ad830610301014l1bf78ce8q998229483d055a90@mail.gmail.com>
	<454782D2.3040208@in.ibm.com>
	<6599ad830610310922p61913cdaqb441a2cb718420a9@mail.gmail.com>
	<4548472A.50608@in.ibm.com>
	<6599ad830610312307i549f5a51h3b7a1744a14919f5@mail.gmail.com>
	<45485046.6080508@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir wrote:
> Paul Menage wrote:
> > On 10/31/06, Balbir Singh <balbir@in.ibm.com> wrote:
> >> I thought this would be hard to do in general, but with a page -->
> >> container mapping that will come as a result of the memory controller,
> >> will it still be that hard?
> > 
> > I meant that it's pretty much impossible with the current APIs
> > provided by the kernel. That's why one of the most useful things that
> > a memory controller can provide is accounting and limiting of page
> > cache usage.
> > 
> > Paul
> 
> Thanks for clarifying that! I completely agree, page cache control is
> very important!

Doesn't "zone_reclaim" (added by Christoph Lameter over the last
several months) go a long way toward resolving this page cache control
problem?

Essentially, if my understanding is correct, zone reclaim has tasks
that are asking for memory first do some work towards keeping enough
memory free, such as doing some work reclaiming slab memory and pushing
swap and pushing dirty buffers to disk.

Tasks must help out as is needed to keep the per-node free memory above
watermarks.

This way, you don't actually have to account for who owns what, with
all the problems arbitrating between claims on shared resources.

Rather, you just charge the next customer who comes in the front
door (aka, mm/page_alloc.c:__alloc_pages()) a modest overhead if
they happen to show up when free memory supplies are running short.

On average, it has the same affect as a strict accounting system,
of charging the heavy users more (more CPU cycles in kernel vmscan
code and clock cycles waiting on disk heads).  But it does so without
any need of accurate per-user accounting.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
