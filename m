Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVFUMRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVFUMRV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 08:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVFUMRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 08:17:17 -0400
Received: from gaz.sfgoth.com ([69.36.241.230]:45536 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S261436AbVFUMQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 08:16:35 -0400
Date: Tue, 21 Jun 2005 05:18:33 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: domen@coderock.org, pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] kernel/power/disk.c string fix and if-less iterator
Message-ID: <20050621121833.GD84485@gaz.sfgoth.com>
References: <20050620215712.840835000@nd47.coderock.org> <20050621073307.GE27887@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050621073307.GE27887@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Tue, 21 Jun 2005 05:18:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J?rn Engel wrote:
> > -	char *p = "-\\|/";
> > +	char p[] = "-\\|/";
> >  
> >  	printk("Freeing memory...  ");
> >  	while ((tmp = shrink_all_memory(10000))) {
> >  		pages += tmp;
> >  		printk("\b%c", p[i]);
> > -		i++;
> > -		if (i > 3)
> > -			i = 0;
> > +		i = (i + 1) % (sizeof(p) - 1);
> >  	}
> >  	printk("\bdone (%li pages freed)\n", pages);
> >  }
> 
> Isn't "-\\|/" NUL-terminated and hence 5 characters long?  In that
> case, you patch may do funny things.

Yeah, you probably really want to do something like:

	static const char p[] = { '-', '\\', '|', '/' };

	printk("Freeing memory...  ");
	while ((tmp = shrink_all_memory(10000))) {
		pages += tmp;
		printk("\b%c", p[i++ % sizeof(p)]);
	}

By using {} instead of "" to declare the char array you avoid placing the
unneeded '\0' terminator on the string.  Plus it definately should be
declared "static".  I don't see any advantage here of keeping "i" explicitly
in range instead of just doing the "i & 3" on each array lookup; it's one
and per loop either way.

-Mitch
