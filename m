Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWGQNBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWGQNBb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 09:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWGQNBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 09:01:31 -0400
Received: from daleth.esc.cam.ac.uk ([131.111.64.59]:34318 "EHLO
	aleph.esc.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750772AbWGQNBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 09:01:30 -0400
Date: Mon, 17 Jul 2006 14:01:28 +0100
From: James <20@madingley.org>
To: linux-kernel@vger.kernel.org
Subject: Bad ext3/nfs DoS bug
Message-ID: <20060717130128.GA12832@circe.esc.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Mail-Author: fish
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried contacting the relevant maintainers directly,
and it's even in the kernel bugzilla, but nothing's happened
and it's been over a month now. No-one seems to be doing anyting 
about this. Is one meant to post this to bugtraq or what?

Here's the bug: http://bugzilla.kernel.org/show_bug.cgi?id=6828
(exploit code follows)

> We found this rather surprising behaviour when debugging a
> network card for one of our embedded systems. There was a
> bus problem that occasionally caused the network card to
> place random data in the outgoing packets. We were using
> NFS root, as we hadn't written drivers for the block
> devices yet, and discovered our Linux NFS servers getting
> ext3 errors. It turned out that the 3com cards we have in
> the servers lie about checking UDP checksums, and passed
> the rubbish to knfsd where it was causing the problem. 
> 
> Here's an example one of our widgets (dcm503) is talking
> to an NFS server (dufftown)
> 
> 17:28:38.535011 dcm503.guralp.local.984095109 > dufftown.guralp.local.nfs: 116 
> lookup fh Unknown/1 "" (DF) (ttl 64, id 0, len 144)
>                          4500 0090 0000 4000 4011 3d45 0a52 01fa
>                          c0a8 3024 03ff 0801 007c 8e9c 3aa8 1985
>                          0000 0000 0000 0002 0001 86a3 0000 0002
>                          0000 0004 0000 0001 0000 001c 028f 5b0c
>                          0000 0006 6463 6d35 3033 0000 0000 0000
>                          0000 0000 0000 0000 0000 0000 0000 0000
>                          0100 0001 0021 0003 3d26 3d00 4a2f ffff
>                          3d00 2c08 c923 0000 0000 0000 0000 0000
>                          0000 0000 000a 6d6f 756e 7470 6f69 6e74
> 
> so what's happened here is 4a2f ffff should have been 4a2f
> xxxx but the network card has missed the clock on the bus
> and gotten ffff instead
> 
> nfsd_dispatch: vers 2 proc 4
> nfsd: LOOKUP   32: 01000001 03002100 003d263d ffff2f4a 082c003d 000023c9
> nfsd: nfsd_lookup(fh 32: 01000001 03002100 003d263d ffff2f4a 082c003d 
> 000023c9, )
> nfsd: fh_verify(32: 01000001 03002100 003d263d ffff2f4a 082c003d 000023c9)
> 
> so here the client does a V2 lookup with a DH which has
> gotten screwed up by my clients network card, this is
> received by my server, gets past the UDP checksum code
> (thank you 3com) and ends up at knfsd.
> 
> knfsd passes this to fh_verify which decodes it to be hde3
> and inode 4294913866 (0xffff2f4a)
> 
> that then gets passed to ext3 which then panics.
> 
> EXT3-fs error (device hde3): ext3_get_inode_block: bad inode number: 
> 4294913866
> 
> marks the file system as containing an error, and remounts
> the system read only.
> 
> Obviously this is sub optimal, and a fairly horrid DoS
> since anyone can craft a UDP packet, with a bogus FH in
> it. Whilst this is for V2_LOOKUP it works for all of the
> V2 procedures we tried.
> 

exploit code is available at

http://www.madingley.org/uploaded/crash-nfs.tar.gz

James.




