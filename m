Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261795AbTCQRDF>; Mon, 17 Mar 2003 12:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261798AbTCQRDF>; Mon, 17 Mar 2003 12:03:05 -0500
Received: from didot.sissa.it ([147.122.2.50]:61138 "EHLO didot.sissa.it")
	by vger.kernel.org with ESMTP id <S261795AbTCQRDA>;
	Mon, 17 Mar 2003 12:03:00 -0500
Date: Mon, 17 Mar 2003 18:13:22 +0100 (MET)
From: Fabrizio Nesti <nesti@medialab.sissa.it>
X-X-Sender: nesti@stheno
Reply-To: Fabrizio Nesti <nesti@medialab.sissa.it>
To: trond.myklebust@fys.uio.no
cc: nfs@lists.sourceforge.net, <linux-kernel@vger.kernel.org>,
       Giuliano Lesa <lesa@medialab.sissa.it>,
       Eric Whiting <ewhiting@amis.com>
Subject: [NFS] 2.4.20 TCP server + solaris client performance
In-Reply-To: <3E69326E.2AF0E6F2@amis.com>
Message-ID: <Pine.GSO.4.40.0303171753070.3235-100000@stheno>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to all.
I'd like to report a linux-server - solaris-client performance problem
that still seems without solution.

- The problem is that untaring a (small) archive on a solaris client is 4-5
  times slower (!) with a linux server than with a solaris server. We tried
  UDP as well as TCP (2.4.20 and also with bs=32k) without improvements.
  See details below..

There was a discussion on the linux-nfs list, from which I extract the last
message below.
         http://marc.theaimsgroup.com/?t=104550454800002&r=1&w=2
There you'll find also some tcpdump output. In case of need don't hesitate
to ask me numbers or further tests.

We really hope not to be forced to install Solaris on our new Linux servers :)

Cheers and thanks in advance to all,
Fabrizio




On Fri, 7 Mar 2003, Eric Whiting wrote:

> Neil/Fabrizio,
>
> I'm still seeing the slow linux 2.4.20 nfs server when using a solaris client.
> (as reported by Fabrizio Nesti <nesti@medialab.sissa.it> last month)
>
> Summary: NFS operations related to the untar of a file are very/very slow on a
> linux 2.4.20 NFS server (TCP and UDP). Bonnie streaming numbers look very good.
> Just the file creation stuff is slow. 15 minutes instead of 2 minutes for the
> tar -xf.
>
> Is this an issue related to noac or sync options from the solaris client?
>
> More benchmark data changing the test to highlight the problem.
> I used 'time tar -xf linux-2.4.20.tar' for this testing.
>
> eric
>
> 2.4.20 NFS server (TCP NFSV3 -- UDP numbers similar)
> ----------------------------------------------
>  0m  4s         untar on local linux box  (no sync included)
>  2m 18s         Linux 2.4.19 NFS client (UDP)
> 15m 28s         Solaris 2.7 NFS client (TCP)
> 26m  9s         Solaris 2.9 NFS client (somewhat a traffic issue perhaps?)
>
> NETAPPS NFS SERVER
> -------------------
>  1m 19s		Linux 2.4.20 client (UDP)
>  1m 54s		Solaris 2.8 client
>
>
>
>
>
> Fabrizio Nesti wrote:
> >
> > >I just tried your tar -xf cvs-1.11.5.tar test and I see numbers like yours
> > > (except I don't see super fast solaris NFS numbers)
> > > Client        Server          Time
> > > -------------------------------------
> > > solaris7      2.4.20          27.3
> > > solaris7      solaris9        26.9
> > > solaris9      solaris7        25.3
> > > 2.4.18        2.4.20           7.0 (defaults to async mounts right?)
> > > 2.4.20        2.4.18          15.1
> > > linux local (no NFS)           1.2 (including sync)
> >
> > Hello, your third line is indeed strange to us.
> > These are our times, in the full range of situations, still for tar xf.
> > We'll try some other tests (dd and bonnie) tomorrow.
> >
> >     Client      Server               Time (sec)                  TCP/UDP
> > -------------------------------------------------------------------------
> > 1)  2.4.18      solaris7               7 (rw=32k)   (7 for rw=8k)   T
> > 2)  solaris8    solaris7               8 (rw=32k)  (15 for rw=8k)   T
> > 3)  2.4.18      solaris7               7                            U
> > 4)  solaris8    solaris7               15                           U
> >
> > 5)  2.4.18      2.4.20 (sync)          30 (rw=8k)                   T
> > 6)  2.4.18      2.4.20 (async)         10 (rw=8k)                   T
> > 7)  solaris8    2.4.20 (sync)          55 (rw=8k) 60 (rw=1k)        T
> > 8)  solaris8    2.4.20 (async)         40 (rw=8k)                   T
> > 9)  2.4.18s     2.4.20 (sync)          15                           U
> > A)  2.4.18s     2.4.20 (async)          3                           U
> > B)  solaris8    2.4.20 (sync)          53                           U
> > C)  solaris8    2.4.20 (async)         34                           U
> >
> > D)  2.4.18      2.4.18s (sync)         50 (both machines loaded)    U
> > E)  2.4.18      2.4.18s (async)         3                           U
> > F)  solaris8    2.4.18s (sync)         87 (both machines loaded)    U
> > G)  solaris8    2.4.18s (async)        33                           U
> >
> > Local Writes (no NFS):
> > 2.4.18s   (Xeon server, RAID5/ext3)     2  (including sync)
> > 2.4.18/20 (Athlon1900DDR test PC, ext3) 3  (including sync)
> > solaris7  (E250 server, RAID5/UFS+logg) 3  (including sync)
> >
> > solaris8 client is an U10 (and has no retransmission problems).
> >
> > Comments:
> > - TCP does not help the present linux server. (on the contrary for pure
> >   linux it's worse).
> > - For pure solaris, wsize=32k doubles the TCP speed, otherwise comparable
> >   to UDP performance. We may try to enable it for linux also..
> > - Does solaris default to async? (Strange, but there's no server side flag).
> >   If not, solaris is _very_ fast.
> >
> > --
> > In other words, we switched from a SUN Enterprise250 to a quad Xeon (Dell),
> > to find performance loss from case 2) to G).  :(
> >
> > Hoping in the best,
> > ciao,
> > Fabrizio
> >
> > PS: Some nfsstat -m as seen from the solaris8 client.
> >
> > 1,2) solaris 7 server via TCP
> >  from didot:/export/backup
> >  Flags:         vers=3,proto=tcp,sec=sys,hard,intr,link,symlink,acl,
> >                 rsize=<....>,wsize=<.....>,retrans=5,timeo=600
> >  Attr cache:    acregmin=3,acregmax=60,acdirmin=30,acdirmax=60
> >
> > 3,4) Solaris 7 server via UDP
> >  Flags:         vers=3,proto=udp,sec=sys,hard,intr,link,symlink,acl,
> >                 rsize=8192,wsize=8192,retrans=5,timeo=11
> >  Attr cache:    acregmin=3,acregmax=60,acdirmin=30,acdirmax=60
> >  Lookups:       srtt=7 (17ms), dev=3 (15ms), cur=2 (40ms)
> >  Reads:         srtt=9 (22ms), dev=6 (30ms), cur=4 (80ms)
> >  Writes:        srtt=7 (17ms), dev=3 (15ms), cur=2 (40ms)
> >  All:           srtt=7 (17ms), dev=3 (15ms), cur=2 (40ms)
> >
> > 5,6,7,8) Linux server via TCP:
> >  Flags:         vers=3,proto=tcp,sec=none,hard,intr,link,symlink,acl,
> >                 rsize=8192,wsize=8192,retrans=5,timeo=600
> >  Attr cache:    acregmin=3,acregmax=60,acdirmin=30,acdirmax=60
> >
> > 9,A,B,C,D,E,F,G) Linux servers via UDP
> >  Flags:         vers=3,proto=udp,sec=none,hard,intr,link,symlink,
> >                 rsize=8192,wsize=8192,retrans=5,timeo=11
> >  Attr cache:    acregmin=3,acregmax=60,acdirmin=30,acdirmax=60
> >  Lookups:       srtt=7 (17ms), dev=3 (15ms), cur=2 (40ms)
> >  Reads:         srtt=7 (17ms), dev=4 (20ms), cur=2 (40ms)
> >  Writes:        srtt=7 (17ms), dev=3 (15ms), cur=2 (40ms)
> >  All:           srtt=7 (17ms), dev=3 (15ms), cur=2 (40ms)
> >
> >   Client        Server          Time (sec)
> > -----------------------------------------------
> > TCP:
> > 1)  2.4.18      solaris7           7 (rw=32k)   (7 for rw=8k)
> > 2)  solaris8    solaris7           8 (rw=32k)  (15 for rw=8k)
> > 3)  2.4.18      2.4.20 (sync)      30 (rw=8k)
> > 4)  2.4.18      2.4.20 (async)     10 (rw=8k)
> > 5)  solaris8    2.4.20 (sync)      55 (rw=8k) 60 (rw=1k)
> > 6)  solaris8    2.4.20 (async)     40 (rw=8k)
> > UDP:
> > 7)  2.4.18      solaris7           7.5
> > 8)  solaris8    solaris7           15
> > 9)  2.4.18s     2.4.20 (sync)      15
> > A)  2.4.18s     2.4.20 (async)     2.5
> > B)  solaris8    2.4.20 (sync)      53
> > C)  solaris8    2.4.20 (async)     34
> >
> > 9)  2.4.18      2.4.18s (sync)      50 (both machines loaded)
> > A)  2.4.18      2.4.18s (async)     2.6
> > B)  solaris8    2.4.18s (sync)      87 (both machines loaded)
> > C)  solaris8    2.4.18s (async)     33



