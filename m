Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266684AbRGJRGZ>; Tue, 10 Jul 2001 13:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266683AbRGJRGG>; Tue, 10 Jul 2001 13:06:06 -0400
Received: from ns.suse.de ([213.95.15.193]:11782 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S266684AbRGJRGC>;
	Tue, 10 Jul 2001 13:06:02 -0400
Date: Tue, 10 Jul 2001 19:06:02 +0200
From: Andi Kleen <ak@suse.de>
To: Craig Soules <soules@happyplace.pdl.cmu.edu>
Cc: Andi Kleen <ak@suse.de>, Chris Wedgwood <cw@f00f.org>,
        linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
Message-ID: <20010710190602.A8997@gruyere.muc.suse.de>
In-Reply-To: <20010710154135.A4603@gruyere.muc.suse.de> <Pine.LNX.3.96L.1010710124338.16113W-100000@happyplace.pdl.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96L.1010710124338.16113W-100000@happyplace.pdl.cmu.edu>; from soules@happyplace.pdl.cmu.edu on Tue, Jul 10, 2001 at 12:48:20PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2001 at 12:48:20PM -0400, Craig Soules wrote:
> On Tue, 10 Jul 2001, Andi Kleen wrote:
> > Because to get that new cookie you would need another cookie; otherwise
> > you could violate the readdir guarantee that it'll never return files
> > twice.
> 
> I cannot locate any such guarantee in the NFS spec... are you refering to
> another spec which applies?

It's the unix semantics of readdir(); e.g. specified in Single Unix:

``   The type DIR, which is defined in the header <dirent.h>, represents
     a directory stream, which is an ordered sequence of all the
     directory entries in a particular directory. Directory entries
     represent files; files may be removed from a directory or added to
     a directory asynchronously to the operation of readdir(). ''

An ordered sequence does not include cycles.


> 
> > BTW; the cookie issue is not an NFS only problem. It occurs on local
> > IO as well. Just consider rm -rf - reading directories and in parallel
> > deleting them (the original poster's file system would have surely
> > gotten that wrong). Another tricky case is telldir().  
> 
> I don't believe that the behavior in this case is deterministic.  If you
> have multiple people accessing a single file, reading and writing to it,
> there is no guarantee as to what the behavior is.  The client should be
> able to handle any errors it creates for itself while doing this kind of
> parallel operation.

What happens with new entries added is unspecified; but old entries removed
in parallel should never cause a violation of the rule above.

A simple index into a rebalancing btree unfortunately doesn't fulfil this;
but there are ways to add additional layers to fix it.

The easiest test for it is rm -rf. 


-Andi
