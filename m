Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267588AbUIXANp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267588AbUIXANp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 20:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267598AbUIXAJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 20:09:12 -0400
Received: from adsl-209-204-138-32.sonic.net ([209.204.138.32]:44721 "EHLO
	server.home") by vger.kernel.org with ESMTP id S267588AbUIXAGO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 20:06:14 -0400
Date: Thu, 23 Sep 2004 17:06:03 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.home
To: Paul Jackson <pj@sgi.com>
cc: simon.derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [rfc][patch] 1/2 Additional cpuset features
In-Reply-To: <20040923164139.506d65d3.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0409231651550.17168@server.home>
References: <Pine.LNX.4.58.0409101036090.2891@daphne.frec.bull.fr>
 <20040911010808.2b283c9a.pj@sgi.com> <Pine.LNX.4.58.0409231238350.11694@server.home>
 <20040923164139.506d65d3.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -4.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2004, Paul Jackson wrote:

> > Simon's 2nd patch provides a translation that we need at SGI for perfmon
> > support within a cpuset. Without the virtualization some
> > means in user space needs to exist to translate a virtual CPU number
> > into a physical CPU number.
>
> In my opinion, user space is exactly the right place for this translation.

How do you do this translation? Search through /dev/cpusets?

> But the jist of the matter is simple.  Just as we (SGI) did with
> cpumemsets and perfmon on 2.4 kernels, so should we do with cpusets and
> perfmon on 2.6 kernels.  And that is to perform this translation in
> perfmon code.  Is it only SGI's dplace that requires the cpuset-relative
> numbering?

pfmon, sched_setaffinity, dplace. And this is only what I saw today.
Might develop into a longer list. The 2.4 solutions were rather
complicated.

> The kernel-user boundary should stick to a single, system-wide, numbering
> of CPUs.

That leads to lots of complicated scripts doing logical -> physical
translation with the danger of access or attempting accesses to not
allowed CPUs. It may be easier to contain tasks into a range of cpus if
the CPUs in use are easily enumerable.

The view from inside a cpuset could simply be of a system with N cpus
(0..N-1) with N memory areas (0..N-1). No access to outside cpus or memory
us allowed. Kernel checks for valid cpu and memory area by simply checking
against an upper boundary on both and then maps these numbers dynamically
according to the CPU set.

Thats what Simon's patch allows.

The patch would allow the use of the existing tools as if the machine
only had N cpus (as you said a soft partitioning of the machine). If
scripts are to be used with the current approach then they need to know
about all the CPUs in the system and perform the mapping. Its going to be
a nightmare to develop scripts that partition off a 512 cpu cluster
appropriately and that track the physical cpu numbers instead of the cpu
number within the cpuset.


