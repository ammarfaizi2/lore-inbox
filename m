Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273749AbRIQXU0>; Mon, 17 Sep 2001 19:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273751AbRIQXUQ>; Mon, 17 Sep 2001 19:20:16 -0400
Received: from iere.net.avaya.com ([198.152.12.101]:50395 "EHLO
	iere.net.avaya.com") by vger.kernel.org with ESMTP
	id <S273749AbRIQXUB>; Mon, 17 Sep 2001 19:20:01 -0400
Message-ID: <3BA6852E.ED734E9E@avaya.com>
Date: Mon, 17 Sep 2001 17:20:14 -0600
From: "Bhavesh P. Davda" <bhavesh@avaya.com>
Organization: Avaya, Inc.
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: TCPv4 State Transition questions
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's what's going on...

client & server on two separate hosts, running 2.2.17 kernel.

1. client <-> server connection in ESTABLISHED state
2. kill -TERM server; respawn server
3. client does select(), gets read event, reads 0 bytes
4. client closes socket
5. client creates new socket, tries non-blocking connect()
6. client gets EINPROGRESS, puts socket on write set, does select
7. select says write event
8. client does getsockopt(SOL_SOCKET, SO_ERROR), gets 0
9. client puts socket on read set, does select
10.client gets read event, reads 0 bytes
11.client repeats sequence of steps from step 4.

Running tcpdump on the server end, this is what I see:
a. server -> client: FIN,ACK
b. client -> server: ACK (of FIN)
c. client -> server: FIN, ACK (of FIN again)
d. server -> client: ACK (of client FIN)
e. client -> server: SYN (new src port)
f. server -> client: RST, ACK
e. & f. repeat forever...


Questions:
1. Why did I get a writable event on select, and the getsockopt telling
me that connect() succeeded, when the SYN, SYN-ACK, ACK handshake has
not completed?

2. Why right after that did I get a readable event on the "connected"
socket, telling me that there was EOF to read?

3. Why is the server sending RSTs back to the client, when the client is
trying to connect to the server from different TCP ports every time? The
new server's socket is in LISTEN state, yet I see this happening.

- Bhavesh
-- 
Bhavesh P. Davda
Avaya Inc
Room B3-B16                     E-mail : bhavesh@avaya.com
1300 West 120th Avenue          Phone  : (303) 538-4438
Westminster, CO 80234           Fax    : (303) 538-3155
