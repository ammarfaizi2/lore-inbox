Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265806AbUGHGDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265806AbUGHGDd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 02:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265805AbUGHGDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 02:03:33 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:27057 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S265799AbUGHGD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 02:03:27 -0400
Date: Thu, 8 Jul 2004 08:03:26 +0200
From: bert hubert <ahu@ds9a.nl>
To: Jamie Lokier <jamie@shareable.org>
Cc: "David S. Miller" <davem@redhat.com>,
       Stephen Hemminger <shemminger@osdl.org>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       ALESSANDRO.SUARDI@ORACLE.COM
Subject: Re: preliminary conclusions regarding window size issues
Message-ID: <20040708060326.GA22258@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Jamie Lokier <jamie@shareable.org>,
	"David S. Miller" <davem@redhat.com>,
	Stephen Hemminger <shemminger@osdl.org>, netdev@oss.sgi.com,
	linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
	ALESSANDRO.SUARDI@ORACLE.COM
References: <20040707232757.GA14471@outpost.ds9a.nl> <20040708014443.GE17266@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708014443.GE17266@mail.shareable.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 02:44:43AM +0100, Jamie Lokier wrote:

> An iptable mangle rule would do the trick -- mangle the TTL only on
> packets which match this point in the trace.

Indeed fiddly - not only does the packet have to disappear, we need an ICMP
to confirm that. This is because the packet currently disappears anyhow. 

Another thought that ocurred to me is that this might be a window tracking
firewall that says, based on the scaled window size which it misinterprets
because it does not understand window scaling: "I'm not going to let this
packet pass, I've seen that the intended recipient announced a 43 byte
window size".

The idea such a silly firewall would have is that it 'protects' a host from
traffic it can't handle.

This jives with the observed fact that things work up to and including
wscale=2, but breaks with wscale=3. With wscale=3, the scaled window size is
730. With wscale=2, the observed window of 1460 is big enough to let a
packet pass.

We could verify this assumption by checking if lowering the MTU to say 700
allows wscale=3 to work. 

Looking at the traceroute to Alessandro, my current suspect is this machine:

(The 1655 ports scanned but not shown below are in state: closed)
PORT    STATE    SERVICE
81/tcp  filtered hosts2-ns
135/tcp filtered msrpc
445/tcp filtered microsoft-ds
514/tcp open     shell
No exact OS matches for host (If you know what OS is running on it, see
http://www.insecure.org/cgi-bin/nmap-submit.cgi).
TCP/IP fingerprint:
SInfo(V=3.50%P=i686-pc-linux-gnu%D=7/8%Time=40ECDF49%O=514%C=1)
TSeq(Class=TR%IPID=Z%TS=U)
T1(Resp=Y%DF=Y%W=1020%ACK=S++%Flags=AS%Ops=ME)
T2(Resp=N)
T3(Resp=Y%DF=Y%W=1020%ACK=S++%Flags=AS%Ops=ME)
T4(Resp=Y%DF=N%W=0%ACK=O%Flags=R%Ops=)
T5(Resp=Y%DF=N%W=0%ACK=S++%Flags=AR%Ops=)
T6(Resp=Y%DF=N%W=0%ACK=O%Flags=R%Ops=)
T7(Resp=Y%DF=N%W=0%ACK=S%Flags=AR%Ops=)
PU(Resp=N)


TCP Sequence Prediction: Class=truly random
                         Difficulty=9999999 (Good luck!)
TCP ISN Seq. Numbers: 9D217EAD 78BBFA4A 6C815E49 191A3C0A 2A07597F 8B869DAA
IPID Sequence Generation: All zeros

Nmap run completed -- 1 IP address (1 host up) scanned in 25.593 seconds

TCP port 514 is rsh, but when I try rsh on that port it doesn't work.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
