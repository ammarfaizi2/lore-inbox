Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264848AbSJPE0G>; Wed, 16 Oct 2002 00:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264858AbSJPE0G>; Wed, 16 Oct 2002 00:26:06 -0400
Received: from gw.softway.com.au ([203.31.96.1]:60176 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id <S264848AbSJPE0C>;
	Wed, 16 Oct 2002 00:26:02 -0400
Date: Wed, 16 Oct 2002 14:31:55 +1000 (EST)
From: Kingsley Cheung <kingsley@aurema.com>
X-X-Sender: kingsley@kingsley.sw.oz.au
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Bug in "sys_init_module", kernel/module.c, 2.4.19
In-Reply-To: <Pine.LNX.4.44.0208051241290.11259-100000@kingsley.sw.oz.au>
Message-ID: <Pine.LNX.4.44.0210161414420.1982-100000@kingsley.sw.oz.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've a trivial patch against kernel/module.c for 2.4.19 below that 
fixes a problem with the initialisation of a stack of modules.  
Though it rarely occurs, without this the kernel can crash when a module 
is being initialised and before this initialisation finishes another 
*dependent* module is loaded.  This occurs when the first module blocks 
in init_module and releases the big kernel lock.  I discussed this earlier 
with Keith Owens but it looks like its been forgotten:  

On Mon, 5 Aug 2002, Keith Owens wrote:

> On Mon, 5 Aug 2002 17:25:21 +1000 (EST),
> Kingsley Cheung <kingsley@aurema.com> wrote:
> >Anyway, at this point I'm still not certain I've completely grasped your
> >reply. Maybe I didn't make my first email clear.  If this is so, then
> >what I was saying is that the invocation of "init_module" functions of
> >*dependent* modules needs be appropriately serialised.  Right now
> >"sys_init_module" is relying on the big kernel lock to completely
> >serialise these calls but if any "init_module" function blocks, the
> >kernel lock is released and this serialisation can be broken.  Maybe one
> >way to avoid this is to check the flags of modules depended on during
> >"sys_init_module". So if the MOD_RUNNING flag is not set for the module
> >we depend on, then the module currently being loaded must have its
> >invocation of "sys_init_module" wait or return an appropriate error
> >indicating why.
>
> Agreed, this is a bigger problem than a failed module_init().  I am
> going to think about this overnight.
>

Cheers,
Kingsley


--- module.c.old        Wed Oct 16 10:46:10 2002
+++ module.c    Wed Oct 16 10:50:13 2002
@@ -528,6 +528,10 @@
                                "(no longer?) a module.\n");
                        goto err3;
                }
+
+               /* Dependents must be initialised and running */
+               if (!(d->flags & MOD_RUNNING) || (d->flags & MOD_DELETED))
+                       goto err3;
        }
 
        /* Update module references.  */





