Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274758AbRJDPta>; Thu, 4 Oct 2001 11:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275120AbRJDPtV>; Thu, 4 Oct 2001 11:49:21 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10771 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274758AbRJDPtQ>; Thu, 4 Oct 2001 11:49:16 -0400
Date: Thu, 4 Oct 2001 08:49:24 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Security question: "Text file busy" overwriting executables but
 not shared libraries?
In-Reply-To: <m1n137zbyo.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33.0110040842320.8350-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 4 Oct 2001, Eric W. Biederman wrote:
>
> First what user space really wants is the MAP_COPY.  Which is
> MAP_PRIVATE with the guarantee that they don't see anyone else's changes.

Which is a completely idiotic idea, and which is only just another example
of how absolutely and stunningly _stupid_ Hurd is.

The thing with MAP_COPY is that how do you efficiently _detect_ somebody
elses changes on a page that you haven't even read in yet?

So you have a few choices, all bad:

 - immediately reading in everything, basically turning the mmap() into a
   read. Obviously a bad idea.

 - mark the inode as a "copy" inode, and whenever somebody writes to it,
   you not only make sure that you do copy-on-write on the page cache page
   (which, btw, is pretty much impossible - how did you intend to find all
   the other _non_COPY_ users that _want_ coherency).

   You also have to make sure that if somebody changes the page, you have
   to read in the old contents first (not normally needed for most
   changes that write over at least a full block), but you also have to
   save the old page somewhere so that the mapping can use it if it faults
   it in later. And how the hell do you do THAT? Especially as you can
   have multiple generations of inodes with different sets of "MAP_COPY"
   on different contents..

   In short, now you need filesystem versioning at a per-page level etc.

Trust me. The people who came up with MAP_COPY were stupid. Really. It's
an idiotic concept, and it's not worth implementing.

And this all for what is a administration bug in the first place.

In short: just say NO TO DRUGS, and maybe you won't end up like the Hurd
people.

		Linus

