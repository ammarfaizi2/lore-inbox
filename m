Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130615AbRARM6B>; Thu, 18 Jan 2001 07:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135433AbRARM5w>; Thu, 18 Jan 2001 07:57:52 -0500
Received: from chiara.elte.hu ([157.181.150.200]:64018 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130138AbRARM5j>;
	Thu, 18 Jan 2001 07:57:39 -0500
Date: Thu, 18 Jan 2001 13:56:55 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Rick Jones <raj@cup.hp.com>, Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <Pine.LNX.4.30.0101171231420.16292-100000@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.30.0101181345020.823-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 Jan 2001, dean gaudet wrote:

> with the linux TCP_CORK API you only get one trailing small packet.
> in case you haven't heard of TCP_CORK -- when the cork is set, the
> kernel is free to send any maximum size packets it can form, but has
> to hold on to the stragglers until userland gives it more data or pops
> the cork.

TCP_CORK has been basically replaced by MSG_MORE these days. The problem
with the cork approach is that it's a persistent socket flag - and it
easily triggers programming errors when the application writer tracks the
state of the cork incorrectly. Also, removing the cork is one extra
system-call. So what you can do with MSG_MORE is to specify at
sendmsg()/writev() time, whether at the end of the buffer there is a cork
or not.

this is what TUX uses. When a eg. static HTTP request arrives it sends
reply headers shortly after having checked file permissions and stuff (but
the file is not yet sent), with MSG_MORE set. Then it sends the file, and
sendfile() keeps MSG_MORE set right until the end of the request, when it
clears it for the last fragment so the last partial packet gets flushed to
the network. In fact there is one more optimization here, if the request
is not keepalive then TUX still kees MSG_MORE set, and closes the socket -
which will implicitly flush the output queue anyway and send any partial
packet, but will also have the FIN packet merged with the last outgoing
packet.

(if there is saturation then further merging might happen as well - if a
sendmsg() comes before a partial, but already xmit-queued packet is sent,
then the TCP layer merges this sendmsg() output with the outgoing packet.)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
