Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135931AbRDTOUD>; Fri, 20 Apr 2001 10:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135928AbRDTOTw>; Fri, 20 Apr 2001 10:19:52 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:63877 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S135934AbRDTOTi>; Fri, 20 Apr 2001 10:19:38 -0400
Date: Fri, 20 Apr 2001 09:19:37 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200104201419.JAA50024@tomcat.admin.navo.hpc.mil>
To: olaf@bigred.inka.de, linux-kernel@vger.kernel.org
Subject: Re: light weight user level semaphores
In-Reply-To: <E14qXEU-0005xo-00@g212.hadiko.de>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Titz <olaf@bigred.inka.de>:
> > Ehh.. I will bet you $10 USD that if libc allocates the next file
> > descriptor on the first "malloc()" in user space (in order to use the
> > semaphores for mm protection), programs _will_ break.
> 
> Of course, but this is a result from sloppy coding. In general, open()
> can just return anything and about the only case where you can even
> think of ignoring its result is this:
>  close(0); close(1); close(2);
>  open("/dev/null", O_RDWR); dup(0); dup(0);
> (which is even not clean for other reasons).
> 
> I can't imagine depending on the "fact" that the first fd I open is 3,
> the next is 4, etc. And what if the routine in question is not
> malloc() but e.g. getpwuid()? Both are just arbitrary library
> functions, and one of them clearly does open file descriptors,
> depending on their implementation.
> 
> What would the reason[1] be for wanting contiguous fd space anyway?
> 
> Olaf
> 
> [1] apart from not having understood how poll() works of course.

Optimization use in select: If all "interesting" file id's are known
to be below "n", then only the first "n" bits in a FD_ISSET need to
be examined. As soon as the bits are scattered, it takes MUCH longer
to check for activity....

It may not be the "best" way, but what I tend to do is:

 Umm - this is snipped from a multiplexed logger using FIFOs for
 and indeterminate amount of data from differet utilities sending
 text buffers (normally one line at a time but could be more).

static void fd_init(argc,argv)
    int         argc;                   /* number of parameters         */
    char        **argv;                 /* parameter list               */
{
    int         i,j;            /* scratch counters                     */
    static char str[50];

    pnames = argv;
    FD_ZERO(&in_files);         /* init all file descriptor sets        */

    for (i = 0; i <= MAX_LOG && i < argc; i++) {
        sprintf(str,"/tmp/%s",pnames[i]);
        mkfifo(str,0600);       /* assume it exists */
        inlogfd[i] = open(str,O_RDONLY | O_NDELAY);
        FD_SET(inlogfd[i],&in_files);
    }
    used = i;
}


Then I can scan for any activity by:

    do {
        while (select(MAX_LOG,&active,NULL,NULL,NULL) >= 0) {
            for(i = 0; i <= used; i++) {
                if (FD_ISSET(inlogfd[i],&active)) {
                    r=ioctl(inlogfd[i],FIONREAD,&n);
                    while (n > 0) {
                        r = (n > BUF_MAX - 1) ? BUF_MAX - 1: n;
                        read(inlogfd[i],buf,r);
                        printbuf(pnames[i],r);
                        n -= r;
                    }
                }
            }
            active = in_files;
        }
    } while (errno == EINTR);

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
