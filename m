Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S.rD5ro160483>; Fri, 14 May 1999 15:48:04 -0400
Received: by vger.rutgers.edu id <S.rD0D2283035>; Fri, 14 May 1999 09:23:16 -0400
Received: from sunsite.ms.mff.cuni.cz ([195.113.19.66]:3547 "EHLO sunsite.ms.mff.cuni.cz") by vger.rutgers.edu with ESMTP id <S.rCz3R283042>; Fri, 14 May 1999 05:48:13 -0400
Date: Fri, 14 May 1999 12:34:56 +0200
From: Jakub Jelinek <jj@sunsite.ms.mff.cuni.cz>
To: Jan-Simon Pendry <jsp@ms.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.rutgers.edu
Subject: Re: [PATCH][2.3.0] Read-write locks instead semaphores on UTS structures
Message-ID: <19990514123456.R3172@mff.cuni.cz>
Mail-Followup-To: Jan-Simon Pendry <jsp@ms.com>, Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.rutgers.edu
References: <Pine.LNX.4.10.9905121645430.498-200000@freak.conectiva> <373B07EF.58664F9B@ms.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <373B07EF.58664F9B@ms.com>; from Jan-Simon Pendry on Thu, May 13, 1999 at 06:12:15PM +0100
Sender: owner-linux-kernel@vger.rutgers.edu
X-UIDL: 926711278.931580.21963

On Thu, May 13, 1999 at 06:12:15PM +0100, Jan-Simon Pendry wrote:
> Marcelo Tosatti wrote:
> > 
> > This patch implements read-write locks instead semaphores in UTS
> > structures as noted by Linus in kernel/sys.c.
> > 
> >  Linus, can you apply this?
> > 
> >   - Marcelo
> > 
> >   ------------------------------------------------------------------------
> >                        Name: uts-rwlock.patch
> >    uts-rwlock.patch    Type: Plain Text (TEXT/PLAIN)
> >                    Encoding: BASE64
> 
> i don't think you want to be holding spin-locks across
> a put_user/copy_from_user etc.  put_user et al can page
> fault and go to sleep holding the spin lock.  this can
> then deadlock the system if other processes comes along
> and contend for the same lock.  if you are desperate for
> parallel performance in this area you will need to implement
> reader-writer semaphores.

Huh? His patch uses read-write locks and not normal spin-locks, so I don't
understand what you find wrong on it. For the common case (hostname is
really not changed very often) anybody can hold the read lock so there is no
contention. I wonder whether it is worth doing something with the areas
which hold the write lock, maybe for those places the uaccess stuff should
move the data from userland first into some buffer on kernel stack (it is
65bytes at most, so it does not matter that much) and only memcpy it from
there with the write_lock held. But as only root can write to it, no DOS can
happen and so I would not worry.

Just there is one more bug in the patch (besides the one I pointed out in
sparc64/solaris/): in sysctl.c's the patch will acquire write lock even when
it is not needed and that can lead into some sort of a DOS attack (a couple of user
programs, each one reading from /proc/sys/kernel/hostname into some unmapped
area in a cycle).
So I'd instead write:

static int proc_doutsstring(ctl_table *table, int write, struct file *filp,
                  void *buffer, size_t *lenp)
{
	int r;
	if (write) {
		write_lock(&uts_rwlock);
	        r=proc_dostring(table,1,filp,buffer,lenp);
		write_unlock(&uts_rwlock);
	} else {
		read_lock(&uts_rwlock);
	        r=proc_dostring(table,0,filp,buffer,lenp);
		read_unlock(&uts_rwlock);
	}
        return r;
}


Cheers,
    Jakub
___________________________________________________________________
Jakub Jelinek | jj@sunsite.mff.cuni.cz | http://sunsite.mff.cuni.cz
Administrator of SunSITE Czech Republic, MFF, Charles University
___________________________________________________________________
UltraLinux  |  http://ultra.linux.cz/  |  http://ultra.penguin.cz/
Linux version 2.3.1 on a sparc64 machine (1343.49 BogoMips)
___________________________________________________________________

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
