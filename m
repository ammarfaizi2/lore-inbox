Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965089AbWGFAtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbWGFAtQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 20:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWGFAtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 20:49:15 -0400
Received: from mail.gmx.net ([213.165.64.21]:45454 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965089AbWGFAtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 20:49:15 -0400
X-Authenticated: #704063
Date: Thu, 6 Jul 2006 02:49:11 +0200
From: Eric Sesterhenn / Snakebyte <snakebyte@gmx.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henk Vergonet <Henk.Vergonet@gmail.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Eric Sesterhenn <snakebyte@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Off by one in drivers/usb/input/yealink.c
Message-ID: <20060706004911.GA3563@alice>
References: <1151448080.16217.3.camel@alice> <20060627155143.b0e3e1dd.rdunlap@xenotime.net> <20060705130231.GA1259@god.dyndns.org> <d120d5000607050655o44cb66c3s7616493c7507d4d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000607050655o44cb66c3s7616493c7507d4d8@mail.gmail.com>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snake-basket.de
X-Operating-System: Linux/2.6.17 (i686)
X-Uptime: 02:46:07 up 18:34,  3 users,  load average: 0.04, 0.15, 0.15
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dmitry Torokhov (dmitry.torokhov@gmail.com) wrote:
> On 7/5/06, Henk Vergonet <Henk.Vergonet@gmail.com> wrote:
> >On Tue, Jun 27, 2006 at 03:51:43PM -0700, Randy.Dunlap wrote:
> >> On Wed, 28 Jun 2006 00:41:19 +0200 Eric Sesterhenn wrote:
> >> > another off by one spotted by coverity (id #485),
> >> > we loop exactly one time too often
> >> >
> >> > Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> >> >
> >> > --- linux-2.6.17-git11/drivers/usb/input/yealink.c.orig     2006-06-28 
> >00:29:46.000000000 +0200
> >> > +++ linux-2.6.17-git11/drivers/usb/input/yealink.c  2006-06-28 
> >00:30:04.000000000 +0200
> >> > @@ -350,7 +350,7 @@ static int yealink_do_idle_tasks(struct
> >> >             val = yld->master.b[ix];
> >> >             if (val != yld->copy.b[ix])
> >> >                     goto send_update;
> >> > -   } while (++ix < sizeof(yld->master));
> >> > +   } while (++ix < sizeof(yld->master)-1);
> >
> >Apart from introducing a new bug in the code, the construct is ugly.
> >
> >I would rather see then the more readable:
> >
> >       ix++;
> >   } while (ix < sizeof(yld->master));
> >
> 
> The new code is exactly the same as the old one; however I do not see
> the problem with the old code. Could it be that Coverity got confused
> by prefix vs. postfix increment?

I looked at this code several times too, and tried to reproduce the bug
with the following little program:

#include <string.h>
int main(int argc, char **argv) {
	char foo[] = "abcdef";
	int i = 0;

	foo[strlen(foo)] = 'X';
	do {
		putchar(foo[i]);
	} while (++i < sizeof(foo));
}

Which clearly shows that the terminating '\0' gets printed too,
replaced by the X for better visibility, so the code
runs past the array, or did I fail to replicate the original
code somewhere?

Eric

