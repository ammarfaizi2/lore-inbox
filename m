Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263862AbUFEH7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263862AbUFEH7b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 03:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbUFEH7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 03:59:30 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:24336 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263862AbUFEH7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 03:59:00 -0400
Date: Sat, 5 Jun 2004 01:04:44 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: mikpe@csd.uu.se, nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040605010444.6a384e6c.pj@sgi.com>
In-Reply-To: <20040605013139.GM21007@holomorphy.com>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<1086313667.29381.897.camel@bach>
	<40BFD839.7060101@yahoo.com.au>
	<20040603221854.25d80f5a.pj@sgi.com>
	<16576.16748.771295.988065@alkaid.it.uu.se>
	<20040604090314.56d64f4d.pj@sgi.com>
	<20040604165601.GC21007@holomorphy.com>
	<20040604170542.576b4243.pj@sgi.com>
	<20040605013139.GM21007@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William wrote:
> Ridiculous == ...

oh - ok - we agree

> Sounds like a glibc bug.

We agree.  Someone in glibc land doesn't.

> it's 1024 bits ... SGI may need to get that bumped up,
> but I doubt many others do.

SGI fits, for now.

Someday, someone, won't.

It's baked in to glibc, so someday, someone will have a bit of pain.  
Oh well ...  Good chance that someone will include me.  Not much I
can do about it now.

> +asmlinkage long compat_sched_getaffinity(compat_pid_t pid, ...

That looks more readable.  Thanks.

Do you see a sensible way to pass back an odd number of u32's?  If
NR_CPUS is say 8, then the 32 bit user code might expect to only need
one compat_ulong_t, not two.  If NR_CPUS is 48, then it should only need
3, not 4.   And so forth.

As I noted in another reply, perhaps your bitmap_to_u32_array() code
could be modified to handle this.

And I agree with Andrew's suggestion, that cpumask provide the
conversion, to and from kernel memory, separately from copying the
result to user space.

> This is trivial. Just like we needed ASCII marshalling ...

The implementation is trivial.

The API design choice was the point of my analysis.  Not how to do it,
but what to do.

Should the kernel support two flavors of bitmap marshalling, where it is
headed now, with the sched_setaffinity() format differing from the
perfctr format?  Or should we pick one, and demand that the other
change?

Since I like the perfctr format better, and since I suspect it is to
late to change the sched_setaffinity format, I am resigned to supporting
two binary bitmap formats, across the kernel/user API boundary, forever.

Actually, the two forms are close.  They differ just in the big endian
64 bit case.  And if you were able to handle an odd number of u32 dest
words in your bitmap_to_u32_array() code, then perhaps that single bit
of code could serve as the marshalling for both.  So we end up with two
variants of one flavor, differing only in whether you want 32 or 64 bit
chunks when running on a 64 bit arch, the 64 bit chunks being the native
kernel bitmap representation, for now at least.

That's probably about as good as we are going to do with this.

> The only case where this is distinguished at all from copy_to_user() is
> 64-bit bigendian with 32-bit userspace.

Yes - exactly.  Well, almost.  Either 32-bit userspace compatibility,
or 32 bit chunks for improved portability, such as perfctr has chosen,
if I understand them correctly.

> Index: irqaction-2.6.7-rc2/include/asm-generic/cpumask_array.h

Hmmm ... do you use Quilt too?  That's the only place I recall seeing
this "Index" line.  Cool.

If Andrew accepts my cpumask patches, then you will presumably have
to do your addition of cpus_to_u32_array().  Trivial, of course.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
