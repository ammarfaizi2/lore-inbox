Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUDNOCu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 10:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbUDNOCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 10:02:50 -0400
Received: from p4.ensae.fr ([195.6.240.202]:65397 "EHLO pc809.ensae.fr")
	by vger.kernel.org with ESMTP id S261258AbUDNOCq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 10:02:46 -0400
From: Guillaume =?iso-8859-1?q?Lac=F4te?= <Guillaume@Lacote.name>
Reply-To: Guillaume@Lacote.name
Organization: Guillaume@Lacote.name
To: Paulo Marques <pmarques@grupopie.com>
Subject: Re: Using compression before encryption in device-mapper
Date: Wed, 14 Apr 2004 16:02:43 +0200
User-Agent: KMail/1.5.3
Cc: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, Linux@glacote.com
References: <200404131744.40098.Guillaume@Lacote.name> <200404141202.07021.Guillaume@Lacote.name> <407D3231.2080605@grupopie.com>
In-Reply-To: <407D3231.2080605@grupopie.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200404141602.43695.Guillaume@Lacote.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mercredi 14 Avril 2004 14:44, Paulo Marques a écrit :
> Guillaume Lacôte wrote:
> >>>Oops ! I thought it was possible to guarantee with the Huffman encoding
> >>>(which is more basic than Lempev-Zif) that the compressed data use no
> >>>more than 1 bit for every byte (i.e. 12,5% more space).
>
> WTF??
>
> Zlib gives a maximum increase of 0.1%  + 12 bytes (from the zlib manual),
> which for a 512 block will be a 2.4% guaranteed increase.
>
> I think that zlib already does the "if this is bigger than original, just
> mark the block type as uncompressed" algorithm internally, so the increase
> is minimal in the worst case.
Actually (see my reply to Timothy Miller) I really want to do "compression" 
even if it does not reduce space: it is a matter of growing the per-bit 
entropy rather than to gain space (see http://jsam.sourceforge.net). Moreover 
I do not want to use sophisticated algorithms (in order to be able to compute 
plain text random distributions that ensure that the compressed distributions 
will be uniform, which is very difficult with for e.g zlib; in particular 
having any kind of "meta-data", "signatures" or "dictionnary" is a no-go for 
me). See details at the end of this post.

I should have made clear that my aim is not space efficiency, although I do 
believe that having a transparent space-efficient compression target a-la 
cloop would be nice.

>
> A while ago I started working on a proof of concept kind of thing, that was
> a network block device server that compressed the data sent to it.
Would it be possible for you to point me to the relevant material ?
>
> I think that if we want to go ahead with this, we really should make the
> extra effort to have actual compression, and use the extra space.
I strongly agree but I fear that I do not have sufficient knowledge to go this 
way.
>
>  From my experience it is possible to get "near tar.gz" compression ratios
> on a scheme like this.
>
> Biggest problems:
>
> 1 - We really need to have an extra layer of metadata. This is the worse
> part. Not only makes the thing much more complex, but it brings new
> problems, like making sure that the order the data is written to disk is
> transparent to the upper layers and won't wreck the journal on a journaling
> file system.
>
> 2 - The compression layer should report a large block size upwards, and use
> a little block size downwards, so that compression is as efficient as
> possible. Good results are obtained with a 32kB / 512 byte ratio. This can
> cause extra read-modify-write cycles upwards.
I failed to understand; could you provide me with more details please ?
>
> 3 - If we use a fixed size partition to store compressed data, the apparent
> uncompressed size of the block device would have to change. Filesystems
> aren't prepared to have a block device that changes size on-the-fly. If we
> can solve this problem, then this compression layer could be really useful.
> Otherwise it can only be used over loopback on files that can grow in size
> (this could still be useful this way).
>
> 4 - The block device has no knowledge of what blocks are actually being
> used by the filesystem above, so it has to compress and store blocks that
> are actually "unused". This is not an actual problem, is just that it could
> be a little more efficient if it could ignore unused blocks.
>
> When I did the tests I mounted an ext2 filesystem over the network block
> device. At least with ext2, the requests were gathered so that the server
> would often receive requests of 128kB, so the big block size problem is not
> too serious (performance will be bad anyway, this is a clear space/speed
> trade-off). This was kernel 2.4. I don't know enough about the kernel
> internals to know which layer is responsible for this "gathering".
>
> On the up side, having an extra metadata layer already provides the "is not
> compressed" bit, so that we never need more than a block of disk to store
> one block of uncompressed data.
>
> Anyway, I really think that if there is no solution for problem 3, there is
> little point in pushing this forward.
You are right I presume.
>
> For a "better encryption only" scheme, we could use a much simpler scheme,
> like having a number of reserved blocks on the start of the block device to
> hold a bitmap of all the blocks. On this bitmap a 1 means that the block is
> uncompressed, so that if, after compression, the block is bigger than the
> original we can store it uncompressed.
As I said earlier I my point is definetely not to gain space, but to grow the 
"per-bit entropy". I really want to encode my data even if this grows its 
length, as is done in http://jsam.sourceforge.net . My final goal is the 
following: for each plain block first draw a chunk of random bytes, and then 
compresse both the random bytes followed by the plain data with a dynamic 
huffman encoding. The random bytes are _not_ drawn uniformly, but rather so 
that the distribution on huffman trees (and thus on encodings) is uniform. 
This ensures (?) that an attacker really has not other solution to decipher 
the data than brute-force: each and every key is possible, and more 
precisely, each and every key is equi-probable.
This is definetely _not_ the case with ext2 over dm-crypt, since for example 
the first sectors are well-known and can help reducing the key search space. 
Once you have a pre-calculated dictionnary of all possible outputs of the 
first 512 bytes of an ext2 partition with all possible keys, finding a secret 
key is trivial ...

This has little to do with compression for space efficiency, although you are 
definetely right that this could be useful to more end-users ...

