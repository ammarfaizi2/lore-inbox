Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129638AbRB0KHK>; Tue, 27 Feb 2001 05:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129636AbRB0KG7>; Tue, 27 Feb 2001 05:06:59 -0500
Received: from atapco.demon.co.uk ([194.222.134.57]:60420 "EHLO
	atapco.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129638AbRB0KGl>; Tue, 27 Feb 2001 05:06:41 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200102271002.f1RA2B408058@brick.arm.linux.org.uk>
Subject: rsync over ssh on 2.4.2 to 2.2.18
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Feb 2001 10:02:11 +0000 (GMT)
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing odd behaviour with rsync over ssh between two x86 machines -
one if the is an UP PIII (Katmai) running 2.4.2 (isdn-gw) and the other
is an UP Pentium 75-200 (pilt-gw) running 2.2.15pre13 with some custom
serial driver hacks (for running Amplicon cards with their ISA interrupt-
sharing scheme).

Please note: although I am using 2.2.15pre13, it is _not_ the cause of
this problem, and I don't particularly want to touch the 2.2.15pre13
machine at the present time, which has been happy for the past year or
so.

netstat on isdn-gw shows the following:

	Proto Recv-Q Send-Q Local Address           Foreign Address         State
	tcp    72868      0 isdn-gw.piltdown.a:1023 pilt-gw.piltdown.at:ssh ESTABLISHED

netstat on pilt-gw shows the following:

	Proto Recv-Q Send-Q Local Address           Foreign Address         State
	tcp        0  14372 pilt-gw.piltdown.at:ssh isdn-gw.piltdown.a:1023 ESTABLISHED

Looking on the network reveals:

	09:49:23.215852 P pilt-gw.ssh > isdn-gw.1023: . 1119640864:1119640864(0) ack 1175090336 win 31856 <nop,nop,timestamp 114834687 8389267> (DF) [tos 0x8]
	09:49:23.216095 P isdn-gw.1023 > pilt-gw.ssh: . 1:1(0) ack 1 win 0 <nop,nop,timestamp 8401267 114186976> (DF) [tos 0x8]

So isdn-gw is saying it can't accept more data, which ties up with what
netstat is indicating.  Note that this situation has persisted for around
12 hours with neither end moving forward.

When I straced the ssh process on isdn-gw this morning, things start moving,
and in this instance everything completed normally, even after I stopped
stracing ssh.  However, there are times when I have to leave strace running
to get the rsync to complete.

select(4, [3], [3], NULL, NULL)         = 2 (in [3], out [3])
read(3, "\0\0\20\t\215R\241\355\201_o\227\4\371\340+\333_\333\34"..., 8192) = 8192
write(3, "\370\325|\355\232\256\247Kf\202\v\272\334@\231\317]\322"..., 135940) = 24616

On this instance, it appears that sshd has gotten stuck in select().
Maybe there is a race condition or missing wakeup in the TCP code?

Note that this problem also exists on 2.4.0 (I upgraded from 2.4.0 to
2.4.2 yesterday to see if the behaviour has changed).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

