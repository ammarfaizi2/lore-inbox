Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264643AbSKUBw5>; Wed, 20 Nov 2002 20:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266270AbSKUBw5>; Wed, 20 Nov 2002 20:52:57 -0500
Received: from r2w25.mistral.cz ([62.245.86.25]:6016 "EHLO ppc.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S264643AbSKUBw4>;
	Wed, 20 Nov 2002 20:52:56 -0500
Date: Thu, 21 Nov 2002 02:59:56 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] module fs or how to not break everything at once
Message-ID: <20021121015956.GB1584@ppc.vc.cvut.cz>
References: <Pine.LNX.4.44.0211202013000.2113-100000@serv> <20021120220338.GA6079@vana> <Pine.LNX.4.44.0211210014500.2113-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211210014500.2113-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 12:32:40AM +0100, Roman Zippel wrote:
> Hi,
> 
> On Wed, 20 Nov 2002, Petr Vandrovec wrote:
> 
> > ... now when we have setxattr() in kernel, what about using
> > setxattr() on module directory instead of separate control file? 
> > I know, you cannot manage it with "echo" then, but it looks
> 
> A normal file is easier for testing.

read/write on directory? OK, if you can make behavior of "control"
file more consistent.

> > strange that mkdir automatically creates control file while
> > rmdir does not remove it automatically... and without control
> 
> Indeed, rmdir should probably also remove the control file.

Actually I was thinking in opposite way: requiring user to create
"control", instead of creating it automatically.

And more I think about it, why there is one "control" for each
directory? Is not one "control" for whole modfs sufficient?
fs is then just mounted with existing control, and unmount
gets rid of it.

And after implementing releasing of .init as truncate() on
module file, you can remove directories from modfs completely,
even more simplifying it.

> > And one minor comment: do you really need both module_dir->module
> > and module_data->module? Do you use it only to make sure that
> > sys_delete_module will not operate on modules not created by
> > sys_init_module? 
> 
> module_dir->module is an optimization to get quickly to the module file 
> created by sys_create_module().

Ok, I'll try something else. If you'll create module through
sys_create_module, and remove using echo/rm/rmdir, will not it leak
dentry?

> > It has unfortunate feature that sys_create_module(); 
> > sys_delete_module() (without suceeding sys_init_module between
> > them) will return -ENOENT, and you'll have to use rm/rmdir to get 
> > rid of module :-(
> 
> As the system calls are only temporary, they don't have to be perfect, but 
> why should it return -ENOINT, AFAICS it should fail for other reason.

Your current implementation will return -ENOENT because of moddir->module 
will be NULL: but it is not critical error, it just means that 
sys_create_module() was called, but sys_init_module() was not, and 
you should not fail cleanup for such case.

I think that you should not be too clever in insmod/rmmod. Just code
them like userspace clients will do: open "control", write "exit module"
and "unmap module" into it, and then unlink "module" and remove
that directory...

And do we need separate map/init and exit/unmap? I do not think that
it should be supported to do map/init/exit/init/exit/unmap...
And because of you do not allow unlink() on mapped module,
what about doing implicit exit/unmap on unlink, removing exit/unmap
operations from control completely?
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz
