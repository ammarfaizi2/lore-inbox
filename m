Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263106AbRFCQh3>; Sun, 3 Jun 2001 12:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263673AbRFCQVI>; Sun, 3 Jun 2001 12:21:08 -0400
Received: from [129.187.154.153] ([129.187.154.153]:53512 "EHLO
	pc40.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S263449AbRFCP5D>; Sun, 3 Jun 2001 11:57:03 -0400
Date: Sun, 3 Jun 2001 17:56:28 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: <linux-kernel@vger.kernel.org>
Subject: iptables port remapping problem (was: [newbie] NFS client:
 port-unreachable)
In-Reply-To: <15129.25972.433708.994343@charged.uio.no>
Message-ID: <Pine.LNX.4.31.0106031550060.19522-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jun 2001, Trond Myklebust wrote:

> Are /home and /compass on the same mount point on the client though?
> If not, then they won't share the same port.
>
> IOW: they will only share the same port if you have '/' as the NFS
> mountpoint.

When I mount via nfs each mount gets its own local port to communicate
with the server. Looking at /proc/net/ip_conntrack I see that one such
port (797) got remapped to 772, so I see packets emerging from 772 and
getting back from the server, but the mapping is not done upon receive, so
that it does not reach port 797 (where it originally came from) but port
772 which has no process attached. This results in an ICMP_PORT_UNREACH to
the server and an nfs client not getting an answer. This problem can be
cured by 'rmmod ip_conntrack' and restarting the firewall, which is not a
good solution.

My conclusion: Either iptables has a problem when remapping ports under
moderate load (several RPCs masqueraded per second) or the nfs-client does
not properly reserve the local port when mounting.

BTW: I use util-linux-2.11d but still get 'nfs warning: mount version
older than kernel'.

DETAILS: I have a DECstation being nis domain server and nfs server for
/home, /compass, /usr/local and some other things (all different
directories on the server, I have given the mount points for the clients).
There are a dozen clients being served without problems, mostly running
2.2.14 (RedHat 6.2), some 2.4.2 (SuSE 7.1). Besides I have another server
(RedHat 7.1, kernel 2.4.4 with knfsd-reiserfs-patch from namesys.com),
which also mounts /home and /compass from the DEC and serves some internal
disk space to a linux cluster (RedHat 6.2). This server has IP 217, but
masquerades (via iptables -j SNAT) the cluster as having IPs 218 or 219
(roughly half of the 32 machines on each address), since the cluster
machines have no other connection to the internet because we ran out of
IPs.

Ciao,
					Roland

+-----------------------------------------------------+
|    Tel.:    089/32649332        0561/873744         |
|    in       Radeberger Weg 8    Am Fasanenhof 16    |
|             85748 Garching      34125 Kassel        |
+---------------------------+-------------------------+
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+
|             May the Source be with you!             |
+-----------------------------------------------------+



