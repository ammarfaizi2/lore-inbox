Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbTEaQLU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 12:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbTEaQLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 12:11:19 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:27856 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S264430AbTEaQLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 12:11:15 -0400
Date: Sat, 31 May 2003 13:28:29 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andrew Morton <akpm@digeo.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: must-fix, version 6
Message-ID: <20030531132829.N626@nightmaster.csn.tu-chemnitz.de>
References: <20030530163720.399a8bac.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030530163720.399a8bac.akpm@digeo.com>; from akpm@digeo.com on Fri, May 30, 2003 at 04:37:20PM -0700
X-Spam-Score: -4.7 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19M99n-0004HC-00*0bcUBtG16i.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
hi Al,
hi LKML,

On Fri, May 30, 2003 at 04:37:20PM -0700, Andrew Morton wrote:
> +lib/kobject.c
> +~~~~~~~~~~~~~
> +
> +o kobject refcounting (comments from Al Viro):
> +
> +  _anything_ can grab a temporary reference to kobject.  IOW, if kobject is
> +  embedded into something that could be freed - it _MUST_ have a destructor
> +  and that destructor _MUST_ be the destructor for containing object.
> +
> +  Any violation of the above (and we already have a bunch of those) is a
> +  user-triggerable memory corruption.
> +
> +  We can tolerate it for a while in 2.5 (e.g.  during work on susbsystem we
> +  can decide to switch to that way of handling objects and have subsystem
> +  vulnerable for a while), but all such windows must be closed before 2.6 and
> +  during 2.6 we can't open them at all.
> +

I think a simple variant of this is to extend the kobject
structure with a backlink void* to the container of this object.

That way:
   - we can use kfree() as the default destructor 
   - use special destructors and pass the right object
   - warn and do the most useful thing (a kfree), until all 
     users are converted to either pass kfree or sth. else as an
     constructor.

This solution becomes non-sense, if we T <<< I, where T is the
amount of unique kobject type and I the sum of instances of all
types.

But even then, there can be a transitional model like the above,
but with a "default destructor" needing the container and the
kobject passed, which can later be reduced trivially to just have
the kobject passed and the container being caclulated with
"containerof" in the destructor with knowlegde about the type
where the kobject is in.

The latter solution needs lots of code to be written and is a
huge janitorial work. The backlink solution is much simpler, but
memory consuming.

Comments appreciated.

Regards

Ingo Oeser
