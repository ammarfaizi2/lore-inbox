Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316864AbSGBR7D>; Tue, 2 Jul 2002 13:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316869AbSGBR7C>; Tue, 2 Jul 2002 13:59:02 -0400
Received: from OL65-148.fibertel.com.ar ([24.232.148.65]:28631 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S316864AbSGBR7B>;
	Tue, 2 Jul 2002 13:59:01 -0400
Date: Tue, 2 Jul 2002 15:05:40 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
Message-ID: <20020702150540.J2295@almesberger.net>
References: <20020702133658.I2295@almesberger.net> <20020702165019.29700@smtp.adsl.oleane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020702165019.29700@smtp.adsl.oleane.com>; from benh@kernel.crashing.org on Tue, Jul 02, 2002 at 06:50:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> That was one of the solutions proposed by Rusty, that is basically
> waiting for all CPUs to have scheduled upon exit from module_exit
> and before doing the actual removal.

No, that's not what I mean. If you have a de-registration function,
it may give you one of the following assurances:

 1) none (e.g. of xxx_deregister just unlinks some ops structure,
    but makes no attempt to squash concurrent accesses)
 2) guarantee that no further access to ops structure will occur
    after xxx_deregister returns, and
    2a) one can probe for cached references/execution of callbacks,
        e.g.
	  foo_deregister(&my_ops);
	  while (foo_running()) schedule();
	  /* can destroy local state/code now */
	This is a common construct in the Linux kernel. Note that
	none of the module code executes after foo_running returns,
	so return-after-removal can't happen.
    2b) we're guaranteed that any running callbacks or such will
	have acquired their own locks/counts/etc. before
	xxx_deregister returns. Modules would (also) use the use
	count to protect code. Not sure if this happens anywhere
	in the kernel. return-after-removal would be possible
	here (unless we're going through a layer of trampolines
	or such). E.g.
	  foo_deregister(&my_ops);
	  while (myself_running()) schedule();
	  /* may still have to execute code after unlocking */
	  while (MOD_IN_USE) schedule();
	Note that this one still protects data !
 3) guarantee that no direct effects of accesses to ops structure
    occur after xxx_deregister returns, e.g.
      foo_deregister(&my_ops);
      /* can destroy local state/code now */
    This also eliminates return-after-removal, because deregister
    would wait for callbacks to return.
 4a/4b) Like 3, but the callback signals back completion without
    returning (i.e. to indicate that it has copied all shared data,
    and is now working on a private copy), we're back to case 2a or
    2b. In the case of modules, the usage count would be used to
    protect code, so decrement_and_return would be sufficient here.

I think these are the most common cases. The point is that only
case 1) leaves you completely in the dark, and only cases 2b and
4b are special when it comes to modules. Cases 2a, 3, and 4a are
always safe.

Moreover, case 1, and cases 2a, 2b, 4a, and 4b without
synchronizing after de-registration, can also cause problems in
non-module code, e.g.

bar_callback(void *my_data)
{
    *(int **) my_data = 1;
}

...
int whatever = 0,*ptr = &whatever;
...
foo_register(&bar_ops,&ptr);
...
foo_deregister(&bar_ops); /* case 1, 2a, 2b, 4a, or 4b */
ptr = NULL;
/* BUG: bar_callback may still be running ! */
...

Such code would only be data-safe (but not code-safe) if all shared
data is static, e.g. if the callback writes to some hardware
register, and the address is either static or constant.

AFAIK, most de-registration functions should be in case 2a, 3, or
4a. Well, we probably have a bunch of cases 1, too :-)

Now, what does this all boil down to ? Cases 2a, 3, and 4a are
non-issues. Cases 2b and 4b still need decrement_and_return, so I
was a bit too optimistic in assuming we're totally safe. Case 1 is
pathological also for non-modules, unless a few unlikely
constraints are met.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://icapeople.epfl.ch/almesber/_____________________________________/
