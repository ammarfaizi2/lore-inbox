Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbSJRLhT>; Fri, 18 Oct 2002 07:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265078AbSJRLhT>; Fri, 18 Oct 2002 07:37:19 -0400
Received: from taifun.devconsult.de ([212.15.193.29]:21265 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S265077AbSJRLhR>; Fri, 18 Oct 2002 07:37:17 -0400
Date: Fri, 18 Oct 2002 13:43:11 +0200
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Andi Kleen <ak@suse.de>
Cc: Crispin Cowan <crispin@wirex.com>, hch@infradead.org, greg@kroah.com,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com, davem@redhat.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021018134311.A30059@devcon.net>
Mail-Followup-To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
	Andi Kleen <ak@suse.de>, Crispin Cowan <crispin@wirex.com>,
	hch@infradead.org, greg@kroah.com, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
	davem@redhat.com
References: <20021017201030.GA384@kroah.com.suse.lists.linux.kernel> <20021017211223.A8095@infradead.org.suse.lists.linux.kernel> <3DAFB260.5000206@wirex.com.suse.lists.linux.kernel> <20021018.000738.05626464.davem@redhat.com.suse.lists.linux.kernel> <3DAFC6E7.9000302@wirex.com.suse.lists.linux.kernel> <p73wuognlox.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <p73wuognlox.fsf@oldwotan.suse.de>; from ak@suse.de on Fri, Oct 18, 2002 at 11:25:02AM +0200
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 11:25:02AM +0200, Andi Kleen wrote:
> 
> The 32bit and the 64bit worlds have different data types. Structure
> layout are different. To handle this the kernel has an emulation
> layer that converts the arguments of ioctls and system calls between 
> 32bit and 64bit.
> 
> This emulation layer sits at the 'edge' of the kernel. For example
> to convert an ioctl it first figures out the ioctl, converts it
> then reissues the same ioctl internally with 64bit arguments. When
> the ioctl returns outgoing arguments are converted too as needed.
> 
> For this to work all data structures need to be transparent.
> The emulation layer needs to have a way to figure out what and
> how to convert without looking at internal state in the kernel.
> Otherwise it cannot do its job. 

Why not let the security module supply the information about the
struct layout?

I'm thinking of something roughly like stdarg.h, e.g.

    #include <linux/user_args.h>
    
    user_args args;

    user_args_start(&args, ptr);

where args is some variable where user_args can save internal state
and ptr is the pointer to the struct from userland (which is
translated appropriately to a kernel space pointer; maybe also a size
argument might be handy, so that you can copy the struct from
userspace memory to kernel memory at once instead of accessing user
address space for every struct member individually), then

    struct.longlongmember = user_args_get(&args, long long);

which applies the right alignment, translates 32bit to 64bit etc.
Due to complexity probably one wants to restrict that to a set of
common types instead of making it full generic (and e.g. use something
like user_args_get_longlong() instead of the type argument), but I
don't think this would be a serious restriction (you can always extend
it later if you really need another type to get through).

This wouldn't work on an architecture where members following later in
a struct could affect the alignment of previous members, but are there
any (sane) architectures around where this is the case? Personally I
can't think of any reason why one possibly wanted to do that...

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
