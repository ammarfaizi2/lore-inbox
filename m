Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262594AbUKQW7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbUKQW7m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbUKQW5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:57:02 -0500
Received: from almesberger.net ([63.105.73.238]:8465 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262643AbUKQW4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:56:04 -0500
Date: Wed, 17 Nov 2004 19:54:17 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrea Arcangeli <andrea@novell.com>, Jesse Barnes <jbarnes@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Chris Ross <chris@tebibyte.org>
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
Message-ID: <20041117195417.A3289@almesberger.net>
References: <20041105200118.GA20321@logos.cnet> <200411051532.51150.jbarnes@sgi.com> <20041106012018.GT8229@dualathlon.random> <1099706150.2810.147.camel@thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099706150.2810.147.camel@thomas>; from tglx@linutronix.de on Sat, Nov 06, 2004 at 02:55:50AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Entering an old discussion ...

Thomas Gleixner wrote:
> context in which oom-killer is called. My concern is that the decision
> critrion which process should be killed is not sufficient. In my case it
> kills sshd instead of a process which forks a bunch of child processes.

It recently occurred to me that we could have relatively light-weight
voluntary victimization for known trouble-makers. E.g. in a desktop
environment, the cause for trouble seems to be almost always the Web
browser, or something closely related to it.

A process could declare itself as usual suspect. This would then be
recorded as a per-task flag, to be inherited by children. Now, one
could write a launcher like this:

int main(int argc,char **argv)
{
    if (argc < 2) {
	fprintf(stderr,"usage: %s command [arguments...]\n",*argv);
	return 1;
    }
    sys_suspect_me();
    execvp(argv[1],argv+1);
    perror(argv[1]);
    return 1;
}

And then something like

# mv /usr/bin/browser /usr/bin/browser.bin
# echo '#!/bin/sh' >/usr/bin/browser
# echo 'suspect_me /usr/bin/browser.bin "$@"' >>/usr/bin/browser
# chmod 555 /usr/bin/browser

or use an alias if you like your packet manager.

Not sure if this would actually be useful in real life, but it looks
at least like a relatively simple and flexible solution to a part of
the selection problem.

One could even consider getting rid of the suspects a while before
hitting OOM, so that the system doesn't have to slow down before the
inevitable killing.

Not that'm getting many OOMs these days - my VNC setup is quite good
at dying well before anything serious turns up :-(

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
