Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTJQDtk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 23:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263300AbTJQDtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 23:49:40 -0400
Received: from auto-matic.ca ([216.209.85.42]:33287 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S263281AbTJQDti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 23:49:38 -0400
Date: Thu, 16 Oct 2003 23:47:55 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Val Henson <val@nmt.edu>, Larry McVoy <lm@work.bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031017034755.GA18901@mark.mielke.cc>
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14> <3F8F0766.30405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8F0766.30405@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 05:02:30PM -0400, Jeff Garzik wrote:
> I'm curious if anyone has done any work on using multiple different 
> checksums?  For example, the cost of checksumming a single block with 
> multiple algorithms (sha1+md5+crc32 for a crazy example), and storing 
> each checksum (instead of just one sha1 sum), may be faster than reading 
> the block off of disk to compare it with the incoming block.  OTOH, 
> there is still a mathematical possibility (however-more-remote) of a 
> collission...

I believe you are drawing your conclusions on a incorrect hunch.

Figure that you had a 'perfect' hash algorithm, that would turn
any 32768 bit block (4096 bytes) into a 32 bit hash value. We will
define 'perfect' to mean that the algorithm is balanced (i.e. the
weight distribution of the hash values is approximately even).

Then, we find a second 'perfect' hash algorithm that can be
mathematically proven to have no similarities to the first algorithm,
and also maps 32768 bit blocks to 32 bit hash values.

The result is two 32 bit values, or a single 64 bit value. The
possible values that can be represented using 64 bits is 2**64-1.

The possible values that can be represented using 32768 bits is
2**32768-1. There is guaranteed to be *many* combinations of bytes
that would produce the same set of 32-bit hash values.

Now, we come back to reality. In reality, I suggest that it is
impossible (or unreasonably difficult) to come up with two 'perfect'
hash algorithms that have no similarities between them. It is likely
that the algorithms are not perfect, and have weaknesses (i.e. certain
hash values would result more frequently than others), and they also
have similarities that would cause these weaknesses to multiply against
each other, meaning that multiple algorithms may make the final result
*less* unique, than using the best algorithm, with a larger hash value.

On the other side of reality, certain types of blocks are a lot more
likely to appear than other types of blocks, within the same file, and
certain types of damage to files, affect blocks in only certain ways.
Meaning -- it is statistically difficult for a block to be altered or
damaged in such a way as to trick any proper checksum/hash algorithm
into thinking the block is valid, when it isn't.

Unclear conclusion? :-)

I believe that checksum/hash is a perfectly valid way of verifying the
consistency of data (no surprise here). I believe that using multiple
algorithms is silly. Instead, pick the best algorithm, and increase the
number of bits. I'll let the experts define 'best', but will suggest that
'best' is relative to the application. For a transmission protocol, 'best'
may mean 'best given that data corruption is only expected to happen in
the following ways'. For digital signatures, 'best' may mean 'statistically
difficult to create a message with the same hash value, that presents a
different apparently valid message'.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

