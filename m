Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276914AbRJKUyO>; Thu, 11 Oct 2001 16:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276917AbRJKUyF>; Thu, 11 Oct 2001 16:54:05 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:8186 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276914AbRJKUx5>;
	Thu, 11 Oct 2001 16:53:57 -0400
Date: Thu, 11 Oct 2001 16:54:23 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: adilger@turbolabs.com, arvest@orphansonfire.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.11 loses sda9
In-Reply-To: <UTC200110112029.UAA31163.aeb@cwi.nl>
Message-ID: <Pine.GSO.4.21.0110111632220.24742-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Oct 2001 Andries.Brouwer@cwi.nl wrote:

> > You know what problems with unified device struct I've brought before.
> 
> I don't mind splitting kdev_t into kbdev_t and kcdev_t.
> Keeping the former requires a cast or a union somewhere.
> Splitting requires some code duplication.
> Altogether there is very little difference between the two setups.

typedef struct block_device *kbdev_t;
 
Aside of 1:5 vowels to consonants ratio I've no problems with that.

> Remains the question, let me repeat:
> "Al, I never understood why you want to introduce a struct block_device *
>  to do precisely what kdev_t was designed to do."
> 
> I see that you are making small steps away from my goal, so I hope
> you know very precisely where you want to go and how to get there.

Right now we have a big and fairly nasty mix of the stuff that can be
turned in pointer to block device, pointer to character device _and_
stuff that is used as numbers.  Moreover, allocation policy for these
structures is a tricky beast - block ones are mostly sane now, but
character are most definitely not. Right now we have places where
we look up the blocksize, etc. with nothing more than a number.
Actually, recent changes, as much as I'd prefer to see them done only
in 2.5, help in that respect - they remove one of the major sources
of that.  Switching get_...size() to stuct block_device * (or kbdev_t
is you like to spell it that way) is a good thing, but it deserves
a separate patch.  And no, changing definition of kdev_t is not a
good idea right now - too large patch and too many places to audit.

Resulting setup is going to be pretty close, indeed, but getting
there is going to take some work.

> > But that's 2.5 stuff
> 
> Yes, precisely. But you do not wait for 2.5 but start walking already.

We needed to switch partition-related code to pagecache; _that_ was the
result of changes that were, IMO, bad idea at that point.  But these
changes were done and we have to deal with the fallout.  Getting to the
address_space of device in question requires pointer to structure.  So
the choice is between merging your patch on top of Andrea's stuff +
fixes to said stuff and praying  and  propagating pointer to existing
object in places where we need it and trying to debug that.  Somehow
the latter variant seems less painful.

