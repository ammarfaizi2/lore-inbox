Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbTEAVF3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 17:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbTEAVF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 17:05:28 -0400
Received: from pat.uio.no ([129.240.130.16]:35261 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262584AbTEAVFZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 17:05:25 -0400
Date: Thu, 1 May 2003 23:17:47 +0200 (MEST)
From: =?iso-8859-1?Q?P=E5l_Halvorsen?= <paalh@ifi.uio.no>
To: Mark Mielke <mark@mark.mielke.cc>
cc: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org,
       =?iso-8859-1?Q?P=E5l_Halvorsen?= <paalh@ifi.uio.no>
Subject: Re: sendfile
In-Reply-To: <20030501042831.GA26735@mark.mielke.cc>
Message-ID: <Pine.SOL.4.51.0305012303540.17001@fjorir.ifi.uio.no>
References: <Pine.LNX.4.51.0304301604330.12087@sondrio.ifi.uio.no>
 <20030430165103.GA3060@outpost.ds9a.nl> <Pine.SOL.4.51.0304302102300.12387@ellifu.ifi.uio.no>
 <20030430192809.GA8961@outpost.ds9a.nl> <Pine.SOL.4.51.0304302317590.13406@thrir.ifi.uio.no>
 <20030430221834.GA23109@mark.mielke.cc> <Pine.SOL.4.51.0305010024180.334@niu.ifi.uio.no>
 <20030501042831.GA26735@mark.mielke.cc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 May 2003, Mark Mielke wrote:

> On Thu, May 01, 2003 at 12:34:32AM +0200, Pål Halvorsen wrote:
> > On Wed, 30 Apr 2003, Mark Mielke wrote:
> > > To some degree, couldn't sendto() fit this description? (Assuming the
> > > kernel implemented 'zero-copy' on sendto()) The benefit of sendfile()
> > > is that data isn't coming from a memory location. It is coming from disk,
> > > meaning that your process doesn't have to become active in order for work
> > > to be done. In the case of UDP packets, you almost always want a layer on
> > > top that either times the UDP packet output, or sends output in response
> > > to input, mostly defeating the purpose of sendfile()...
> > Maybe, but then I'll have two system calls...
>
> As I mentioned before, the real benefit to sendfile(), as I understand it, is
> that sendfile() makes it unnecessary for the OS to fully activate the calling
> process in order to do work for the calling process. Unless you can point out
> some other benefit provided by sendfile(), I fail to see how you will do:
>
>     while (1) {
>         send_frame_over_udp();
>         sleep();
>     }
>
> Without two system calls. Whether send_frame_over_udp() uses sendfile() as
> you seem to want it to, or whether it just calls sendto(), doesn't make a
> difference. Because one of your requirements is that you need to provide a
> smooth feed, the primary benefit of sendfile(), that of not having to activate
> your process, becomes invalid.
>
> I haven't done timings, or looked deeply at this part of linux-2.5.x,
> however, I fail to see why the following code should not meet your
> requirements:
>
>     void *p = mmap(0, length_of_file, PROT_READ, MAP_SHARED, fd, 0);
>     off_t offset = 0;
>
>     while (offset < length_of_file)
>       {
>         int packet_size = max(512, length_of_file - offset);
>         send(socket, &p[offset], packet_size, 0);
>         offset += packet_size;
>         usleep(packets_size * 1000000 / packets_per_second);
>       }
>
> In theory, send() should be able to provide the zero copy benefits you
> are requesting. In practice, it might be a little harder, but in this
> case, from my perspective, send() and sendfile() should both provide
> equivalent performance. Why would sendfile() perform better than send()?

As far as i understand mmap/send, you'll have a copy operation in the
kernel here. mmap shares the kernel and user buffer, but when sending the
packet data is copied to the socket buffer!!??

OK, but I understand that my streaming scenario is not the target
application for sendfile.

Then, I have another question - so that I maybe can implement this myself.
Can the network interface support gather operations - ie. collecting data
several places for a packet ("DMA gather copy" from memory to NIC)?

(Like described in
http://delivery.acm.org/10.1145/610000/603774/6345.html?key1=603774&key2=4582281501&coll=portal&dl=ACM&CFID=10149715&CFTOKEN=89922395
- Linux Journal Volume 2003 ,  Issue 105  (January 2003) )

If so, does the sk_buff use the struct skb_shared_info to point to the
different memory regions, or ...?

-ph

> mark

