Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbWJBUiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbWJBUiP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbWJBUiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:38:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13737 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965007AbWJBUiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:38:14 -0400
Date: Mon, 2 Oct 2006 13:38:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Brownell <david-b@pacbell.net>
Cc: "Thiago Galesi" <thiagogalesi@gmail.com>,
       "Andrea Paterniani" <a.paterniani@swapp-eng.it>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.18-git] SPI -- Freescale iMX SPI controller driver
Message-Id: <20061002133806.10bd652d.akpm@osdl.org>
In-Reply-To: <200610021310.15374.david-b@pacbell.net>
References: <200610020816.58985.david-b@pacbell.net>
	<82ecf08e0610021137r446031a8pa303053479e9cb27@mail.gmail.com>
	<200610021310.15374.david-b@pacbell.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2006 13:10:14 -0700
David Brownell <david-b@pacbell.net> wrote:

> > > +/* Message state */
> > > +#define START_STATE                    ((void*)0)
> > > +#define RUNNING_STATE                  ((void*)1)
> > > +#define DONE_STATE                     ((void*)2)
> > > +#define ERROR_STATE                    ((void*)-1)
> > 
> > !?!??!?!
> 
> Now that you mention it ... let me second that comment!

These are "better enums".  The problem with C's enums is that it's possible
to mix them with integers and the compiler just swallows it.  With the
above, you'll get a warning if you make that mistake.

But otoh, it's possible to accidentally mix the above with, say, char*. 
And it's not convenient to declare this type.  So something like this would
be better:

struct not_a_struct {};
typedef struct not_a_struct *better_enum;

#define RUNNING_STATE		((better_enum)1)

better_enum my_function(better_enum b)
{
	...
	return RUNNING_STATE;
}

would work.

Next would be

#define DECLARE_BETTER_ENUM(name)				\
	struct not_a_struct_##name {};				\
	typedef struct not_a_struct##name better_enum_##name;

so we can declare types like better_enum_spi_state,
better_enum_notifier_return_, etc.


Anyway, back to work...  any patch which actually attempts to implement
this sort of thing will be cheerily ignored ;)   Do the enum-mismatch checking
in sparse.

