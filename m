Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276966AbRJKW0k>; Thu, 11 Oct 2001 18:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276990AbRJKW0a>; Thu, 11 Oct 2001 18:26:30 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:32647 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276966AbRJKW0T>;
	Thu, 11 Oct 2001 18:26:19 -0400
Date: Thu, 11 Oct 2001 18:26:42 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: adilger@turbolabs.com, arvest@orphansonfire.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.11 loses sda9
In-Reply-To: <UTC200110112211.WAA33043.aeb@cwi.nl>
Message-ID: <Pine.GSO.4.21.0110111815520.24742-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Oct 2001 Andries.Brouwer@cwi.nl wrote:

> Not really. I don't know whether you ever tried the experiment
> and compiled kdev_t as a pointer to a struct with two members
> namely major and minor, where the struct is allocated by MKDEV().
> Very few places break, and these places are very easy to fix.
> Stuff that is used as numbers can be forgotten quickly.
> It is not difficult at all to get a kernel up and running that has
> kdev_t a pointer type.

Ugh... When do you free them?
 
> > Moreover, allocation policy for these structures is a tricky beast.
> 
> Yes. I entirely agree. All the rest is a mechanical action.
> (Or, more precisely, removable modules require freeing, and
> freeing requires refcounting. It is the refcounting that is
> work, more than the allocation.)

Precisely.  I think that on the block side we are fairly close to
reasonable one - at least I see how to get there.  Character devices
are nastier - especially with the lack of common point on ->release()
path (->f_op reassignment done by various subsystems).  Once we have
that, the rest will be pretty easy (there will be a separate issue
with per-disk objects, e.g. for serialization between open() and
BLKRRPART, but that's almost independent).

However, amount of mechanical work is going to be large - especially
if ->i_rdev becomes dev_t.  That means changing types of a lot of local
variables in drivers and I'd rather leave that to 2.5.  It _does_ break
source compatibility, and that makes it -CURRENT material.

