Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263977AbSKMWzd>; Wed, 13 Nov 2002 17:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264004AbSKMWzd>; Wed, 13 Nov 2002 17:55:33 -0500
Received: from zmamail05.zma.compaq.com ([161.114.64.105]:45330 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S263977AbSKMWz3>; Wed, 13 Nov 2002 17:55:29 -0500
Message-ID: <3DD2D933.9C3BE8F5@hp.com>
Date: Wed, 13 Nov 2002 14:58:59 -0800
From: "Brian J. Watson" <Brian.J.Watson@hp.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Prasad <prasad_s@gdit.iiit.net>
Cc: Bruce Walker <bruce@kahuna.lax.cpqcorp.net>,
       "Aneesh Kumar K.V" <aneesh.kumar@digital.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ssic-linux-devel <ssic-linux-devel@lists.sourceforge.net>
Subject: Re: [SSI] Re: Distributed Linux
References: <Pine.LNX.4.44.0211140023310.6182-100000@students.iiit.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, openSSI approach has some advantages, but how about the other side,
> how are the devices and files being handled?

The file systems are shared across the cluster. A mount done on one node
is done on all nodes, and every node has coherent read/write access to
that file system. This can be done in one of three ways: CFS, GFS, and
Lustre. CFS is a stateful NFS with tight coherency guarantees that
allows the internal disk of one node to be shared with all nodes. GFS is
a parallel physical file system that allows virtually simultaneous
access to a shared disk that is connected to all nodes. I don't know
much about Lustre, so someone else can fill you in on this. Only CFS and
GFS can be used for the root file system.

Devices are handled by function shipping the file ops. When a process
migrates onto a new node, it "reopens" all of its file descriptors. For
regular files, it essentially opens the files again on the new node
(leveraging the shared file systems described above). For all other
files (devices, sockets, pipes, etc.), it sets up a dummy file structure
with special ops that function ship reads, writes, ioctls, polls, etc.
to the node where a particular object lives.

> isn't it wrong to run
> someone elses process when the data that he is supposed to provide is
> missing?

As I described above, the data is available anywhere in the cluster.

> One of my major constraints is
> that the system should be binary compatible with the kernel that does not
> support my model.

That's a constraint of our clustering technology, as well. Our stuff is
installed by replacing the kernel and a few key commands that have been
made cluster aware: init, mkinitrd, lilo, mount, swapon, fsck, and maybe
one or two others I can't remember. Everything else in the OS is
blissfully unaware of the modified kernel underneath. A process running
an unmodified program can be migrated around the cluster without any
problems (apart from potential performance issues if it's doing a lot of
work with remote objects).

-- 
Brian Watson                | "Now I don't know, but I been told it's
Software Developer          |  hard to run with the weight of gold,
Open SSI Clustering Project |  Other hand I heard it said, it's
Hewlett-Packard Company     |  just as hard with the weight of lead."
                            |     -Robert Hunter, 1970

mailto:Brian.J.Watson@hp.com
http://opensource.compaq.com/
