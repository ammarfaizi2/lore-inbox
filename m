Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131587AbRDJMVJ>; Tue, 10 Apr 2001 08:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131630AbRDJMU7>; Tue, 10 Apr 2001 08:20:59 -0400
Received: from ns.suse.de ([213.95.15.193]:5640 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131587AbRDJMUo>;
	Tue, 10 Apr 2001 08:20:44 -0400
Date: Tue, 10 Apr 2001 14:20:42 +0200
From: Andi Kleen <ak@suse.de>
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] amusing copy_from_user bug
Message-ID: <20010410142042.A15540@gruyere.muc.suse.de>
In-Reply-To: <200104101011.DAA29579@csl.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104101011.DAA29579@csl.Stanford.EDU>; from engler@csl.Stanford.EDU on Tue, Apr 10, 2001 at 03:11:05AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 03:11:05AM -0700, Dawson Engler wrote:
>                 segment = kmalloc((sizeof(agp_segment) * reserve.seg_count),
>                                   GFP_KERNEL);
> 
>                 if (segment == NULL) {
>                         return -ENOMEM;
>                 }
>                 if (copy_from_user(segment, (void *) reserve.seg_list,
>                                    GFP_KERNEL)) {
>                         kfree(segment);
>                         return -EFAULT;
>                 }
> 
> As a side question: is it still true that verify_area's must be done before
> any use of __put_user/__get_user/__copy_from_user/etc?

I must be done in front of __*_user, but in front of [^_][^_]*_user it's not needed
anymore because they include an access_ok() hit.
If you would check this there would be false hits, because a lot of code
does tricks like sharing it between a __copy_from_user and a __copy_to_user
(legal but slightly hackish). access_ok() instead of verify_area is also ok.
__*_user without verify_area/access_ok is usually a bug and a security hole.
There is also some code that does the verify_area/access_ok only for the beginning
of a structure, and then hopes that the structure is known-length bound and
that non verify_area checked accesses behind the first element get catched by
an architecture specific memory hole after PAGE_OFFSET (nasty trick, should
only occur in arch/*/*, e.g. on i386 it's incorrect).

BTW another common mistake is to directly return the value of copy_{from,to}_user
directly as an error. Unlike {get,put}_user they  do not return an error code, but
the number of uncopied bytes. There is unfortunately some code that uses this
internally as return, but e.g. if you could check in CHECKER if a function that
ever returns -E<something> returns the value of copy_{from,to}_user directly it would
probably catch quite a few bugs (at least I found quite a bit of them in the past).


-Andi

