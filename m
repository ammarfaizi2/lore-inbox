Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUB1HBA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 02:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbUB1HBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 02:01:00 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:17883 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261830AbUB1HA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 02:00:58 -0500
Date: Fri, 27 Feb 2004 23:00:44 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <474350000.1077951643@[10.10.2.4]>
In-Reply-To: <20040228064352.GP8834@dualathlon.random>
References: <20040227173250.GC8834@dualathlon.random> <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com> <20040227122936.4c1be1fd.akpm@osdl.org> <20040227211548.GI8834@dualathlon.random> <162060000.1077919387@flay> <20040228023236.GL8834@dualathlon.random> <469160000.1077948622@[10.10.2.4]> <20040228064352.GP8834@dualathlon.random>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The last issue that we may run into are apps assuming the stack is at 3G
> fixed, some jvm assumed that, but they should be fixed by now (at the
> very least it's not hard at all to fix those).

All the potential solutions we're discussing hit that problem so I don't
see it matters much which one we choose ;-)
 
> It also depends on the performance difference if this is worthwhile, if
> the difference isn't very significant 4:4 will be certainly prefereable
> so you can also allocate 4G in the same task for apps not using syscalls
> or page faults or flood of network irqs.

There are some things that may well help here: one is vsyscall gettimeofday,
which will fix up the worst of the issues (the 30% figure you mentioned
to me in Ottowa), the other is NAPI, which would help with the network
stuff.

Bill had a patch to allocate mmaps, etc down from the top of memory and
thus elimininate TASK_UNMAPPED_BASE, and shift the stack back into the
empty hole from 0-128MB of memory where it belongs (according to the spec).
Getting rid of those two problems gives us back a little more userspace 
as well. 

Unfortunately it does seem to break some userspace apps making stupid 
assumptions, but if we have a neat way to mark the binaries (Andi was
talking about personalities or something), we could at least get the
big mem hogs to do that (databases, java, etc).

I have a copy of Bill's patch in my tree if you want to take a look:

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/patches/2.6.3/2.6.3-mjb1/410-topdown

That might make your 2.5/1.5 proposal more feasible with less loss of
userspace.

M
