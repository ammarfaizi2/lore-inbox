Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbTEQVk4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 17:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbTEQVk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 17:40:56 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:57261
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261851AbTEQVkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 17:40:55 -0400
Date: Sat, 17 May 2003 23:53:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: dak@gnu.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scheduling problem with 2.4?
Message-ID: <20030517215345.GA1429@dualathlon.random>
References: <x54r3tddhs.fsf@lola.goethe.zz> <20030517174100.GT1429@dualathlon.random> <x5r86x74ci.fsf@lola.goethe.zz> <20030517203045.GZ1429@dualathlon.random> <x565o9717j.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x565o9717j.fsf@lola.goethe.zz>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 10:44:16PM +0200, David Kastrup wrote:
> Which kernel?  Oh, and of course: on a SMP machine the problem would

I run it on smp. but I understood what's going on.

--- testio.el.orig	2003-05-17 22:22:24.000000000 +0200
+++ testio.el	2003-05-17 23:39:49.000000000 +0200
@@ -19,7 +19,7 @@
   (setq test-pattern nil test-start (float-time))
   (let ((process (start-process
 		  "test" (and (bufferp printer) printer) "sh"
-		  "-c" "od -v /dev/zero|dd bs=1 count=100k")))
+		  "-c" "od -v /dev/zero| dd bs=100k count=1")))
     (set-process-filter process `(lambda (process string)
 				   (test-filter process string
 						',printer)))


this is what I thought you were really doing with this script, not the
other way around ;).

The reason you get the 1 char reads in your version is because dd will
only write 1 char at time to emacs. This has nothing to do with emacs,
this is about dd writing 1 char at time. If you don't write 1 char at
time, emacs won't read 1 char at time.

The only thing you could do to decrease the cxt switch flood is to put a
buffer with timeout in between, but by default having a buffer with
timeout in the kernel would be an overkill overhead and depending on the
timeout it could be visible for normal shells. So the kernel behaviour
is right and it isn't going to change.

If one important app of yours is dumb and writes flood of data 1 char at
time then just write a buffer in userspace yourself, and in 99% of cases
a dd bs=4k will just work perfectly (you'll need a timeout-stdout-flush
version one only if the pipe keeps staying open i.e. if the app doesn't
quit).

Andrea
