Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316663AbSGIBsf>; Mon, 8 Jul 2002 21:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316683AbSGIBse>; Mon, 8 Jul 2002 21:48:34 -0400
Received: from pool-129-44-58-3.ny325.east.verizon.net ([129.44.58.3]:57093
	"EHLO arizona.localdomain") by vger.kernel.org with ESMTP
	id <S316663AbSGIBsc>; Mon, 8 Jul 2002 21:48:32 -0400
Date: Mon, 8 Jul 2002 21:50:11 -0400
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Werner Almesberger <wa@almesberger.net>
Cc: Bill Davidsen <davidsen@tmr.com>, Keith Owens <kaos@ocs.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
Message-ID: <20020708215011.A2592@arizona.localdomain>
References: <20020702133658.I2295@almesberger.net> <Pine.LNX.3.96.1020704000434.2248F-100000@gatekeeper.tmr.com> <20020704032929.N2295@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020704032929.N2295@almesberger.net>; from wa@almesberger.net on Thu, Jul 04, 2002 at 03:29:29AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2002 at 03:29:29AM -0300, Werner Almesberger wrote:
> This certainly seems to be the most understandable way, yes. I think
> modules follow basically the principle illistrated below (that's case
> 4b in the taxonomy I posted earlier), where deregistration doesn't
> stop everything, but which should be safe except for
> return-after-removal:
> 
> foo_dispatch(...)
> {
>     read_lock(global_foo_lock);
>     ...
>     xxx = find_stuff();
>     ...
>     xxx->whatever_op(xxx->data);
> }
> 
> foo_deregister(...)
> {
>     write_lock(global_foo_lock);
>     ...
>     write_unlock(global_foo_lock);
> }
> 
> bar_whatever_op(my_data)
> {   
>     lock(my_data); /* think MOD_INC_USE_COUNT */
>     ...
>     read_unlock(global_foo_lock);
>     ...
>     unlock(my_data); /* think MOD_DEC_USE_COUNT */
>     /* return-after-removal race if my_data also protects code,
>        not only data ! */
> }
> 
> bar_main(...)
> {
>     foo_register(&bar_ops,&bar_data);
>     ...
>     foo_deregister(&bar_ops);
>     ...
>     lock(bar_data); /* barrier */
>     unlock(bar_data);
>     ...
>     destroy(&bar_data);
> }

Hi Werner,

I think the above works, but the locking is a bit hairy.  How about the
following.  (Taxonomy 3)

foo_dispatch(...)
{
    spin_lock(global_foo_lock);
    xxx = find_stuff();            // atomic_inc(xxx->refcnt)
    spin_unlock(global_foo_lock);
    ...
    xxx->whatever_op(xxx->data);
    ...
    put_stuff(xxx);                // atomic_dec(xxx->refcnt)
}

foo_deregister(...)
{
    spin_lock(global_foo_lock);
    remove_stuff(xxx);
    spin_unlock(global_foo_lock);

    while (atomic_read(xxx->refcnt))
        schedule();
}

bar_whatever_op(my_data)
{   
    /* no return-after-removal race because bar is pinned. */
}

bar_main(...)
{
    foo_register(&bar_ops,&bar_data);
    ...
    foo_deregister(&bar_ops);

    /* Now guaranteed that no references to bar_ops exist, and guaranteed
       that no concurrent accesses exist. */

    destroy(&bar_data);
}


I get the feeling you already had something like this in mind, but your
example above was rather complicated.  The latter implementation is just
standard reference counting.

> [...]
> I can understand why people don't want to use totally "safe"
> deregistration, e.g.
> 
>  - locking gets more complex and you may run into hairy deadlock
>    scenarios
>  - accomplishing timely removal may become more difficult
>  - nobody likes patches that change the world

With a standard reference counting implementation I don't see any of these
issues being a problem..

Did I miss something?
-Kevin

-- 
 ------------------------------------------------------------------------
 | Kevin O'Connor                     "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net                  'IMHO', 'FAQ', 'BTW', etc. !"    |
 ------------------------------------------------------------------------
