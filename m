Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264375AbRFOMou>; Fri, 15 Jun 2001 08:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264376AbRFOMok>; Fri, 15 Jun 2001 08:44:40 -0400
Received: from picard.csihq.com ([204.17.222.1]:38299 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S264375AbRFOMo1>;
	Fri, 15 Jun 2001 08:44:27 -0400
Message-ID: <025c01c0f598$f04d0f30$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "Robert Kleemann" <robert@kleemann.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0106142028150.1149-100000@localhost.localdomain>
Subject: Re: Client receives TCP packets but does not ACK
Date: Fri, 15 Jun 2001 08:44:36 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the end of my run -- I assume this means my config works OK?
I'm on a dual PIII/600 linux-2.4.6-pre3 -- ran it all on the local host.

received msg#90, name pad1, 1 blocks, 12 total bytes
received msg#91, name pad1, 1 blocks, 12 total bytes
received msg#92, name class tande.server.ClientMap, 1624 blocks, 3244 total
bytes
received msg#93, name pad1, 1 blocks, 12 total bytes
received msg#94, name pad1, 1 blocks, 12 total bytes
received msg#95, name pad1, 1 blocks, 12 total bytes
received msg#96, name class tande.server.ClientMap, 1624 blocks, 3244 total
bytes
successfully read all blocks

I'm concerned that you're probably just overruning your IP stack:
      foreach $block (@blocks) {
        print $client $block;
        $bytes += length($block);
      }

TCP is NOT a guaranteed protocol -- you can't just blast data from one port
to another and expect it to work.
a tcp-write is NOT guaranteed -- and as you've seen -- a recv() isn't either
(that's why you need timeouts).
You're probably overrunning the tcp buffer on your "print" statement and
truncating a block.
I don't see where you're checking for        EAGAIN or EWOULDBLOCK (see man
send).
Not real sure how to do this in perl...


You need a layer-7 protocol that will guarantee your transactions -- once
you're client acks/naks your server I'll bet everything works hunky-dory.
If you're not familiar with the OSI model
http://www.csihq.com/~mike/students/networking/iso/isomodel.html
________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355
----- Original Message -----
From: "Robert Kleemann" <robert@kleemann.org>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, June 14, 2001 11:50 PM
Subject: Re: Client receives TCP packets but does not ACK


A couple people have requested a test case.

The problem first showed up in a very large java app.  Since then I
wrote a small perl program to duplicate the behavior of the large app
by sending the same data, in the same order, in the same sized blocks,
from the server to the client.

If you want to test this on your configuration then download the
following two files:
http://www.kleemann.org/crap/clientserver
http://www.kleemann.org/crap/log1e1.txt

Place a copy of the files in the same directory on both the client and
the server and run the program the following way:

[server]$ ./clientserver -s log1e1.txt
listening on port 20001

[client]$ ./clientserver -c serverhostname log1e1.txt

The server will attempt to send the data to the client which then
verifies each byte received.

My client generally stops ack-ing between messages 15 and 25.

Robert.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

