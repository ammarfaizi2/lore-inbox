Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281928AbRKZRDU>; Mon, 26 Nov 2001 12:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281927AbRKZRDL>; Mon, 26 Nov 2001 12:03:11 -0500
Received: from [195.63.194.11] ([195.63.194.11]:46866 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S281929AbRKZRDF>; Mon, 26 Nov 2001 12:03:05 -0500
Message-ID: <3C027377.F0B61BD3@evision-ventures.com>
Date: Mon, 26 Nov 2001 17:53:11 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Martin Dalecki <dalecki@evision.ag>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.0 kill  read_ahead array.
In-Reply-To: <Pine.LNX.4.33.0111221046170.1479-100000@penguin.transmeta.com> <3C022CEF.BC4340A1@evision-ventures.com> <20011126093414.B730@lynx.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Nov 26, 2001  12:52 +0100, Martin Dalecki wrote:
> > This is removing the "write only" read_ahead sparse array from all
> > the places where it's "used" by now.
> > This is just saving some memmory.
> 
> Is this a case of the "read_ahead" array is redundant and read ahead is
> done at a different level (not using this array), or is it a case of
> read ahead not being done at all?  If it is not being done at all, then
> removing the unused array is the wrong thing to do - we should fix
> read ahead, and start using the array.

No we shouldn't.

There are the following problems with the read_ahead array as it
currently
stands:

1. It isn't used at all at any level! 
Even the AS390 people finally cleaned aparently theyr code up. 

REALY REALY Please look at the the patch. 

There is only one bogous place in hfs, where this array was used at all.
Literally all other places are just writing some values into it.
This is what I'm calling a "write only" variable.

2. It is bound to the major number, which is the wrong granularity,
since linux doesn't preserve the device type on this level and is
slicing up
the minor numbers. This is the most severe brain damage of it.

3. We have anyway a filesystem read ahead layer there.

4. We have a block device driver read ahead layer there too 
(it's called blksize there...).

5. We have blk_dev_t and block_device structs, which are supposed
to replace the current static global array, since they are the
more logical place where such information should be placed. This
is unevitable if we are ever willing to provide support for real
kernel scalability in terms of numbers of attached devices...

Regard's.
