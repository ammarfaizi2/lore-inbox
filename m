Return-Path: <linux-kernel-owner+w=401wt.eu-S1161102AbXAEN4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161102AbXAEN4A (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 08:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161100AbXAEN4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 08:56:00 -0500
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:54644 "EHLO
	mail-gw1.sa.eol.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161099AbXAENz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 08:55:59 -0500
To: pavel@ucw.cz
CC: matthew@wil.cx, bhalevy@panasas.com, arjan@infradead.org,
       mikulas@artax.karlin.mff.cuni.cz, jaharkes@cs.cmu.edu,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
In-reply-to: <20070105131235.GB4662@ucw.cz> (message from Pavel Machek on Fri,
	5 Jan 2007 13:12:35 +0000)
Subject: Re: Finding hardlinks
References: <4593E1B7.6080408@panasas.com> <E1H01Og-0007TF-00@dorka.pomaz.szeredi.hu> <20070102191504.GA5276@ucw.cz> <E1H1qRa-0001t7-00@dorka.pomaz.szeredi.hu> <20070103115632.GA3062@elf.ucw.cz> <E1H25JD-0003SN-00@dorka.pomaz.szeredi.hu> <20070103135455.GA24620@parisc-linux.org> <E1H28Oi-0003kw-00@dorka.pomaz.szeredi.hu> <20070104225929.GC8243@elf.ucw.cz> <E1H2kfa-0007Jl-00@dorka.pomaz.szeredi.hu> <20070105131235.GB4662@ucw.cz>
Message-Id: <E1H2pXI-0007jY-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 05 Jan 2007 14:55:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well, sort of.  Samefile without keeping fds open doesn't have any
> > protection against the tree changing underneath between first
> > registering a file and later opening it.  The inode number is more
> 
> You only need to keep one-file-per-hardlink-group open during final
> verification, checking that inode hashing produced reasonable results.

What final verification?  I wasn't just talking about 'tar' but all
cases where st_ino might be used to check the identity of two files at
possibly different points in time.

Time A:    remember identity of file X
Time B:    check if identity of file Y matches that of file X

With samefile() if you open X at A, and keep it open till B, you can
accumulate large numbers of open files and the application can fail.

If you don't keep an open file, just remember the path, then renaming
X will foil the later identity check.  Changing the file at this path
between A and B can even give you a false positive.  This applies to
'tar' as well as the other uses.

Miklos
