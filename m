Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316609AbSE0Nbi>; Mon, 27 May 2002 09:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSE0Nbh>; Mon, 27 May 2002 09:31:37 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:525 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S316609AbSE0Nbc>;
	Mon, 27 May 2002 09:31:32 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200205271304.OAA06906@gw.chygwyn.com>
Subject: Re: Kernel deadlock using nbd over acenic driver
To: ptb@it.uc3m.es
Date: Mon, 27 May 2002 14:04:48 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux kernel), alan@lxorguk.ukuu.org.uk,
        chen_xiangping@emc.com
In-Reply-To: <200205241554.g4OFsWN29042@oboe.it.uc3m.es> from "Peter T. Breuer" at May 24, 2002 05:54:32 PM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> 
> "Steven Whitehouse wrote:"
> > (and ptb wrote, at ever greater quoting distance)
> > > > so I'm still hopeful that it can be solved in a reasonably simple way,
> > > If you can manage to reserve memory for a socket, that should be it.
> > 
> > I'd like to do that if I can, on the otherhand, thats going to be rather
> > a tricky one. We are not going to know which process called run_task_queue()
> 
> We should be able to change the function which registers tasks to also
> record the originating process id, if that's any help.  But it might
> have to be inherited through a lot of places, and it's not therefore a
> point change in the code. Discard that idea.
> 
Yes. Agreed.

> > so that we can't use the local pages list as a hackish way of doing this
> > easily (I looked into that). If we did all sends from one process though
> > it becomes more of a possibility, there are problems with that though....
> 
> I do do that in ENBD.
> 
> > I've wondered before about changing the request function so that it just
> > puts the request on the local queue and wakes up the thread for sending
> 
> That is again what I do do in ENBD.
> 
Ok. Then I think nbd will shortly start to look more like enbd then :-)

> > data. That would solve the blocking problem, but also mean that we had to
> > schedule for every request that comes in which I'd rather avoid for
> > performance reasons (not that I've actually done the experiment to work out
> > what we'd loose, but I suspect it would make a difference).
> 
> There's no difference for NBD, essentially, if the kernel is merging
> requests (and it is, by default, in the make request function). Then
> nearly every read and write through the device ends up as several KB in
> size, maybe up to about 32KB (or even 128KB, or 256KB), and that is
> significant time over a network link, so that whatever else happens 
> in the kernel is dominated by the transmission speed over the medium.
> 
> You end up with some latency, and that's all.
> 
Yes, and with the new scheduling code that Ingo wrote recently, that
should be even less than it used to be I guess.

> People are doing large studies of performance over ENBD over
> various media, with various kernels. I should be able to tell you more
> one day soon! At the moment I don't see any obvious way-to-go
> indicators in the results.
> 
That sounds very interesting. I'm certainly keen to see the results when
they are available.

[snip]
> 
> > Also there is the possibility of combining the sending thread with the
> > receiving thread. This has complications because we'd have to poll()
> 
> I do use the same thread for sending and receiving in ENBD. This is
> because the cycle is invariant .. you send a question, and then you
> receive an answer back. Or you send a command, and you get an ack back.
> Both times it's write then read. Separate threads would be possible,
> but are kind of a luxury item.
> 
I think thats what I'd like to do for nbd having thought things through
a bit more.

> > the socket and be prepared to do non-blocking read or write on it as
> > required. Obviously by no means impossible, but certainly more complicated
> > than the current code.
> 
> I'm not sure that I see the difficulty. Yes, to answer that question,
> ENBD does use non-blocking sockets, and does run select on them to
> detect what happens. But that's more or less just so it can detect
> errors. I don't think there'd be any significant harm accruing from
> using blocking sockets.
> 
I should have really explained that a bit more. I was thinking about another
bug which I fixed in nbd before which was related to the network buffer
queue sizes and certain workloads. It was possible to get into a state
where both client and server were waiting for each other to process
requests (and hence reduce the outstanding queue length) before they
would continue.

If you use blocking sockets in a loop along the lines of:

 while(1) {
	if (request_waiting)
		write_a_request(); /* may block until whole request sent */
	if (receive_queue_size >= sizeof(an nbd header))
		read_a_request(); /* may block until whole request read */
	if (nothing_is_happening)
		wait_for_something_to_happen();
 }

then I think the same problem applies (assuming that the server uses a similar
loop to the client and that the relative speeds of the client and server are
such that it allows getting in such a state).

> > This would prevent blocking in the request function, but I still don't know
> > how we can ensure that there is enough memory available. In some ways I
> 
> This is the key.
> 
Agreed. Though now you've convinced me of the problems involved in blocking
in the request function, I'm going to deal with that first and come back
to the memory management question later.

After reading the run_task_queue() source, I agree that we shouldn't block
in the request function. I'm not completely convinced that its not ok under
any circumstances - it might be fine when we know it will only be for a
very short period, but it does seem that there is one reason that we must
never block in the request function which is to wait for memory.

> > feel that we ought to be able to make use of the local pages list for the
> > process to (ab)use for this, but if the net stack frees any memory from
> > interrupt context that was allocated in process context, that idea won't
> > work,
> 
> What was my idea .. oh yes, that the tcp stack should get its memory
> from a specific place for each socket, if there is a specific place
> defined. This involves looking at the tcp stack, which I hate ...
> 
> 
> Peter
> 

I'm not so worried about looking at this code. I studied it a great deal
when I was looking for inspiration for the DECnet stack. Its changed since
then, but not so much that I'd have to start from scratch,

Steve.

