Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbVANXes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbVANXes (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 18:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVANXes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 18:34:48 -0500
Received: from relay.axxeo.de ([213.239.199.237]:50619 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S261990AbVANXen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 18:34:43 -0500
From: Ingo Oeser <ioe-lkml@axxeo.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
Date: Sat, 15 Jan 2005 00:34:31 +0100
User-Agent: KMail/1.7.1
Cc: linux@horizon.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050108082535.24141.qmail@science.horizon.com> <200501142312.50861.ioe-lkml@axxeo.de> <Pine.LNX.4.58.0501141430320.2310@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501141430320.2310@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501150034.31880.ioe-lkml@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Linus Torvalds wrote:
> That's where it gets interesting. Everybody needs buffers, and they are
> generally so easy to implement that there's no point in having much of a
> "buffer library".

But my hardware has the buffers on chip, if connected directly to each other.
So no system level buffering is needed.

> No. Use two totally separate fd's, and make it _cheap_ to move between
> them. That's what "splice()" gives you - basically a very low-cost way to
> move between two uni-directional things. No "memcpy()", because memcpy is
> expensive for large streams of data.

Here we agree already, so lets talk about the rest.

> If you end up reading from a regular file (or writing to one), then yes,
> the buffers end up being picked up from the buffer cache. But that's by no
> means required. The buffers can be just anonymous pages (like the ones a
> regular "write()" to a pipe generates), or they could be DMA pages
> allocated for the data by a device driver. Or they could be the page that
> contains a "skb" from a networking device.
>
> I really think that splice() is what you want, and you call "wire()".

That sounds really close to what I want.

Now imagine this (ACSCII art in monospace font):

[ chip A ] ------(1)------ [ chip B ]   [ CPU ]   [memory]  [disk]
      |                        |           |         |        |
      +----------(2)-----------+---(2)-----+----(2)--+--------+

(1) Is a direct path between these chips.
(2) Is the system bus (e.g. PCI)

(1) works without any CPU intervention
(2) needs the buffering scheme you described.

I like to use (1) for obvious reasons, but still allow (2).
User space should decide which one, since it's a policy decision.

I need to open the chips with default to (2), because the driver
doesn't know in advance, that it will be connected to a chip it can talk to 
directly. Everything else will be quite ugly.

Please note, that this is a simplified case and we actually have many chips of
A/B and (1) is more like a software programmable "patch field" you
might know from a server rack. I want user space to operate this "patch 
field".

Maybe "io router" is a descriptive term. No?

> Yes, I believe that we're talking about the same thing. What you can do in
> my vision is:
>
>  - create a pipe for feeding the audio decoder chip. This is just the
>    sound driver interface to a pipe, and it's the "device_open()" code I
>    gave as an example in my previous email, except going the other way (ie
>    the writer is the 'fd', and the driver is the "reader" of the data).
>
>    You'd do this with a simple 'fd = open("/dev/xxxx", O_WRONLY)",
>    together with some ioctl (if necessary) to set up the actual
>    _parameters_ for the piped device.
>
>  - do a "splice()" from a file to the pipe. A splice from a regular file
>    is really nothing but a page cache lookup, and moving those page cache
>    pages to the pipe.
>
>  - tell the receiving fd to start processing it (again, this might be an
>    ioctl - some devices may need directions on how to interpret the data,
>    or it might be implicit in the fact that the pipe got woken up by being
>    filled)

Yes, I understand and support your vision. Now I would like to use path (1)
the direct for this. Possible? 

Maybe by making drivers optionally aware of splice() and defaulting to a 
regular pipe, if they don't care?


Thanks and Regards

Ingo Oeser

