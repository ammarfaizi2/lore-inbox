Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263329AbRFRVTJ>; Mon, 18 Jun 2001 17:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263318AbRFRVTA>; Mon, 18 Jun 2001 17:19:00 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:14310 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S263257AbRFRVSw>; Mon, 18 Jun 2001 17:18:52 -0400
Message-ID: <3B2E7094.D53308BD@kegel.com>
Date: Mon, 18 Jun 2001 14:20:20 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Wyckoff <pw@osc.edu>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: getrusage vs /proc/pid/stat?
In-Reply-To: <3B2D8ED0.40B299B5@kegel.com> <20010618134433.C9415@osc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Wyckoff wrote:
> 
> dank@kegel.com said:
> > I'd like to monitor CPU, memory, and I/O utilization in a
> > long-running multithreaded daemon under kernels 2.2, 2.4,
> > and possibly also Solaris (#ifdefs are ok).
> 
> getrusage() isn't really the system call you want for this.

I'll buy that.  Looks like a lot of unices don't implement that
call fully, and Linux is one of them.

What is the proper way to measure total CPU time used by a multithreaded program?
The only way I can figure to do it is to sum /proc/pid/stat across
the threads of interest (see below).  Is this the easiest way, 
or am I missing something?  (Forgive the C++.  I'd recode this in C
if it were for general use.)

========= LinuxTimes.h ==========
#include <sys/times.h>
#include <pthread.h>

/*--------------------------------------------------------------------------
 Source and test case at http://www.kegel.com/lt.tar.gz

 Monitor the CPU usage of a bunch of threads in the same process.
 This is a simulation of the system call times() 
 providing traditional semantics under LinuxThreads.
 On e.g. Solaris, you don't need this; you just call the standard times().
--------------------------------------------------------------------------*/
class LinuxTimes {
    const static int MAXTHREADS = 100;

    /// number of threads being monitored
    int m_nthreads;

    /// fd open to /proc/pid/stat for each thread
    int m_proc_pid_stat_fd[MAXTHREADS];

    /// make addSelf threadsafe
    pthread_mutex_t m_lock;

public:

    LinuxTimes() { m_nthreads = 0; pthread_mutex_init(&m_lock, NULL); }

    /**
     New threads call this to add themselves to the group.
     Threadsafe.
     @return 0 on success, Unix error code on failure
     */
    int addSelf();

    /**
     Calculate user and system time accumulated by all threads in group.
     Return result in tms_utime and tms_stime fields of given struct tms.
     Similar to 'man 2 times' on Solaris (where all CPU time of all threads
     is counted as CPU time towards the process).
     @return 0 on success, Unix error code on failure
     */
    int times(struct tms *buf);
};

========= LinuxTimes.cc ==========

#include "LinuxTimes.h"
#include <ctype.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>      

/**
 New threads call this to add themselves to the group.
 Threadsafe.
 @return 0 on success, Unix error code on failure
 */
int LinuxTimes::addSelf()
{
    int fd;
    char fname[256];
    int err = 0;

    if (pthread_mutex_lock(&m_lock))
        return EINVAL;

    if (m_nthreads >= MAXTHREADS) {
        err = E2BIG;
    } else {
        // Under LinuxThreads, each thread has its own pid
        sprintf(fname, "/proc/%d/stat", getpid());
        fd = open(fname, O_RDONLY);
        if (fd == -1) 
            err = errno;
        else {
            m_proc_pid_stat_fd[m_nthreads++] = fd;
        }
    }

    if (pthread_mutex_unlock(&m_lock))
        return EINVAL;

    return err;
}

/* Skip to char after nth whitespace.  Returns NULL on failure. */
static const char *skipNspace(const char *p, int n)
{
    while (*++p)
        if (isspace(*p) && ! --n) 
            return p+1;
    return NULL;
}

/**
 Calculate user and system time accumulated by all threads in group.
 Return result in tms_utime and tms_stime fields of given struct tms.
 Similar to 'man 2 times' on Solaris (where all CPU time of all threads
 is counted as CPU time towards the process).
 @return 0 on success, Unix error code on failure
 */
int LinuxTimes::times(struct tms *buf)
{
    int i;
    int nread;

    buf->tms_utime = 0;
    buf->tms_stime = 0;
    for (i=0; i<m_nthreads; i++) {
        char scratch[1024]; // FIXME: is that big enough?
        int fd = m_proc_pid_stat_fd[i];

        // rewind to start of stat file.  (Not all /proc entries support this.)
        if (lseek(fd, 0, SEEK_SET))
            return EBADF;

        // Read in ASCII data and parse out utime and stime fields
        // (see 'man proc')
        nread = read(fd, scratch, sizeof(scratch)-1);
        if (nread < 50)     // FIXME: cheesy
            return EINVAL;
        scratch[nread] = 0;
        
        // Skip to end of command field
        // FIXME: what if executable has ) in its filename?  Bleh.
        const char *p = strchr(scratch, ')') + 2;

        // Skip to utime field
        p = skipNspace(p, 11);
        if (!p) return EINVAL;
        buf->tms_utime += atoi(p);

        // Skip to stime field
        p = skipNspace(p, 1);
        if (!p) return EINVAL;
        buf->tms_stime += atoi(p);
    }

    return 0;
}

==============

Thanks,
Dan

-- 
"A computer is a state machine.
 Threads are for people who can't program state machines."
         - Alan Cox
