Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965136AbWGFC00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbWGFC00 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 22:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965138AbWGFC0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 22:26:25 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:48732 "EHLO
	asav05.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S965136AbWGFC0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 22:26:25 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAAMPrESBTA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Eric Sesterhenn / Snakebyte <snakebyte@gmx.de>
Subject: Re: [Patch] Off by one in drivers/usb/input/yealink.c
Date: Wed, 5 Jul 2006 22:25:32 -0400
User-Agent: KMail/1.9.3
Cc: Henk Vergonet <Henk.Vergonet@gmail.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
References: <1151448080.16217.3.camel@alice> <d120d5000607050655o44cb66c3s7616493c7507d4d8@mail.gmail.com> <20060706004911.GA3563@alice>
In-Reply-To: <20060706004911.GA3563@alice>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607052225.33352.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 July 2006 20:49, Eric Sesterhenn / Snakebyte wrote:
> * Dmitry Torokhov (dmitry.torokhov@gmail.com) wrote:
> > On 7/5/06, Henk Vergonet <Henk.Vergonet@gmail.com> wrote:
> > >On Tue, Jun 27, 2006 at 03:51:43PM -0700, Randy.Dunlap wrote:
> > >> On Wed, 28 Jun 2006 00:41:19 +0200 Eric Sesterhenn wrote:
> > >> > another off by one spotted by coverity (id #485),
> > >> > we loop exactly one time too often
> > >> >
> > >> > Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> > >> >
> > >> > --- linux-2.6.17-git11/drivers/usb/input/yealink.c.orig     2006-06-28 
> > >00:29:46.000000000 +0200
> > >> > +++ linux-2.6.17-git11/drivers/usb/input/yealink.c  2006-06-28 
> > >00:30:04.000000000 +0200
> > >> > @@ -350,7 +350,7 @@ static int yealink_do_idle_tasks(struct
> > >> >             val = yld->master.b[ix];
> > >> >             if (val != yld->copy.b[ix])
> > >> >                     goto send_update;
> > >> > -   } while (++ix < sizeof(yld->master));
> > >> > +   } while (++ix < sizeof(yld->master)-1);
> > >
> > >Apart from introducing a new bug in the code, the construct is ugly.
> > >
> > >I would rather see then the more readable:
> > >
> > >       ix++;
> > >   } while (ix < sizeof(yld->master));
> > >
> > 
> > The new code is exactly the same as the old one; however I do not see
> > the problem with the old code. Could it be that Coverity got confused
> > by prefix vs. postfix increment?
> 
> I looked at this code several times too, and tried to reproduce the bug
> with the following little program:
> 
> #include <string.h>
> int main(int argc, char **argv) {
> 	char foo[] = "abcdef";
> 	int i = 0;
> 
> 	foo[strlen(foo)] = 'X';
> 	do {
> 		putchar(foo[i]);
> 	} while (++i < sizeof(foo));
> }
> 
> Which clearly shows that the terminating '\0' gets printed too,
> replaced by the X for better visibility, so the code
> runs past the array, or did I fail to replicate the original
> code somewhere?
> 

What do you mean "the code runs past the array"? The size of array is 7
(compiler allocates the space for terminating '\0') and the array is
printed in its entirety.

-- 
Dmitry
