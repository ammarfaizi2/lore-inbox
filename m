Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291216AbSBLWNV>; Tue, 12 Feb 2002 17:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291215AbSBLWNC>; Tue, 12 Feb 2002 17:13:02 -0500
Received: from 213-96-124-18.uc.nombres.ttd.es ([213.96.124.18]:55019 "HELO
	dardhal") by vger.kernel.org with SMTP id <S291213AbSBLWMu>;
	Tue, 12 Feb 2002 17:12:50 -0500
Date: Tue, 12 Feb 2002 23:12:39 +0100
From: Jose Luis Domingo Lopez <jdomingo@internautas.org>
To: linux-kernel@vger.kernel.org
Cc: netfilter-devel@lists.samba.org
Subject: [netfilter]: FTP connection tracking problem
Message-ID: <20020212221239.GB2161@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	netfilter-devel@lists.samba.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel developers:

[I'm am not subscribed to netfilter-devel, so please Cc: linux-kernel]

I am experiencing some problems with FTP connection tracking in recent
2.4.x kernels. In short, it seems ip_conntrack_ftp misses some
legitimate packets belonging to already stablished connections, and
sometimes FTP sessions don't work. Of course, this is NATing outgoing
traffic, including FTP. A more complete explanation follows.

A Linux machine (tried 2.4.17 and 2.4.18-pre9) acting as a router/NAT
inconditionally does SNAT on all traffic leaving some interface:
iptables -t nat -A POSTROUTING --out-interface eth2 --jump SNAT \
    --to-source $PUBLIC_ADDRESS

As we don't want to leave the box open to external port scan, but we do
want to let the machine connect to the Internet to grab security updates
from time to time, we allow all outgoing traffic through "eth2" but just
allow related traffic in the opposite direction:
iptables -t filter -A OUTPUT --jump ACCEPT
iptables -t filter -A INPUT --in-interface eth2 --match state \
    --state RELATED,ESTABLISHED --jump ACCEPT
iptables -t filter -A INPUT --in-interface eth2 --match state \
    --state NEW,INVALID --jump DROP

So, as we manually (well, our script :) install all required netfilter
modules into memory, we expected most protocols to work, including FTP
(ip_conntrack, ip_conntrack_ftp, ip_nat_ftp among others are in memory).
And in fact, most of the time every "supported" protocol work fine.
However, some combinations of FTP client and remote FTP server fail.

Starting with iptables counters reset, we try to connect to some remote
FTP server, and the connection isn't fully established. With no other
network traffic going on  we see packets matching the DROP rule. Logging
those packets to syslog (via --jump LOG) shows they are packets from the
FTP connection. This happens both with active and passive transfer modes.

We tried to ACCEPT INVALID traffic, with no luck: packets continue to be
dropped, so to FTP connection tracking they appear as NEW instead of
somewhat related to the ongoing FTP session.

The strange part is that this will show up with just some FTP clients
and/or remote FTP servers. For example, text-mode web browser "links"
doesn't work in any case. On the other hand, text-mode browser "lynx"
works nice in the same places where "links" fails. "wget", "ftp" and
"ncftp" show various degrees of success with several combinations of
active/passive transfer mode and remote FTP servers (tried with
ftp.kernel.org, ftp.at.kernel.org, ftp.mozilla.org, ftp.rediris.es,
ftp.sourceforge.net).

For example, "ftp.rediris.es" won't even show the greeting message with
"links", but will with for example "ncftp". However, trying to download
some file from the server, stalls as soon as some kilobytes of data have
been received (in the order of 8 to 10 KB).

If we configure INPUT to not discard packets, and just ACCEPT all that
comes in solves the proble. ECN is not compiled in nor activated. The rest
of network-related kernel tunnable parameters have default values.


Searching the Internet for information took me to a messages on
netfilter-devel mailing list, namely:
http://lists.samba.org/pipermail/netfilter-devel/2001-October/002433.html

It contains a patch for a problem very similar to what I am
experiencing, and seems to be related to the fact that some FTP clients
end their FTP commands with just \r instead of \r\n, and viceversa. A
"ethereal" packet capture in a "clean" (no firewall rules) state with
the FTP clients described above show that all of them follow RFC959 and
terminate FTP commands with "\r\n".

I compiled the same kernel (2.4.18-pre9 in this case) with the patch
applied, and repeated some of the test described above with some degree
of success. Some combinations of FTP client and remote FTP servers now
work OK, but some other combinations continue failing. As previously
said, in absence of (DROP) firewall rules, everything works fine. We
checked the possibility of our ISP messing the packets up, but some
tests limited to our LAN show the same problems.

NOTE: "links" author says in the manual page:
BUGS
       Can't connect to some  FTP  servers  (Novell,  NT).
       Connection stays in "Request sent" state.
So in this particular case, the application could also have problems.


I am willing to perform as much tests as you need to help discover what
is going on, so if I missed something important, please ask.

Keep up the good work !

-- 
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo AT internautas DOT   org  => Spam at your own risk

