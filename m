Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275884AbSIUHde>; Sat, 21 Sep 2002 03:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275885AbSIUHde>; Sat, 21 Sep 2002 03:33:34 -0400
Received: from pool-129-44-58-33.ny325.east.verizon.net ([129.44.58.33]:29962
	"EHLO arizona.localdomain") by vger.kernel.org with ESMTP
	id <S275884AbSIUHdd>; Sat, 21 Sep 2002 03:33:33 -0400
Date: Sat, 21 Sep 2002 03:38:30 -0400
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] In-kernel module loader 1/7
Message-ID: <20020921033830.A32446@arizona.localdomain>
References: <20020919183843.GA16568@kroah.com> <20020920040241.4C03F2C0D9@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020920040241.4C03F2C0D9@lists.samba.org>; from rusty@rustcorp.com.au on Fri, Sep 20, 2002 at 11:22:08AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 11:22:08AM +1000, Rusty Russell wrote:
> Well, it's up to you.  You *could* implement:
> 
> #define call_security(method , ...)					\
> 	({ int __ret;							\
> 	   if (try_module_get(security_ops->owner)) {			\
> 		__ret = security_ops->method(__VA_ARGS__);		\
> 		module_put(security_ops->owner);			\
> 	   } else							\
> 		/* If unloading or loading, default to "allow" */	\
> 		__ret = 0;						\
> 	  __ret;							\
> 	})
[...]
> Now, if you don't have CONFIG_MODULES this becomes the code as it is
> now.

Hi Rusty,

Please consider the following non-module code snippet:

int
sys_enable_foo_security()
{
        foocache = kmalloc(100000);
        register_security(&foo_ops);
}

int
sys_disable_foo_security()
{
        unregister_security(&foo_ops);
        kfree(foocache);  // OOPS
}


If I follow Roman's argument correctly, the unload race is not module
specific.  (The problem is that unregister_security() only asserts that no
new callers will be made to foo_ops, it doesn't guarantee that there are no
current callers.)

In the above example, one solution would be to reference count foocache.
However, another viable solution would be to ref-count the security_ops
field.

Anyway, given that the problem is a general resource management issue (and
not module specific), I think one could implement call_security() with less
overhead:

#define call_security(method , ...)					\
	({ int __ret;							\
	   read_lock(&SecurityLock);                                    \
	   __ret = security_ops->method(__VA_ARGS__);                   \
           read_unlock(&SecurityLock);                                  \
	  __ret;							\
	})

where (un)register_security used a write_lock to guard accesses to
security_ops changes.

This implementation is still a bit sluggish (as well as limiting), however
one could conceivable use RCU or a similar mechanism to further reduce
overhead of the common path.

-Kevin


P.S. it may also be possible for this alternate solution to work:

#define call_security(method , ...)					\
	({ int __ret;							\
           atomic_inc(&SecurityRefCount);                               \
	   __ret = security_ops->method(__VA_ARGS__);                   \
           atomic_dec(&SecurityRefCount);                               \
	})

where unregister_security set the security_ops field to a dummy value and
then waited for the ref-count to hit zero before returning.  However, this
may depend too heavily on memory ordering..

-- 
 ------------------------------------------------------------------------
 | Kevin O'Connor                     "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net                  'IMHO', 'FAQ', 'BTW', etc. !"    |
 ------------------------------------------------------------------------
