Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbTEAP0G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 11:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbTEAP0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 11:26:06 -0400
Received: from [68.162.198.3] ([68.162.198.3]:29644 "EHLO mail.starbak.net")
	by vger.kernel.org with ESMTP id S261373AbTEAP0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 11:26:04 -0400
Message-ID: <00e601c30ff5$e53ead00$65c7a244@starbak.net>
From: "Joseph Malicki" <jmalicki@starbak.net>
To: "Mark Mielke" <mark@mark.mielke.cc>,
       =?iso-8859-1?Q?P=E5l_Halvorsen?= <paalh@ifi.uio.no>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.51.0304301604330.12087@sondrio.ifi.uio.no> <20030430165103.GA3060@outpost.ds9a.nl> <Pine.SOL.4.51.0304302102300.12387@ellifu.ifi.uio.no> <20030430192809.GA8961@outpost.ds9a.nl> <Pine.SOL.4.51.0304302317590.13406@thrir.ifi.uio.no> <20030430221834.GA23109@mark.mielke.cc> <Pine.SOL.4.51.0305010024180.334@niu.ifi.uio.no> <20030501042831.GA26735@mark.mielke.cc>
Subject: Re: sendfile
Date: Thu, 1 May 2003 11:25:28 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One major difference I've noticed is the interaction with the VM subsystem.
When you have a large number of processes mmap'ing large files to send(), it
really starts to tickle bugs and performance problems.  sendfile() avoids
this, only needing to use the page cache.

-joe

----- Original Message ----- 
From: "Mark Mielke" <mark@mark.mielke.cc>
To: "Pål Halvorsen" <paalh@ifi.uio.no>
Cc: "bert hubert" <ahu@ds9a.nl>; <linux-kernel@vger.kernel.org>
Sent: Thursday, May 01, 2003 12:28 AM
Subject: Re: sendfile


> On Thu, May 01, 2003 at 12:34:32AM +0200, Pål Halvorsen wrote:
> > On Wed, 30 Apr 2003, Mark Mielke wrote:
> > > To some degree, couldn't sendto() fit this description? (Assuming the
> > > kernel implemented 'zero-copy' on sendto()) The benefit of sendfile()
> > > is that data isn't coming from a memory location. It is coming from
disk,
> > > meaning that your process doesn't have to become active in order for
work
> > > to be done. In the case of UDP packets, you almost always want a layer
on
> > > top that either times the UDP packet output, or sends output in
response
> > > to input, mostly defeating the purpose of sendfile()...
> > Maybe, but then I'll have two system calls...
>
> As I mentioned before, the real benefit to sendfile(), as I understand it,
is
> that sendfile() makes it unnecessary for the OS to fully activate the
calling
> process in order to do work for the calling process. Unless you can point
out
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
> smooth feed, the primary benefit of sendfile(), that of not having to
activate
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
>
> mark
>
> -- 
> mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com
__________________________
> .  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
> |\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   |
> |  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario,
Canada
>
>   One ring to rule them all, one ring to find them, one ring to bring them
all
>                        and in the darkness bind them...
>
>                            http://mark.mielke.cc/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

