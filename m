Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269361AbUI3Qx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269361AbUI3Qx7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 12:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269357AbUI3Qx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 12:53:59 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:63699 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S269356AbUI3QxQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 12:53:16 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: Ray Lee <ray-lk@madrabbit.org>
To: Paul Jackson <pj@sgi.com>
Cc: rml@novell.com, akpm@osdl.org, ttb@tentacle.dhs.org,
       cfriesen@nortelnetworks.com,
       Linux Kernel <linux-kernel@vger.kernel.org>, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
In-Reply-To: <20040930092744.5eb5ea10.pj@sgi.com>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
	 <1096350328.26742.52.camel@orca.madrabbit.org>
	 <20040928120830.7c5c10be.akpm@osdl.org>
	 <41599456.6040102@nortelnetworks.com>
	 <1096390398.4911.30.camel@betsy.boston.ximian.com>
	 <1096392771.26742.96.camel@orca.madrabbit.org>
	 <1096403685.30123.14.camel@vertex> <20040929211533.5e62988a.akpm@osdl.org>
	 <1096508073.16832.17.camel@localhost> <20040929200525.4e7bb489.pj@sgi.com>
	 <1096558180.26742.133.camel@orca.madrabbit.org>
	 <20040930092744.5eb5ea10.pj@sgi.com>
Content-Type: text/plain
Organization: http://madrabbit.org/
Date: Thu, 30 Sep 2004 09:53:13 -0700
Message-Id: <1096563193.26742.152.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 09:27 -0700, Paul Jackson wrote:
> > This changes an O(1) process to O(N),
> 
> At the microlevel, yes.  But:

Apologies, I wasn't trying to shut down the conversation with a magic
O(N) wand.

>  1) If one takes as the "unit of measurement" the number of
>     system calls made, it's more like O(N/128), given that
>     one might average 128 directory entries per getdents()
>     call.

O(N/128) = O(N), but you knew that already. My fully arbitrary units,
however, were in terms of what needs to be done from userspace to
recreate the information that the kernel already had, and that means
basically scanning a directory of N items. Sure, it's less than N
syscalls, but userspace is still going to ask the CPU to do N
comparisons across N items, with all the implications that comes along
with that. (To be explicit: Syscalls, memory usage for caching, blowing
the processor cache by visiting lots of useless items, and speed of just
CPU time for the comparisons.)

>  2) This can be cached, with user code mapping inode->d_ino
>     to d_name, and then the cached name checked with a single
>     stat(2) call to ensure it wasn't stale.

Yeah, well, dnotify asks userspace to do much the same thing. This is
marginally better, in that we'd know what we're looking for once we see
it. However, dnotify has shown that forcing userspace to cache the
entire contents of all the directories it wishes to watch doesn't scale
well. That's one of the core problems they're trying to address, and
passing an inode number back would reintroduce it.

> Be leary of micro optimizations imposing a poorer design, especially
> across major API boundaries. 

Yes.

> Simply waving "O(N)" in our face may not be adequately persuasive.

It shouldn't be persuasive on its own. It should be coupled with the
fact that dnotify already forces an O(N) workload per directory onto
userspace, and that has shown itself to not work well.

> And there is a long history of pain in Unix dealing with variable length
> return values.

Y'know, I keep hearing this, but I'm afraid I'm just too dense to get
it. How about we get it right once, in the kernel and userspace, and we
make a library out of it so that luser space authors like myself don't
have to reinvent the wheel? (getdents(2) seems to work somehow.) I'll
even offer to write the code once I can sit down and spend time with the
kernel again, if no one else is willing to touch this.

> Much better to deal with that entirely in user space
> code under your control, than to have to align kernel and glibc code in
> addition to your code, to get something fixed.  More often than not,
> you will end up with faster code when you control the details, than if
> you have to align heaven and earth to make changes.

Sure, there are designs that have a natural fit with the system, and
others that don't. Much like trying to express a trig function in terms
of polynomials. Not a good fit, and you get a massive series to try to
approximate it, if you'll forgive a calculus analogy. Anyway, the kernel
*has* that information already, so we're not shoving the work somewhere
else just to make userspace simpler somehow (which is always a specious
argument).

I think I understand your point. What I'd suggest is reading Robert's
"Why inotify?" that's posted along with the inotify patches (see
http://lkml.org/lkml/2004/9/28/201 for example) to get a small feel for
what issues are trying to be addressed.

Off to do honest work,

Ray

