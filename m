Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVANVc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVANVc3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 16:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVANVbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 16:31:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:18114 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262124AbVANVaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 16:30:09 -0500
Date: Fri, 14 Jan 2005 13:29:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Oeser <ioe-lkml@axxeo.de>
cc: linux@horizon.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
In-Reply-To: <200501142203.44720.ioe-lkml@axxeo.de>
Message-ID: <Pine.LNX.4.58.0501141318030.2310@ppc970.osdl.org>
References: <20050108082535.24141.qmail@science.horizon.com>
 <200501132246.37289.ioe-lkml@axxeo.de> <Pine.LNX.4.58.0501131429400.2310@ppc970.osdl.org>
 <200501142203.44720.ioe-lkml@axxeo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Jan 2005, Ingo Oeser wrote:
> 
> But we have currently no suitable interface for this.
> 
> We have socketpair(), we have pipe(), but we don't have
> dev_pipe() creating a pipe with the driver sitting in the middle.

Not exactly that, no.

But realize that what you are asking for is actually a _much_ simpler 
thing than even "fifo_open()". What you ask for (if somebody really starts 
doing this, and I'd love to see it) is not much more difficult than

	int device_open(struct inode *inode, struct file *filp)
	{
		if (!pipe_new(inode))
			return -ENOMEM;

		/* The hardware is a writer */
		PIPE_WRITERS(*inode)++;

		/* The new fd is a reader of the data the hardware generates */
		file->f_op = read_fifo_fops;

		/*
		 * This starts the hardware capture - although in real
		 * life there might be a "start it" ioctl or something
		 * that actually does that together with the parameters
		 * for capture..
		 */
		start_capture_process(inode);

		return 0;
	}

ie we're definitely not talking rocket science here.

(Yes, I'm sure there are some details missing in the above, but you get 
the idea: the infrastructure really _is_ pretty much there, and any lack 
comes from the fact that nobody has actually ever _used_ it).

> Usage: "processing devices" like crypto processors, DSPs, 
>  MPEG-Encoding/-Decoding hardware, smart cards and the like.
> 
> Synopsys: int dev_pipe(const char *dev_path, int fd_vec[2]);

No, I do NOT think that's what you'd want. 

What you want is more of a

	fd = open("/dev/mpeginput", O_RDONLY);

and then that device driver open just does the thing outlined above.

> We also don't have wire_fds(), which would wire up two fds by 
> connecting the underlying file pointers with each other and closing the fds.

But that is _exactly_ what splice() would do.

So you could have the above open of "/dev/mpeginput", and then you just 
sit and splice the result into a file or whatever.

See?

(Or maybe it's me who doesn't see what it is you want).

			Linus
