Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261519AbRETKYt>; Sun, 20 May 2001 06:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbRETKYi>; Sun, 20 May 2001 06:24:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7438 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261515AbRETKY3>;
	Sun, 20 May 2001 06:24:29 -0400
Date: Sun, 20 May 2001 11:23:51 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>, Matthew Wilcox <matthew@wil.cx>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
Message-ID: <20010520112351.A32544@flint.arm.linux.org.uk>
In-Reply-To: <200105200248.f4K2mws02918@mobilix.ras.ucalgary.ca> <Pine.LNX.4.21.0105192017480.28666-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0105192017480.28666-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, May 19, 2001 at 08:26:20PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2001 at 08:26:20PM -0700, Linus Torvalds wrote:
> You're missing the point.

I don't think Richard is actually.  I think Richard has hit a nail
dead on its head.

> It's ok to do "read()/write()" on structures.

Ok, we can read()/write() structures.  So someone invents the following
structure:

	struct foo {
		int cmd;
		void *data;
	} foo;

Now they use write(fd, &foo, sizeof(foo)); Haven't they just swapped
the ioctl() interface for write() instead?

Ok, lets hope that humanity isn't that stupid, so lets take another
example:

	struct bar {
		int in_size;
		void *in_data;
		int out_size;
		void *out_data;
	};

	struct foo {
		int cmd;
		struct bar1;
	} foo;

Same write call, but ok, we have a structure of known size.  Its still
the same problem.

What I'm trying to say is that I think that read+write is open to more
or the same abuse that ioctl has been, not less.

However, it does have one good thing going for it - you can support
poll on blocking "ioctls" like TIOCMIWAIT.

> None of which are "network-nice". Basically, ioctl() is historically used
> as a "pass any crap into driver xxxx, and the driver - and ONLY the driver
> - will know what to do with it".

I still see read()/write() being a "pass any crap" interface.  The
implementer of the target for read()/write() will probably still be
a driver which will need to decode what its given, whether its in
ASCII or binary.

And driver writers are already used to writing ioctl-like interfaces.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
