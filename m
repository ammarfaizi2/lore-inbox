Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266608AbRGGWQE>; Sat, 7 Jul 2001 18:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266606AbRGGWPz>; Sat, 7 Jul 2001 18:15:55 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:53895 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S266598AbRGGWPg>; Sat, 7 Jul 2001 18:15:36 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: ext3-users@redhat.com
Date: Sun, 8 Jul 2001 08:15:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15175.35317.985921.670835@notabene.cse.unsw.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>, "Stephen C. Tweedie" <sct@redhat.com>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Peter J. Braam" <braam@clusterfilesystem.com>
Subject: Re: ext3-2.4-0.9.0
In-Reply-To: message from Andrew Morton on Saturday July 7
In-Reply-To: <3B45D6DB.70B9D754@uow.edu.au>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday July 7, andrewm@uow.edu.au wrote:
> An update of the ext3 journalling filesystem for 2.4 kernels
> is available at
> 
> 	http://www.uow.edu.au/~andrewm/linux/ext3/
> 
> Patches are against 2.4.6-ac1 and 2.4.6.

I thought it was time to try out ext3 between nfsd and raid5, so I
built 2.4.6  plus this patch, and an ext3 filesystem on a largish
raid5 volume, exported it (with the "sync" flag), mounted it from
another machines with NFSv2, and ran "dbench 4".

This produces a live-lock (I think that it the right term).
Throughput would drop to zero (determined by watching the counts in 
/proc/nfs/rpc/nfsd), but could be coaxed along by generating other
filesystem activity.

I tried nfs over ext3 on a plain ide disc and it worked fine.
I tried dbench directly on ext3/raid5 and it worked fine.
I tried dbench/nfs/ext2/raid5 and it worked fine.

So I think it is some interaction between ext3fs and raid5 triggered
by the high rate of "fsync" calls made by nfsd.  Naturally I blame
ext3 because I know more about raid5 and nfsd :-)

One particular aspect of raid5 that *could* be related is that it is
very reticent to schedule write requests. It tries to hang on the them
as long as possible in the hope of getting more write requests in the
same stripe.  My guess as to what is happening is that as write
request is submitted and then waited-for without an intervening 
		run_task_queue(&tq_disk);

When the system is livelocked, all I can tell at the moment (I am at
home and the console is at work so I cannot use alt-sysrq) is that 
kjournal is waiting in wait_on_buffer and an nfsd thread is waiting on
the journal.

I will try to explore it more deeply next time I am at work, but if
there are any suggestions as to what it might be, or how I might more
easily find out what is going on, I am all ears.

NeilBrown
