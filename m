Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313492AbSDYVUw>; Thu, 25 Apr 2002 17:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313501AbSDYVUv>; Thu, 25 Apr 2002 17:20:51 -0400
Received: from pc132.utati.net ([216.143.22.132]:21916 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S313492AbSDYVUv>; Thu, 25 Apr 2002 17:20:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Steffen Persvold <sp@scali.com>
Subject: Re: [NFS] NFS clients behind a masqueraded gateway
Date: Thu, 25 Apr 2002 11:22:17 -0400
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0204251922190.16930-100000@elin.scali.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020425214220.2C658761@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 April 2002 01:24 pm, Steffen Persvold wrote:
> Hi again,
>
> I hate to bother you guys again with this problem, but do you have any
> ideas (haven't received any response so far) ?
>
> Answers highly appreciated.
>
> On Thu, 18 Apr 2002, Steffen Persvold wrote:
> > Hi all,
> >
> > I'm experiencing some problems with a cluster setup. The cluster is set
> > up in a way that you have a frontend machine configured as a masquerading
> > gateway and all the compute nodes behind it on a private network (i.e the
> > frontend has two network interfaces). User home directories and also
> > other data directories which should be available to the cluster (i.e
> > statically mounted in the same location on both frontend and nodes) are
> > located on external NFS servers (IRIX and Linux servers). This seems to
> > work fine when the cluster is in use, but if the cluster is idle for some
> > time (e.g over night), the NFS directories has become unavailable and
> > trying to reboot the frontend results in a complete hang when it tries to
> > unmount the NFS directories (it hangs in a fuser command). The frontend
> > and all the nodes are running RedHat 7.2, but with a stock 2.4.18 kernel
> > (plus Trond's seekdir patch, thanks for the help BTW).
> >
> > Ideas anyone ?
> >
> > Thanks in advance,
>
> Regards,

I've run into a similar problem combining ssh with IP Masquerading.  
Specificallly, IP Masquerading has a timeout: after a certain period of 
inactivity it forgets about a connection.  (It doesn't seem to clean up the 
connection and send close packets, it just silently drops it from its 
internal routing tables.)

The really FUN part is that, depending on how your firewall rules are set up, 
when you try to send a packet along an expired NAT connection it may just 
silently drop it (rather than sending back a "what, are you NUTS?" packet to 
let you know that's not a good connection anymore).

I believe the NAT Masquerading timeout defaults to 15 minutes (it probably 
has a configuration entry under /proc somewhere, but am not caffienated 
enough to remember where.  Try Documentation/filesystems/procfs.txt in the 
linux source tarball.)

It's also possible that something like "echo 600 > 
/proc/sys/net/ipv4/tcp_keepalive_time" might help.  (Make keepalive timeout 
happen faster than IP masquerading timeout.)  You never know. :)

Rob
