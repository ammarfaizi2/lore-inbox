Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272280AbTHRTnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 15:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272307AbTHRTnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 15:43:49 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:8713 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S272280AbTHRTnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 15:43:47 -0400
Date: Mon, 18 Aug 2003 21:43:45 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3: setuid32(8) returns EAGAIN (WTF?!)
Message-ID: <20030818214345.A1144@pclin040.win.tue.nl>
References: <20030817010336.GA12079@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030817010336.GA12079@codeblau.de>; from felix-kernel@fefe.de on Sun, Aug 17, 2003 at 03:03:36AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 03:03:36AM +0200, Felix von Leitner wrote:
> I just changed from 2.5.75 to 2.6.0-test3 and suddenly my imap server
> fails to start (it's dovecot).  It wrote to syslog:
> 
> Aug 17 02:58:02 hellhound dovecot: Dovecot starting up
> Aug 17 02:58:03 hellhound imap-login: setuid(8) failed: Resource temporarily unavailable
> Aug 17 02:58:03 hellhound dovecot: Login process died too early - shutting down
> 
> So I strace -f it, and sure enough, here is what happens:
> 
> [init, fork, tzfile...]
> 8094  chroot("/var/run/dovecot//login") = 0
> 8094  chdir("/")                        = 0
> 8094  setuid32(0x8)                     = -1 EAGAIN (Resource temporarily unavailable)
> 
> Why is this happening?

In sys.c:set_user() we see

        if (atomic_read(&new_user->processes) >=
                                current->rlim[RLIMIT_NPROC].rlim_cur &&
                        new_user != &root_user) {
                free_uid(new_user);
                return -EAGAIN;
        }

which was added in patch-2.6.0-test2.
No doubt this causes your problem.

You might check what values these variables have for you.

Andries

