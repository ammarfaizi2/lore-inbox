Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264879AbRFUHhJ>; Thu, 21 Jun 2001 03:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264927AbRFUHg7>; Thu, 21 Jun 2001 03:36:59 -0400
Received: from mailserv.intranet.GR ([146.124.14.106]:60305 "EHLO
	mailserv.intranet.gr") by vger.kernel.org with ESMTP
	id <S264879AbRFUHgq>; Thu, 21 Jun 2001 03:36:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: anpol <anpol@intracom.gr>
Organization: INTRACOM S.A.
To: linux-kernel@vger.kernel.org
Subject: State changes for T/TCP
Date: Thu, 21 Jun 2001 10:39:14 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01062110391402.00804@patdpd21.intranet.gr>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I am trying to implement T/TCP in linux 2.2.14. I am using a Linux box as a 
client and a FreeBSD box as server. I have the following problem:

I send multiple data packets from the client, the sequence looks like this:

1. Client sends syn with data <SYN, PSH> 
2. Client sends data <PSH>
3. Client sends data along with its fin <FIN, PSH>
4. Server sends synack <SYN, ACK>
....................................
5. Server sends his data and finishes <FIN, PSH, ACK>
6. Client acks the data <ACK>
7. Server sends fin again <FIN, ACK>
8. Client sends reset <RST>

My problem is in segment 8. In segment 5 the client is already in FIN_WAIT2 
since the server acked his fin (client's fin in segment 3) in previous 
segments (shown with dots), and when he gets the fin from the server he acks 
(segment 6) it and gets in TIME_WAIT (tcp_time_wait() in 2.2.14). But in 
tcp_time_wait() the original socket gets linked to another socket-like 
structure and then gets closed (CLOSE). Now, when the segment 7 arrives it is 
dropped by the client (since its socket is in CLOSE state) and a RST is send 
back. But what should happen in T/TCP is that in segment 8 i should have an 
ACK for the FIN in segment 7. 
My question now (provided that all that i have mentioned before are correct) 
is: Should i change the above behaviour of original TCP? If i leave the 
socket in TIME_WAIT instead of CLOSE, would that require further changes?

Thank you all in advance
Tasos

p.s. please CC your e-mail to my address (anpol@intracom.gr)
