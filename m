Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbTD3Vpm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 17:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbTD3Vpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 17:45:41 -0400
Received: from pat.uio.no ([129.240.130.16]:4783 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262447AbTD3Vpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 17:45:39 -0400
Date: Wed, 30 Apr 2003 23:57:59 +0200 (MEST)
From: =?iso-8859-1?Q?P=E5l_Halvorsen?= <paalh@ifi.uio.no>
To: bert hubert <ahu@ds9a.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: sendfile
In-Reply-To: <20030430192809.GA8961@outpost.ds9a.nl>
Message-ID: <Pine.SOL.4.51.0304302317590.13406@thrir.ifi.uio.no>
References: <Pine.LNX.4.51.0304301604330.12087@sondrio.ifi.uio.no>
 <20030430165103.GA3060@outpost.ds9a.nl> <Pine.SOL.4.51.0304302102300.12387@ellifu.ifi.uio.no>
 <20030430192809.GA8961@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Apr 2003, bert hubert wrote:

> On Wed, Apr 30, 2003 at 09:12:17PM +0200, P?l Halvorsen wrote:
>
> > It could be useful for applications like streaming video where other
> > protocols on top provide additional functionality or in a multicast
> > session where TCP migth not be appropriate.
>
> sendfile on UDP would try to send gigabits per second over ppp0...

YES, I guess sendfile will send "count" bytes as fast as possible using
UDP. However, can't sendfile be called several times, allowing the
sender to keep track of the offsett and byte count, e.g., sending the
data needed for a second video each second? Or does sendfile
close the file/socket after each call (really making it useful for only
whole file transfers at a time like retrieving a www-document)?

> > But should not the 2.4.X kernels have support for chained sk_buffs (like
> > the BSD mbufs) meaning that support for scatter-gatter I/O from the NIC
> > should be unneccessary to support zero-copy (i.e., NO in-memory data
> > copy operations)?
>
> No clue what you mean over here. Zero copy means different things to
> different people. Sendfile eliminates the 'read(to buffer);write(buffer to
> network);' copy.

First, zero-copy for me is to have no copy operations from one main memory
location to another (not counting the transfer from disk to memory and
from memory to NIC). Thus, I would like to read data into one memory
location and transfer the same data form the same location to the NIC.

I would like to be able to have data several places in memory
(like reading data from disk into several non-contiguous pages, e.g.
using DMA). Then, I would like to be able to send these data without
moving data to another memory location. If for example data for a packet
is located in two different pages, I'd like to have a sk_buff pointing to
each of these data areas and sending these two data chunks to the NIC
without having to copy the data into one single, continuous memory region
first before sending it to the NIC.

The issue about "chained" sk_buffs is something I read in the Linux
Journal (january issue I think) about sendfile. Taking a very brief look
at the sk_buff code, I think skb->data could be pointing to a
	struct skb_shared_info {
        	atomic_t        dataref;
        	unsigned int    nr_frags;
        	struct sk_buff  *frag_list;
        	skb_frag_t      frags[MAX_SKB_FRAGS];
	};
where each "frags" is a pointer to a page, the offset and the size.
Thus, the sk_buff could be able to get data from several memory pages
for a single packet!??

However, you will have a data transfer to the CPU calculating the
checksum, but the data will not be put into another memory region (i.e.,
no copy operation).

> Some network drivers again may eliminate the 'copy_with_checksum()' step,
> allowing minus-one-copy, in zerocopy reference frame.

Does this mean that if the NIC cannot perform the checksum on-board, the
Linux communication system performs a "copy_with_checksum" copying the
data to another location when performing the checksum, i.e., always
giving a copy operation?

-ph

> Regards,
>
> bert

