Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267660AbUIXBRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267660AbUIXBRK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 21:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267679AbUIXBRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 21:17:08 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:15814 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267660AbUIXBOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 21:14:46 -0400
Date: Thu, 23 Sep 2004 18:13:08 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <christoph@lameter.com>
Cc: simon.derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [rfc][patch] 1/2 Additional cpuset features
Message-Id: <20040923181308.1e96ddff.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0409231651550.17168@server.home>
References: <Pine.LNX.4.58.0409101036090.2891@daphne.frec.bull.fr>
	<20040911010808.2b283c9a.pj@sgi.com>
	<Pine.LNX.4.58.0409231238350.11694@server.home>
	<20040923164139.506d65d3.pj@sgi.com>
	<Pine.LNX.4.58.0409231651550.17168@server.home>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> How do you do this translation? Search through /dev/cpusets?

Map from pid to cpuset to cpus.  No searching.

The file /proc/<pid>/cpuset names the cpuset to which that pid is
attached.  Presuming the cpuset file system is mounted at /dev/cpuset,
then the file /dev/cpuset/xxx/cpus lists the cpus in the cpuset named
'xxx'.

> pfmon, sched_setaffinity, dplace. 

To the best of my current understanding, the only reason perfmon
wants relative numbering is because that's what dplace wants.

Sched_setaffinity uses system-wide numbering, no?

> That leads to lots of complicated scripts doing logical -> physical
> translation with the danger of access or attempting accesses to not
> allowed CPUs.

No -- it leads to more user level libraries and tools, encapsulating
the complexity, layering the abstractions.

And "danger" ... what's dangerous?  An application in a cpuset won't
be able to use (if that's what you meant by 'access') CPUs outside
its cpuset.  Nothing dangerous there that I see.

> The view from inside a cpuset could simply be of a system with N cpus
> (0..N-1) with N memory areas (0..N-1). No access to outside cpus or memory
> us allowed. Kernel checks for valid cpu and memory area by simply checking
> against an upper boundary on both and then maps these numbers dynamically
> according to the CPU set.
> 
> Thats what Simon's patch allows.

Regardless, that's the eventual view seen by some apps from inside the
cpuset.  We're just discussing where the translation code goes.  I see
nothing that requires kernel priviledge or synchronization here.

> Its going to be a nightmare to develop scripts that partition off a 512
> cpu cluster appropriately and that track the physical cpu numbers
> instead of the cpu number within the cpuset.

No need for any nightmares.

Just because the meaning of CPU numbers at the kernel-user boundary is
system-wide doesn't mean that this view has to be imposed on all above.
We should write the higher level stuff as if the kernel could do what
you want with relative numbering, then arrange the tools and libraries
to convert.

Just because something is essential doesn't mean the kernel needs to do
it.  And just because I oppose putting something in the kernel doesn't
mean I oppose doing it.  Indeed, I'm doing quite a bit of work in this
very direction ... outside the kernel.

We have more reasons than just this issue of numbering to require a
robust set of user level libraries and tools.  Pretty much everyone
working in this area seems to agree that a decent library layer is
needed on top of the raw kernel API's, which are difficult to code to
directly, and vary in "interesting" ways between the affinity, the numa
and the cpuset interfaces (e.g. three different forms for passing
bitmaps).

This is perhaps the biggest difference between what SGI does on Irix,
and what is happening in Linux 2.6.  Quite a bit is moved outside the
kernel.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
