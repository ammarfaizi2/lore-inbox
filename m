Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281118AbRKTPKX>; Tue, 20 Nov 2001 10:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281116AbRKTPKN>; Tue, 20 Nov 2001 10:10:13 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:43161 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S281105AbRKTPKJ>;
	Tue, 20 Nov 2001 10:10:09 -0500
Message-Id: <5.1.0.14.2.20011120142040.02701100@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 20 Nov 2001 15:08:45 +0000
To: Alexander Viro <viro@math.psu.edu>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: x bit for dirs: misfeature?
Cc: vda <vda@port.imtp.ilyichevsk.odessa.ua>,
        Horst von Brand <vonbrand@inf.utfsm.cl>,
        James A Sutherland <jas88@cam.ac.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0111200639010.21912-100000@weyl.math.psu.edu
 >
In-Reply-To: <5.1.0.14.2.20011120111439.04d42380@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:01 20/11/01, Alexander Viro wrote:
>On Tue, 20 Nov 2001, Anton Altaparmakov wrote:
> > So what? The following two commands do exactly that:
> >
> > find . -type d -exec chmod a+rx "{}" \;
> > find . -type f -exec chmod a+r "{}" \;
> >
> > Just stick them in a shell script and call the script chmod-world-readable
> > and stop complaining...
>
>Just don't do that if that subtree contains a directory writable to somebody
>else.  There is a nasty attack here.

Ok. But I assume the application for this is something like /usr/share to 
which noone would have write privileges to (I would hope). I doubt anyone 
would want to run it on /home... and if they do they most likely don't care 
about security too much anyway... (-;

>Think what happens if root does that for /tmp/foo and some luser has write
>permissions on /tmp/foo/bar.  There is a window between execve() on chmod(1)
>and call of chmod(2) and during that window luser can replace /tmp/foo/bar/baz
>to symlink to /etc and leave root doing chmod("/tmp/foo/bar/baz/shadow", 
>0744);
>
>Not that chmod(1) was any better at that...  It should've been keeping
>all chain between the root of subtree and parent of file we currently
>handling opened and do open()/fstat()/fchdir() to go down and fchdir()
>to go up.  Then all calls of chmod(2) would be for files in current
>directory, which prevents symlink attacks.
>
>Moral: think _very_ hard when you write any tree-walking code that will
>ever be used on a tree writable to somebody else.

Point taken. I will keep it in mind when implementing ACLs (and ACL 
inheritance in particular) in NTFS. That will involve walking back to the 
volume's root to establish the inherited rights... which might perhaps lend 
itself to simillar abuse.

Cheers,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

