Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265515AbTIDW7K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 18:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265635AbTIDW7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 18:59:10 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:1570 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265515AbTIDW7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 18:59:04 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: schierlm@gmx.de, Michael Schierl <schierlm-usenet@gmx.de>
Subject: Re: PROBLEM: laptop touchpad on linux-2.6.0-test4
Date: Thu, 4 Sep 2003 17:58:56 -0500
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <rauV.61c.9@gated-at.bofh.it> <raEA.6jw.17@gated-at.bofh.it> <200309042031.h84KVKH8001507@mx1-ipltin.ipltin.ameritech.net>
In-Reply-To: <200309042031.h84KVKH8001507@mx1-ipltin.ipltin.ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309041758.59907.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 September 2003 03:30 pm, Michael Schierl wrote:
> On Tue, 02 Sep 2003 06:10:12 +0200, in linux.kernel you wrote:
> >http://geocities.com/dt_or/gpm/gpm.html for updated version of GPM
>
> Hmm, I downloaded gpm-1.20.1, unpacked it, applied the patches (tried
> it both with the cumulative one and with the single ones), ran
>
> autoconf && ./configure && make
>
> and got:
>
> [...]
> gcc -I/usr/src/gpm/gpm-1.20.1/src -DHAVE_CONFIG_H -include
> headers/config.h -Wall -DSYSCONFDIR="\"/usr/local/etc\""
> -DSBINDIR="\"/usr/local/sbin\""  -g -O2  -c -o prog/mouse-test.o
> prog/mouse-test.c
> prog/mouse-test.c: In function `main':
> prog/mouse-test.c:285: parse error before `struct'
> prog/mouse-test.c:337: `opt' undeclared (first use in this function)
> prog/mouse-test.c:337: (Each undeclared identifier is reported only
> once
> prog/mouse-test.c:337: for each function it appears in.)
> prog/mouse-test.c:394: `mdev' undeclared (first use in this function)
> prog/mouse-test.c:553: warning: value computed is not used
> prog/mouse-test.c:606: warning: value computed is not used
> prog/mouse-test.c:655: warning: value computed is not used
> make[1]: *** [prog/mouse-test.o] Error 1
> make[1]: Leaving directory `/usr/src/gpm/gpm-1.20.1/src'
> make: *** [do-all] Error 1
>
> Any ideas what I did wrong?
>
> Michael

What GCC version? I think the problem is because of declaration after
statements which is allowed in newer standard. Please try the patch 
below, I will update the web page later tonight.

Dmitry

diff -urN --exclude-from=/usr/src/exclude gpm-1.20.1/src/gpm.c gpm/src/gpm.c
--- gpm-1.20.1/src/gpm.c	2003-09-03 00:52:32.000000000 -0500
+++ gpm/src/gpm.c	2003-09-03 22:34:43.000000000 -0500
@@ -225,9 +225,9 @@
    /* selection used 1-based coordinates, so do I */
    /*
     * 1.05: only one margin is current. Y takes priority over X.
-    * The i variable is how much margin is allowed. "m" is which one is there.
     */
 
+   event->margin = 0;
 
    if (event->y > console.max_y) {
       event->y = console.max_y + extent; 
diff -urN --exclude-from=/usr/src/exclude gpm-1.20.1/src/prog/mouse-test.c gpm/src/prog/mouse-test.c
--- gpm-1.20.1/src/prog/mouse-test.c	2003-09-03 00:52:32.000000000 -0500
+++ gpm/src/prog/mouse-test.c	2003-09-04 17:53:05.000000000 -0500
@@ -280,11 +280,11 @@
    int pending, maxfd;
    int trial, readamount,packetsize,got;
    int baudtab[4]={1200,9600,4800,2400};
-#define BAUD(i) (baudtab[(i)%4])
-   consolename = Gpm_get_console();
    struct miceopt opt = {0};
    struct micedev mdev = {0};
 
+#define BAUD(i) (baudtab[(i)%4])
+   consolename = Gpm_get_console();
    if (!isatty(fileno(stdin))) {
       fprintf(stderr,"%s: stdin: not a tty\n",argv[0]);
       exit(1);
