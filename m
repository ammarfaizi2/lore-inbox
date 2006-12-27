Return-Path: <linux-kernel-owner+w=401wt.eu-S932883AbWL0CD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932883AbWL0CD7 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 21:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932885AbWL0CD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 21:03:58 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:42227 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932883AbWL0CD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 21:03:58 -0500
Date: Wed, 27 Dec 2006 03:03:50 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux tcp stack behavior change
Message-ID: <Pine.LNX.4.61.0612270258450.14578@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,


I have been noticing that running nmap -sF on oneself does not generate 
a reply from the TCP stack on 2.6.18(.5). In other words:

# tcpdump -ni lo &
[1] 32376
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on lo, link-type EN10MB (Ethernet), capture size 96 bytes
# nmap localhost -n -sX -p 22
Starting Nmap 4.11 ( http://www.insecure.org/nmap/ ) at 2006-12-27 02:59 CET
02:59:54.199763 IP 127.0.0.1.44431 > 127.0.0.1.22: FP 2987942575:2987942575(0) win 3072 urg 0

and it just sits there. By chance, I found that passing FIN,ACK gives 
the desired effect

# nmap localhost -n -sX -p 22 --scanflags FIN,ACK
Starting Nmap 4.11 ( http://www.insecure.org/nmap/ ) at 2006-12-27 03:01 CET
03:01:28.847871 IP 127.0.0.1.34140 > 127.0.0.1.22: F 935914709:935914709(0) ack 1975786655 win 4096
03:01:28.847943 IP 127.0.0.1.22 > 127.0.0.1.34140: R 1975786655:1975786655(0) win 0
Interesting ports on 127.0.0.1:
PORT   STATE  SERVICE
22/tcp closed ssh
Nmap finished: 1 IP address (1 host up) scanned in 0.071 seconds

However, I know that plain -sF worked with previous kernels. Using 
nmap-4.00 on 2.6.18.5 yields the same result, so I do not think it is 
caused by a change in nmap code. Could someone with 2.6.13-2.6.17 verify 
that the TCP stack returned a RST? Or perhaps someone else actually 
knows there was a change in the linux kernel to cause the now-observed 
behavior.


Thanks,
Jan
-- 
