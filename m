Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132939AbRDXWc2>; Tue, 24 Apr 2001 18:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133009AbRDXWcT>; Tue, 24 Apr 2001 18:32:19 -0400
Received: from pat.uio.no ([129.240.130.16]:63731 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S132939AbRDXWcE>;
	Tue, 24 Apr 2001 18:32:04 -0400
MIME-Version: 1.0
Message-ID: <15077.65246.992239.329501@charged.uio.no>
Date: Wed, 25 Apr 2001 00:31:58 +0200
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <Pine.GSO.4.21.0104241805280.9199-100000@weyl.math.psu.edu>
In-Reply-To: <shszod6j6w4.fsf@charged.uio.no>
	<Pine.GSO.4.21.0104241805280.9199-100000@weyl.math.psu.edu>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alexander Viro <viro@math.psu.edu> writes:

     > _Ouch_. So what are you going to do if another iget4() comes
     > between the moment when you hash the inode and set these
     > fields? You are filling them only after you drop inode_lock, so
     > AFAICS the current code has the same problem.

The entire call to iget4() is protected by the BKL in all relevant
instances. As long as we don't sleep between find_inode() and
nfs_fill_inode(), we're safe.

In fact the BKL protection is needed also for another reason: we don't
actually initialize the inode in the I_LOCK-protected read_inode() but
instead rely on the caller of iget4 to do it for us. The reason is
that one we would need to pass the struct nfs_fattr to read_inode()
and this wasn't possible until the ReiserFS people introduced
read_inode2().

Cheers,
   Trond
