Return-Path: <linux-kernel-owner+w=401wt.eu-S1750896AbWLLCJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWLLCJM (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 21:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWLLCJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 21:09:12 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60937 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896AbWLLCJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 21:09:10 -0500
Date: Mon, 11 Dec 2006 18:08:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>,
       Andrew MChuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
Message-Id: <20061211180822.5f7814d5.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612110748570.12500@woody.osdl.org>
References: <200612110330_MC3-1-D49B-BC0F@compuserve.com>
	<20061211005557.04643a75.akpm@osdl.org>
	<20061211011327.f9478117.akpm@osdl.org>
	<20061211092130.GB4587@ftp.linux.org.uk>
	<20061211012545.ed945cbd.akpm@osdl.org>
	<20061211093314.GC4587@ftp.linux.org.uk>
	<20061211014727.21c4ab25.akpm@osdl.org>
	<20061211100301.GD4587@ftp.linux.org.uk>
	<20061211021718.a6954106.akpm@osdl.org>
	<20061211022746.9ec80c03.akpm@osdl.org>
	<20061211104556.GF4587@ftp.linux.org.uk>
	<Pine.LNX.4.64.0612110748570.12500@woody.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006 08:01:40 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Mon, 11 Dec 2006, Al Viro wrote:
> 
> > On Mon, Dec 11, 2006 at 02:27:46AM -0800, Andrew Morton wrote:
> > > @@ -115,6 +115,11 @@ extern void setup_arch(char **);
> > >  #define device_initcall_sync(fn)	__define_initcall("6s",fn,6s)
> > >  #define late_initcall(fn)		__define_initcall("7",fn,7)
> > >  #define late_initcall_sync(fn)		__define_initcall("7s",fn,7s)
> > > +#define populate_rootfs_initcall(fn)	__define_initcall("8",fn,8)
> > > +#define populate_rootfs_initcall_sync(fn) __define_initcall("8s",fn,8s)
> > > +#define rootfs_neeeded_initcall(fn)	__define_initcall("9",fn,9)
> > > +#define rootfs_neeeded_initcall_sync(fn) __define_initcall("9s",fn,9s)
> > 
> > Ewww....  After module_init()?  Please, don't.  Come on, if it can
> > be a module, it _must_ be ready to run late in the game.
> 
> Yeah, I think you should just run "populate_rootfs()" just before 
> "module_init" (which is the same as "device_initcall()").
> 
> So perhaps somethign like this? (totally untested)
> 
> Btw, if the linker sorts sections some way (does it?) we could probably 
> just make the vmlinux.lds.S file do
> 
> 	*(.initcall*.init)
> 
> or something, and then just let special cases like this use
> 
> 	__initcall(myfn, 5.1);
> 
> to show that it's between levels 5 and 6. But that would depend on the 
> linker section beign sorted alphabetically. Does anybody know if the 
> linker sorts these things somehow?
> 
> This patch is totally untested, but it looks obvious. It just says that 
> we'll populate rootfs _after_ we've done the fs-level initcalls, but 
> before we do any actual "device" initcalls.
> 
> If any really core stuff needs user-land - tough titties, as they say.
> 
> 		Linus
> ----
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 6e9fceb..7437cca 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -242,6 +242,7 @@
>    	*(.initcall4s.init)						\
>    	*(.initcall5.init)						\
>    	*(.initcall5s.init)						\
> +	*(.initcallrootfs.init)						\
>    	*(.initcall6.init)						\
>    	*(.initcall6s.init)						\
>    	*(.initcall7.init)						\
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 5eb5d24..5a593a1 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -111,6 +111,7 @@ extern void setup_arch(char **);
>  #define subsys_initcall_sync(fn)	__define_initcall("4s",fn,4s)
>  #define fs_initcall(fn)			__define_initcall("5",fn,5)
>  #define fs_initcall_sync(fn)		__define_initcall("5s",fn,5s)
> +#define rootfs_initcall(fn)		__define_initcall("rootfs",fn,rootfs)
>  #define device_initcall(fn)		__define_initcall("6",fn,6)
>  #define device_initcall_sync(fn)	__define_initcall("6s",fn,6s)
>  #define late_initcall(fn)		__define_initcall("7",fn,7)

Looks like this might break pcmcia which for some reason does firmware
requesting at fs_initcall level (drivers/pcmcia/ds.c).


