Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313299AbSDJQbD>; Wed, 10 Apr 2002 12:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313305AbSDJQbD>; Wed, 10 Apr 2002 12:31:03 -0400
Received: from eowyn.iae.nl ([212.61.25.227]:41490 "HELO eowyn.vianetworks.nl")
	by vger.kernel.org with SMTP id <S313299AbSDJQbC>;
	Wed, 10 Apr 2002 12:31:02 -0400
Date: Wed, 10 Apr 2002 19:08:27 +0200
Message-Id: <200204101708.TAA01151@fikkie.vesc.nl>
From: "E. Abbink" <esger@bumblebeast.com>
To: linux-kernel@vger.kernel.org
Reply-To: esger@bumblebeast.com
Subject: Problem using mandatory locks (other apps can read/delete etc)
X-Mailer: NeoMail 1.25
X-IPAddress: 192.0.0.12
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to solve a problem using mandatory locks but am having some
difficulty in doing so. (if there's a more appropriate place for
discussing this please ignore the rest of this post. pointers to that
place would be appreciated ;) )

my problem:

when I lock a file with a mandatory write lock (ie. fcntl, +s-x bits and
mand mount option. for code see below) it is still possible:

- for me to rm the file in question
- for the file to be read by an other process

It's not possible to cat to the file or cp another file over it (as
expected). For my application I want a locked file to be completely
locked/protected from other processes.

If I retry the same without setting the +s-x bits the cp & cat succeed,
so something special is being done in the first case.


According to all docs (i can find) mandatory locks should block both the 
read and write system calls (i cant find anything in it regarding unlink 
though...). In my case however it seems as if only write calls are
blocked but not read calls?

If anyone could shed any light on this it would be much appreciated.

Esger



system details:

linux 2.4.17 partially suse & xfs patched kernel
filesystem is reiserfs
i386 dual pIII450

test app code:

int main ()
{
    int fd ;


    fd = open ("image.jpg", O_RDWR) ;

    if (fd == -1)
    {
        printf ("error %d while opening file\n", errno) ;
        exit (1) ;
    }

    struct flock lock ;

    lock.l_type = F_WRLCK ;
    lock.l_whence = SEEK_SET ;
    lock.l_start = 0 ;
    lock.l_len = 0 ;
    lock.l_pid = 0 ; // ignored

    int err = fcntl (fd, F_SETLK, &lock) ;

    if (err == -1)
    {
        printf ("error %d while locking file\n", errno) ;
        exit (1) ;
    }
    else
        printf ("file locked\n") ;


    while (1)
        sleep (1) ;
}






-- 
NeoMail - Webmail that doesn't suck... as much.
http://neomail.sourceforge.net
