Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269730AbSISB4l>; Wed, 18 Sep 2002 21:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269742AbSISB4l>; Wed, 18 Sep 2002 21:56:41 -0400
Received: from mx01-a.netapp.com ([198.95.226.53]:40586 "EHLO
	mx01-a.netapp.com") by vger.kernel.org with ESMTP
	id <S269730AbSISB4k>; Wed, 18 Sep 2002 21:56:40 -0400
Message-ID: <6440EA1A6AA1D5118C6900902745938E07D54E7F@black.eng.netapp.com>
From: "Lever, Charles" <Charles.Lever@netapp.com>
To: "'Andrew Morton'" <akpm@digeo.com>
Cc: "David S. Miller" <davem@redhat.com>, taka@valinux.co.jp,
       neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: RE: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
Date: Wed, 18 Sep 2002 19:00:32 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dude, that's pretty cool.

if you were re-implementing XDR, you think a series of movl
instructions would be best?  i'm not sure how practical that
is for an architecture-independent implementation.

> > > It was discussed long ago that csum_and_copy_from_user() performs 
> > > better than plain copy_from_user() on x86.  I do not remember all
> > 
> > The better was a freak of PPro/PII scheduling I think
> > 
> > > details, but I do know that using copy_from_user() is not a real 
> > > improvement at least on x86 architecture.
> > 
> > The same as bit is easy to explain. Its totally memory bandwidth 
> > limited on current x86-32 processors. (Although I'd welcome 
> > demonstrations to the contrary on newer toys)
> 
> Nope.  There are distinct alignment problems with movsl-based 
> memcpy on PII and (at least) "Pentium III (Coppermine)", 
> which is tested here:
> 
> copy_32 uses movsl.  copy_duff just uses a stream of "movl"s
> 
> Time uncached-to-uncached memcpy, source and dest are 8-byte-aligned:
> 
> akpm:/usr/src/cptimer> ./cptimer -d -s     
> nbytes=10240  from_align=0, to_align=0
>     copy_32: copied 19.1 Mbytes in 0.078 seconds at 243.9 Mbytes/sec
> __copy_duff: copied 19.1 Mbytes in 0.090 seconds at 211.1 Mbytes/sec
> 
> OK, movsl wins.   But now give the source address 8+1 alignment:
> 
> akpm:/usr/src/cptimer> ./cptimer -d -s -f 1
> nbytes=10240  from_align=1, to_align=0
>     copy_32: copied 19.1 Mbytes in 0.158 seconds at 120.8 Mbytes/sec
> __copy_duff: copied 19.1 Mbytes in 0.091 seconds at 210.3 Mbytes/sec
> 
> The "movl"-based copy wins.  By miles.
> 
> Make the source 8+4 aligned:
> 
> akpm:/usr/src/cptimer> ./cptimer -d -s -f 4
> nbytes=10240  from_align=4, to_align=0
>     copy_32: copied 19.1 Mbytes in 0.134 seconds at 142.1 Mbytes/sec
> __copy_duff: copied 19.1 Mbytes in 0.089 seconds at 214.0 Mbytes/sec
> 
> So movl still beats movsl, by lots.
> 
> I have various scriptlets which generate the entire matrix.
> 
> I think I ended up deciding that we should use movsl _only_ 
> when both src and dsc are 8-byte-aligned.  And that when you 
> multiply the gain from that by the frequency*size with which 
> funny alignments are used by TCP the net gain was 2% or something.
> 
> It needs redoing.  These differences are really big, and this 
> is the kernel's most expensive function.
> 
> A little project for someone.
> 
> The tools are at http://www.zip.com.au/~akpm/linux/cptimer.tar.gz
