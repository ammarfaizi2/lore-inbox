Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286238AbSAGB2p>; Sun, 6 Jan 2002 20:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286261AbSAGB20>; Sun, 6 Jan 2002 20:28:26 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:29958 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S286238AbSAGB2P>;
	Sun, 6 Jan 2002 20:28:15 -0500
Date: Sun, 6 Jan 2002 23:27:39 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Legacy Fishtank <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net, Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] [PATCH] Clean up fs.h union for ext2
Message-ID: <20020107012739.GB1920@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Legacy Fishtank <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net, Alexander Viro <viro@math.psu.edu>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <5.1.0.14.2.20020106035716.02c49b80@pop.cus.cam.ac.uk> <5.1.0.14.2.20020105145226.03163170@pop.cus.cam.ac.uk> <5.1.0.14.2.20020106035716.02c49b80@pop.cus.cam.ac.uk> <5.1.0.14.2.20020107000736.04eb1c90@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020107000736.04eb1c90@pop.cus.cam.ac.uk>
User-Agent: Mutt/1.3.25i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 07, 2002 at 12:30:58AM +0000, Anton Altaparmakov escreveu:
> At 22:42 06/01/02, Daniel Phillips wrote:
> >I wrote:
> >> To be honest I fail to see how one additional slab allocation will make
> >> any difference.                                                      /
> >                                                                      /
> >You could say the same about any aspect of Linux: and, relaxing your /
> >standards in such a way, you would inevitably end up with a dog.  A /
> >good fast system emerges from its many small perfections.  Half of /
> >the number of cache entries for inodes qualifies as one of those. /
> 
> Due to the nature of the content in the vfs vs. fs inode I would expect 
> that one is used independent of the other in many, if not in the majority 
> of cases. If this is correct, then it might well be an actual benefit to 
> have the two separate and to benefit from the hwcache line alignment in the 
> fs specific part. Also considering that allocation happens once in 
> read_inode but the structure is then accessed many times.
> 
> Please note, I am not saying you are wrong, most likely you are quite right 
> in fact, I am just raising a caution flag that perhaps benchmarks of both 
> implementations for the same fs might be a Good Idea(TM)...

Yes, having benchmarks done is a good idea and can clear any doubts about
the validity of such approach on a performace point of view.

When I did similar work for the network protocols, cleaning up
include/net/fs.h DaveM asked for benchmarks to see if the new approach,
i.e., using per network family slabcaches would lead to a performance drop,
I did it and we realized that it lead to performance _gains_, that in turn
made DaveM ask for a per network protocol slabcache, which made furter
memory savings and lead to further performance gains.

Yes, the usage pattern for sockets and inodes is different, thats why having
Daniel patches benchmarked against the current scheme can clear up the
matter about the validity of having the slabcaches.

Please note that we can have both approaches by leaving the
generic_ip/generic_sbp. In the struct sock case I left protinfo as a void
pointer, like generic_ip and some protocols use the slabcache approach
while others use the private area allocated separately and its pointer
stored in struct sock->protinfo.

- Arnaldo
