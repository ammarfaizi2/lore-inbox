Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUELToJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUELToJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 15:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265199AbUELToI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 15:44:08 -0400
Received: from ltgp.iram.es ([150.214.224.138]:34690 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S265198AbUELTnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 15:43:20 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 12 May 2004 21:34:38 +0200
To: Stephen Hemminger <shemminger@osdl.org>
Cc: David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@linuxia64.org,
       linux-kernel@vger.kernel.org
Subject: Re: GCC nested functions?
Message-ID: <20040512193438.GA4725@iram.es>
References: <20040512105924.54a8211b@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040512105924.54a8211b@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 10:59:24AM -0700, Stephen Hemminger wrote:
> I used GCC nested functions in the (not released) bridge sysfs interface for 2.6.6.
> It seemed like a nice way to express the sysfs related interface without doing
> lots of code copying (or worse lots of macros).
> 
> The code in question looks like:
> static ssize_t store_bridge_parm(struct class_device *cd,
>                                  const char *buf, size_t len,
>                                  void (*store)(struct net_bridge *, unsigned long))
> {
>         struct net_bridge *br = to_bridge(cd);
>         char *endp;
>         unsigned long val;
>                                                                                 
>         if (!capable(CAP_NET_ADMIN))
>                 return -EPERM;
>                                                                                 
>         val = simple_strtoul(buf, &endp, 0);
>         if (endp == buf)
>                 return -EINVAL;
>                                                                                 
>         spin_lock_bh(&br->lock);
>         store(br, val);
>         spin_unlock_bh(&br->lock);
>         return len;
> }
> ...
> 
> static ssize_t store_forward_delay(struct class_device *cd, const char *buf,
>                                    size_t len)
> {
>         void store(struct net_bridge *br, unsigned long val)
>         {
>                 unsigned long delay = clock_t_to_jiffies(val);
>                 br->forward_delay = delay;
>                 if (br_is_root_bridge(br))
>                         br->bridge_forward_delay = delay;
>         }
>                                                                                 
>         return store_bridge_parm(cd, buf, len, store);
> }
> 
> 
> This works fine for GCC 2.95 and 3.X for i386 and x86_64 architectures, but the ia64
> (cross compiler) pukes with:
> 
>  In function `store_forward_delay':
> : undefined reference to `__ia64_trampoline'
> 
> Redoing it as separate functions is easy enough, but the questions are:
> 	- Are gcc nested functions allowed in the kernel?  If not where should
> 	  this restriction be put in Documentation? CodingStyles?

There is some kind of implicit prohibition in Documentation/CodingStyle
(Chapter3: Placing braces):

"Heretic people all over the world have claimed that this inconsistency
is ...  well ...  inconsistent, but all right-thinking people know that
(a) K&R are _right_ and (b) K&R are right.  Besides, functions are
special anyway (you can't nest them in C)."
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^

Maybe the way it is stated is too close so subliminal ;-) But I never found 
a real need for them in C.

	Gabriel
