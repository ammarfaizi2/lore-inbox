Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbTHYQzW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 12:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbTHYQzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 12:55:22 -0400
Received: from imap.gmx.net ([213.165.64.20]:16008 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261830AbTHYQzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 12:55:15 -0400
Date: Mon, 25 Aug 2003 19:55:12 +0300
From: Dan Aloni <da-x@gmx.net>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] One strdup() to rule them all
Message-ID: <20030825165512.GA9782@callisto.yi.org>
References: <20030825161435.GB8961@callisto.yi.org> <20030825163745.GA17608@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825163745.GA17608@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 06:37:45PM +0200, J?rn Engel wrote:
> > +/**
> > + * strdup - Allocate a copy of a string.
> > + * @s: The string to copy. Must not be NULL.
> > + *
> > + * returns the address of the allocation, or NULL on
> > + * error. 
> > + */
> > +char *strdup(const char *s)
> > +{
> > +	char *rv = kmalloc(strlen(s)+1, GFP_KERNEL);
> > +	if (rv)
> > +		strcpy(rv, s);
> > +	return rv;
> > +}
> 
> My gut feeling is always afraid when something "must not be NULL",
> someone will ignore this and Bad Things (tm) happen.  Is strdup ever
> used such performance critical code that the extra check would hurt?

There are two reasons while it shouldn't have a NULL check. One,
persistency: the other str*() functions don't do this sort of check.
Two, for general uses like that:

     new_name = strdup(name);
     if (!new_name)
         goto allocation_failed;
	 
With this check, NULL would be returning from strdup() either because 
name == NULL or when the allocation fails. You cannot simply pass that 
information through its return value and the caller would need to 
check whether name == NULL by itself which should have been done anyway.

Passing NULL to strdup() is a bug, which would have NOT show as an
Oops if you add this check, and that is bad. Maybe it would be worth 
to add a BUG_ON(s == NULL) instead, and perhaps also add this to the 
other str*() functions, but that is a different patch.

-- 
Dan Aloni
da-x@gmx.net
