Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130747AbQLTRPR>; Wed, 20 Dec 2000 12:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130694AbQLTRPI>; Wed, 20 Dec 2000 12:15:08 -0500
Received: from mail.SerNet.DE ([193.159.217.66]:63241 "EHLO mail.SerNet.DE")
	by vger.kernel.org with ESMTP id <S130453AbQLTRPC>;
	Wed, 20 Dec 2000 12:15:02 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Cord Seele <Seele@emlix.com>
Newsgroups: lists.linux.kernel,lists.linux.netdev
Subject: getsockopt() with IP_PKTINFO not working?
Date: Wed, 20 Dec 2000 17:44:34 +0100
Organization: emlix GmbH
Message-ID: <3A40E1F2.2C8E0127@emlix.com>
NNTP-Posting-Host: seele.sernet.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: server1.GoeNet.DE 977330675 15317 193.159.216.42 (20 Dec 2000 16:44:35 GMT)
X-Complaints-To: news@news.SerNet.DE
NNTP-Posting-Date: 20 Dec 2000 16:44:35 GMT
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to get the destination address of an incoming udp packet
with getsockopt().
According to the man pages flag IP_PKTINFO should do that. But it
doesn't work:

        struct in_pktinfo pktinfo;
        socklen_t optlen;
        struct in_addr local_addr;

        optlen=(socklen_t)sizeof(pktinfo);   
        syslog (LOG_ERR, "ERR %d",           
          getsockopt(fd, SOL_IP, IP_PKTINFO, &pktinfo, &optlen));
        syslog (LOG_ERR, "LENGTH %d %d", (int)optlen, sizeof(pktinfo));
        local_addr=pktinfo.ipi_addr;                                   
        syslog (LOG_ERR,"ADDR %s",inet_ntoa(local_addr));

results in /var/log/messages:

Dec 19 19:27:49 coda tftpd[20081]: ERR 0
Dec 19 19:27:49 coda tftpd[20081]: LENGTH 4 12
Dec 19 19:27:49 coda tftpd[20081]: ADDR 232.252.255.191

While getsockopt() returns no error, the resulting length is too short
and the addr is
definitely invalid. I would expect either getsockopt() to return -1, it
this is not
implemented or return at least 12 valid bytes.
(I am running a 2.2.16 kernel with glibc 2.1.3.)

I even tried the 'hard way' using recvmsg() but the resulting
msg_controllen == 0. 


Background:
If a machine has more than one address in a single network, i.e.

	eth0   192.168.0.10
	eth0:1 192.168.0.20

a call to bind() normally assigns the primary ip address (.10) to the
socket.
If the server was addressed on his second address (.20) the request is
not answered
and fails. I have this problem with tftpd.
Or is there a better way to get the destination address of an incoming
udp packet?

Thanks for any help.

	Cord Seele

PS: Please CC me since I am not an the list.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
