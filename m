Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291216AbSBGS3K>; Thu, 7 Feb 2002 13:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291194AbSBGS1l>; Thu, 7 Feb 2002 13:27:41 -0500
Received: from air-2.osdl.org ([65.201.151.6]:31924 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S291197AbSBGS13>;
	Thu, 7 Feb 2002 13:27:29 -0500
Date: Thu, 7 Feb 2002 10:27:35 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] read() from driverfs files can read more bytes 
In-Reply-To: <1124DDDD7FF9@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.33.0202071021280.25114-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Feb 2002, Petr Vandrovec wrote:

> On  7 Feb 02 at 9:43, Patrick Mochel wrote:
> > > And neither of driverfs_read_file nor driverfs_write_file supports
> > > semantic we use with other filesystems: If at least one byte was 
> > > read/written, return byte count (even if error happens). Only if zero 
> > > bytes was written, return error code.
> > 
> > I would think that you would want to return the error code. Say you did:
> > 
> > echo "action parameter" > file
> > 
> > and 'parameter' is an invalid parameter, as determined by the driver. It 
> > would require another arbitrary check to determine if the command 
> > succeeded or not if it returned the number of bytes written. Returning 
> > -EINVAL lets userspace know that it made a boo-boo. Is that not good?
> 
> If you want bidirectional communication, something like SOCK_SEQPACKET
> or SOCK_DGRAM is better suitable. And if we learn open() to open
> unix sockets, even 'echo' can be still used for configuring. I understand 
> that it is radical change, but why these configuration points should
> look like real files if they are not ones? And you do not have troubles
> with supporting lseek() on them - if contents of file is "minutes\n",
> is it correct to do lseek(fd, 1, SEEK_SET); write(fd, "onths\n", 6);
> or is it incorrect usage?
> 
> If you do not want to change these objects from files to sockets,
> I agree with your explanation for write(). But I do not agree with this
> semantic for read() - reading byte after byte, and reading in one big 
> chunk should not yield in different results on regular files, otherwise 
> couple of nasty surprises is hidding there.

Ok, I agree with your argument concerning read(). 

Concerning reading/writing from offsets, it's up to the drivers for them 
to either support it or not. In the files I've done so far, I return 0 if 
show() is called with an offset. Which will give different results if you 
read byte-by-byte or an entire chunk. 

It makes the callbacks simpler, but it is not technically correct. 

Something I did a while ago was implement default callbacks for basic 
types. So you would have something like:

default_show_u32(char * buf, size_t count, loff_t off, u32 * data)
{
	...
}

So the driver could do 

driver_show(struct device * dev, char * buf, size_t count, loff_t off)
{
	return default_show_u32(buf,count,off,&data);
}

And in the default_* handle the offset appropriately. 

If that seems reasonable, I'll dig it up and integrate it...

	-pat

