Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276334AbRJCOf7>; Wed, 3 Oct 2001 10:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276332AbRJCOfv>; Wed, 3 Oct 2001 10:35:51 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:40687 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S276333AbRJCOff>; Wed, 3 Oct 2001 10:35:35 -0400
Date: Wed, 3 Oct 2001 09:36:04 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200110031436.JAA51720@tomcat.admin.navo.hpc.mil>
To: Frank.dekervel@student.kuleuven.ac.Be, linux-kernel@vger.kernel.org
Subject: Re: mtu problem with masquerading+pppoe(adsl) setup
In-Reply-To: <200110031300.PAA17063@lambik.cc.kuleuven.ac.be>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>:
>  Hello, (i am sorry if this is the wrong place to ask)
>  
>  despite the frequent discussions concerning this topic on usenet, i failed 
>  to solve my problem:
>  
>  - i have a debian potatoe box that acts as a masquerading server for a 
>  heterogenous win2k/winnt/mac LAN. pppoe works fine, and so does 
>  masquerading ... almost
>  
>  - the kernel i installed is the latest 2.2 kernel (2.2.19)
>  
>  the problem:
>  
>  i can't access some sites from the masq clients, while i can access them 
>  from the masq server. (like www.vitrine.be)

Actually it sounds like two problems:
1. the NAT server needs "always defragment packets". This way the entire
   header is available for use.
2. Turn on forwarding.

BTW, you also have to hame the "ip_masq_ftp" module if you are going to
provide FTP to outside systems for your internal network. Just masquerading
support will do single TCP/IP and UDP connections. FTP uses a command
connection and a separate data connection. Since they are paired, the ftp
module supports the data channel.

I'm still useing the ipchains wrapper ipfwadm, which works with the following:

# flush every rule (this was recommended by the wrapper since the wrapper
# uses ipchains)

/sbin/ipchains -F
/sbin/ipchains -X

#                        (internal net)   (destination)
/sbin/ipfwadm -F -a m -S 192.168.0.0/24 -D 0.0.0.0/0 
/sbin/ipfwadm -F -p deny
echo 1 > /proc/sys/net/ipv4/ip_forward

This still assumes that the default route/gateway is defined on the
NAT server.

In terms of ipchains the above ipfwadm wrapper generates:

ipchains -L IpFwAdM! -v
ipchains -R IpFwAdM! 2 -m 10004
ipchains -A fwd -s 192.168.0.0/24 -d 0.0.0.0/0 -j MASQ -m 0x2713

ipchains -P forward DENY


>  The problem seems to be widely known, and seems to be an MTU+no-fragment 
>  packets issue. and indeed:
>  - the MTU on my LAN is 1500 bytes
>  - the MTU on my ppp connection is 1492 bytes.
>  
>  on the archives, i found the following solutions:
>  - raising the ppp MTU to 1500 bytes. it won't work. even if i specify 1500, 
>  the mtu is still 1492.
>  - lowering the mtu of the LAN to 1492 bytes. thats not an option according 
>  to my boss.
>  - upgrade to something newer than 2.2.14. i run 2.2.19 and i still have the 
>  problem.
>  
>  So my questions are:
>  
>  - are there other options ? i read some vague german things about msschamp 
>  or something like that, but i don't know if they are even related.
>  
>  - will an upgrade to linux 2.4 or the kernelspace pppoe driver fix my 
>  problem ? (i would like to keep my current setup, i don't know how 
>  difficult it is to upgrade a potatoe box to such a recent version ..)

>
>  
>  Some other observations:
>  
>  - win2k as masquerading server does not have the problem, but switching to 
>  win2k is not really an option since win2k seems to have severe problems 
>  with ftp connections.

That's because it does not support ftp masquerading.

>  - the problem also occurs for some mail servers.

Incoming or outgoing?

What I do is have the NAT server recieve the incoming mail, and immediately
relay that to the real mail server. It IS possible to do port forwarding
on the NAT server to provide a direct connection to the mail server:

/usr/sbin/ipmasqadm portfw -f		# flush forward tables
#                                     (NAT ip addr)    (real mail server)
/usr/sbin/ipmasqadm portfw -a -P tcp -L ${IPADDR2} 25 -R 192.168.0.1 25

I use this technique for a web server.

Outgoing mail from the server was no problem since that uses a single
TCP connection.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
