Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266994AbSKUTj5>; Thu, 21 Nov 2002 14:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266996AbSKUTj5>; Thu, 21 Nov 2002 14:39:57 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:24337 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266994AbSKUTj4>; Thu, 21 Nov 2002 14:39:56 -0500
Date: Thu, 21 Nov 2002 20:46:57 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] module fs or how to not break everything at once
In-Reply-To: <20021121015956.GB1584@ppc.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0211212015340.2113-100000@serv>
References: <Pine.LNX.4.44.0211202013000.2113-100000@serv> <20021120220338.GA6079@vana>
 <Pine.LNX.4.44.0211210014500.2113-100000@serv> <20021121015956.GB1584@ppc.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 21 Nov 2002, Petr Vandrovec wrote:

> > Indeed, rmdir should probably also remove the control file.
> 
> Actually I was thinking in opposite way: requiring user to create
> "control", instead of creating it automatically.
> 
> And more I think about it, why there is one "control" for each
> directory? Is not one "control" for whole modfs sufficient?
> fs is then just mounted with existing control, and unmount
> gets rid of it.

I'd rather create a central control file (which might be really the 
cleaner solution), than let the user create it.

> And after implementing releasing of .init as truncate() on
> module file, you can remove directories from modfs completely,
> even more simplifying it.

Directories are likely required, e.g. symbols have to be added and I'm 
still thinking about how to represent the module arguments.

> > module_dir->module is an optimization to get quickly to the module file 
> > created by sys_create_module().
> 
> Ok, I'll try something else. If you'll create module through
> sys_create_module, and remove using echo/rm/rmdir, will not it leak
> dentry?

I noticed that too, but it's easy to fix and not the only leak, as you 
probably noticed. :)

> > > It has unfortunate feature that sys_create_module(); 
> > > sys_delete_module() (without suceeding sys_init_module between
> > > them) will return -ENOENT, and you'll have to use rm/rmdir to get 
> > > rid of module :-(
> > 
> > As the system calls are only temporary, they don't have to be perfect, but 
> > why should it return -ENOINT, AFAICS it should fail for other reason.
> 
> Your current implementation will return -ENOENT because of moddir->module 
> will be NULL: but it is not critical error, it just means that 
> sys_create_module() was called, but sys_init_module() was not, and 
> you should not fail cleanup for such case.

moddir->module is initialized in sys_create_module, so this shouldn't be a 
problem.

> I think that you should not be too clever in insmod/rmmod. Just code
> them like userspace clients will do: open "control", write "exit module"
> and "unmap module" into it, and then unlink "module" and remove
> that directory...

Well, first I have to see if I have to emulate these system calls at all.
I still have to see how much work it will be to reimplement the magic 
do-it-all module load syscall on top of modfs, it probably will be easier 
to keep them separate.

> And do we need separate map/init and exit/unmap? I do not think that
> it should be supported to do map/init/exit/init/exit/unmap...

You first have to map the module into the kernel (or at least reserve the 
space), so you know the address the module has to be relocated to.

> And because of you do not allow unlink() on mapped module,
> what about doing implicit exit/unmap on unlink, removing exit/unmap
> operations from control completely?

For now I'd rather keep a fine grained interface, it can still be 
simplified later.

bye, Roman

