Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbWAFJtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWAFJtn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 04:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWAFJtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 04:49:43 -0500
Received: from [218.25.172.144] ([218.25.172.144]:31501 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S964879AbWAFJtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 04:49:42 -0500
Date: Fri, 6 Jan 2006 17:49:33 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: Dave Jones <davej@redhat.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
Cc: rms@gnu.org, torvalds@osdl.org
Subject: Re: Add tainting for proprietary helper modules.
Message-ID: <20060106094933.GB2807@localhost.localdomain>
References: <20051203004102.GA2923@redhat.com> <Pine.LNX.4.61.0512050832290.27133@chaos.analogic.com> <20051205173041.GE12664@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205173041.GE12664@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 12:30:41PM -0500, Dave Jones wrote:
> On Mon, Dec 05, 2005 at 08:41:57AM -0500, linux-os (Dick Johnson) wrote:
>  > 
>  > On Fri, 2 Dec 2005, Dave Jones wrote:
>  > 
>  > > Kernels that have had Windows drivers loaded into them are undebuggable.
>  > > I've wasted a number of hours chasing bugs filed in Fedora bugzilla
>  > > only to find out much later that the user had used such 'helpers',
>  > > and their problems were unreproducable without them loaded.
>  > >
>  > > Acked-by: Arjan van de Ven <arjan@infradead.org>
>  > > Signed-off-by: Dave Jones <davej@redhat.com>
>  > >
>  > > --- linux-2.6.14/kernel/module.c~	2005-11-29 16:44:00.000000000 -0500
>  > > +++ linux-2.6.14/kernel/module.c	2005-11-29 17:03:55.000000000 -0500
>  > > @@ -1723,6 +1723,11 @@ static struct module *load_module(void _
>  > > 	/* Set up license info based on the info section */
>  > > 	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
>  > >
>  > > +	if (strcmp(mod->name, "ndiswrapper") == 0)
>  > > +		add_taint(TAINT_PROPRIETARY_MODULE);
>  > > +	if (strcmp(mod->name, "driverloader") == 0)
>  > > +		add_taint(TAINT_PROPRIETARY_MODULE);
>  > > +
>  > > #ifdef CONFIG_MODULE_UNLOAD
>  > > 	/* Set up MODINFO_ATTR fields */
>  > > 	setup_modinfo(mod, sechdrs, infoindex);
>  > 
>  > So your are blacklisting certain drivers? If so, you probably
>  > should have an array containing their names plus a header-file
>  > into which the hundreds, perhaps thousands, of future module-
>  > names can be added.
>  > 
>  > ... Not meant as a joke or an affront. User's should be able to
>  > know what hardware to NOT purchase because of the proprietary
>  > nature of their drivers. Putting a couple "exceptions" into
>  > code as above is not good coding practice. If you need to
>  > exclude stuff, there should be an exclusion procedure that
>  > treats all that stuff equally, no?
> 
> There's a point where the effort of creating an array, and
> loops to parse it isn't worth it. For two entries, this
> seemed a lot simpler.
> 
> Though if there more additions, I'd agree.
> 
> 		Dave

Hello,

You've hard-coded some module names, that itself `taints' the
kernel source IMO.  Blacklisting in kernel is both ugly and unacceptable.

I agree that it would be convenient for you to only check if there's `Not tainted' in oops messages.  But I still suggest you to not hard-code them in the
kernel source.  Instead you could use some script to grep the problematic module
names in the `Modules linked in' field.

For the long run, we could:

1) Add some other mechanism, like MODULE_LICENSE_STRICT("GPL.strict").

   GPL.strict:  A GPL.strict module is not only itself licensed under GPL,
   but it shall not load/link any binary code (specially non-gpl binaries)
   nor any non-GPL.strict code. This definition goes recursively.

   Then we let a module without GPL.strict taints the kernel. This time we
   treat everyone equally.

2) Fix the gpl in gpl3; follow the above.

-- 
Coywolf Qi Hunt
