Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317393AbSHKAxq>; Sat, 10 Aug 2002 20:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317396AbSHKAxp>; Sat, 10 Aug 2002 20:53:45 -0400
Received: from mta06bw.bigpond.com ([139.134.6.96]:29165 "EHLO
	mta06bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S317393AbSHKAxo>; Sat, 10 Aug 2002 20:53:44 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Pete de Zwart <dezwart@froob.net>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: 2.4.19: drivers/usb/printer.c usblpX on fire
Date: Sun, 11 Aug 2002 10:52:25 +1000
User-Agent: KMail/1.4.5
References: <200208092200.RAA34736@tomcat.admin.navo.hpc.mil> <20020811000340.GF27819@niflheim>
In-Reply-To: <20020811000340.GF27819@niflheim>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200208111052.25488.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 11 Aug 2002 10:03, Pete de Zwart wrote:
> Cool, thanx Jesse, I always wondered what the history was behind it and
> how to achieve it.
>
> Here is another query:
>
> If each printer had their own set of error codes, what would be the way to
> implement their display from the kernel?
>
> Would each printer have to have their own module if they had a non-standard
> list of error codes or would we simply ignore them and state that the
> ill conforming printer is on fire?
There is more than one way of getting information over the printer connection.

If you think about old-style centronics type parallel connections, there are 
data pins that can provide 8-bit parallel transfers. There are also some 
status pins (no paper, busy, on-fire, whatever). Clearly there will never be 
enough pins on a real system to indicate every combination that might be 
possible ("cyan toner nearly empty", "jam in duplexer unit", "C5 envelope 
tray at 42%"). So you need another way. One option is to make the parallel 
transfer mechanism bi-directional, and do both data and status transfers over 
the same 8-bit parallel pins. Then you can establish a protocol for this (eg 
IEEE-1284 variants).

When you want to map this type of usage to USB, you can indicate some things 
over a "get_status" query at the USB level (which is basically mapping the 
old status pins), and you can just pass the data up to a normal printer 
system (which doesn't care whether it is talking to the printer over the 
traditional /dev/lpX device or a USB emulation.

So the kernel doesn't care about most of the error codes (since it isn't 
interpreting the data stream), but there are some things that are noted for 
historical reasons. Those things (like "out of paper" turn out to be widely 
supported (or if not, are at least set to benign values). All the "unique" 
error codes are a problem for userspace.

Does this make sense?

Brad
- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9VbVJW6pHgIdAuOMRAmvXAJ9lWcnGN24F6tyJEOUoID/1fl4oUQCgovse
oPsfs1E7GHh1jbUjCYUiiTg=
=qENi
-----END PGP SIGNATURE-----

