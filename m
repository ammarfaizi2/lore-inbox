Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312227AbSCRHhN>; Mon, 18 Mar 2002 02:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312226AbSCRHhE>; Mon, 18 Mar 2002 02:37:04 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:56332 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S311239AbSCRHgx>; Mon, 18 Mar 2002 02:36:53 -0500
Date: Mon, 18 Mar 2002 08:36:50 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jeremy Jackson <jerj@coplanar.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New commandline parsing framework
Message-ID: <20020318083650.A2152@ucw.cz>
In-Reply-To: <003c01c1cddf$f9fdb780$7e0aa8c0@bridge>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This sounds pretty cool, do you have the patch available?

Vojtech

On Sun, Mar 17, 2002 at 10:17:16AM -0800, Jeremy Jackson wrote:
> Hi linux-kernel,
> 
> In looking through the IDE hotswap support (2.5.6), it occurred to me that
> having a static array big enough to hold all possibly interfaces, is,
> um, inelegant, when you start adding and removing devices.  This is common
> with many things.
> 
> Looking furthur, I see that this is because the structures must
> exist when the command line is parsed, and that's done ahead
> of the IDE module's init, before kmalloc is available.
> 
> __setup("",ide_setup); is called by __parse_options() in main.c by
> start_kernel()
> 
> Of course the mm subsys needs access to cmdline args.  But *most* other
> sys don't.  So they shouldn't *have* to be able to parse here.  Forcing them
> to means they must use fixed sized arrays in bss segment, not kmalloc et al.
> 
> I have almost completed a patch which moves the IDE module's cmdline
> parsing into the module's init routine, allowing the hwif structure to
> become an linked list of hwif_t structures, kmalloced or slab
> construced/freed as needed.  It simply copies the options it's given into an
> __initdata
> buffer, delaying parsing them until ide.c:init_ata().  Of course it could
> just
> use the saved_command_line[], as could everyone.
> 
> Question: are there any problems with using this approach in general?
> 
> * extra pointer derefrence (linked list vs static array indexing)
> performance issue?
> 
> Perks:
> 
> * slab cache constructor could fill in what's currently initialized data
> * backwards compatibility is easy to provide
> * may be incrementally/optionally adopted in drivers in kernel tree and
> outside
> * old interface may be removed easily at some time in future
> * drivers can unify boot cmdline and module load options parsing,
>    reducing complexity and code size
> * eases removal of legacy support (ie don't probe, just use PCI config
>   data and allocate one hwif for each one found)
> * each subsys is more self-contained. cleaner code.
> 
> I propose to create a patch which makes main.c:checksetup() more of a
> library function, with __setup being used only by subsystems that
> require
> command line parsing at the current early point.  Others can call
> checksetup(saved_command_line, __setup-like-list-of-my-argnames);
> in their main init routine.  the /sbin/init env/arg construction could
> be
> delayed until the init thread is started.
> 
> things like serial driver (when serial console support is selected)
> could simply start their linked list with one statically allocated,
> and add others in later, so they can still be initialized early on.
> 
> I think I've figured out the side effects but I'm looking for some more
> experienced advice.
> 
> Thanks,
> 
> Jeremy
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
