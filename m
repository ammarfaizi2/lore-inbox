Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbVLYPQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbVLYPQQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 10:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbVLYPQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 10:16:16 -0500
Received: from rain.plan9.de ([193.108.181.162]:17837 "HELO rain.plan9.de")
	by vger.kernel.org with SMTP id S1750837AbVLYPQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 10:16:15 -0500
Date: Sun, 25 Dec 2005 16:16:11 +0100
From: Marc Lehmann <schmorp@schmorp.de>
To: linux-kernel@vger.kernel.org
Subject: read returns EAGAIN on a _blocking_ socket, but should not?
Message-ID: <20051225151611.GA20443@schmorp.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP: "1024D/DA743396 1999-01-26 Marc Alexander Lehmann <schmorp@schmorp.de>
       Key fingerprint = 475A FE9B D1D4 039E 01AC  C217 A1E8 0270 DA74 3396"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The SuS documents EAGAIN for read(2) as:

   [EAGAIN]
       The O_NONBLOCK flag is set for the file descriptor and the thread would
       be delayed.

And the linux manpage for read(2) says something similar. Yet, I do get
EAGAIN when reading from a blocking socket. Here is a short strace:

   socket(PF_FILE, SOCK_STREAM, 0)         = 3
   connect(3, {sa_family=AF_FILE, path="/serv"}, 110) = 0
   write(3, "\0\3", 2)                     = 2
   write(3, "NEW", 3)                      = 3
... many writes and reads omitted
   sendmsg(3, {msg_name(0)=NULL, msg_iov(1)=[{"\0", 1}], msg_controllen=20, {cmsg_len=20, cmsg_level=SOL_SOCKET, cmsg_type=SCM_RIGHTS, {3}}, msg_flags=MSG_OOB|MSG_DONTROUTE}, 0)                            = 1
   read(3, "\0\3", 2)            = 2
   read(3, 0x51d030, 3)           = -1 EAGAIN (Resource temporarily unavailable)
   write(2, "protocol error: unexpected eof f"..., 44)                 = 44

(the sendmsg call in the source, incidentally, specifies "0" as flags
argument, not MSG_OOB|MSG_DONTROUTE, but this is likely irrelevant).

Here is the server side for the last exchange above:

   recvmsg(9, {msg_name(0)=NULL, msg_iov(1)=[{"\0", 1}], msg_controllen=24, {cmsg_len=20, cmsg_level=SOL_SOCKET, cmsg_type=SCM_RIGHTS, {10}}, msg_flags=0}, 0) = 1
... ioctls on other fds omitted
   write(9, "\0\3", 2) = 2
   write(9, "END", 3) = 3

Now, the first backtrace creates a unix domain socket, connects to an
existing one, passes a file descriptor and then read() returns with
EAGAIN. Nowhere does it set the socket to blocking.

The full backtraces can be found as http://data.plan9.de/x.20407 (client
getting EAGAIN) and at http://data.plan9.de/x.20406 (server writing).

I am looking for the obvious logical error I made, but I can only
come up with the conclusion that read returning EAGAIN on a blocking
socket must be a kernel bug. It is also interesting that this code and
the server/client exchanges worked reliably _until_ I started to pass
filehandles from client to server.

I am using linux 2.6.14 on x86_64.

Thanks for your time and any insights you can give!

-- 
                The choice of a
      -----==-     _GNU_
      ----==-- _       generation     Marc Lehmann
      ---==---(_)__  __ ____  __      pcg@goof.com
      --==---/ / _ \/ // /\ \/ /      http://schmorp.de/
      -=====/_/_//_/\_,_/ /_/\_\      XX11-RIPE
