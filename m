Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261361AbSJVL1j>; Tue, 22 Oct 2002 07:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbSJVL1j>; Tue, 22 Oct 2002 07:27:39 -0400
Received: from tolkor.sgi.com ([198.149.18.6]:61382 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S261361AbSJVL1h>;
	Tue, 22 Oct 2002 07:27:37 -0400
Date: Tue, 22 Oct 2002 14:47:45 -0400
From: Christoph Hellwig <hch@sgi.com>
To: Piet Delaney <piet@www.piet.net>
Cc: "Matt D. Robinson" <yakker@aparity.com>, linux-kernel@vger.kernel.org,
       Keith Owens <kaos@ocs.com.au>, steiner@sgi.com,
       jeremy@classic.engr.sgi.com
Subject: Re: [PATCH] 2.5.44: lkcd (9/9): dump driver and build files
Message-ID: <20021022144745.A7367@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	Piet Delaney <piet@www.piet.net>,
	"Matt D. Robinson" <yakker@aparity.com>,
	linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>,
	steiner@sgi.com, jeremy@classic.engr.sgi.com
References: <200210211016.g9LAG5J21214@nakedeye.aparity.com> <20021021172112.C14993@sgi.com> <1035238019.4123.85.camel@www.piet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1035238019.4123.85.camel@www.piet.net>; from piet@www.piet.net on Mon, Oct 21, 2002 at 03:06:59PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 03:06:59PM -0700, Piet Delaney wrote:
> > Using volatile is almost always a bug.  USe atomic variables
> > or bitops instead.
> 
> Yea, volatile is just being used to implement a simple atomic variable. 

It just isn't guaranteed to be atomic.. Use atomic_t (for actual
values) or unsigned long + set_bit/test_bit/ænd friends for bitmasks.

> > > +static dump_compress_t dump_none_compression = {
> > > +	compress_type:	DUMP_COMPRESS_NONE,
> > > +	compress_func:	dump_compress_none,
> > > +};
> > 
> > C99 initializers.
> 
> What's C99?

.name = value, i.e. in this case:

static dump_compress_t dump_none_compression = {
	.compress_type		= DUMP_COMPRESS_NONE,
	.compress_func		= dump_compress_none,
};

> > > +#if DUMP_DEBUG
> > > +void dump_bp(void) {}
> > > +#endif
> > 
> > Doesn't seem to be implemented at all.
> 
> .
> dump_bp() is just a debugging hook that's
> enabled while debugging the lkcd dump driver.
> DUMP_DEBUG can be defined in dump.h and allows
> the kernel and user space code to be instrumented
> for easier debugging. I found it useful while debugging.

Well, I can't find dump_bp beeing implemented at all.

> Perhaps the usefulness of the various aproaches during early startup
> should be considered. In RedHat 8.0 there does seem to be existant
> hooks for user space core dumps in /etc/sysctl.conf:
> ----------------------------------------------------------------------
>  Controls whether core dumps will append the PID to the core filename.
> # Useful for debugging multi-threaded applications.
> kernel.core_uses_pid =
> ----------------------------------------------------------------------
> When is /etc/sysctl.conf read by the kernel?

It isn't.  Ths userspace tool sysctl reads it if asked to.  It's done
in /etc/init.d/network by redhat.  But you can uses systcl with a config
file or directly specified parameters at any time you want - or just
write to the /proc/sys/* files (which is what sysctl does internally).

> It's a callback used by the dump driver. These callbacks are
> used by disk drivers, like the SGI SCSI driver, to tune the
> dump driver for it's needs. The callback facility was added
> to the dump driver and this tuning for the device driver seemed
> like a natural user of the facility. 

IMHO we should not have that code in the mainline kernel unless
uses.  And personally I can't see any reason why xscsi should be
ported to 2.6, although of course I can't don't know what plans
that team has nor do I know about any managment decisions.

> > Yuck.  Please just declare page_is_ram for every port.
> > 
> > > +#if !defined(CONFIG_DISCONTIGMEM) && !defined(CONFIG_IA64)
> > > +	p = (struct page *) &(mem_map[page_index]);
> > 
> > Yuck.  Please don't use mem_map in common code.
> 
> Yea the NUMA Ia64 code can't use it; I dind't see
> and easy way of replacing it. What do you suggest?

There is a node_mem_map in each pgdat_t - that's what the common
code uses nowdays.

> > Why don't you do this 
> 
> Perhaps it could. Perhaps kern_addr_valid() doesn't work for ia64.
> I'd have to check to be sure.

It should work on any architecture.  Once you're in mainline thay
just have to fix it if it doesn't :)

> > I don't think ioctl is the right interface.  Most of those want to be sysctls.
> 
> When can sysctls be set up? Earlier that ioctls() can be used? Perhaps
> something very early in startup should be used; like kernel boot
> options. 

sysctl by number is a syscall and can be used at any time.  sysctl
by name needs procfs mounted.  And of course you driver must either
in the kernel or the module loaded so that the entries are actually
registered.

> > 
> > Just move it to arch code for everyone.
> 
> What's wrong with having code which is common for most
> arch's in the dump driver. Seems to me it keeps things
> easier to understand. With ia64 being the only arch
> with special needs, it seems cleaner to just have common
> code handle the common situation.

ifdefs in common code make reading it a lot harder, and per-arch
ifdefs are a maintaince horror.  Maybe introduce a __ARCH_DUMP_MBANK
in asm-ia64/dump.h instead so any new arch can plug in easily?

> > > +	/* try to create our dump device */
> > > +	if (unregister_chrdev(DUMP_MAJOR, "dump"))
> > > +		DUMP_PRINT("cannot unregister dump character device!\n");
> > 
> > the printk is rather pointless..
> 
> Why is that?

Because the module will be unloaded anyway - i.e. the admin can do
anything at all if it failed.  For the given arguments it can't
return an error anyway - I think we should change it to void return
for 2.6..

> > > +kdev_t dump_dev;   	           /* the actual kdev_t device number      */
> > 
> > didn't we already have this one in dump_base.c?
> I thought this is dump_base.c

Exactly the same line is in dump_base.c and dump_blockdev.c.

> > Shouldn't much of this be static? again volatile is seldomly a good idea.
> 
> I suppose  with 'bio_complete' being an int changing it's value is
> atomic as long as it's treated a a volatile.Using a spinlock might
> be cleaner.

an atomic_t or set_bit/test_bit/etc is used to be atomic in the kernel
if you don't want a lock.  And in this case a lock looks like overkill.

