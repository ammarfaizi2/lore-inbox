Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSE1BH1>; Mon, 27 May 2002 21:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316793AbSE1BH0>; Mon, 27 May 2002 21:07:26 -0400
Received: from relay1.pair.com ([209.68.1.20]:22023 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S316792AbSE1BHZ>;
	Mon, 27 May 2002 21:07:25 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3CF2D86C.8745D791@kegel.com>
Date: Mon, 27 May 2002 18:07:56 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Sethman <androsyn@ratbox.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        pwaechtler@loewe-komp.de, austin@digitalroadkill.net
Subject: Re: RT Sigio broken on 2.4.19-pre8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Sethman wrote:
> > > Using the Dan Kegel's Poller_bench utility I noticed that RT SIGIO is not
> > > working on 2.4.19-pre8.  Basically sigtimedwait() is always returning
> > > SIGIO.  Note that 2.4.18 works fine.
> > > ... It seems rtsig-nr keeping rising slowly as the system runs.

That sounds like the way I'm clearing the signal queue is not working.
Here's a minimal test case for clearing the signal queue.  Could
you try it and tell me what it says?
- Dan

#include <stdio.h>
#include <signal.h>
#include <assert.h>

int main(int argc, char **argv)
{
        sigset_t sigset;
        siginfo_t info;
        static struct timespec timeout = {0,0};

        // block delivery of SIGRTMIN
        sigemptyset(&sigset);
        sigaddset(&sigset, SIGRTMIN);
        assert(0 == sigprocmask(SIG_BLOCK, &sigset, NULL));

        // clear signal queue
        assert(0 == signal(SIGRTMIN, SIG_IGN)); // POSIX says this clears the queue

        // Make sure that cleared the queue.  (Note that timeout is zero here.)
        assert(sigtimedwait(&sigset, &info, &timeout) != SIGRTMIN);

        printf("test passed\n");
        exit(0);
}
