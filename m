Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133091AbRDZEfT>; Thu, 26 Apr 2001 00:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133098AbRDZEfA>; Thu, 26 Apr 2001 00:35:00 -0400
Received: from ns1.eqip.net ([195.206.66.146]:33497 "HELO mailgate.eqip.net")
	by vger.kernel.org with SMTP id <S133091AbRDZEeu>;
	Thu, 26 Apr 2001 00:34:50 -0400
Path: Home.Lunix!not-for-mail
Subject: Re: Problem with "su -" and kernels 2.4.3-ac11 and higher
Date: Thu, 26 Apr 2001 04:34:28 +0000 (UTC)
Organization: lunix confusion services
In-Reply-To: <E14rcVF-0007cJ-00@the-village.bc.nu>
NNTP-Posting-Host: kali.eth
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: quasar.home.lunix 988259668 7616 10.253.0.3 (26 Apr 2001 04:34:28
    GMT)
X-Complaints-To: abuse-0@ton.iguana.be
NNTP-Posting-Date: Thu, 26 Apr 2001 04:34:28 +0000 (UTC)
X-Newsreader: knews 1.0b.0
Xref: Home.Lunix mail.linux.kernel:87341
X-Mailer: Perl5 Mail::Internet v1.33
Message-Id: <9c88gk$7e0$1@post.home.lunix>
From: linux-kernel@ton.iguana.be (Ton Hospel)
To: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@ton.iguana.be (Ton Hospel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E14rcVF-0007cJ-00@the-village.bc.nu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
>> > Did you try nesting more than one "su -"? The first one after a boot
>> > works for me - every other one fails.
>> 
>> Same here: the first "su -" works OK, but a second nested one hangs:
> 
> It appears to be a bug in PAM. Someone seems to reply on parent/child running
> order and just got caught out
> 

I once debugged a very simular sounding problem that I solved with
the following patch to login. It's a wild guess, but you could try if
it happens to solve it. If not it might at least be a hint of what has to
be done to su.
(the problem is that the extra process PAM keeps waiting is process leader)
(I don't have redhat, so I can't check if this is relevant here)

diff -ur util-linux-2.9x/login-utils/login.c util-linux-2.9x-ton/login-utils/login.c
--- util-linux-2.9x/login-utils/login.c	Sun Sep 12 23:25:30 1999
+++ util-linux-2.9x-ton/login-utils/login.c	Tue Sep 21 03:24:52 1999
@@ -1109,6 +1112,15 @@
        exit(0);
     }
     /* child */
+
+    if (tcsetpgrp(0, getpid()) < 0)
+        fprintf(stderr,
+                _("login: could not become foreground process group: %s\n"),
+                strerror(errno));
+    if (setpgid(0, 0) < 0)
+        fprintf(stderr, _("login: could not become process leader: %s\n"),
+                strerror(errno));
+
 #endif
     signal(SIGINT, SIG_DFL);
     
