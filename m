Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266132AbUFILeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266132AbUFILeT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 07:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266126AbUFILeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 07:34:19 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:13066 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265736AbUFILeO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 07:34:14 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: netdev@oss.sgi.com, linux-net@vger.kernel.org
Subject: UDP sockets bound to ANY send answers with wrong src ip address
Date: Wed, 9 Jun 2004 14:25:39 +0300
X-Mailer: KMail [version 1.4]
Cc: davem@redhat.com, yoshfuji@linux-ipv6.org, pekkas@netcore.fi,
       jmorris@redhat.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200406091425.39324.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I observe that UDP sockets listening on ANY
send response packets with ip addr derived from
ip address of interface which is used to send 'em
instead of using dst ip address of client's packet.

I was bitten by this with DNS and NTP.

This is a test setup:

{net 172.16/16}----- 172.16.22.2 [multihomed] 195.66.192.167 ----....

This is a UDP server on multihomed box:
# echo test | nc -vvvnu -l -p 222
listening on [any] 222 ...
connect to [172.16.22.2] from (UNKNOWN) [172.16.42.177] 333
ping
 sent 5, rcvd 5 : Connection refused
#

This is client on 172.16.42.177:
# echo ping | nc -vvvnu -p 333 195.66.192.167 222
(UNKNOWN) [195.66.192.167] 222 (?) open

it waits forever, never getting 'test' string from server.

This is a tcpdump of this event:
13:58:00.555207 172.16.42.177.333 > 195.66.192.167.222: udp 5 (DF)
13:58:00.559849 172.16.22.2.222 > 172.16.42.177.333: udp 5 (DF)
                ^^^^^^^^^^^
13:58:00.560457 172.16.42.177 > 172.16.22.2: icmp: 172.16.42.177 udp port 333 unreachable [tos 0xc0]

This is why 172.16.42.177 thinks that port 333 is unreachable:
# lsof -nP | grep 333
ntpd        418   root  mem    REG        3,4   133316      68184 /.share/usr/lib/all-lib/libreadline.so.3.0
most       7559   root  txt    REG        3,4    46828      24333 /.share/usr/app/most-4.9.2/bin/most
nc        15085   root    3u  IPv4      29381                 UDP 172.16.42.177:333->195.66.192.167:222
#                                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

kernel does not think that 172.16.22.2.222 > 172.16.42.177.333 packet
belong to this socket, and it is right imo.

Test works ok if I remove -u from both netcats (i.e. TCP works).

client:
# uname -a
Linux firebird 2.6.6-rc1-bk1 #1 Wed May 26 11:03:11 EEST 2004 i686 unknown

server:
# uname -a
Linux oldie 2.4.22-rc2_QoS #1 Tue Nov 18 15:55:00 GMT-2 2003 i586 unknown
root@oldie:/.share/home/vda#

I saw this behavior on 2.6 based machines as well.
-- 
vda
