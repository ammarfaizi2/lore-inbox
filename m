Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289076AbSAGCJb>; Sun, 6 Jan 2002 21:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289077AbSAGCJV>; Sun, 6 Jan 2002 21:09:21 -0500
Received: from dsl-213-023-043-019.arcor-ip.net ([213.23.43.19]:13836 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289076AbSAGCJJ>;
	Sun, 6 Jan 2002 21:09:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [RFC] [PATCH] Clean up fs.h union for ext2
Date: Mon, 7 Jan 2002 03:12:06 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Legacy Fishtank <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net, Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <5.1.0.14.2.20020106035716.02c49b80@pop.cus.cam.ac.uk> <5.1.0.14.2.20020107000736.04eb1c90@pop.cus.cam.ac.uk> <20020107012739.GB1920@conectiva.com.br>
In-Reply-To: <20020107012739.GB1920@conectiva.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16NPGi-0001N0-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 7, 2002 02:27 am, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jan 07, 2002 at 12:30:58AM +0000, Anton Altaparmakov escreveu:
> > At 22:42 06/01/02, Daniel Phillips wrote:
> > >I wrote:
> > >> To be honest I fail to see how one additional slab allocation will make
> > >> any difference.                                                      /
> > >                                                                      /
> > >You could say the same about any aspect of Linux: and, relaxing your /
> > >standards in such a way, you would inevitably end up with a dog.  A /
> > >good fast system emerges from its many small perfections.  Half of /
> > >the number of cache entries for inodes qualifies as one of those. /
> > 
> > Due to the nature of the content in the vfs vs. fs inode I would expect 
> > that one is used independent of the other in many, if not in the majority 
> > of cases. If this is correct, then it might well be an actual benefit to 
> > have the two separate and to benefit from the hwcache line alignment in
> > the fs specific part. Also considering that allocation happens once in 
> > read_inode but the structure is then accessed many times.
> > 
> > Please note, I am not saying you are wrong, most likely you are quite 
> > right in fact, I am just raising a caution flag that perhaps benchmarks 
> > of both implementations for the same fs might be a Good Idea(TM)...
> 
> Yes, having benchmarks done is a good idea and can clear any doubts about
> the validity of such approach on a performace point of view.
> 
> When I did similar work for the network protocols, cleaning up
> include/net/fs.h DaveM asked for benchmarks to see if the new approach,
> i.e., using per network family slabcaches would lead to a performance drop,
> I did it and we realized that it lead to performance _gains_, that in turn
> made DaveM ask for a per network protocol slabcache, which made furter
> memory savings and lead to further performance gains.

Oh, so that's why you were too busy to do the fs.h patch ;-)

> Yes, the usage pattern for sockets and inodes is different, thats why having
> Daniel patches benchmarked against the current scheme can clear up the
> matter about the validity of having the slabcaches.

Yes, I can test against the good old version.  Actually, my htree benchmarks 
will do nicely here.  They process a lot of inodes quickly and they put a lot 
of pressure on the icache, which needs to be tested.

> Please note that we can have both approaches by leaving the
> generic_ip/generic_sbp. In the struct sock case I left protinfo as a void
> pointer, like generic_ip and some protocols use the slabcache approach
> while others use the private area allocated separately and its pointer
> stored in struct sock->protinfo.

Even if we leave the generic_ip in the common inode, we will for sure remove 
the union at some point, meaning that even filesystems that use the 
generic_ip now will have to do a big edit to clean up the fallout.  Which 
isn't such a bad thing I suppose.

If we wanted to be lazy, we could just leave the union there, with one 
element, the generic_ip.  How ugly would that be?

--
Daniel
