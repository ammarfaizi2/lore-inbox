Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132151AbRDJVTw>; Tue, 10 Apr 2001 17:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132127AbRDJVTn>; Tue, 10 Apr 2001 17:19:43 -0400
Received: from elf.ihep.su ([194.190.161.106]:37617 "EHLO fay.elferno.lo")
	by vger.kernel.org with ESMTP id <S132151AbRDJVT3>;
	Tue, 10 Apr 2001 17:19:29 -0400
Date: Wed, 11 Apr 2001 01:19:01 +0400
From: "Eugene B. Berdnikov" <berd@elf.ihep.su>
To: kuznet@ms2.inr.ac.ru
Cc: "Eugene B. Berdnikov" <berd@elf.ihep.su>, linux-kernel@vger.kernel.org,
        Dave Miller <davem@redhat.com>
Subject: Re: Bug report: tcp staled when send-q != 0, timers == 0.
Message-ID: <20010411011901.A2029@fay.elferno.lo>
In-Reply-To: <20010409184338.B1396@elf.ihep.su> <200104101738.VAA21467@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104101738.VAA21467@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Tue, Apr 10, 2001 at 09:38:43PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello.

On Tue, Apr 10, 2001 at 09:38:43PM +0400, kuznet@ms2.inr.ac.ru wrote:
> If my guess is right, you can easily put this socket to funny state
> just catting a large file and kill -STOP'ing ssh. ssh will close window,
> but sshd will not send zero probes.

 [1] I have checked your statement on 2 different machines, running 2.2.17.
 No confirmation. But this is much more funny than it simply sounds. :)

 The thing is that one machine (which run ssh client in my bug report)
 do send ACKs when ssh is SIGSTOP'ed. The other one does not send ACKs,
 but much more curious is that it does not send ACKs even when input
 buffer is filled, and client IS NOT stopped! :))) Hence connection dies
 due to retransmission timeout on the server side.

 I did not believe my own eyes and tried this test several times, with
 ssh1 and openssh, copying ssh configs, but results were always the same.

 Both hosts are running 2.2.17 on K6 processors, compiled via egcs-1.1.2,
 with minor differences in the kernel configuration. If you really check
 your statements before writing, you surely have a 2.2.17 which behave some
 another way, which I can't reproduce. Isn't funny? :)))

 I can send configs (and even binary kernels with modules) for verification.
 If this is not a complete fault, we have a very-very sad situation, when
 tcp core behaviour depends on the secondary configuration options.
 I have no other ideas how it can be explained.

 [2] Your second statement is that sshd with keepalive enabled does not send
 zero probes when input window is closed. Be sure, in my case it sends:

 01:04:05.025715 194.190.166.31.22 > 194.190.161.106.1006: . ack 1 win 32120 <nop,nop,timestamp 117938386 1780393243> (DF) [tos 0x10]
 01:04:05.025816 194.190.161.106.1006 > 194.190.166.31.22: . ack 17376 win 0 <nop,nop,timestamp 1780405324 117898941> (DF) [tos 0x10]
 01:06:05.953026 194.190.166.31.22 > 194.190.161.106.1006: . ack 1 win 32120 <nop,nop,timestamp 117950477 1780405324> (DF) [tos 0x10]
 01:06:05.953122 194.190.161.106.1006 > 194.190.166.31.22: . ack 17376 win 0 <nop,nop,timestamp 1780417417 117898941> (DF) [tos 0x10]

 BTW, I strongly rule out a possibility to stop my ssh client when I
 encounter the reported bug.

> Any socket with keepalives enabled
> enters this state after the first keepalive is sent.

 I do not understand how connection with closed window can wait until
 first keepalive - it must do zero probes instead.

> [ Note, that it is not Butenko's problem, it is still to be discovered. 8) ]
> 
> I think you will not able to reproduce full problem: socket will revive
> after the first received ACK. It is another bug and its probability is
> astronomically low.

 Hmm... I observed this bug on the host, which never performs more
 than 10 conn/sec and has peak loadvg ~ 0.15.
-- 
 Eugene Berdnikov
