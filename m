Return-Path: <linux-kernel-owner+w=401wt.eu-S932233AbXAHIvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbXAHIvH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbXAHIvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:51:06 -0500
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:54361 "EHLO
	mail-gw2.sa.eol.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932233AbXAHIvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:51:04 -0500
To: mikulas@artax.karlin.mff.cuni.cz
CC: pavel@ucw.cz, matthew@wil.cx, bhalevy@panasas.com, arjan@infradead.org,
       jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, nfsv4@ietf.org
In-reply-to: <Pine.LNX.4.64.0701080652220.3506@artax.karlin.mff.cuni.cz>
	(message from Mikulas Patocka on Mon, 8 Jan 2007 06:57:06 +0100 (CET))
Subject: Re: Finding hardlinks
References: <4593E1B7.6080408@panasas.com> <E1H01Og-0007TF-00@dorka.pomaz.szeredi.hu>
 <20070102191504.GA5276@ucw.cz> <E1H1qRa-0001t7-00@dorka.pomaz.szeredi.hu>
 <20070103115632.GA3062@elf.ucw.cz> <E1H25JD-0003SN-00@dorka.pomaz.szeredi.hu>
 <20070103135455.GA24620@parisc-linux.org> <E1H28Oi-0003kw-00@dorka.pomaz.szeredi.hu>
 <20070104225929.GC8243@elf.ucw.cz> <E1H2kfa-0007Jl-00@dorka.pomaz.szeredi.hu>
 <20070105131235.GB4662@ucw.cz> <E1H2pXI-0007jY-00@dorka.pomaz.szeredi.hu>
 <Pine.LNX.4.64.0701051502120.28914@artax.karlin.mff.cuni.cz>
 <E1H2qhP-0007qc-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.64.0701080652220.3506@artax.karlin.mff.cuni.cz>
Message-Id: <E1H3qCY-0004mP-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 08 Jan 2007 09:49:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> No one guarantees you sane result of tar or cp -a while changing the tree.
> >> I don't see how is_samefile() could make it worse.
> >
> > There are several cases where changing the tree doesn't affect the
> > correctness of the tar or cp -a result.  In some of these cases using
> > samefile() instead of st_ino _will_ result in a corrupted result.
> 
> ... and those are what?

  - /a/p/x and /a/q/x are links to the same file

  - /b/y and /a/q/y are links to the same file

  - tar is running on /a

  - meanwhile the following commands are executed:

     mv /a/p/x /b/x
     mv /b/y /a/p/x

With st_ino checking you'll get a perfectly consistent archive,
regardless of the timing.  With samefile() you could get an archive
where the data in /a/q/y is not stored, instead it will contain the
data of /a/q/x.

Note, this is far nastier than the "normal" corruption you usually get
with changing the tree under tar, the file is not just duplicated or
missing, it becomes a completely different file, even though it hasn't
been touched at all during the archiving.

The basic problem with samefile() is that it can only compare files at
a single snapshot in time, and cannot take into account any changes in
the tree (unless keeping files open, which is impractical).

There's really no point trying to push for such an inferior interface
when the problems which samefile is trying to address are purely
theoretical.

Currently linux is living with 32bit st_ino because of legacy apps,
and people are not constantly agonizing about it.  Fixing the
EOVERFLOW problem will enable filesystems to slowly move towards 64bit
st_ino, which should be more than enough.

Miklos
