Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130003AbQLATBv>; Fri, 1 Dec 2000 14:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130027AbQLATBm>; Fri, 1 Dec 2000 14:01:42 -0500
Received: from cliff.mcs.anl.gov ([140.221.9.17]:54147 "EHLO mcs.anl.gov")
	by vger.kernel.org with ESMTP id <S130003AbQLATB2>;
	Fri, 1 Dec 2000 14:01:28 -0500
Message-ID: <3A27EDF5.6060609@mcs.anl.gov>
Date: Fri, 01 Dec 2000 12:29:09 -0600
From: JP Navarro <navarro@mcs.anl.gov>
Organization: Argonne National Laboratory
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; m18) Gecko/20001108 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IP fragmentation (DF) and ip_no_pmtu_disc in 2.2 vs 2.4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.2.17 when /proc/sys/net/ipv4/ip_no_pmtu_disc is 0/false we're 
seeing outbound udp packets with the IP DF (don't fragment) bit clear. 
With 2.4.0-test11, when ip_no_pmtu_disc is still 0/false we're seeing 
outbound udp packets with the IP DF bit set.  Is this change in default 
behavior a fix or a break?

[start non expert thinking]
ip_no_pmtu_disc = 0/false means that we DO want MTU discovery.
ip_no_pmtu_disc = 1/true means that we DON't want MTU discovery.
to do MTU discovery you want DF set, so if fragmenting is necessary to 
reach your target you get an unreachable error and can try smaller MTUs.

So, it appears that 2.4 fixed a problem with 2.2, correct?
[stop non expert thinking]

The problem that led us to notice this behavior was:

Intel PXE uses tftp to download boot images and discards IP packets with 
the DF bit set; so a tftpd server on 2.4 with the default 
ip_no_pmtu_disc set to 0/false can't serve tftp to PXE. Changing 
ip_no_pmtu_disc to 1/true "fixes it". One problem is that we'd rather 
have our tftpd server w/ 2.4 configured for mtu discovery.

We've tried to setsockopt(sock, SOL_IP, IP_MTU_DISCOVER, ...) with the 
IP_PMTUDISC_DONT option but can't make it work. How does one change MTU 
discovery and/or the don't fragment bit on a single socket?


JP Navarro
-- 
John-Paul Navarro                                      (630) 252-1233
Mathematics & Computer Science Division
Argonne National Laboratory                       navarro@mcs.anl.gov
Argonne, IL 60439                     http://www.mcs.anl.gov/~navarro

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
