Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312802AbSDBPnP>; Tue, 2 Apr 2002 10:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312817AbSDBPnG>; Tue, 2 Apr 2002 10:43:06 -0500
Received: from spoutnik.cartel-securite.net ([194.3.136.16]:17109 "EHLO
	spoutnik.cartel-securite.net") by vger.kernel.org with ESMTP
	id <S312802AbSDBPm4>; Tue, 2 Apr 2002 10:42:56 -0500
Date: Tue, 2 Apr 2002 17:42:54 +0200 (CEST)
From: Phil <biondi@cartel-securite.fr>
To: linux-kernel@vger.kernel.org
Subject: ICMP time exceeded DNAT info leak ?
Message-ID: <Pine.LNX.4.43.0204021742190.8681-100000@deneb.intranet.cartel-securite.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've just seen that a if a linux 2.4 router does DNAT for a port (for ex.)
the ICMP time exceeded packet will take the mangled tcp packet as a
citation and won't un-DNAT the ICMP citation, so that the real IP and port
behind the gateway are revealed.


Ex:

Let's take a machine that does DNAT :
<spoiler>
iptables -t nat -A PREROUTING -p tcp --dport 666 -j DNAT --to 172.16.3.26:22
</spolier>

Then if a host send one side :
hping  -t 1 --syn -p 666  172.16.1.40

This is the icmp packet we get
17:07:46.709230 172.16.1.40 > 172.16.1.28: icmp: time exceeded in-transit [tos
0xc0]
0x0000   45c0 0044 eaa6 0000 ff01 75f1 ac10 0128        E..D......u....(
0x0010   ac10 0118
                   0b00 516d 0000 0000
                                       4500 0028        ......Qm....E..(
0x0020   b0f3 0000 0106 ac8a ac10 0118 ac10 031a <-+    ................
0x0030   04bd 0016 3206 3ec0 0490 00b4 5002 0200   |    ....2.>.....P...
0x0040   d6b2 00^0                                 |    ....
                |                            172.16.3.26
                +-- port 22


I think it should not behave like this. I know some routers does not
see this kind of ICMP packets as related to the connection that trigerred
this error (for obvious reasons).
I've not taken the time to look into the sources yet.


I've just discovered that when making a patch to nmap today to implement a
"ttl scan" (as I've never heard about that technique before, that's how
I called it), so that I complemented the patch to automate this :

pbi@exchange1:~$ sudo ./nmap -sS -P0 mymachine -p 22,23,666,667 -t 9

Starting nmap V. 2.54BETA32 ( www.insecure.org/nmap/ )
Interesting ports on mymachine:
Port       State       Service
22/tcp     open        ssh
23/tcp     filtered    telnet
666/tcp    UNfiltered  doom                     DNAT to 192.168.8.10:22
667/tcp    UNfiltered  unknown                  DNAT to 192.168.26.10:22


Nmap run completed -- 1 IP address (1 host up) scanned in 2 seconds



-- 
Philippe Biondi <biondi@ cartel-securite.fr> Cartel Sécurité
Security Consultant/R&D                      http://www.cartel-securite.fr
Phone: +33 1 44 06 97 94                     Fax: +33 1 44 06 97 99
PGP KeyID:3D9A43E2  FingerPrint:C40A772533730E39330DC0985EE8FF5F3D9A43E2



