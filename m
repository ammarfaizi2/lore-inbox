Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275720AbRJQLPJ>; Wed, 17 Oct 2001 07:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275719AbRJQLPA>; Wed, 17 Oct 2001 07:15:00 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:25869 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S275716AbRJQLOu>; Wed, 17 Oct 2001 07:14:50 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: NFS file locking?
Date: Wed, 17 Oct 2001 11:15:23 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9qjp8b$o3q$1@ncc1701.cistron.net>
In-Reply-To: <200110141811.f9EIB4823631@work.bitmover.com> <15306.9552.673923.69404@notabene.cse.unsw.edu.au> <20011014193844.C13153@work.bitmover.com>
X-Trace: ncc1701.cistron.net 1003317323 24698 195.64.65.67 (17 Oct 2001 11:15:23 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011014193844.C13153@work.bitmover.com>,
Larry McVoy  <lm@bitmover.com> wrote:
>OK, tried that too, here's the code.  Doesn't work.  Neither does the
>link approach.  Am I doing something wrong?  It seems to me that I'm
>completely at the mercy of the client NFS implementation - if it caches
>stuff wrong, I'm hosed.  There has to be some cute trick to get past this.

Download ftp://ftp.debian.org/debian/pool/main/libl/liblockfile/liblockfile_1.03.tar.gz

It contains NFS safe locking functions, and it knows how to work around
NFS client caches. And it documents all algorithms in the manpages too.

ALGORITHM
       The algorithm that is used to  create  a  lockfile  in  an
       atomic way, even over NFS, is as follows:

       1      A  unique  file  is  created. In printf format, the
              name of the file is .lk%05d%x%s. The first argument
              (%05d)  is the current process id. The second argu­
              ment (%x) consists of the 4 minor bits of the value
              returned  by time(2). The last argument is the sys­
              tem hostname.


       2      Then the lockfile is  created  using  link(2).  The
              return value of link is ignored.


       3      Now the lockfile is stat()ed. If the stat fails, we
              go to step 6.


       4      The stat value of the  lockfile  is  compared  with
              that  of  the temporary file. If they are the same,
              we have the lock. The temporary file is deleted and
              a value of 0 (success) is returned to the caller.


       5      A  check is made to see if the existing lockfile is
              a valid one. If it isn't valid, the stale  lockfile
              is deleted.


       6      Before  retrying, we sleep for n seconds. n is ini­
              tially 5 seconds, but after  every  retry  5  extra
              seconds  is added up to a maximum of 60 seconds (an
              incremental backoff). Then we go to step  2  up  to
              retries times.


REMOTE FILE SYSTEMS AND THE KERNEL ATTRIBUTE CACHE
       If  you  are  using  lockfile_create to create a lock on a
       file that resides on a remote server, and you already have
       that  file open, you need to flush the NFS attribute cache
       after locking. This is needed  to  prevent  the  following
       scenario:

       o  open /var/mail/USERNAME
       o  attributes,  such as size, inode, etc are now cached in
          the kernel!
       o  meanwhile,  another  remote  system  appends  data   to
          /var/mail/USERNAME
       o  grab lock using lockfile_create()
       o  seek to end of file
       o  write data

       Now the end of the file really isn't the end of the file -
       the kernel cached the attributes on open, and  st_size  is
       not  the  end  of  the  file anymore. So after locking the
       file, you need to tell the kernel to flush  the  NFS  file
       attribute cache.

       The only portable way to do this is the POSIX fcntl() file
       locking primitives - locking a file using fcntl() has  the
       fortunate   side-effect   of  invalidating  the  NFS  file
       attribute cache of the kernel.

       lockfile_create() cannot do this for you for two  reasons.
       One,  it  just  creates  a lockfile- it doesn't know which
       file you are actually trying to  lock!  Two,  even  if  it
       could deduce the file you're locking from the filename, by
       just opening and  closing  it,  it  would  invalidate  any
       existing  POSIX  locks  the  program might already have on
       that file (yes, POSIX locking semantics are insane!).

       So basically what you need to do is something like this:

         fd = open("/var/mail/USER");
         .. program code ..

         lockfile_create("/var/mail/USER.lock", x, y);

         /* Invalidate NFS attribute cache using POSIX locks */
         if (lockf(fd, F_TLOCK, 0) == 0) lockf(fd, F_ULOCK, 0);

       You have to be careful with this if you're putting this in
       an  existing  program that might already be using fcntl(),
       flock() or lockf() locking- you might invalidate  existing
       locks.



       There  is also a non-portable way. A lot of NFS operations
       return the updated attributes - and the Linux kernel actu­
       ally  uses  these  to  update  the attribute cache. One of
       these operations is chmod(2).

       So stat()ing a file and then chmod()ing it  to  st.st_mode
       will  not  actually change the file, nor will it interfere
       with any locks on the file, but  it  will  invalidate  the
       attribute cache. The equivalent to use from a shell script
       would be

         chmod u=u /var/mail/USER

Mike.
-- 
Move sig.

