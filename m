Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWBBQNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWBBQNN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWBBQNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:13:13 -0500
Received: from rodin.limsi.fr ([129.175.152.156]:64198 "EHLO rodin.limsi.fr")
	by vger.kernel.org with ESMTP id S932098AbWBBQNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:13:11 -0500
Date: Thu, 2 Feb 2006 17:12:53 +0100
From: Olivier Galibert <olivier.galibert@limsi.fr>
To: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: How is static multicast routing done in practice ?
Message-ID: <20060202161253.GA10215@m23.limsi.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-LIMSI-rodin-MailScanner: Found to be clean
X-LIMSI-rodin-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.599,
	requis 5, autolearn=not spam, BAYES_00 -2.60)
X-MailScanner-Auteur: galibert@m23.limsi.fr
X-MailScanner-Dest: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an application[1] that does sends and recieve over multicast
udp.  Its setup looks like that (note, no IP_MULTICAST_IF call):

4920  socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 3
4920  fcntl64(3, F_GETFL)               = 0x2 (flags O_RDWR)
4920  fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
4920  setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
4920  bind(3, {sa_family=AF_INET, sin_port=htons(8649), sin_addr=inet_addr("239.2.11.71")}, 16) = 0
4920  ioctl(3, SIOCGIFADDR, 0xbfcc0bd0) = 0
4920  setsockopt(3, SOL_IP, IP_ADD_MEMBERSHIP, "\357\2\vG\300\250Wd", 8) = 0

4920  socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 4
4920  fcntl64(4, F_GETFL)               = 0x2 (flags O_RDWR)
4920  fcntl64(4, F_SETFL, O_RDWR|O_NONBLOCK) = 0
4920  setsockopt(4, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
4920  bind(4, {sa_family=AF_INET, sin_port=htons(8649), sin_addr=inet_addr("0.0.0.0")}, 16) = 0
4920  listen(4, 5)                      = 0

4920  socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 5
4920  connect(5, {sa_family=AF_INET, sin_port=htons(8649), sin_addr=inet_addr("239.2.11.71")}, 16) = 0
4920  getsockname(5, {sa_family=AF_INET, sin_port=htons(32775), sin_addr=inet_addr("192.168.87.100")}, [16]) = 0
4920  setsockopt(5, SOL_IP, IP_MULTICAST_TTL, "\1", 1) = 0

The box has two ethernet interfaces, eth0 and eth1.  The routes are:

239.2.11.71 dev eth1  scope link 
192.168.87.0/24 dev eth1  proto kernel  scope link  src 192.168.87.100 
192.44.78.0/24 dev eth0  scope link 
169.254.0.0/16 dev eth1  scope link 
224.0.0.0/4 dev eth1 

And the adresses:
1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:09:6b:00:dc:8a brd ff:ff:ff:ff:ff:ff
    inet 192.168.87.100/24 brd 192.168.87.255 scope global eth0
    inet6 fe80::209:6bff:fe00:dc8a/64 scope link 
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:09:6b:00:dc:8b brd ff:ff:ff:ff:ff:ff
    inet 192.168.87.100/24 scope global eth1
    inet6 fe80::209:6bff:fe00:dc8b/64 scope link 
       valid_lft forever preferred_lft forever
4: sit0: <NOARP> mtu 1480 qdisc noop 
    link/sit 0.0.0.0 brd 0.0.0.0

Yes, same ip on both interfaces, we want it that way.

No mrouted anywhere as far as I know.

Problem is: the multicast udp packets are sent over eth0, not eth1.

How can I debug/fix that?

  OG.

[1] Ganglia daemon
