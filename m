Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318292AbSHUOUH>; Wed, 21 Aug 2002 10:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318294AbSHUOUH>; Wed, 21 Aug 2002 10:20:07 -0400
Received: from [216.167.37.170] ([216.167.37.170]:21260 "EHLO cob427.dn.net")
	by vger.kernel.org with ESMTP id <S318292AbSHUOUE>;
	Wed, 21 Aug 2002 10:20:04 -0400
From: lists@corewars.org
Date: Wed, 21 Aug 2002 16:24:06 +0200
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bad Network SIGIO on Linux-2.4.19
Message-ID: <20020821162406.C10368@corewars.org>
References: <Pine.LNX.3.95.1020816152457.203A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1020816152457.203A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Fri, Aug 16, 2002 at 03:27:33PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a fix included since 2.4.19-pre5-aa1. 

You're assuming that every SIGIO coming your way
1) is coming via fd 0
2) is a POLL_IN interrupt

You should either be polling the file descriptor (0) from the signal
handler, or using SA_SIGINFO (see sigaction(2)) to determine
which interrupt it is.

Regards,
Sapan

On Fri, Aug 16, 2002 at 03:27:33PM -0400, Richard B. Johnson wrote:
> 
> This stand-alone program demonstrates the problem previously
> reported.
> 
> If you execute this locally, the program will wait for any
> input from the terminal (STDIN_FILENO) and then it will
> terminate. This is the expected behavior.
> 
> If you execute this while logged in using telnet, using linux-2.4.18,
> this program will also execute as expected.
> 
> However, if you execute using linux-2.4.19, when logged in using
> telnet, the program will exit as soon as the child writes the
> first '.' to the terminal because a SIGIO signal is being incorrectly
> generated for both output and input.
> 
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <string.h>
> #include <signal.h>
> #include <termios.h>
> #include <fcntl.h>
> #include <sys/wait.h>
> #include <errno.h>
> #include <sys/resource.h>
> 
> #define ERRORS(s) { \
>     fprintf(stderr, "Error from line %d, file %s, call %s, (%s)\n", \
>     __LINE__,__FILE__,(s), strerror(errno)); \
>     }
> 
> #define FAIL -1
> int enab = 0;
> int alive = 0;
> static void set_sig(int sig, sig_t funct, int flags)
> {
>     struct sigaction sa;
>     if(sigaction(sig, NULL, &sa) == FAIL)
>         ERRORS("sigaction");
>     sa.sa_flags = flags;
>     sa.sa_handler = funct;
>     if(sigaction(sig, &sa, NULL) == FAIL)
>         ERRORS("sigaction");
>     return;
> }
> static void iotrap(int unused)
> {
>    enab = 0; 
> }
> static void reaper(int unused)
> {
>     alive = 0;
>     while(wait3(&unused, WNOHANG, NULL) > 0)
>         ;
> 
> }
> int main(int args, char *argv[]);
> int main(int args, char *argv[])
> {
>     int flags;
>     size_t i;
>     pid_t pid;
>     struct termios term, save;
>     set_sig(SIGCHLD, reaper, SA_INTERRUPT|SA_RESTART);
>     set_sig(SIGIO,   iotrap, SA_INTERRUPT|SA_RESTART);
>     alive = 1;
>     switch((pid = fork()))
>     {
>     case 0:                 /*  Child */
>         for(i=0; i < 0x10; i++)
>         {
>             (void)sleep(1);
>             fprintf(stderr, ".");
>             (void)sleep(1);
>         }
>         exit(EXIT_SUCCESS);
>     default:
>         break;
>     }
> /*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
> /*
>  *  Save terminal characteristics and then set the terminal for raw
>  *  input generating a signal upon any received character.
>  */ 
>     if(tcgetattr(STDIN_FILENO, &term) == FAIL)
>         ERRORS("tcgetattr");
>     save = term;
>     term.c_lflag = ISIG;
>     term.c_iflag = 0;
>     if(tcsetattr(STDIN_FILENO, TCSANOW, &term) == FAIL)
>         ERRORS("tcsetattr");
>     if((flags = fcntl(STDIN_FILENO, F_GETFL)) == FAIL)
>         ERRORS("fcntl");
>     flags |= (FNDELAY|FASYNC);
>     if(fcntl(STDIN_FILENO, F_SETFL, flags) == FAIL)
>         ERRORS("fcntl");
>     if(fcntl(STDIN_FILENO, F_SETOWN, getpid()) == FAIL)
>         ERRORS("fcntl");
> /*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
>     fprintf(stderr, "Waiting for input.......");
>     enab = 1;
>     while(enab)
>     {
>         pause();
>         fprintf(stderr, "Got out of pause\n");
> 
>     }
>     if(alive) kill(pid, SIGINT);
>     fprintf(stderr, "Exit okay, cleaning up...\n");
> /*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
> /*
>  *  Restore the terminal characteristics before we exit. Note, the
>  *  terminal is shared. We can't just exit!
>  */
>     flags &= ~(FNDELAY|FASYNC);
>     if(fcntl(STDIN_FILENO, F_SETFL, flags) == FAIL)
>         ERRORS("fcntl");
>     if(tcsetattr(STDIN_FILENO, TCSAFLUSH, &save) == FAIL)
>         ERRORS("tcsetattr");
>     set_sig(SIGIO,  SIG_DFL, SA_INTERRUPT);
>     fprintf(stderr, "Done!\n");
>     return 0;
> }
> 
> 
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.19 on an i686 machine (797.90 BogoMips).
> The US military has given us many words, FUBAR, SNAFU, now ENRON.
> Yes, top management were graduates of West Point and Annapolis.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
