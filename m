Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131016AbRBVCaE>; Wed, 21 Feb 2001 21:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131049AbRBVC3y>; Wed, 21 Feb 2001 21:29:54 -0500
Received: from hermes.mixx.net ([212.84.196.2]:60934 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S131016AbRBVC3i>;
	Wed, 21 Feb 2001 21:29:38 -0500
Message-ID: <3A947953.B88A23E2@innominate.de>
Date: Thu, 22 Feb 2001 03:28:35 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <01022022544707.18944@gimli> <Pine.LNX.4.10.10102201618520.31530-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 20 Feb 2001, Daniel Phillips wrote:
> >
> > You mean full_name_hash?  I will un-static it and try it.  I should have
> > some statistics tomorrow.  I have a couple of simple metrics for
> > measuring the effectiveness of the hash function: the uniformity of
> > the hash space splitting (which in turn affects the average fullness
> > of directory leaves) and speed.
> 
> I was more thinking about just using "dentry->d_name->hash" directly, and
> not worrying about how that hash was computed. Yes, for ext2 it will have
> the same value as "full_name_hash" - the difference really being that
> d_hash has already been precomputed for you anyway.
> 
> > Let the hash races begin.
> 
> Note that dentry->d_name->hash is really quick (no extra computation), but
> I'm not claiming that it has anything like a CRC quality. And it's
> probably a bad idea to use it, because in theory at least the VFS layer
> might decide to switch the hash function around. I'm more interested in
> hearing whether it's a good hash, and maybe we could improve the VFS hash
> enough that there's no reason to use anything else..

In the first heat of hash races - creating 20,000 files in one directory
- dentry::hash lost out to my original hack::dx_hash, causing a high
percentage of leaf blocks to remain exactly half full and slowing down
the whole thing by about 5%.  (This was under uml - I haven't tried it
native yet but I expect the results to be similar.)

	  Contender			Result
	  =========			======
	dentry::hash		Average fullness = 2352 (57%)
	hack::dx_hash		Average fullness = 2758 (67%)

This suggests that dentry::hash is producing distinctly non-dispersed
results and needs to be subjected to further scrutiny.  I'll run the
next heat of hash races tomorrow, probably with R5, and CRC32 too if I
have time.

--
Daniel
