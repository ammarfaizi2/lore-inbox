Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129225AbRBBRym>; Fri, 2 Feb 2001 12:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129475AbRBBRyd>; Fri, 2 Feb 2001 12:54:33 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:40089 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S129225AbRBBRyV>; Fri, 2 Feb 2001 12:54:21 -0500
Date: Fri, 2 Feb 2001 09:51:21 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: "David S. Miller" <davem@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <3A7A8822.CC5D8E4E@uow.edu.au>
Message-ID: <Pine.LNX.4.31.0102020943270.1221-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been watching this thread with interest for a while now, but am
wondering about the real-world use of this, given the performance penalty
for write()

As I see it there are two basic cases you are saying this will help in.

1. webservers

2. other fileservers

I also freely admit that I don't know a lot about sendfile() so it may
have some capability that makes my concerns meaningless, if so please let
me know.

1a. for webservers that server static content (and can therefor use
sendfile) I don't see this as significant becouse as your tests have been
showing, even a modest machine can saturate your network (unless you are
useing gigE at which time it takes a skightly larger machine)

1b. for webservers that are not primarily serving static content, they
have to use write() for the output from cgi's, etc and therefor pay the
performance penalty without being able to use sendfile() much to get the
advantages. These machines are the ones that really need the performance
as the cgi's take a significant amount of your cpu.

2. for other fileservers sendfile() sounds like it would be useful if the
client is reading the entire file, but what about the cases where the
client is reading part of the file, or is writing to the file. In both of
these cases it seems that the fileserver is back to the write() penalty.
does anyone have stats on the types of requests that fileservers are being
asked for?

David Lang



 On Fri, 2 Feb 2001, Andrew Morton wrote:

> Date: Fri, 02 Feb 2001 21:12:50 +1100
> From: Andrew Morton <andrewm@uow.edu.au>
> To: David S. Miller <davem@redhat.com>
> Cc: lkml <linux-kernel@vger.kernel.org>,
>      "netdev@oss.sgi.com" <netdev@oss.sgi.com>
> Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
>
> "David S. Miller" wrote:
> >
> > ...
> > Finally, please do some tests on loopback.  It is usually a great
> > way to get "pure software overhead" measurements of our TCP stack.
>
> Here we are.  TCP and NFS/UDP over lo.
>
> Machine is a dual-PII.  I didn't bother running CPU utilisation
> testing while benchmarking loopback, although this may be of
> some interest for SMP.  I just looked at the throughput.
>
> Machine is a dual 500MHz PII (again).  Memory read bandwidth
> is 320 meg/sec.  Write b/w is 130 meg/sec.  The working set
> is 60 ~300k files, everything cached. We run the following
> tests:
>
> 1: sendfile() to localhost, sender and receiver pinned to
>    separate CPUs
>
> 2: sendfile() to localhost, sender and receiver pinned to
>    the same CPU
>
> 3: sendfile() to localhost, no explicit pinning.
>
> 4, 5, 6: same as above, except we use send() in 8kbyte
>    chunks.
>
> Repeat with and without zerocopy patch 2.4.1-2.
>
> The receiver reads 64k hunks and throws them away. sendfile()
> sends the entire file.
>
> Also, do an NFS mount of localhost, rsize=wsize=8192, see how
> long it takes to `cp' a 100 meg file from the "server" to
> /dev/null.  The file is cached on the "server".  Do this for
> the three pinning cases as well - all the NFS kernel processes
> were pinned as a group and `cp' was the other group.
>
>
>                                 sendfile()     send(8k)   NFS
>                                  Mbyte/s       Mbyte/s   Mbyte/s
>
> No explicit bonding
>   2.4.1:                          66600        70000     25600
>   2.4.1-zc:                      208000        69000     25000
>
> Bond client and server to separate CPUs
>   2.4.1:                          66700        68000     27800
>   2.4.1-zc:                      213047        66000     25700
>
> Bond client and server to same CPU:
>   2.4.1:                          56000        57000     23300
>   2.4.1-zc:                      176000        55000     22100
>
>
>
> Much the same story.  Big increase in sendfile() efficiency,
> small drop in send() and NFS unchanged.
>
> The relative increase in sendfile() efficiency is much higher
> than with a real NIC, presumably because we've factored out
> the constant (and large) cost of the device driver.
>
> All the bits and pieces to reproduce this are at
>
> 	http://www.uow.edu.au/~andrewm/linux/#zc
>
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
