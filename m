Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268051AbTB1Sj5>; Fri, 28 Feb 2003 13:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268060AbTB1Sj5>; Fri, 28 Feb 2003 13:39:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55566 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268051AbTB1Sj4>; Fri, 28 Feb 2003 13:39:56 -0500
Date: Fri, 28 Feb 2003 10:47:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, <lse-tech@projects.sourceforge.net>
Subject: Re: [PATCH] New dcache / inode hash tuning patch
In-Reply-To: <p73n0kg7qi7.fsf@amdsimf.suse.de>
Message-ID: <Pine.LNX.4.44.0302281039570.3177-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 28 Feb 2003, Andi Kleen wrote:
>
> Also isn't it a bit late in the 2.5 cycle to think about such radical
> changes like local lookup?

Look again at my suggestion: forcing locality by just changing the hash
function to _intentionally_ bunch directory hashes together.

Yes, it's "pseudo-locality" (and my example hash was truly broken: we 
must _not_ use the directory dentry hash value as part of the hash, as the 
hash needs to be stable over the whole lifetime of the directory dentry), 
but the point is that by just changing the hashing algorithm you can 
potentially get a good portion of the locality we want.

Right now the dcache hash is often something like 17 bits - and we could
easily make it so that roughly "half" the bits would be based purely on
the directory. That would still give each directory ~8 bits worth of
"local hashing", which is fairly reasonable.

> It sounds more like a nice 2.7 project.

It sounds more like changing two lines of code to me.

> I believe my patch with a bit more tweaking (my current 64K hash table
> seems to be too small) is suitable even for an soon to be stable
> kernel.

Quite frankly, right now the only report I've seen about your patch is 
that it made things slightly _slower_.

For a patch that is supposed to speed stuff up, that's a damn bad track 
record. Sorry.

I'd suggest you drop the hash size changes, and try with _just_ the hlist 
stuff, and once that is verified to perform well, _then_ worry about 
hashing changes. Because quite frankly, I suspect my "local hash" thing 
performs better than "make the hashes smaller". And the hash algorithm and 
size is _totally_ independent from whether it uses the regular lists or 
the hlists..

			Linus

