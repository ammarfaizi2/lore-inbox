Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267225AbRGKIPL>; Wed, 11 Jul 2001 04:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267227AbRGKIOw>; Wed, 11 Jul 2001 04:14:52 -0400
Received: from mons.uio.no ([129.240.130.14]:40374 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S267225AbRGKIOq>;
	Wed, 11 Jul 2001 04:14:46 -0400
MIME-Version: 1.0
Message-ID: <15180.2794.472409.969703@charged.uio.no>
Date: Wed, 11 Jul 2001 10:14:34 +0200
To: Chris Wedgwood <cw@f00f.org>
Cc: Craig Soules <soules@happyplace.pdl.cmu.edu>, jrs@world.std.com,
        linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
In-Reply-To: <20010711013805.C31799@weta.f00f.org>
In-Reply-To: <15178.3722.86802.671534@charged.uio.no>
	<Pine.LNX.3.96L.1010709175623.16113S-100000@happyplace.pdl.cmu.edu>
	<15178.47928.328862.678031@charged.uio.no>
	<20010711013805.C31799@weta.f00f.org>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Chris Wedgwood <cw@f00f.org> writes:

     > On Tue, Jul 10, 2001 at 10:22:16AM +0200, Trond Myklebust
     > wrote:
     >     Imagine if somebody gives you a 1Gb directory. Would it or
     >     would it not piss you off if your file pointer got reset to
     >     0 every time somebody created a file?
    
     >     The current semantics are scalable. Anything which resets
     >     the file pointer upon change of a file/directory/whatever
     >     isn't...

     > Anyone using a 1GB directory deserves for it not to scale.  I
     > think this is a very poor example.

It's an extreme case, but it illustrates something the kernel should
be able to cope with.

     > No that I disagree with you, the largest directories I have on
     > my system here are 2.6MB (freedb, lots of hashed flat-files in
     > one directory), here I do agree that you should not have to
     > reset the counter everytime.

Right: this is what most people expect. The reason why the readdir
code went through several quite different incarnations in the 2.3.x
series was that duplicate directory entries were not acceptable to
people.

readdir() is not an atomic operation. You can't lock a directory while
doing a series of readdir calls either on local filesystems nor over
NFS. As such, the idea of volatile cookies doesn't really make sense,
nor is it supported in rfc1094 (NFSv2):

   Each "entry" contains a "fileid" which consists of a unique number
   to identify the file within a filesystem, the "name" of the file,
   and a "cookie" which is an opaque pointer to the next entry in the
   directory.  The cookie is used in the next READDIR call to get more
   entries starting at a given point in the directory.

Nothing there states that the cookie can be invalidated, nor is there
even an error to tell you that this is the case.


In rfc1813 (NFSv3), they recognized that NFSv2 couldn't cope with
stale cookies (yes: this fact is explicitly written down on pages 77
and 78), and hence they introduced the cookie verifier and the
NFS3ERR_BAD_COOKIE error, that can be used by the server to declare a
cookie as being stale. In this case, some extra recovery action might
make sense. I can see 3 possible solutions:

  1) The behaviour in this case is undefined. Leave it up to the
     user to reopen the directory, reset the file pointer, or whatever.
     This is what we do now.

  2) implement some extra caching info to allow an improved recovery
     of the last file position. This would likely have to involve
     storing the fileid + filename of the last entry somewhere in the
     struct file.

     This scheme means that lseek() breaks, and can undermine
     glibc. The latter has a lousy getdents algorithm in which it
     reads a number n of entries into a temporary buffer, the copy <=
     n entries to the user (because their struct dirent is larger than
     the kernel struct dirent), and then use lseek() to jump back.

  3) Implement something like Craig suggests whereby you reset the
     file pointer.

     This gives unexpected results as far as the user is concerned as
     it causes duplicate entries to pop up without any warning. It too
     breaks lseek(). It's a policy decision on behalf of the user.

If someone can persuade the glibc people to implement a sane algorithm
for getdents() that precalculates the upper limit on how much padding
is needed, and drops the use of lseek(), then (2) might possibly be
worth doing for 2.5.x (I believe I heard that Solaris does something
along these lines).

If not, given a choice between (1) and (3), I choose (1).



Finally, any scheme that assumes cookie staleness in all cases where
the directory mtime changes will not be passed on to Linus.

Cheers,
  Trond
