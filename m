Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135741AbRDSWgx>; Thu, 19 Apr 2001 18:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135742AbRDSWgn>; Thu, 19 Apr 2001 18:36:43 -0400
Received: from 4dyn165.delft.casema.net ([195.96.105.165]:56593 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S135741AbRDSWg3>; Thu, 19 Apr 2001 18:36:29 -0400
Message-Id: <200104192235.AAA09208@cave.bitwizard.nl>
Subject: Re: light weight user level semaphores
In-Reply-To: <E14qHz3-0007cZ-00@the-village.bc.nu> from Alan Cox at "Apr 19,
 2001 06:12:42 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 20 Apr 2001 00:35:57 +0200 (MEST)
CC: Linus Torvalds <torvalds@transmeta.com>, Alon Ziv <alonz@nolaviz.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mkravetz@sequent.com>,
        Ulrich Drepper <drepper@cygnus.com>
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > > libc is entitled to, and most definitely does exactly that. Take a look at
> > > things like gethostent, getpwent etc etc.
> > 
> > Ehh.. I will bet you $10 USD that if libc allocates the next file
> > descriptor on the first "malloc()" in user space (in order to use the
> > semaphores for mm protection), programs _will_ break.
> > 
> > You want to take the bet?
> 
> Its not normally a good idea to take a Linus bet, but this time Im obviously
> missing something. fd0-2 will be passed in (and if not then shit already
> happens - see old bugtraq on the matter for setuid apps, glibc bugs)
> 
> So the C library gets fd 3
> My first fopen gets fd 4.

Code may 
	close (0);
	close (1);
	close (2); 
	... 
	malloc (); 

	/* Now open our controlling TTY/ stdin .. */ 
	fd = open (... ) ;

After taking care of this (*), problem I find the fd trick WAY more
appealing than Linus' magic numbers. With file descriptors we have a
"small integer which can be validated quickly". We also have storage
for a private pointer somewhere in the fd structure. 

If people are TOO afraid of breaking something, creating a new set of
small integers handled similarly as "fds" would do fine. (Maybe here
we'd allocate just a few, and reallocate when neccesary).

Roger. 

(*) I bet that 
	get_sem_fd () 
	{
	int rv;
	int fd; 
	fd = get_fd ();
	if (fd < 5) {
		rv = get_sem_fd ();
		close(fd);
	  	fd = rv; 
	  } 
	return fd; 
	}

will not break much. (UGLY coding. Don't tell me.)

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
