Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132019AbRACPIB>; Wed, 3 Jan 2001 10:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132066AbRACPHv>; Wed, 3 Jan 2001 10:07:51 -0500
Received: from nta-monitor.demon.co.uk ([212.229.78.70]:22790 "EHLO
	mercury.nta-monitor.com") by vger.kernel.org with ESMTP
	id <S132019AbRACPHh>; Wed, 3 Jan 2001 10:07:37 -0500
Message-Id: <4.3.2.7.2.20010103142412.00b54ea0@192.168.124.1>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 03 Jan 2001 14:36:23 +0000
To: linux-kernel@vger.kernel.org
From: Roy Hills <Roy.Hills@nta-monitor.com>
Subject: Re: UDP ports 800-n used by NFS client in 2.2.17
In-Reply-To: <14925.931.62753.695344@notabene.cse.unsw.edu.au>
In-Reply-To: <message from Roy Hills on Friday December 29>
 <4.3.2.7.2.20001229133326.00b28990@192.168.124.1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Neil and everyone else who helped me understand this one.
Here's my summary of what I've been told and what I've discovered:

The port 800-n is indeed the source port that is used for NFS
communications for the filesystem.  Using tcpdump, we see
communication between port 800 on the client and port 2049
on the NFS server.

The kernel source code involved for 2.2 and 2.4 is function
xprt_bindresvport in net/sunrpc/xprt.c.

I can prevent this wild UDP socket by using TCP for the mount.
This results in an established TCP connection between client
and server, e.g:

tcp        0      0 192.168.124.7:800       192.168.124.6:2049      ESTABLISHED

My only remaining question is why the UDP port needs to be bound
to any local address, any foreign address, and any foreign port
e.g. why we can't have:

udp        0      0 192.168.124.7:800            192.168.124.6:2049

instead of:

udp        0      0 0.0.0.0:800            0.0.0.0:*

This would avoid having a UDP socket that is accessible from any address/port.

Roy Hills

At 08:35 30/12/00 +1100, Neil Brown wrote:
>On Friday December 29, Roy.Hills@nta-monitor.com wrote:
> > Does anyone know what causes netstat to show UDP port 800
> > as active on a Linux NFS client with 2.2.17 kernel when an NFS filesystem
> > is mounted?
> >
> > Using Debian Linux 2.2 with Kernel 2.2.17 with one NFS filesystem mounted,
> > I see
> > the following:
> >
> >     rsh@lithium [3]$ netstat -n -a -u
> >     Active Internet connections (servers and established)
> >     Proto Recv-Q Send-Q Local Address          Foreign Address
> >     udp        0      0 0.0.0.0:800            0.0.0.0:*
> >
> > If I unmount the NFS Filesystem, the UDP port disappears.
>
>That will be the local port that is used to talk to the NFS server.
>
> >
> > It appears that each NFS mounted filesystem uses a separate UDP
> > port, and that they count down from port 800.  I.e. the first
> > mount uses UDP port 800, the second UDP port 799.
> >
> > "lsof -i" doesn't show this port belonging to any process, and the "-p"
> > option to netstat
> > doesn't show any process info either. I assume that this means that it's a
> > kernel thing
> > rather than a process level thing.
> >
> > A network sniff while mounting and umounting the NFS filesystem
> > doesn't show any traffic on UDP port 800 - I just see portmapper, mountd
> > and nfs
> > traffic.
>
>While mounting and unmounting you might not (I'm not sure) but while
>accessing the filesystem you definately should.
>You say that you see "nfs" traffic.  Each packet has a source port and
>a destintation port.  For an NFS request, the destination port will be 2049
>on the server, the source port will be 800 (or 799 ...) on the client.
>
> >
> > Does anyone know what this is or where I can look in the source for 
> more info?
> > I've searched /usr/src/linux/fs/nfs/*.c for 800 and 320 (800 in hex)
> > without success.
>
>Check out net/sunrpc/xprt.c:xprt_bindresvport
>
>NeilBrown
>
> >
> > Roy Hills
> > --
> > Roy Hills                                    Tel:   +44 1634 721855
> > NTA Monitor Ltd                              FAX:   +44 1634 721844
> > 14 Ashford House, Beaufort Court,
> > Medway City Estate,                          Email: 
> Roy.Hills@nta-monitor.com
> > Rochester, Kent ME2 4FA, 
> UK                  WWW:   http://www.nta-monitor.com/
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>Please read the FAQ at http://www.tux.org/lkml/

--
Roy Hills                                    Tel:   +44 1634 721855
NTA Monitor Ltd                              FAX:   +44 1634 721844
14 Ashford House, Beaufort Court,
Medway City Estate,                          Email: Roy.Hills@nta-monitor.com
Rochester, Kent ME2 4FA, UK                  WWW:   http://www.nta-monitor.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
