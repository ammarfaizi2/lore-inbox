Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318886AbSHMAP4>; Mon, 12 Aug 2002 20:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318888AbSHMAP4>; Mon, 12 Aug 2002 20:15:56 -0400
Received: from p3E9EA9E9.dip.t-dialin.net ([62.158.169.233]:52618 "EHLO
	santana.vm.dabrunz.de") by vger.kernel.org with ESMTP
	id <S318886AbSHMAPz>; Mon, 12 Aug 2002 20:15:55 -0400
Date: Tue, 13 Aug 2002 02:19:44 +0200
From: Olaf Dabrunz <Olaf.Dabrunz@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: TCP/IP connection setup using ECN: interaction with firewall problems
Message-ID: <20020813021944.A11951@santana.vm.dabrunz.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I am using the explicit congestion notification feature by switching it on
with "echo 1 >/proc/sys/net/ipv4/tcp_ecn". Usually this works fine. But
there are certain hosts whose firewalls consider the ECN flags to be an
indicator for a scan or attack. This (mis-)behaviour has also been
described in the standards track protocol definition for ECN, RFC 3168. 

Though the firewalls are the faulty components (see RFC 3168), my
experience with similar problems (server-side firewalls that drop all ICMP
packets, causing a loss of service to clients with a smaller MTU than the
server) has shown that these kinds of firewall problems are difficult to
overcome on the firewall configuration side (it seems this is due to lack
of time and/or problem-awareness of the administrators).

In order to still work together with such hosts, RFC 3168 section 6.1.1.1
suggests a change in behaviour of the ECN-capable clients. It states that

   A host that receives no reply to an ECN-setup SYN within the normal
   SYN retransmission timeout interval MAY resend the SYN and any
   subsequent SYN retransmissions with CWR and ECE cleared.  To overcome
   normal packet loss that results in the original SYN being lost, the
   originating host may retransmit one or more ECN-setup SYN packets
   before giving up and retransmitting the SYN with the CWR and ECE bits
   cleared.

Also, in case the firewall responds to an ECN-setup SYN by sending a
packet with the RST flag set, it states that

   [...] a host that receives a RST in response to the transmission
   of an ECN-setup SYN packet MAY resend a SYN with CWR and ECE cleared.
   This could result in a TCP connection being established without using
   ECN.

I actually experience the first problem stated above. The tpcdump trace
below shows what happens when I try to connect to www.nvidia.com.

19:10:37.192791 123.45.67.89.34342 > 209.213.198.80.http: S [ECN-Echo,CWR] 2222688860:2222688860(0) win 5808 <mss 1452,sackOK,timestamp 15670700,nop,wscale 0> (DF)
19:10:40.183059 123.45.67.89.34342 > 209.213.198.80.http: S [ECN-Echo,CWR] 2222688860:2222688860(0) win 5808 <mss 1452,sackOK,timestamp 15673700,nop,wscale 0> (DF)
19:10:46.183270 123.45.67.89.34342 > 209.213.198.80.http: S [ECN-Echo,CWR] 2222688860:2222688860(0) win 5808 <mss 1452,sackOK,timestamp 15679700,nop,wscale 0> (DF)
19:10:58.183715 123.45.67.89.34342 > 209.213.198.80.http: S [ECN-Echo,CWR] 2222688860:2222688860(0) win 5808 <mss 1452,sackOK,timestamp 15691700,nop,wscale 0> (DF)

AFAICS from the kernel ChangeLogs Linux versions 2.4.* and 2.5.* do not
implement the interoperability features described above. Is that correct?
Is someone working on a patch that implements these features?

Thanks, Olaf.

