Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135593AbRDSUIT>; Thu, 19 Apr 2001 16:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135603AbRDSUIC>; Thu, 19 Apr 2001 16:08:02 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:29836 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S135593AbRDSUHo>;
	Thu, 19 Apr 2001 16:07:44 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com (Linus Torvalds),
        viro@math.psu.edu (Alexander Viro),
        abramo@alsa-project.org (Abramo Bagnara), alonz@nolaviz.org (Alon Ziv),
        linux-kernel@vger.kernel.org (Kernel Mailing List),
        mkravetz@sequent.com (Mike Kravetz)
Subject: Re: light weight user level semaphores
In-Reply-To: <E14qKDi-0007sy-00@the-village.bc.nu>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 19 Apr 2001 13:06:45 -0700
In-Reply-To: Alan Cox's message of "Thu, 19 Apr 2001 20:35:59 +0100 (BST)"
Message-ID: <m3lmow1woa.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> mknod foo p. Or use sockets (although AF_UNIX sockets are higher latency)
> Thats why I suggested using flock - its name based. Whether you mkstemp()
> stuff and pass it around isnt something I care about
> 
> Files give you permissions for free too

I don't want nor need file permissions.  A program would look like this:


  process 1:


   fd = open("somefile")
   addr = mmap(fd);
   
   pthread_mutexattr_init(&attr);
   pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);

   pthread_mutex_init ((pthread_mutex_t *) addr, &attr);

   pthread_mutex_lock ((pthread_mutex_t *) addr);

   pthread_mutex_destroy((pthread_mutex_t *) addr);

  process 2:

   fd = open("somefile")
   addr = mmap(fd);

   pthread_mutex_lock ((pthread_mutex_t *) addr);


The shared mem segment can be retrieved in whatever way.  The mutex in
this case is anonymous.  Everybody who has access to the shared mem
*must* have access to the mutex.


For semaphores it looks similarly.  First the anonymous case:

 process 1:


   fd = open("somefile")
   addr = mmap(fd);

   sem_init ((sem_t *) addr, 1, 10);	// 10 is arbitrary

   sem_wait ((sem_t *) addr);

   sem_destroy((sem_t *) addr);


  process 2:

   fd = open("somefile")
   addr = mmap(fd);

   sem_wait ((sem_t *) addr);

Note that POSIX semaphores could be implemented with global POSIX
mutexes.


Finally, named semaphores:

   semp = sem_open("somefile", O_CREAT|O_EXCL, 0600)

   sem_wait (semp);

   sem_close(semp);
   sem_unlink(semp);


This is the only semaphore kind which maps nicely to a pipe or socket.
All the others don't.  And even for named semaphores it is best to
have a separate name space like the shmfs.

> So you have unix file permissions on them ?

See above.  Permissions are only allowed for named semaphores.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
