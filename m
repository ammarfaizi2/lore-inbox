Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312915AbSDORWV>; Mon, 15 Apr 2002 13:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312986AbSDORWU>; Mon, 15 Apr 2002 13:22:20 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:38138 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S312915AbSDORWS>; Mon, 15 Apr 2002 13:22:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: "Bill Abt" <babt@us.ibm.com>
Subject: Re: [PATCH] Futex Generalization Patch
Date: Mon, 15 Apr 2002 12:22:59 -0400
X-Mailer: KMail [version 1.3.1]
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org, Martin.Wirth@dlr.de,
        Peter =?iso-8859-1?q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <OF24E0B753.2B92A422-ON85256B9C.00512368@raleigh.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020415172204.4B6073FE08@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 April 2002 10:49 am, Bill Abt wrote:
> Dealing with the realtime signal is not a problem.  Also, saving the extra
> system call is *BIG* bonus.
>
>
> Regards,
>      Bill Abt
>      Senior Software Engineer
>      Next Generation POSIX Threading for Linux
>      IBM Cambridge, MA, USA 02142
>      Ext: +(00)1 617-693-1591
>      T/L: 693-1591 (M/W/F)
>      T/L: 253-9938 (T/Th/Eves.)
>      Cell: +(00)1 617-803-7514
>      babt@us.ibm.com or abt@us.ibm.com
>      http://oss.software.ibm.com/developerworks/opensource/pthreads


Cool

As of Peter's initial message. I took a look at the siginfo_t and Peter's 
statement needs to be corrected "a bit".
All the members he listed are NOT necessarily available. 

typedef struct siginfo {
        int si_signo;
        int si_errno;
        int si_code;
 
        union {
                int _pad[SI_PAD_SIZE];
 
                /* kill() */
                struct {
                        pid_t _pid;             /* sender's pid */
                        uid_t _uid;             /* sender's uid */
                } _kill;
 
                /* POSIX.1b timers */
                struct {
                        unsigned int _timer1;
                        unsigned int _timer2;
                } _timer;
 
                /* POSIX.1b signals */
                struct {
                        pid_t _pid;             /* sender's pid */
                        uid_t _uid;             /* sender's uid */
                        sigval_t _sigval;
                } _rt;
 
                /* SIGCHLD */
                struct {
                        pid_t _pid;             /* which child */
                        uid_t _uid;             /* sender's uid */
                        int _status;            /* exit code */
                        clock_t _utime;
                        clock_t _stime;
                } _sigchld;
 
                /* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
                struct {
                        void *_addr; /* faulting insn/memory ref. */
                } _sigfault;
 
                 /* SIGPOLL */
                struct {
                        int _band;      /* POLL_IN, POLL_OUT, POLL_MSG */
                        int _fd;
                } _sigpoll;
        } _sifields;
} siginfo_t;


I'd suggest we tag along the _sigfault semantics.
We don't need to know who woke us up, just which <addr> got signalled.


-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
