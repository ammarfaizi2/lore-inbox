Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264232AbUDNNas (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 09:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264233AbUDNNas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 09:30:48 -0400
Received: from [195.23.16.24] ([195.23.16.24]:35207 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S264232AbUDNNag convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 09:30:36 -0400
Message-ID: <407D3231.2080605@grupopie.com>
Date: Wed, 14 Apr 2004 13:44:33 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Guillaume@Lacote.name
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, Linux@glacote.com
Subject: Re: Using compression before encryption in device-mapper
References: <200404131744.40098.Guillaume@Lacote.name> <200404140854.56387.Guillaume@Lacote.name> <20040414094334.GA25975@wohnheim.fh-wedel.de> <200404141202.07021.Guillaume@Lacote.name>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.25.0.2; VDF: 6.25.0.12; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Lacôte wrote:

>>>Oops ! I thought it was possible to guarantee with the Huffman encoding
>>>(which is more basic than Lempev-Zif) that the compressed data use no
>>>more than 1 bit for every byte (i.e. 12,5% more space).

WTF??

Zlib gives a maximum increase of 0.1%  + 12 bytes (from the zlib manual), which 
for a 512 block will be a 2.4% guaranteed increase.

I think that zlib already does the "if this is bigger than original, just mark 
the block type as uncompressed" algorithm internally, so the increase is minimal 
in the worst case.

A while ago I started working on a proof of concept kind of thing, that was a 
network block device server that compressed the data sent to it.

I think that if we want to go ahead with this, we really should make the extra 
effort to have actual compression, and use the extra space.

 From my experience it is possible to get "near tar.gz" compression ratios on a 
scheme like this.

Biggest problems:

1 - We really need to have an extra layer of metadata. This is the worse part. 
Not only makes the thing much more complex, but it brings new problems, like 
making sure that the order the data is written to disk is transparent to the 
upper layers and won't wreck the journal on a journaling file system.

2 - The compression layer should report a large block size upwards, and use a 
little block size downwards, so that compression is as efficient as possible. 
Good results are obtained with a 32kB / 512 byte ratio. This can cause extra 
read-modify-write cycles upwards.

3 - If we use a fixed size partition to store compressed data, the apparent 
uncompressed size of the block device would have to change. Filesystems aren't 
prepared to have a block device that changes size on-the-fly. If we can solve 
this problem, then this compression layer could be really useful. Otherwise it 
can only be used over loopback on files that can grow in size (this could still 
be useful this way).

4 - The block device has no knowledge of what blocks are actually being used by 
the filesystem above, so it has to compress and store blocks that are actually 
"unused". This is not an actual problem, is just that it could be a little more 
efficient if it could ignore unused blocks.

When I did the tests I mounted an ext2 filesystem over the network block device. 
At least with ext2, the requests were gathered so that the server would often 
receive requests of 128kB, so the big block size problem is not too serious 
(performance will be bad anyway, this is a clear space/speed trade-off). This 
was kernel 2.4. I don't know enough about the kernel internals to know which 
layer is responsible for this "gathering".

On the up side, having an extra metadata layer already provides the "is not 
compressed" bit, so that we never need more than a block of disk to store one 
block of uncompressed data.

Anyway, I really think that if there is no solution for problem 3, there is 
little point in pushing this forward.

For a "better encryption only" scheme, we could use a much simpler scheme, like 
having a number of reserved blocks on the start of the block device to hold a 
bitmap of all the blocks. On this bitmap a 1 means that the block is 
uncompressed, so that if, after compression, the block is bigger than the 
original we can store it uncompressed.

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"

