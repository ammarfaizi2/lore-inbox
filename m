Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316605AbSEPItW>; Thu, 16 May 2002 04:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316606AbSEPItV>; Thu, 16 May 2002 04:49:21 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:17928 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S316605AbSEPItU>;
	Thu, 16 May 2002 04:49:20 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200205160849.g4G8nF716074@oboe.it.uc3m.es>
Subject: Re: Kernel deadlock using nbd over acenic driver
In-Reply-To: <200205160804.JAA24761@gw.chygwyn.com> from Steven Whitehouse at
 "May 16, 2002 09:04:31 am"
To: Steve Whitehouse <Steve@ChyGwyn.com>
Date: Thu, 16 May 2002 10:49:15 +0200 (MET DST)
Cc: ptb@it.uc3m.es, alan@lxorguk.ukuu.org.uk, chen_xiangping@emc.com,
        linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Steven Whitehouse wrote:"
> > I don't see any reason to introduce a second flag to say when a flag
> > has been set .. Initial reports are that symptoms go away when
> > 
> >     current->flags |= PF_MEMALLOC;
> > 
> > is set in the process about to do networking (and unset afterwards).
> 
> The reason for adding the second flag is that I suspect that nbd_send_req()
> can be called by processes which already have PF_MEMALLOC set, in which case

If we are talking about kernel nbd, then the send_req is called by
the unique process which entered the kernel ages ago, and has been stuck
in the kernel doing its protocol loop ever sice.  At least, if things
are still the way they were the last time I looked!  Pavel originally
used the client daemons to get a socket, then pass it down into the
kernel, and then they stayed there pumping data into and out of the
socket. They get stuck there in the first place when they call a special
ioctl. No user process in its right mind would call that ioctl, and 
couldn't, unless it were root.

(It's one of the reasons why I wrote ENBD (a long time ago!). Those
processes are now just specialized kernel threads, in effect, and can't
be talked into doing anything different .. like dying, for example.)

> we don't want to alter that. The "priority inversion" that I mentioned occurs
> when you get processes without PF_MEMALLOC set calling nbd_send_req() as when
> they call through to page_alloc.c:__alloc_pages() they won't use any memory
> once the free pages hits the min mark even though there is memory available
> (see the code just before and after the rebalance label).

There is a possible inversion, but I'm not sure it's that. I assume
the problem is that bdflush has high priority, and thus preempts the
nbd processes either from running or from gaining tcp buffers, yet
bdflush needs nbd to run and get buffers in order to flush the requests
through the net.

> Once one process has started sleeping waiting for memory in nbd_send_req()
> thats is, since tx_lock prevents any further writeouts until the sleeping
> process has completed. Unfortunately this has to be the case in order to
> ensure that nbd's requests are sent atomically.

I'm not following you closely here, but in Enbd I don't attempt to send
atomically and I don't believe it's necessary.  The process in Enbd is
an ordinary user process doing ordinary user networking.  It shovels
data to and fro from the kernel via ioctls.  Yes I believe it _does_
stick in networking, when it sticks.  I do have the socket set to "write
at once" instead of accumulating data to make up whole packets, but
that's all.

What's more, in Enbd, the user process can be set to run "async", and it
still locks when swapping over nbd.  This means that it acks the kernel
_before_ sending to the net, so if it's blocked, it's not blocked
against its own request!  It must be blocked against lack of buffers in
general.  It's locked in memory so it can't lack for pages.

> So rather than reserve memory specifically for sockets, in effect the
> min free pages for each zone place a limit on what "normal" allocations
> may use as a maximum. This is fine provided allocations in the write out
> path are not "normal" as well, but able to use whatever they need. At first
> I thought "we only need to set PF_MEMALLOC if we are writing" but in fact
> we have to set it for reads too so that reads don't block writes I think.

I set it for both reads and writes, and the one report I have back said
"that cures it".

However, I don't believe it necessary for reading. I haven't thought
about it. It's just silly!

> There is a difference though between preventing the deadlock and adjusting
> the system so that we get the maximum performance, so it will be interesting
> to see whether we ought to adjust the min free pages figure in order to
> get higher performance, or whether its ok as it is.

Tell me how to, and I'll do it. I can tell you exactly how much min is
required for Enbd, per socket. But how can I make sure that only the
nbd process with the socket can claim that memory? Actually .. that
sounds a lot easier than "how can a socket reserve memory".

> I'm not sure yet that the PF_MEMALLOC change I described actually fixes the
> problem either, although it should make things a lot better. Thats

Yes. I agree that it probably does not avoid the situation where
buffers have completely disappeared, and we need to send via tcp in
order to free some of them.

> something else for further investigation.


Peter
