Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281179AbRKTRiH>; Tue, 20 Nov 2001 12:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281181AbRKTRh5>; Tue, 20 Nov 2001 12:37:57 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:57814 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281179AbRKTRht>;
	Tue, 20 Nov 2001 12:37:49 -0500
Date: Tue, 20 Nov 2001 12:37:45 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Mike Castle <dalgoda@ix.netcom.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: x bit for dirs: misfeature?
In-Reply-To: <20011120091838.B16407@thune.mrc-home.com>
Message-ID: <Pine.GSO.4.21.0111201226320.21912-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Nov 2001, Mike Castle wrote:

> find /path/to/dir -type d -print0 | xargs -0 chmod a+rx
> find /path/to/dir -type f -print0 | xargs -0 chmod a+r
> 
> That way, xargs bunches up the arguments into as many arguments as chmod
> can handle, and calls it fewer times.
> 
> The -print0 and -0 are GNU extensions to handle spaces in names.

That's even worse than original.  You've got a very wide race here -
think what happens if luser does

cd /path/to/dir/something/writable/to/luser
mkdir bar
mkdir baz
for i in `seq 1 500`; do
	mkdir bar/$i
	touch bar/$i/shadow
	ln -sf /etc baz/$i
done

before you start, then waits for first chmod a+r and does

mv bar quux; mv baz bar

leaving you with very interesting results.  It's much wider window than
in the original.

