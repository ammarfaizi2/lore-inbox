Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317923AbSFSQQF>; Wed, 19 Jun 2002 12:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317925AbSFSQQE>; Wed, 19 Jun 2002 12:16:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8208 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id <S317923AbSFSQQA>;
	Wed, 19 Jun 2002 12:16:00 -0400
Date: Wed, 19 Jun 2002 11:15:55 -0500
From: Tommy Reynolds <reynolds@redhat.com>
To: "Chris Friesen" <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: recommended method for hardware to report events to userspace?
Message-Id: <20020619111555.1abc950e.reynolds@redhat.com>
In-Reply-To: <3D10A017.C22CDD0D@nortelnetworks.com>
References: <3D10A017.C22CDD0D@nortelnetworks.com>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uttered "Chris Friesen" <cfriesen@nortelnetworks.com>, spoke thus:

> I'm doing some work on a SONET PHY and I was wondering what the recommended
> method is for asynchronously reporting events to userspace.
> 
> I have some non-critical events (correctable ecc errors, etc) that I poll
> every once in a while, but there are some critical events (loss of signal, for
> instance) that I want to report immediately.
> 
> What is the usual way of doing this?  I see three possibilities: 1) the
> userspace app could register its pid with the driver using ioctl() and on a
> fault the interrupt handler in the driver could fire off a signal to the
> registered pids to alert them that something happened, at which point they do
> another ioctl() to find out exactly what it was,  2) use netlink to provide a
> socket-based notification of what happened,  3) provide a file descriptor that
> becomes readable when an event happens.
> 
> What's the Right Thing to do here?

There's no One Right Way to do this.  Here's my suggested feature
hierarchy:

1) Provide a "/proc" file system entry so humans can easily see your
driver's status.  It's easy to make a simple read-only "/proc" file.

2) Implement a "poll" method in your device driver that simply blocks
until one of your anomalous events occurs.  Applications can then do
a standard select(2) system call to detect these events.  Select(2)
is quite efficient.  After the select(2) returns, then a simple
read(2) could get the data.

3) Implement a "mmap" method in your device driver so that
applications could just map in a status buffer.

4) You could use signals, but these take more handshaking
infrastructure via ioctl's between the driver and applications than
do these other suggestions.
