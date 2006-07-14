Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422717AbWGNTKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422717AbWGNTKM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 15:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422718AbWGNTKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 15:10:12 -0400
Received: from cantor.suse.de ([195.135.220.2]:9345 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422717AbWGNTKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 15:10:11 -0400
From: Andi Kleen <ak@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
Date: Fri, 14 Jul 2006 21:09:34 +0200
User-Agent: KMail/1.9.3
Cc: Steve Munroe <sjmunroe@us.ibm.com>, Theodore Tso <tytso@mit.edu>,
       libc-alpha@sourceware.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Arjan van de Ven <arjan@infradead.org>,
       Ulrich Drepper <drepper@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>
References: <OF1343C031.500862D1-ON862571A9.00817A27-862571A9.00826BED@us.ibm.com> <1152902996.23037.90.camel@localhost.localdomain>
In-Reply-To: <1152902996.23037.90.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607142109.34170.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 July 2006 20:49, Benjamin Herrenschmidt wrote:
> > We will need an implementation that will fall back to sys_sysctl for older
> > kernels. This is already common practice in glibc. I don't really
> > understand the performance concern because it seems to me that
> > _is_smp_system() is only called once per process.
> > 
> > But isn't this the kind of thing that the Aux Vector is for? I like vDSO
> > too, but I think it is best deployed for information of a more dynamic
> > nature and performance sensitive.
> 
> For a simple "is_smp" kind of flag, I would tend to agree with the
> above... for more complex NUMA topology and/or cache characteristics,
> which is quite a bigger amount of information, I'm not sure it's worth
> copying all of that data on every process exec (and making the initial
> AT_ parsing slower). Especially since very few processes actually care
> about those.

I've actually spent some thought on that recently. The motivation
came from someone who wanted the number of CPUs in a fast way 
to tune AMD64 memcpy etc. better.

My proposal was to supply four new count:
number of cores, number of siblings, number of sockets, number of nodes

These all fit easily in 16bit so it would be 2 new entries in the
aux vector (128 bit total). Shouldn't be much overhead to write this.

If you need more exact topology you can probably eat the overhead
of parsing /proc/cpuinfo or read it from sysfs (or just use libnuma
which supplies most of this in an easy way) 

Doing it in a vDSO would be in theory ok for me too, except that x86-64
doesn't have one so far. Even in vDSO I wouldn't add much more than this
(like bitmaps and similar) because otherwise cpu/node hotplug could be racy.
Also I'm reluctant to redo /proc/cpuinfo and /sys for this.

-Andi
