Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263865AbTEWGvV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 02:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263914AbTEWGvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 02:51:21 -0400
Received: from ip68-4-255-84.oc.oc.cox.net ([68.4.255.84]:1408 "EHLO
	ip68-101-124-193.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id S263865AbTEWGvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 02:51:12 -0400
Date: Fri, 23 May 2003 00:04:16 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: "Barry K. Nathan" <barryn@pobox.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.[45] ioperm fix seems broken (was Re: Linux 2.4.21-rc3)
Message-ID: <20030523070416.GA2408@ip68-101-124-193.oc.oc.cox.net>
References: <Pine.LNX.4.55L.0305221915450.1975@freak.distro.conectiva> <20030523005149.GA2420@ip68-101-124-193.oc.oc.cox.net> <200305230732.49914.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305230732.49914.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 07:32:49AM +0200, Marc-Christian Petersen wrote:
> nono, this fix is the right one. All works fine :-)

Nope, the ioperm fix seems to be breaking something alright. Eventually
I was able to reproduce this on 2.5.69-mm[78] as well.

Here's my distilled test case. (My real test case is FCE Ultra, compiled
for svgalib. The crash happens in svgalib, version 1.4.3-cl1 if that
matters.)

---cut here---
#include <sys/io.h>

int main()
{
        char c;

        if (ioperm(0x3b4, 0x3df - 0x3b4 + 1, 1)) {
                perror("ugh");
                exit(1);
        } else printf("ioperm succeeded\n");

        printf("About to perform inb...\n");
        c = inb(0x3cc);
        printf("result: %d\n", (int)c);
        return 0;
}
---cut here---

Steps to reproduce:

1. Compile this program (e.g., "gcc iopt.c" or "gcc -O2 iopt.c").
2. Switch to a text virtual console.
3. Log in as root (or log in as a normal user and su to root). This
program does not crash from within X, nor does it crash from an SSH
session.
4. Run the program (e.g., "./a.out").
5. The program will probably crash after "About to perfrom inb" but
before "result:...". If not, try it again a few times. If it still
doesn't crash for you, try logging in on another virtual console, or
just wait a few minutes and try again. Sometimes it's 10% reproducible
and sometimes it's well over 90% reproducible...
6. Examine the code/core using gdb. Notice that the inb caused the
segfault.

The real-world effect of this bug is that my NES emulator just broke
almost completely. :( Interestingly, a somewhat reliable workaround for
fceu (but not for my test case AFAICT) is to strace it rather than
running it directly -- then it usually doesn't segfault.

-Barry K. Nathan <barryn@pobox.com>
