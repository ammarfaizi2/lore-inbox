Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267032AbRGQUu1>; Tue, 17 Jul 2001 16:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267030AbRGQUuR>; Tue, 17 Jul 2001 16:50:17 -0400
Received: from 216-158-32-38.forthillcompany.com ([216.158.32.38]:13333 "EHLO
	lazerdye.org") by vger.kernel.org with ESMTP id <S267012AbRGQUuH>;
	Tue, 17 Jul 2001 16:50:07 -0400
Date: Tue, 17 Jul 2001 16:49:28 -0400
From: Terence Haddock <thaddock@tripi.com>
To: linux-kernel@vger.kernel.org
Subject: TCP/IP connections hang with TCP_RETRANS_COLLAPSE=1 - kernel bug?
Message-ID: <20010717164928.A2457@haddock.fhint.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I am having TCP/IP connections "hang", and investigation seems to point to
the tcp_retrans_collapse feature as the culprit. I have the following
network configuration:

Web Server --Switch-> Proxy Server --Internet-> Client

The web server is Windows 2000 running IIS 5.0
The proxy server is Red Hat 7.1, kernel 2.4.5, running Squid 2.4-stable1.
The problem appears on clients running Linux (kernel 2.4.5), Solaris, and
Windows.

The problem is, if I load a page from the web server which is very large
(200k to 500k) and takes a long time to load (20-30 seconds), after some
amount of transmission (usually about 80-100k), the communication stops.
Netstat shows that the web server has sent the remaining data, but the
proxy has stopped sending data.

What I find in the TCP dumps is that at one point the proxy sends two small
(5-byte) packets. Those packets are lost somewhere between the proxy and
the client. After some more data is transmitted, the proxy re-sends the
missing data as one 10-byte packet. This packet is ignored by the client.
The client ignores and dropped any more incoming packets from the server.

>From snort, here are the packets which are lost:

=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+

07/17-14:34:18.391665 65.89.88.135:90 -> 216.158.32.38:10030
TCP TTL:64 TOS:0x0 ID:23851 IpLen:20 DgmLen:57 DF
***AP*** Seq: 0x499CEA40  Ack: 0xA509642A  Win: 0x43E0  TcpLen: 32
TCP Options (3) => NOP NOP TS: 7268336 1992429
3C 2F 44 4C 3E                                   </DL>

=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+

07/17-14:34:18.391665 65.89.88.135:90 -> 216.158.32.38:10030
TCP TTL:64 TOS:0x0 ID:23852 IpLen:20 DgmLen:57 DF
***AP*** Seq: 0x499CEA45  Ack: 0xA509642A  Win: 0x43E0  TcpLen: 32
TCP Options (3) => NOP NOP TS: 7268336 1992429
3C 2F 44 4C 3E                                   </DL>

And here is the re-send packet which is received by the client, but
ignored:

=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+

07/17-14:34:18.681665 65.89.88.135:90 -> 216.158.32.38:10030
TCP TTL:64 TOS:0x0 ID:23872 IpLen:20 DgmLen:62 DF
***AP*** Seq: 0x499CEA40  Ack: 0xA509642A  Win: 0x43E0  TcpLen: 32
TCP Options (3) => NOP NOP TS: 7268365 1992460
3C 2F 44 4C 3E 3C 2F 44 4C 3E                    </DL></DL>

--------------------------------------------------------------------------

If I set /proc/sys/net/ipv4/tcp_retrans_collapse to zero, the problem goes
away. Could this be a bug in the tcp_retrans_collapse() code in the kernel?

I am new to posting on the linux kernel newsgroups, please let me know if
any more information would be helpful, and please reply by E-mail since I
am not subscribed to Linux-kernel.

Sincerely,
Terence Haddock
