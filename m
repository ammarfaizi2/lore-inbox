Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263850AbRFHFqS>; Fri, 8 Jun 2001 01:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263851AbRFHFqI>; Fri, 8 Jun 2001 01:46:08 -0400
Received: from cc1074780-a.ewndsr1.nj.home.com ([24.180.76.171]:30611 "HELO
	saw.sw.com.sg") by vger.kernel.org with SMTP id <S263850AbRFHFqF>;
	Fri, 8 Jun 2001 01:46:05 -0400
Message-ID: <20010608014443.A28407@saw.sw.com.sg>
Date: Fri, 8 Jun 2001 01:44:43 -0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: "Nadav Har'El" <nyh@math.technion.ac.il>, linux-kernel@vger.kernel.org
Subject: Re: Bug in nonlocal-bind (transparent proxy)?
In-Reply-To: <20010607170825.A18760@leeor.math.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20010607170825.A18760@leeor.math.technion.ac.il>; from "Nadav Har'El" on Thu, Jun 07, 2001 at 05:08:25PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It's not a bug, it's willful.

On Thu, Jun 07, 2001 at 05:08:25PM +0300, Nadav Har'El wrote:
> I am writing a transparent-proxy-like application, that needs to be able to
> bind a TCP socket with a non-local address (i.e., the proxy contacts the
> origin-server, in the local network, pretending to be the original client.
> The reply will get back to the proxy because it acts as the default
> gateway, and the kernel needs to pass that reply to the socket).
> 
> Bind()ing a non-local address worked fine in the 2.2 line of kernels if a
> certain compile-time option was enabled (TRANSPARENT_PROXY, or something
> like that). But it no longer seems to be working in the 2.4 kernels (I
> tried this on 2.4.2 coming from the Redhat 7.1 distribution).
> 
> First, bind() simply refused to work when given a non-local address (returning
> EADDRNOTAVAIL). Reading the kernel's source I discovered that an undocumented
> "ip_nonlocal_bind" sysctl makes the kernel agree to do such a bind (this
> should really be in the bind() documentation...). Enabling this option
> allowed bind to work (it can even catch the case of two sockets trying to
> bind the same address), but the later connect() fails!
> I tryed reading the kernel sources to figure out what's wrong with the
> connect(), but failed to understand why it returns a EINVAL. I think this
> is a bug, and include below a short program to reproduce it:
> 
> If you run the program below, connect() will fail with EINVAL (it will do
> so before even trying to output a packet). To see that nothing's actually
> wrong with the connect, change the #if 1 to #if 0, eliminating the bind(),
> and see that the connect works (or at least fails with a connection refused,
> as it should because of the random IP address).
> Note that you must run the program as root, and do
> 	echo 1 > /proc/sys/net/ipv4/ip_nonlocal_bind 
> to get the bind() to work at all. But once you do that, and bind() works,
> how come connect() doesn't work?
> 
> Thanks in advance for any insights or fixes!

To make a custom kernel where you can use non-local addresses more freely,
find source address checks in ip_route_output_slow() and get rid of all of
them except considering
	MULTICAST(saddr) || BADCLASS(saddr) || ZERONET(saddr) ||
		saddr == htonl(INADDR_BROADCAST)
as invalid.

	Andrey
