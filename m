Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131230AbRACQnf>; Wed, 3 Jan 2001 11:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132294AbRACQn0>; Wed, 3 Jan 2001 11:43:26 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:3970 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131230AbRACQnT>;
	Wed, 3 Jan 2001 11:43:19 -0500
Date: Wed, 3 Jan 2001 11:12:48 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Andreas Dilger <adilger@enel.ucalgary.ca>,
        Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] Re: [RFC] ext2_new_block() behaviour
In-Reply-To: <20010103121609.C1290@redhat.com>
Message-ID: <Pine.GSO.4.21.0101031051080.15658-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Jan 2001, Stephen C. Tweedie wrote:

> Having preallocated blocks allocated immediately is deliberate:
> directories grow slowly and remain closed most of the time, so the
> normal preallocation regime of only preallocating open files and
> discarding preallocation on close just doesn't work.

Erm. For directories we would not have the call of discard_prealloc()
on close(2) - they have NULL ->release() anyway and for them it would
happen only on ext2_put_inode(), i.e. upon the final dput(). Which would
not happen while some descendent would stay in dcache.

IOW, if directory is really going to grow (which normally mean that we
are busily writing into files in it or its subdirectories) we will not
get discard_prealloc() until it's all over. open()/close() has nothing
to it - even if we used the same ->release() as for files, it would be
a no-op since all opens are read-only. Even for normal files close() after
read-only open() doesn't do anything to preallocation.

Comments? I'm not saying that it's necessary a good idea, but the argument
about file-like preallocation regime really doesn't apply - regime will
be different anyway...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
