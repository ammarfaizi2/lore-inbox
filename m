Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132626AbRDKQga>; Wed, 11 Apr 2001 12:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132627AbRDKQgU>; Wed, 11 Apr 2001 12:36:20 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:38927 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S132626AbRDKQgC>;
	Wed, 11 Apr 2001 12:36:02 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200104111635.UAA08446@ms2.inr.ac.ru>
Subject: Re: Bug report: tcp staled when send-q != 0, timers == 0.
To: berd@elf.ihep.su (Eugene B. Berdnikov)
Date: Wed, 11 Apr 2001 20:35:51 +0400 (MSK DST)
Cc: berd@elf.ihep.su, linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <20010411011901.A2029@fay.elferno.lo> from "Eugene B. Berdnikov" at Apr 11, 1 01:19:01 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > If my guess is right, you can easily put this socket to funny state
> > just catting a large file and kill -STOP'ing ssh. ssh will close window,
> > but sshd will not send zero probes.
> 
>  [1] I have checked your statement on 2 different machines, running 2.2.17.
>  No confirmation. But this is much more funny than it simply sounds. :)

_That_ socket which was stuck must show this behaviour.

To get this on new socket you should leave session idle for >2hours
until the first keeplaive. After this it will never probe under
any curcumstances. The bug was that keepalive corrupts state of timer
and probe0 timer is not started after this.


>  buffer is filled, and client IS NOT stopped! :))) Hence connection dies
>  due to retransmission timeout on the server side.

It is known linuxism. If the ratio connection_mss/link_mtu less than ~1/4
or connection is flood with tiny packets, after rcvbuf is full linux
enters memory paranoia mode pretending that all the packets are lost.
Ugly, unpleasant, but luckily harmless under any normal curcumstances.

One way to workaround is to set rx_copybreak on ethernet drivers to 400-500.

The bug is really difficult. It is not cured even in current 2.4
(only with zerocopy patch).


>  I do not understand how connection with closed window can wait until
>  first keepalive - it must do zero probes instead.

If socket has ever sent keepalive, it will not be able to send zero window
probes after this.


>  Hmm... I observed this bug on the host, which never performs more
>  than 10 conn/sec and has peak loadvg ~ 0.15.

8)8)8) Probability is probability.

Alexey
