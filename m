Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbQLUHby>; Thu, 21 Dec 2000 02:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130132AbQLUHbp>; Thu, 21 Dec 2000 02:31:45 -0500
Received: from entropy.muc.muohio.edu ([134.53.213.10]:387 "EHLO
	entropy.muc.muohio.edu") by vger.kernel.org with ESMTP
	id <S129752AbQLUHb3>; Thu, 21 Dec 2000 02:31:29 -0500
Date: Thu, 21 Dec 2000 02:00:49 -0500 (EST)
From: George <greerga@entropy.muc.muohio.edu>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: "Michael H. Warfield" <mhw@wittsend.com>, <linux-kernel@vger.kernel.org>
Subject: Re: iptables: "stateful inspection?"
In-Reply-To: <3A40DE97.96228B5E@holly-springs.nc.us>
Message-ID: <Pine.LNX.4.30.0012210147540.8317-100000@entropy.muc.muohio.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2000, Michael Rothwell wrote:

>"Michael H. Warfield" wrote:
>>         I think that's more than a little overstatement on your
>> part.  It depends entirely on the application you intend to put
>> it to.
>
>Fine. How do I make FTP work through it? How can I allow all outgoing
>TCP connections without opening the network to inbound connections on
>the ports of desired services?

/etc/sysctl.conf:
	# Set local port range to be higher.
	net.ipv4.ip_local_port_range = 32768 33792

/etc/ftpaccess:
	passive ports 0.0.0.0/0 32768 36863

Firewall script:
-----------------
STDPORT=32768:33792
IP=1.2.3.4/32

# Client FTP
ipchains -A output -j ACCEPT -p tcp -s $IP $STDPORT -d 0.0.0.0/0 ftp-data -y -l
ipchains -A output -j ACCEPT -p tcp -s $IP $STDPORT -d 0.0.0.0/0 ftp-data
ipchains -A output -j ACCEPT -p tcp -s $IP $STDPORT -d 0.0.0.0/0 ftp -y -l
ipchains -A output -j ACCEPT -p tcp -s $IP $STDPORT -d 0.0.0.0/0 ftp

# Server FTP
ipchains -A input -j ACCEPT -p tcp -s 0.0.0.0/0 ftp-data -d $IP $STDPORT # Needs SYN
ipchains -A input -j ACCEPT -p tcp -s 0.0.0.0/0 ftp -d $IP $STDPORT ! -y

[now deny all for all chains]

Unfortunately, any FTP server that doesn't use port 20 for data streams
won't work in Passive mode (oh well).  So I just download elsewhere first
and then get it locally for browsers that insist upon Passive.

For allowing outgoing connections without inbound, you'd use:

	ipchains -A input -j DENY -p tcp -y

or if that complains:

	ipchains -A input -j DENY -p tcp -s 0.0.0.0/0 -d $IP -y

You'll notice above I used '! -y' on the Server FTP rule.  If I missed a
detail, it might be due to trying to condense everything I have into what
you wanted.

-George Greer

(7,323 and 189 lines in my firewall rule script.)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
