Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbTDGSym (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 14:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbTDGSym (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 14:54:42 -0400
Received: from ns.suse.de ([213.95.15.193]:17158 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263591AbTDGSyk (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 14:54:40 -0400
To: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] New kernel tree for embedded linux
References: <20030407171037.GB8178@wohnheim.fh-wedel.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 07 Apr 2003 21:06:16 +0200
In-Reply-To: <20030407171037.GB8178@wohnheim.fh-wedel.de.suse.lists.linux.kernel>
Message-ID: <p73r88exh3r.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> writes:

> The RATIONALE is that on a ppc with some flash, memory, network and
> nothing much else, I don't feel like parsing MS-DOS partitions,
> offering IPX networking etc., but that junk is still included in
> 2.[45].current - unconditionally. And there is more...

Both dos partitions and IPX are already CONFIG_* options. As "conditional" 
as you can get. 

If you want to reduce memory bloat I would start with shrinking the
dynamic sized hashtables. That will likely give you several hundred KB
depending on the memory size, much more than you could get from
code size reductions.

Another obvious candidate for memory reduction would be mem_map
(struct page). If you accept some total memory size limit (256MB
with 4k pages) you could replace next_hash and pprev_hash with an
16bit index into mem_map and save 8 bytes per 4k of memory. Possible even 
fold count into flags and save another 4 bytes per 4k of memory
For 256MB of memory this would be 768k. That's more than a stripped
down kernel has code in total.

Probably more could be saved by attacking other bloated data structures
in the kernel.

Really there are many targets that have bigger potential pay off 
than just code shrinking.

If you want to shrink code:

The TCP/IP stack could be also put on a diet. You likely don't need
an backbone router class routing table manager in your embedded
system. The code is already modularized enough that it could be 
replaced with a simple "client" implementation using linked 
lists for routing tables with minor changes.
Unfortunately developing it is still quite some work.

-Andi
