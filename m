Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267434AbSLLUHb>; Thu, 12 Dec 2002 15:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265096AbSLLUHb>; Thu, 12 Dec 2002 15:07:31 -0500
Received: from chaos.analogic.com ([204.178.40.224]:64389 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265095AbSLLUH2>; Thu, 12 Dec 2002 15:07:28 -0500
Date: Thu, 12 Dec 2002 15:18:07 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andreani Stefano <stefano.andreani.ap@h3g.it>
cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Kernel bug handling TCP_RTO_MAX?
In-Reply-To: <047ACC5B9A00D741927A4A32E7D01B73D66176@RMEXC01.h3g.it>
Message-ID: <Pine.LNX.3.95.1021212143002.31074A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2002, Andreani Stefano wrote:

> Problem: I need to change the max value of the TCP retransmission timeout. 
> 
> Background: According to Karn's exponential backoff algorithm, when the
> receiver doesn't acknowledge packets for a while, the sender should
> retransmit the latest not acknowledged packet several times increasing
> the delay (RTO) since this delay reaches the Max Retransmission Timeout
> Value. 
> 
> Testing environment: Red Hat Linux release 7.2 (Enigma), Kernel 2.4.7-10
> on an i686, Kernel 2.4.7-10.
> 
> Test details: I supposed this timeout in Linux was TCP_RTO_MAX, so I
> changed in /include/net/tcp.h the following line:
> 
> #define TCP_RTO_MAX	((unsigned)(6*HZ)) //It was: ((unsigned)(120*HZ))
> 
> Then I recompiled the kernel, rebooted the machine and tested the solution.
> The result I obtained was the same I had before this modification. 
> 
> I'm confident there isn't an error in the testing procedure because I
> already tested with a Solaris server the same procedure (changing the
> tcp_rexmit_interval_max variable) and it works. I'm just trying to
> reproduce the modification of that parameter in Linux. 
> 
> Could it be a bug on the RTO calculation algorithm, or there is something
> I mistook?
> 
> This is the first time I get into the linux kernel, so please be patient!
> 
> Thanks,
> 
> Stefano.

No file like /include/net/tcp.h is used in the compilation of the kernel.
Perhaps you mean ../linux-VERS/include/net/tcp.h (make sure you are
not compiling against some user-space headers).

Also, please fix your mailer line-wrap. Unix/Linux machines put '\n'
on or before the 80th character.

Once you check this out, search through that file, looking for "RTO".
There are many things that affect the retransmit interval. FYI the
current algorithm is correct and the minimum time to retransmit must
not be changed if you put this on a "live" network. If you were to
do this, your Linux machine gets an unfair advantage on a congested
network. This may seem great at first, but eventually your machine
will actually need to receive some some data. By taking over the
wire, you will end up with a bunch of hosts that were backed off,
now trying to jam packets into your machine. The result will be
poor performance because many packets will have to be dumped on
the floor, requiring an eventual retransmit. 

Also, remember to install the new kernel before you re-boot. Some
persons forget that they actually have to install the kernel. They
compile it, smile when it completes, then reboot. 

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


