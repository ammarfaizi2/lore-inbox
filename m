Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269332AbRHCHAg>; Fri, 3 Aug 2001 03:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269333AbRHCHA1>; Fri, 3 Aug 2001 03:00:27 -0400
Received: from cube1.cubit.at ([194.163.15.68]:40970 "EHLO cube1.cubit.at")
	by vger.kernel.org with ESMTP id <S269332AbRHCHAT>;
	Fri, 3 Aug 2001 03:00:19 -0400
Date: Fri, 3 Aug 2001 09:00:26 +0200
From: Philipp Reisner <philipp.reisner@cubit.at>
To: linux-kernel@vger.kernel.org
Subject: tcp connection hangs on connect
Message-ID: <20010803090026.C31230@cubit.at>
Reply-To: Philipp Reisner <philipp.reisner@cubit.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: CUBiT
X-PGP-Key: http://www.ist.org/~kde/mykey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have discovered here something that causes TCP connections to
hang if one of the initial packets is lost.

We have a script which runs scp every 10 seconds, and the script
simply hangs after some minutes to an hour. The script runs on
a Linux-2.2.19 Box (we have also tested Linux-2.4.2) and the ssh server
is running on some Windows box.

Here is the good case:

15:26:11.100413 192.168.53.4.4819 > 212.31.78.62.22: S 2626815412:2626815412(0) +win 16060 <mss 1460,sackOK,timestamp 809461847[|tcp]> (DF)
15:26:11.119964 212.31.78.62.22 > 192.168.53.4.4819: S 3560917622:3560917622(0) +ack 2626815413 win 17520 <mss 1460,nop,wscale 0,nop,nop,timestamp[|tcp]> (DF)
15:26:11.120011 192.168.53.4.4819 > 212.31.78.62.22: . ack 1 win 16060 +<nop,nop,timestamp 809461848 0> (DF)
15:26:11.228046 212.31.78.62.22 > 192.168.53.4.4819: P 1:24(23) ack 1 win 17520 +<nop,nop,timestamp 6062108 809461848> (DF)

Here is the hang:

12:01:24.753703 192.168.53.4.4442 > 212.31.78.62.22: S 2538486974:2538486974(0) +win 16060 <mss 1460,sackOK,timestamp 808233194[|tcp]> (DF)
12:01:24.798610 212.31.78.62.22 > 192.168.53.4.4442: S 3871618076:3871618076(0) +ack 2538486975 win 17520 <mss 1460,nop,wscale 0,nop,nop,timestamp[|tcp]> (DF)
12:01:24.798729 192.168.53.4.4442 > 212.31.78.62.22: . ack 1 win 16060 +<nop,nop,timestamp 808233198 0> (DF)
12:01:28.048197 212.31.78.62.22 > 192.168.53.4.4442: S 3871618076:3871618076(0) +ack 2538486975 win 17520 <mss 1460,nop,wscale 0,nop,nop,timestamp[|tcp]> (DF)
12:01:34.611132 212.31.78.62.22 > 192.168.53.4.4442: S 3871618076:3871618076(0) +ack 2538486975 win 17520 <mss 1460,nop,wscale 0,nop,nop,timestamp[|tcp]> (DF)

192.168.53.4: Is the Linux box.
212.31.78.62: Is the Windows box.

It looks like that the packet at 12:01:24.798729 never reaches the Windows
box. Ok -- That is probabely why the Windows box resends it's syn packet
(at 12:01:28.048197 and 12:01:34.611132).

BTW, the Linux box is convinced that the connection is established
(confirmed with lsof), while the Windows box probabely does not think
that there is a connection.

The question is, why is Linux not responding to the resent syn packets ?

PS: the process (scp/ssh) on the Linux side of the connection wants
    to read from the socket (confirmed with strace).

-Philipp


