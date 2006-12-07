Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937969AbWLGTWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937969AbWLGTWW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 14:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937999AbWLGTWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 14:22:22 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:48906 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937969AbWLGTWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 14:22:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SPB701yPPHzLvOidJKloAk6bH89OiU1zb5vyjOlFPuFN/6AZ8OG6Mrb2nOrUj97s6TfEq+41oimvQfZXIEQgyl1C+y/OOpwatO5OXNwftjMHOutyK0zMxYVoPcBGchRE/3n8B36t1wobYqWoT0wCMyEWDAddIfgS0XLltTc3geA=
Message-ID: <5c49b0ed0612071122v4378f853lc6684ed8a7bbbf7f@mail.gmail.com>
Date: Thu, 7 Dec 2006 11:22:18 -0800
From: "Nate Diller" <nate.diller@gmail.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [patch] speed up single bio_vec allocation
Cc: "Jens Axboe" <jens.axboe@oracle.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <000001c71963$17d88130$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061206100847.GP4392@kernel.dk>
	 <000001c71963$17d88130$ff0da8c0@amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/06, Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:
> Jens Axboe wrote on Wednesday, December 06, 2006 2:09 AM
> > > > I will try that too.  I'm a bit touchy about sharing a cache line for
> > > > different bio.  But given that there are 200,000 I/O per second we are
> > > > currently pushing the kernel, the chances of two cpu working on two
> > > > bio that sits in the same cache line are pretty small.
> > >
> > > Yep I really think so. Besides, it's not like we are repeatedly writing
> > > to these objects in the first place.
> >
> > This is what I had in mind, in case it wasn't completely clear. Not
> > tested, other than it compiles. Basically it eliminates the small
> > bio_vec pool, and grows the bio by 16-bytes on 64-bit archs, or by
> > 12-bytes on 32-bit archs instead and uses the room at the end for the
> > bio_vec structure.
>
> Yeah, I had a very similar patch queued internally for the large benchmark
> measurement.  I will post the result as soon as I get it.
>
>
> > I still can't help but think we can do better than this, and that this
> > is nothing more than optimizing for a benchmark. For high performance
> > I/O, you will be doing > 1 page bio's anyway and this patch wont help
> > you at all. Perhaps we can just kill bio_vec slabs completely, and
> > create bio slabs instead with differing sizes. So instead of having 1
> > bio slab and 5 bio_vec slabs, change that to 5 bio slabs that leave room
> > for the bio_vec list at the end. That would always eliminate the extra
> > allocation, at the cost of blowing the 256-page case into a order 1 page
> > allocation (256*16 + sizeof(*bio) > PAGE_SIZE) for the 4kb 64-bit archs,
> > which is something I've always tried to avoid.
>
> I took a quick query of biovec-* slab stats on various production machines,
> majority of the allocation is on 1 and 4 segments, usages falls off quickly
> on 16 or more.  256 segment biovec allocation is really rare.  I think it
> makes sense to heavily bias towards smaller biovec allocation and have
> separate biovec allocation for really large ones.

what file system?  have you tested with more than one?  have you
tested with file systems that build their own bio's instead of using
get_block() calls?  have you tested with large files or streaming
workloads?  how about direct I/O?

i think that a "heavy bias" toward small biovecs is FS and workload
dependent, and that it's irresponsible to make such unjustified
changes just to show improvement on your particular benchmark.

i do however agree with killing SLAB_HWCACHE_ALIGN for biovecs,
pending reasonable regression benchmarks.

NATE
