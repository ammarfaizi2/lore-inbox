Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWFNAPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWFNAPn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWFNAPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:15:43 -0400
Received: from xenotime.net ([66.160.160.81]:26777 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932097AbWFNAPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:15:42 -0400
Date: Tue, 13 Jun 2006 17:18:27 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Greg KH <greg@kroah.com>
Cc: mp3@de.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: statistics infrastructure (in -mm tree) review
Message-Id: <20060613171827.73cd0688.rdunlap@xenotime.net>
In-Reply-To: <20060613234739.GA30534@kroah.com>
References: <20060613232131.GA30196@kroah.com>
	<20060613234739.GA30534@kroah.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2006 16:47:39 -0700 Greg KH wrote:

> First cut at reviewing this code.
> 
> Initial impression is, "damm, that's a complex interface".  I'd really
> like to see some other, real-world usages of this.  Like perhaps the
> io-schedular statistics?  Some other /proc stats that have nothing to do
> with processes?

Agreed with complexity.

> And what does this mean for relayfs?  Those developers tuned that code
> to the nth degree to get speed and other goodness, and here you go just
> ignoring that stuff and add yet another way to get stats out of the
> kernel.  Why should I use this instead of my own code with relayfs?

Good questions.

> And is the need for the in-kernel parser really necessary?  I know it
> makes the userspace tools simpler (cat and echo), but should we be
> telling the kernel how to filter and adjust the data?  Shouldn't we just
> dump it all to userspace and use tools there to manipulate it?

I agree again.

> Code comments now:
> 
> 
> > diff -puN /dev/null include/linux/statistic.h
> > --- /dev/null	2006-06-03 22:34:36.282200750 -0700
> > +++ devel-akpm/include/linux/statistic.h	2006-06-09 15:22:58.000000000 -0700
> > @@ -0,0 +1,348 @@
> > +/*
> > + * include/linux/statistic.h
> > + *
> > + * Statistics facility

> > +/**
> > + * struct statistic_info - description of a class of statistics
> > + * @name: pointer to name name string
> > + * @x_unit: pointer to string describing unit of X of (X, Y) data pair
> > + * @y_unit: pointer to string describing unit of Y of (X, Y) data pair
> > + * @flags: only flag so far (distinction of incremental and other statistic)
> > + * @defaults: pointer to string describing defaults setting for attributes
> > + *
> > + * Exploiters must setup an array of struct statistic_info for a
> > + * corresponding array of struct statistic, which are then pointed to
> > + * by struct statistic_interface.
> > + *
> > + * Struct statistic_info and all members and addressed strings must stay for
> > + * the lifetime of corresponding statistics created with statistic_create().
> > + *
> > + * Except for the name string, all other members may be left blank.
> > + * It would be nice of exploiters to fill it out completely, though.
> > + */
> > +struct statistic_info {
> > +/* public: */
> > +	char *name;
> > +	char *x_unit;
> > +	char *y_unit;
> > +	int  flags;
> > +	char *defaults;
> > +};
> 
> The whole "public:" and "private:" thing in these structures is not
> needed.  Just document it in the kernel-doc comments and you should be
> fine.  This isn't C++ :)

but public: and private: are kernel-doc comments...
Using "private:" causes those fields to be omitted from the
generated documentation because those fields are for internal/private
use of the (statistics) infrastructure code, not to be used by
its clients (er, ugh, exploiters) etc.

> > --- /dev/null	2006-06-03 22:34:36.282200750 -0700
> > +++ devel-akpm/lib/statistic.c	2006-06-09 15:22:58.000000000 -0700
> > @@ -0,0 +1,1459 @@
> > +/*
> > + *  lib/statistic.c
> > + *    statistics facility
> > + *

> Again with the verbose license :)

Well it's not uncommon in kernel source files.
Where do we document how licenses should be written?


---
~Randy
