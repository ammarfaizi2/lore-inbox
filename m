Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291062AbSBGBy1>; Wed, 6 Feb 2002 20:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291063AbSBGByR>; Wed, 6 Feb 2002 20:54:17 -0500
Received: from bgp387566bgs.jersyc01.nj.comcast.net ([68.36.43.111]:11653 "EHLO
	moisil.badula.org") by vger.kernel.org with ESMTP
	id <S291062AbSBGByG>; Wed, 6 Feb 2002 20:54:06 -0500
Date: Wed, 6 Feb 2002 20:51:04 -0500
Message-Id: <200202070151.g171p4h11574@moisil.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, cfriesen@nortelnetworks.com (Chris Friesen)
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
In-Reply-To: <E16YcOK-0006wT-00@the-village.bc.nu>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.17 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002 00:26:20 +0000 (GMT), Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> I ran into a somewhat related issue on a 2.2.16 system, where I had an app that
>> was calling sendto() on 217000 packets/sec, even though the wire could only
>> handle about 127000 packets/sec.  I got no errors at all in sendto, even though
>> over a third of the packets were not actually being sent.
> 
> That is correct UDP behaviour

This is totally untrue, unless the socket doing non-blocking I/O -- and
even then you get -1 and EAGAIN from sendto.

Otherwise sendto is very much a blocking operation which will block until
there is enough space in socket buffer to store the data. From there,
there is no way to "lose" that data before it hits the wire, unless of
course the network driver is broken and doesn't plug the upper layers when
its TX queue is full.

Think of it: if what you said were true, NFS over UDP would be totally
useless. But it's not, so if UDP data gets lost before it hits the wire,
it's usually a bug in the network driver.

>From the limited testing I just ran, I appears that starfire and 3c59x 
handle this correctly, whereas tulip always loses a small number of 
packets during a UDP storm. ttcp -us[rt] is very useful for such 
testing...

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
