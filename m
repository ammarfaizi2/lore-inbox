Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbVANWSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVANWSR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 17:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVANWR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 17:17:58 -0500
Received: from relay.axxeo.de ([213.239.199.237]:48059 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S262202AbVANWNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 17:13:06 -0500
From: Ingo Oeser <ioe-lkml@axxeo.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
Date: Fri, 14 Jan 2005 23:12:50 +0100
User-Agent: KMail/1.7.1
Cc: linux@horizon.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050108082535.24141.qmail@science.horizon.com> <200501142203.44720.ioe-lkml@axxeo.de> <Pine.LNX.4.58.0501141318030.2310@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501141318030.2310@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501142312.50861.ioe-lkml@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Linus Torvalds wrote:
> On Fri, 14 Jan 2005, Ingo Oeser wrote:
> But realize that what you are asking for is actually a _much_ simpler
> thing than even "fifo_open()". What you ask for (if somebody really starts
> doing this, and I'd love to see it) is not much more difficult than
>
>  int device_open(struct inode *inode, struct file *filp)
>  {
>   if (!pipe_new(inode))
>    return -ENOMEM;
>
>   /* The hardware is a writer */
>   PIPE_WRITERS(*inode)++;
>
>   /* The new fd is a reader of the data the hardware generates */
>   file->f_op = read_fifo_fops;
>
>   /*
>    * This starts the hardware capture - although in real
>    * life there might be a "start it" ioctl or something
>    * that actually does that together with the parameters
>    * for capture..
>    */
>   start_capture_process(inode);
>
>   return 0;
>  }
>
> ie we're definitely not talking rocket science here.

Data sink/source is simple, indeed. You just implemented a buffering
between a drivers output filp, if I understand you correctly.

Now both directions together and it gets a bit more difficult.
Driver writers basically reimplement fs/pipe.c over and over again.

encoded stream -> write() -> decoder hardware -> read() -> decoded stream

I'm trying to model the decoder as device here.
Same goes for encoding.

> (Yes, I'm sure there are some details missing in the above, but you get
> the idea: the infrastructure really _is_ pretty much there, and any lack
> comes from the fact that nobody has actually ever _used_ it).

No, we have all the hardware actually doing this hidden behind other 
interfaces. e.g. the DVB core, my LinuxDSP core, the upcoming hardware
crypto core and so on.

Always the same basic operations for that needing the same structure
to handle it.

Maybe the solution here is just using ONE fd and read/write to it.

But for identifying producer/consumer, you need two fds. And now we come to
wire() (or maybe we discover that splice() is really doing the same).
 
> > We also don't have wire_fds(), which would wire up two fds by
> > connecting the underlying file pointers with each other and closing the
> > fds.
>
> But that is _exactly_ what splice() would do.
>
> So you could have the above open of "/dev/mpeginput", and then you just
> sit and splice the result into a file or whatever.
>
> See?

But you are still pushing everything through the page cache.
I would like to see "fop->connect(producer, consumer)"

instead of

while (producer->not_killed &&) consumer->not_killed) {
 producer->read(buffer);
 consumer->write(buffer);
}

That's what the wire() syscall is about. If the splice() syscall is the same
and enables drivers to avoid the copying through the CPU, I'm perfectly happy.

> (Or maybe it's me who doesn't see what it is you want).

Imagine 3 chips. One is a encoder/decoder chip with 8 channels, the other
2 chips are a video DAC/ADC and an audio DAC/ADC with 4 channels each.

These chips can be wired directly by programming a wire matrix (much like a 
dumb routing table). But you can also receive/send via all of these chips
to/from harddisk for recording/playback. 

So you have to implement the drivers for these chips to provide one filp per 
channel and one minor per chip.

If I can do this with splice, you've got me and I'm really looking forward to 
your first commits/patches, since this itch is scratching me since long ;-)


Thanks and Regards

Ingo oeser

