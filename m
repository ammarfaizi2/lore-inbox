Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286931AbSABK6b>; Wed, 2 Jan 2002 05:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286936AbSABK6P>; Wed, 2 Jan 2002 05:58:15 -0500
Received: from dsl-213-023-043-195.arcor-ip.net ([213.23.43.195]:9743 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286931AbSABK5x>;
	Wed, 2 Jan 2002 05:57:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: David Chow <davidchow@rcn.com.hk>
Subject: Re: [RFC] [WIP] Unbork fs.h, 3 of 3
Date: Wed, 2 Jan 2002 12:01:27 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@math.psu.edu>,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112311004580.1404-100000@penguin.transmeta.com> <E16L8JK-0000ao-00@starship.berlin> <3C313324.3010504@rcn.com.hk>
In-Reply-To: <3C313324.3010504@rcn.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Lj9E-00010N-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 1, 2002 04:55 am, David Chow wrote:
> Just some comments and questions about the new fs.h .. its great to hear 
> improvements in the new year!
> 
> Are you people going to put this on the 2.5?

It's entirely up to Linus.  There's no chance it will go in before it a) 
works (which it doesn't at the moment) b) has been tested (a lot) c) meets 
with general approval and d) survives the viro test.

> It seems you are keeping 
> the generic_ip pointer for compatibility. And I guess this is what other 
> file systems (those not included in the standardkernel sources) are 
> using, at least I am the one.

Yes, IMHO, once people are able to use the fs-specific inode mechanism they 
will prefer it over the generic_ip method.  However, the generic_ip will be 
the last item of the union to go, and even then, it will just be moved into 
private area of whatever filesystem uses it, with something like:

    struct myfs_inode { struct inode; struct myfs_inode_info *private; }

    static inline struct myfs_inode_info *myfs_i(struct inode *inode)
    {
            return ((struct myfs_inode *) inode)->private;
    }

> I am using the generic_ip to hold my fs inode data pointer. During the 
> implementation, I tested both approaches... but it seems not sigficant 
> in detection of inode cache allocation overheads in read_inode(). Its 
> worth to talk about memory consumptions because it is silly to allocate 
> the largest possible inode cache sizes. I strongly agree with the new fs 
> declaration interface becuase of higher efficiency and less overhead, 
> but it seems more and more fs are supported in Linux, the effort to 
> patch all fs'es is a lot of work.

That's why it's good to do it sooner rather than later, the number of 
filesystems will only increase.  Changing a filesystem to use the 
xxx_i(inode)->field idea is an easy edit.

> I am working on a compression file systmes, many thing varies such that 
> I have to use dynamically link allocated structures in the inode cache.

Yes, so saving one dereference would make very little difference to you, and 
the same with saving one slab alloc.

> For the remount issue, I don't think its just affect the root 
> filesystem, for me I also reload other settings during a remount. For 
> feature oriented filesystems, remount may be use more frequent then 
> umount and mount. Other admins may also remount their /usr fs and other 
> protected fs to read-only for safe after altering their fs. Why not 
> changing the remount behaviour in VFS not to call module_exit()? I also 
> can't see why VFS has to call module_exit() in remount if we have 
> remount() in super_operations ... I think remount operations are fs 
> specific and shuold pass this job to super_operations->remount . I think 
> it is a better way to solve the root fs problem. But it would require 
> even more work to get all fs to obey the new standard. If you want nice 
> and clean efficient solutions, work is must anyway... good luck.

I think you're on to something with the ->remount idea, however it's outside 
the scope of this work.  For now, the goal is just get the fs.h includes 
straightened out.

--
Daniel
