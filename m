Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbVJaWCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbVJaWCp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 17:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbVJaWCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 17:02:45 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17352 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964857AbVJaWCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 17:02:44 -0500
Date: Mon, 31 Oct 2005 23:02:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] swsusp: move snapshot-handling functions to snapshot.c
Message-ID: <20051031220233.GC14877@elf.ucw.cz>
References: <200510301637.48842.rjw@sisk.pl> <200510301644.44874.rjw@sisk.pl> <20051030195254.GA1729@openzaurus.ucw.cz> <200510312036.36335.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510312036.36335.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This patch moves the snapshot-handling functions remaining in swsusp.c
> > > to snapshot.c (ie. it moves the code without changing the functionality).
> > >
> > 
> > I'm sorry, but I acked this one too quickly. I'd prefer to keep "relocate" code where
> > it is, and define "must not collide" as a part of interface. That will keep snapshot.c
> > smaller/simpler,
> 
> Speaking of simplifications and having seen your code I hope you will agree with
> the appended patch against vanilla 2.6.14-git3 (it reduces the duplication of code,
> and replaces swsusp_pagedir_relocate with a simpler mechanism).

...and also moves stuff around in a way

a) I don't like

and

b) is almost impossible to review

:-). Can you keep "relocate" code in swsusp.c, just making it simpler?

> @@ -997,20 +870,22 @@
>  	int error = 0;
>  	struct pbe *p;
>  
> -	if (!(p = alloc_pagedir(nr_copy_pages)))
> +	if (!(p = alloc_pagedir(nr_copy_pages, 0)))
>  		return -ENOMEM;
>  
>  	if ((error = read_pagedir(p)))
>  		return error;
> -
>  	create_pbe_list(p, nr_copy_pages);
> -
> -	if (!(pagedir_nosave = swsusp_pagedir_relocate(p)))
> +	mark_unsafe_pages(p);
> +	if (!(pagedir_nosave = alloc_pagedir(nr_copy_pages, 1)))
>  		return -ENOMEM;

Okay, this is probably better approach than copying pagedir around...

								Pavel
-- 
Thanks, Sharp!
