Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314707AbSFGCRc>; Thu, 6 Jun 2002 22:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSFGCRb>; Thu, 6 Jun 2002 22:17:31 -0400
Received: from pc132.utati.net ([216.143.22.132]:41638 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S314707AbSFGCRa>; Thu, 6 Jun 2002 22:17:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: linux-kernel@vger.kernel.org
Subject: Obscure networking question (shutdown on socket WITHOUT discarding data...)
Date: Thu, 6 Jun 2002 16:19:08 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020607024846.81BF37C8@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a way to call shutdown(blah, SHUT_WR) on a network SOCK_STREAM 
connection's fd without discarding pending output?  Or some way to block 
until pending output has been acknowledged by the far end?  (There's a TCP/IP 
acknowledgement packet being sent, I'm fairly certain of this...)

I want the connection at the far end to get EOF from read, but still be able 
to send me data back from the other half of the connection.

I've looked at the BSD networking documentation, the source code to "netcat", 
all the man pages I could find, asked google, etc.  The 2.4.18 net/ipv4/tcp.c 
source has some interesting comments (line 396) about poll not having a 
notion of HUP in just one direction, but I've gathered that select and poll 
behave differently on files, pipes, network sockets, block devices, etc...  
In any case, this doesn't help me find an exported user-space API that might 
help me implement this behavior.  (By the way, is "PULLHUP" on lines 414 and 
417 a typo for "POLLHUP", or not?)

There doesn't seem to be any variant of a blocking flush() call on a socket 
(that I can find), or a way to tell shutdown() to wait for pending output the 
way a normal close() does.  (Maybe I can do something fancy with poll or 
select?)

If there IS no way to do this, why does shutdown(2) bother taking a second 
argument?

(Maybe I can disable nagle and then do a write of length zero, to make the 
other end unblock with a read of length zero and THINK the stream's done?  
Probably won't work, but it's worth a try...)

Rob

(P.S.  yes I can rewrite the protocol being sent over the wire to signal EOF 
in-band (yet again) but this keeps coming up over and over.  Processes that 
work when stdin and stdout are seperate file handles don't work when the data 
goes back and forth through a network socket...)
