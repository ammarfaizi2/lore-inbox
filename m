Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143376AbREKT5r>; Fri, 11 May 2001 15:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143372AbREKT5i>; Fri, 11 May 2001 15:57:38 -0400
Received: from zeus.kernel.org ([209.10.41.242]:19341 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S143377AbREKT5W>;
	Fri, 11 May 2001 15:57:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Brad Pepers <brad@linuxcanada.com>
Organization: Linux Canada Inc.
To: linux-kernel@vger.kernel.org
Subject: Loopback TCP timer bug?
Date: Fri, 11 May 2001 13:15:58 -0600
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01051113155804.17685@dragon.linuxcan.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a problem where a client and server stop talking to each other after 
around 32 minutes.  The server is sending a packet to the client every minute 
with 4 bytes but the client is in a GUI loop and isn't receiving them.  They 
should just build up in the Recv-Q for the client but after 32 minutes they 
stop going to the client and instead they stay in the Send-Q of the server.  
A timer is also started on the server socket so that after 15 times 
(tcp_retries2) of attempting to send, it returns back ETIMEDOUT and the 
server exits.

A tcpdump shows that the server is sending the 4 byte packet every minute but 
that after 32 minutes, the client stops acking them.  Why would it do that?

This is all using localhost and the Recv-Q of the client only ends up with 
124 bytes of data in it so I don't think its buffer is filling.  The problem 
doesn't seem to exist on the 2.4.x kernels and only occurs on systems using 
the 2.2.x kernels.  Was there a fix along the way for this?

Here is the last bit of the tcpdump:

18:06:11.135201 localhost.localdomain.gds_db > localhost.localdomain.3139: P 
16:20(4) ack 1 win 31072 (DF) (ttl 64, id 41071)
18:06:11.135201 localhost.localdomain.gds_db > localhost.localdomain.3139: P 
16:20(4) ack 1 win 31072 (DF) (ttl 64, id 41071)
18:06:11.154090 localhost.localdomain.3139 > localhost.localdomain.gds_db: . 
ack 20 win 30952 (DF) (ttl 64, id 41072)
18:06:11.154090 localhost.localdomain.3139 > localhost.localdomain.gds_db: . 
ack 20 win 30952 (DF) (ttl 64, id 41072)
18:07:11.131571 localhost.localdomain.gds_db > localhost.localdomain.3139: P 
20:24(4) ack 1 win 31072 (DF) (ttl 64, id 41073)
18:07:11.131571 localhost.localdomain.gds_db > localhost.localdomain.3139: P 
20:24(4) ack 1 win 31072 (DF) (ttl 64, id 41073)
18:07:11.151759 localhost.localdomain.3139 > localhost.localdomain.gds_db: . 
ack 24 win 30948 (DF) (ttl 64, id 41074)
18:07:11.151759 localhost.localdomain.3139 > localhost.localdomain.gds_db: . 
ack 24 win 30948 (DF) (ttl 64, id 41074)
18:08:11.128095 localhost.localdomain.gds_db > localhost.localdomain.3139: P 
24:28(4) ack 1 win 31072 (DF) (ttl 64, id 41075)
18:08:11.128095 localhost.localdomain.gds_db > localhost.localdomain.3139: P 
24:28(4) ack 1 win 31072 (DF) (ttl 64, id 41075)
18:08:11.331289 localhost.localdomain.gds_db > localhost.localdomain.3139: P 
24:28(4) ack 1 win 31072 (DF) (ttl 64, id 41076)
18:08:11.331289 localhost.localdomain.gds_db > localhost.localdomain.3139: P 
24:28(4) ack 1 win 31072 (DF) (ttl 64, id 41076)
18:08:11.725170 localhost.localdomain.gds_db > localhost.localdomain.3139: P 
24:28(4) ack 1 win 31072 (DF) (ttl 64, id 41077)
18:08:11.725170 localhost.localdomain.gds_db > localhost.localdomain.3139: P 
24:28(4) ack 1 win 31072 (DF) (ttl 64, id 41077)
18:08:12.529711 localhost.localdomain.gds_db > localhost.localdomain.3139: P 
24:28(4) ack 1 win 31072 (DF) (ttl 64, id 41078)
18:08:12.529711 localhost.localdomain.gds_db > localhost.localdomain.3139: P 
24:28(4) ack 1 win 31072 (DF) (ttl 64, id 41078)
18:08:14.133679 localhost.localdomain.gds_db > localhost.localdomain.3139: P 
24:28(4) ack 1 win 31072 (DF) (ttl 64, id 41079)
18:08:14.133679 localhost.localdomain.gds_db > localhost.localdomain.3139: P 
24:28(4) ack 1 win 31072 (DF) (ttl 64, id 41079)
18:08:17.326826 localhost.localdomain.gds_db > localhost.localdomain.3139: P 
24:28(4) ack 1 win 31072 (DF) (ttl 64, id 41080)
18:08:17.326826 localhost.localdomain.gds_db > localhost.localdomain.3139: P 
24:28(4) ack 1 win 31072 (DF) (ttl 64, id 41080)
18:08:23.726980 localhost.localdomain.gds_db > localhost.localdomain.3139: P 
24:28(4) ack 1 win 31072 (DF) (ttl 64, id 41081)
18:08:23.726980 localhost.localdomain.gds_db > localhost.localdomain.3139: P 
24:28(4) ack 1 win 31072 (DF) (ttl 64, id 41081)
18:08:36.527097 localhost.localdomain.gds_db > localhost.localdomain.3139: P 
24:28(4) ack 1 win 31072 (DF) (ttl 64, id 41082)
18:08:36.527097 localhost.localdomain.gds_db > localhost.localdomain.3139: P 
24:28(4) ack 1 win 31072 (DF) (ttl 64, id 41082)

-- 
Brad Pepers
brad@linuxcanada.com
