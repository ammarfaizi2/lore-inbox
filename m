Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965277AbVLRVV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965277AbVLRVV1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 16:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965278AbVLRVV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 16:21:27 -0500
Received: from mail.gmx.net ([213.165.64.21]:42141 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965277AbVLRVV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 16:21:26 -0500
X-Authenticated: #19855039
Date: Sun, 18 Dec 2005 22:21:23 +0100
From: Marc-Jano Knopp <pub_ml_lkml@marc-jano.de>
To: linux-kernel@vger.kernel.org
Subject: [Bug] mlockall() not working properly in 2.6.x
Message-ID: <20051218212123.GC4029@mjk.myfqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

A year ago, I wrote a small mlockall()-wrapper ("noswap") to make
certain programs unswappable. It used to work perfectly, until I
upgraded to kernel 2.6.x (2.6.13.1 in my case, but that shouldn't
matter), which made the mlockall() execute without error, but also
without any effect (the "L" in the STAT column of "ps axf" which
indicates locked pages is missing).


The complete program source and the strace log of

  strace -v -f -s 4096 noswap sleep 9999

is here:

  http://marc-jano.de/tmp/noswap-10935/


Here are the most important lines:

-----< snip >-----

  /* mark process as unswappable for all times */
  if (ret = mlockall (MCL_CURRENT | MCL_FUTURE))
    perror ("mlockall()");

  /* give up root privileges */
  if (ret = setuid (getuid()) ) { perror ("setuid()"); exit (ret); };
  if (ret = setgid (getgid()) ) { perror ("setgid()"); exit (ret); };

  /* execute program */
  if (ret = execvp (argv[1], exec_argv)) perror ("execvp()");

  exit (ret);

-----< snip >-----

The strace log shows that mlockall() returns with no error.


If I replace the execvp() call with a sleep(9999), then the current
process (noswap) is properly locked, as can be checked by looking
for a capital "L" in the ps STAT column.

So it seems that the mlockall() flags are not passed somehow when
using execvp().


Best regards

  Marc-Jano (not subscribed to the list, so for further questions,
  please Cc:)
