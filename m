Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131246AbRDXBhy>; Mon, 23 Apr 2001 21:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132668AbRDXBho>; Mon, 23 Apr 2001 21:37:44 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:54172 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S131246AbRDXBh2>; Mon, 23 Apr 2001 21:37:28 -0400
Date: Mon, 23 Apr 2001 21:37:10 -0400
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Alexander Viro <viro@math.psu.edu>, Christoph Rohland <cr@sap.com>,
        "David L. Parsley" <parsley@linuxjedi.org>,
        linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
Message-ID: <20010423213709.A19705@cs.cmu.edu>
Mail-Followup-To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	Alexander Viro <viro@math.psu.edu>, Christoph Rohland <cr@sap.com>,
	"David L. Parsley" <parsley@linuxjedi.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010423172335.G719@nightmaster.csn.tu-chemnitz.de> <Pine.GSO.4.21.0104231133120.3617-100000@weyl.math.psu.edu> <20010423224505.H719@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010423224505.H719@nightmaster.csn.tu-chemnitz.de>; from ingo.oeser@informatik.tu-chemnitz.de on Mon, Apr 23, 2001 at 10:45:05PM +0200
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 10:45:05PM +0200, Ingo Oeser wrote:
> Last time we suggested this, people ended up with some OS trying
> it and getting worse performance. 
> 
> Why? You need to allocate the VFS-inode (vnode in other OSs) and
> the on-disk-inode anyway at the same time. You get better
> performance and less fragmentation, if you allocate them both
> together[1].
> 
> So that struct inode around is ok.
> 
> BTW: Is it still less than one page? Then it doesn't make me
>    nervous. Why? Guess what granularity we allocate at, if we
>    just store pointers instead of the inode.u. Or do you like
>    every FS creating his own slab cache?

I've actually got the coda_inode_info (inode->u.u_coda_fs_i) split out
of the union in my development kernel. It doesn't shrink the size of the
struct inode yet, Coda isn't the biggest user at the moment.

But, it forced me to do several cleanups in the code, and it even has
resulted in fixing a 'leak'. Not a real memory loss leak one, but we
left uninitialized inodes around in the icache for no good reason. Also
changing a but in a coda specific header file does trigger an almost
complete rebuild of the whole kernel (coda.h -> coda_fs_i.h -> fs.h ->
everything?)

The allocation overhead really isn't that bad. kmalloc/kfree are also
using the slabcache, and a trivial variant using a 'private' slabcache
gave me the counters to find the 'leak' I mentioned before.

I can't really evaluate performance impacts. The struct inode is still
the same size, so for now there even is a little bit of additional
memory pressure. Also, Coda wasn't really developed to achieve high
performance but more to explore novel features.

Jan

