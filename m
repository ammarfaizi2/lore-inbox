Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279814AbRKVPQB>; Thu, 22 Nov 2001 10:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279818AbRKVPPv>; Thu, 22 Nov 2001 10:15:51 -0500
Received: from ns.suse.de ([213.95.15.193]:51466 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279814AbRKVPPm> convert rfc822-to-8bit;
	Thu, 22 Nov 2001 10:15:42 -0500
To: Phil Howard <phil-linux-kernel@ipal.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EINTR vs ERESTARTSYS, ERESTARTSYS not defined
In-Reply-To: <20011122083623.A18057@vega.ipal.net>
X-Yow: TAPPING?  You POLITICIANS!  Don't you realize that the END of the
 ``Wash Cycle'' is a TREASURED MOMENT for most people?!
From: Andreas Schwab <schwab@suse.de>
Date: 22 Nov 2001 16:15:40 +0100
In-Reply-To: <20011122083623.A18057@vega.ipal.net> (Phil Howard's message of "Thu, 22 Nov 2001 08:36:23 -0600")
Message-ID: <jeherm7s6b.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.1.30
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Howard <phil-linux-kernel@ipal.net> writes:

|> The accept() call does indeed return errno==ERESTARTSYS to user space
|> when coming back from signal handling, even though other things like
|> poll() return errno==EINTR.  This would not really be a problem except
|> for this in include/linux/errno.h starting at line 6:
|> 
|> +=============================================================================
|> | #ifdef __KERNEL__
|> | 
|> | /* Should never be seen by user programs */
|> | #define ERESTARTSYS     512
|> | #define ERESTARTNOINTR  513
|> | #define ERESTARTNOHAND  514     /* restart if no handler.. */
|> | #define ENOIOCTLCMD     515     /* No ioctl command */
|> +=============================================================================
|> 
|> So which way is it _supposed_ to be (so someone can patch things up
|> to make it consistent):
|> 
|> 1.  User space should never see ERESTARTSYS from any system call

Yes.  The kernel either transforms it to EINTR, or restarts the syscall
when the signal handler returns.

|> 2.  ERESTARTSYS can be seen from system call and is defined somewhere
|> 
|> In user space I have to define __KERNEL__ to get programs to compile
|> when coded to know about all possible (valid?) values of errno from
|> system calls.  As seen from strace:

strace is special here, because it gets more information than the traced
program would get.

|> +=============================================================================
|> | [pid  6453] accept(5, 0xbffff908, [16]) = ? ERESTARTSYS (To be restarted)

At this point the accept syscall hasn't actually finished yet, but rather
suspended to let the program execute the signal handler.  As soon as the
signal handler returns the syscall will be restarted.

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
