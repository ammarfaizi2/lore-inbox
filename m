Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262677AbVFWIss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbVFWIss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbVFWIpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:45:06 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:38609 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262596AbVFWIJH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 04:09:07 -0400
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel>
            <p73d5qgc67h.fsf@verdi.suse.de>
            <42B86027.3090001@namesys.com>
            <20050621195642.GD14251@wotan.suse.de>
            <42B8C0FF.2010800@namesys.com>
            <84144f0205062223226d560e41@mail.gmail.com>
            <42BA67C9.7060604@namesys.com>
In-Reply-To: <42BA67C9.7060604@namesys.com>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Hans Reiser <reiser@namesys.com>
Cc: Pekka Enberg <penberg@gmail.com>, vs <vs@thebsh.namesys.com>,
       Andi Kleen <ak@suse.de>, Alexander Lyamin aka FLX <flx@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: -mm -> 2.6.13 merge status
Date: Thu, 23 Jun 2005 11:08:55 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42BA6E17.00005001@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans, 

On Thu, 2005-06-23 at 00:42 -0700, Hans Reiser wrote:
> > These assertion codes are meaningless to the rest of us so please drop
> > them. 
> 
> I think you don't appreciate the role of assertions in making code
> easier to audit and debug.

I did not say you should drop the assertions. I referred to the
"nikita-955" part which is redundant and pointless. Using
__FILE__:__LINE__ (or BUG_ON even) will give you enough information to
identify where the error occured. 

On Thu, 2005-06-23 at 00:42 -0700, Hans Reiser wrote:
> > This belongs to include/linux, not reiser4. 
> 
> Too much politics are involved in modifying other peoples directories,
> or I'd agree with you.  The first person outside the reiser4 project to
> use it should move it into a different place.

What politics? Please do hide generic code in your fs. How should
someone outside reiser4 know you have type-safe hash tables and linked
lists in there? Why should they care? It is obvious that you did not
think <linux/list.h> and <linux/jhash.h> were sufficient so please fix
those instead and use them. 

> >>+reiser4_internal void reiser4_handle_error(void)
> >>+{
> >>+   struct super_block *sb = reiser4_get_current_sb();
> >>+
> >>+   if ( !sb )
> >>+           return;
> >>+   reiser4_status_write(REISER4_STATUS_DAMAGED, 0, "Filesystem error occured");
> >>+   switch ( get_super_private(sb)->onerror ) {
> >>+   case 0:
> >>+           reiser4_panic("foobar-42", "Filesystem error occured\n");
> >>+   case 1:
> >>+           if ( sb->s_flags & MS_RDONLY )
> >>+                   return;
> >>+           sb->s_flags |= MS_RDONLY;
> >>+           break;
> >>+   case 2:
> >>+           machine_restart(NULL);
> >>    
> >>
> >
> > Probably not something you should do at fs level. 
> 
> Not sure why you say that.

Because Reiser4 hitting an error condition and restarting the machine
silently is silly. Just do panic() there. 

> This is not too defensive.  Nikita did well here.  The culture of code
> auditors is very different from most programmers.  Like most
> specialists, they have wisdom to offer those who listen to them.  In
> essence, they teach that every function should have a specification of
> every possible restriction on allowed input that can be imagined and is
> correct as a restriction.  Code auditors love assertions like this.  I
> look at my understanding of this before DARPA, and I wince.  DARPA
> patiently taught me much in this area as I listened to security talks at
> our meetings, and I thank them for it. 

Hans, I am aware of techniques such as design-by-contract but it is not
the kernel coding style. That's because it makes the code harder to read
and refactor. 

> Large scale projects like reiser4 are crippled by debugging costs. 
> Anything that reduces debugging time is worth so much.....

Then start writing automated unit tests. 

> >>+/* allocate fresh znode */
> >>+reiser4_internal znode *
> >>+zalloc(int gfp_flag /* allocation flag */ )
> >>+{
> >>+   znode *node;
> >>+
> >>+   node = kmem_cache_alloc(znode_slab, gfp_flag);
> >>+   return node;
> >>+}
> >>    
> >>
> >
> >Please drop this useless wrapper.
> >  
> >
> Thanks.  vs, I think he is right here.... I see zalloc used in only two
> places.....  Or is the desire to ease future porting work?

Then add it later. It is a useless wrapper now. 

> >>--- /dev/null       2003-09-23 21:59:22.000000000 +0400
> >>+++ linux-2.6.11-vs/fs/reiser4/debug.h      2005-06-03 17:49:38.297184283 +0400
> >>+
> >>+/*
> >>+ * Error code tracing facility. (Idea is borrowed from XFS code.)
> >>    
> >>
> >
> >Could this be turned into a generic facility? 
> 
> 
> Probably it already is one.  Getting it used as such sounds like a lot
> of political work though.  Maybe the first person outside the reiser4
> project to want to use it should move the code into a different location.

What political work? Just whoop up a patch to introduce it as a generic
facility and let others review it. There are plenty of janitors that are
willing to convert the existing code. Please note that you're now 
duplicating code from XFS (even if it is just an idea you borrowed). 

This stuff is fairly simple: if the technique you're using is good, it
should probably be generic; if it isn't, you shouldn't be using it
either. Please don't let the pissing contest between you and hch create
more work for the rest of us. 

> actually I want to see emergency flush die very very much.   As for
> fixing vm, easier said than done, politically.

As you might have noticed, I don't care for politics. Just post the patch
to fix the vm for review. 

                       Pekka 

