Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbUKPNWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbUKPNWA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 08:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbUKPNWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 08:22:00 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:18305 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S261465AbUKPNV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 08:21:56 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Andreas Schwab <schwab@suse.de>
Date: Tue, 16 Nov 2004 14:21:26 +0100
MIME-Version: 1.0
Subject: Re: CPU hogs ignoring SIGTERM (unkillable processes)
Cc: linux-kernel@vger.kernel.org
Message-ID: <419A0CE1.9661.15BCCEF@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <je4qjqxefy.fsf@sykes.suse.de>
References: <4199C06E.14572.3113A6@rkdvmks1.ngate.uni-regensburg.de> (Ulrich Windl's message of "Tue, 16 Nov 2004 08:55:09 +0100")
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-3.84+2.20+2.07.066+02 August 2004+94348@20041116.131837Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Nov 2004 at 11:42, Andreas Schwab wrote:

> "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:
> 
> > On 15 Nov 2004 at 14:39, Andreas Schwab wrote:
> >
> >> "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:
> >> 
> >> > Hello,
> >> >
> >> > today I've discovered a programming error in one of my programs (that's fixed 
> >> > already). When trying to replace the binary, I found out that the processes seem 
> >> > unaffected by a plain "kill": They just continue to consume CPU. However, a "kill 
> >> > -9" terminates them. ist that intended behavior? I guess not. Here are some facts:
> >> 
> >> Are you sure it doesn't block or ignore the signal?
> >
> > Andreas,
> >
> > I don't mess with signals (as said);
> 
> That is not required.  It could just as well inherit the setting from the
> parent.

OOps! Now that you are telling me, I realize that the program that hung was 
actually started by a shell script that was in turn exec'd() (after a fork()) from 
a truly multi-threaded application.

I couldn't capture the binary via "ps -axs", because it's terribly efficient, but 
I managed to captue the shell script that way:

  UID   PID          PENDING          BLOCKED          IGNORED           CAUGHT 
STAT TTY        TIME COMMAND
    2  7792 0000000000000000 0000000080014003 8000000000001004 0000000000010002 S    
?          0:00 /bin/sh /usr/local/milter/Sopho

The manpage on execve() isn't too verbose on the topic:

...
       execve() does not return on success, and the  text,  data,
       bss,  and  stack of the calling process are overwritten by
       that of the program loaded.  The program invoked  inherits
       the  calling  process's PID, and any open file descriptors
       that are not set to close on exec.  Signals pending on the
       calling process are cleared.  Any signals set to be caught
       by  the  calling  process  are  reset  to  their   default
       behaviour.   The  SIGCHLD signal (when set to SIG_IGN) may
       or may not be reset to SIG_DFL.
...

"Yet Another UNIX-like OS" dared to state in the man page:

      The processing of signals by the process is unchanged by exec*(),
      except that signals caught by the process are set to their default
      values (see signal(2)).

However the same man page states that pending signals are not cleared. 
Interesting.

      The process also retains the following attributes:

...
           +  pending signals
...

This is the rerason for returning the following errno, I guess:

           [EINTR]             A signal was caught during the exec*() system
                               call.


Let me summarize: The Kernel has no problem, just the docs ;-) Prpgrammers are fed 
with docs of course...

Thanks and regards,
Ulrich Windl

