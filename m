Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281040AbRKTMCN>; Tue, 20 Nov 2001 07:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281046AbRKTMBx>; Tue, 20 Nov 2001 07:01:53 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:43469 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281040AbRKTMBu>;
	Tue, 20 Nov 2001 07:01:50 -0500
Date: Tue, 20 Nov 2001 07:01:49 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: vda <vda@port.imtp.ilyichevsk.odessa.ua>,
        Horst von Brand <vonbrand@inf.utfsm.cl>,
        James A Sutherland <jas88@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: x bit for dirs: misfeature?
In-Reply-To: <5.1.0.14.2.20011120111439.04d42380@pop.cus.cam.ac.uk>
Message-ID: <Pine.GSO.4.21.0111200639010.21912-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Nov 2001, Anton Altaparmakov wrote:

> So what? The following two commands do exactly that:
> 
> find . -type d -exec chmod a+rx "{}" \;
> find . -type f -exec chmod a+r "{}" \;
> 
> Just stick them in a shell script and call the script chmod-world-readable 
> and stop complaining...

Just don't do that if that subtree contains a directory writable to somebody
else.  There is a nasty attack here.

Think what happens if root does that for /tmp/foo and some luser has write
permissions on /tmp/foo/bar.  There is a window between execve() on chmod(1)
and call of chmod(2) and during that window luser can replace /tmp/foo/bar/baz
to symlink to /etc and leave root doing chmod("/tmp/foo/bar/baz/shadow", 0744);

Not that chmod(1) was any better at that...  It should've been keeping
all chain between the root of subtree and parent of file we currently
handling opened and do open()/fstat()/fchdir() to go down and fchdir()
to go up.  Then all calls of chmod(2) would be for files in current
directory, which prevents symlink attacks.

Moral: think _very_ hard when you write any tree-walking code that will
ever be used on a tree writable to somebody else.

