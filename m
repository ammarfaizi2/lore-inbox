Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbRAPMec>; Tue, 16 Jan 2001 07:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbRAPMeW>; Tue, 16 Jan 2001 07:34:22 -0500
Received: from Cantor.suse.de ([194.112.123.193]:22280 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129534AbRAPMeJ>;
	Tue, 16 Jan 2001 07:34:09 -0500
Date: Tue, 16 Jan 2001 13:34:05 +0100
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        dean gaudet <dean-list-linux-kernel@arctic.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Jonathan Thackray <jthackray@zeus.com>
Subject: Re: O_ANY  [was: Re: 'native files', 'object fingerprints' [was: sendpath()]]
Message-ID: <20010116133405.A576@gruyere.muc.suse.de>
In-Reply-To: <20010116123743.A32075@gruyere.muc.suse.de> <Pine.LNX.4.30.0101161242180.529-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101161242180.529-100000@elte.hu>; from mingo@elte.hu on Tue, Jan 16, 2001 at 01:04:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2001 at 01:04:22PM +0100, Ingo Molnar wrote:
> - a less radical solution would be to still map file structures to an
> integer range (file descriptors) and usage-maintain files per processes,
> but relax the 'allocate first non-allocated integer in the range' rule.
> I'm not sure exactly how simple this is, but something like this should
> work: on close()-ing file descriptors the freed file descriptors would be
> cached in a list (this needs a new, separate structure which must be
> allocated/freed as well). Something like:
> 
> 	struct lazy_filedesc {
> 		int fd;
> 		struct file *file;
> 	}

More generic file -> fd mapping would be useful to speed up poll() too,
because the event trigger could directly modify the poll table without 
a second slow walk over the whole table. 

So you could add another bit that tells if the fd is open or closed 
and share it with poll. 

Also in that table you could just keep a linked ordered free list
and not use GFP_ANY, because getting the lowest would be rather cheap.

Disadvantage is that it would need more cache and more overhead than
the current scheme.
[in a way it is a ugly duck like pte<->vma links] 


> - Best-case overhead saves us a get_unused_fd() call, which can be *very*
>   expensive (in terms of CPU time and cache footprint) if thousands of
>   files are used. If O_ANY is used mostly, then the best-case is always
>   triggered.

Really? Does the open_fds bitmap get that big ?

Maybe it just needs a faster find_next_zero_bit() @)


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
