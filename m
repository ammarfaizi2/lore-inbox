Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263862AbTDHCBE (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 22:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263869AbTDHCBD (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 22:01:03 -0400
Received: from dp.samba.org ([66.70.73.150]:34280 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263862AbTDHCBB (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 22:01:01 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christoph Hellwig <hch@infradead.org>
Cc: Paul Mackerras <paulus@au1.ibm.com>,
       Fabrice Bellard <fabrice.bellard@free.fr>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Qemu support for PPC 
In-reply-to: Your message of "Mon, 07 Apr 2003 13:49:55 +0100."
             <20030407134954.A31558@infradead.org> 
Date: Tue, 08 Apr 2003 11:52:57 +1000
Message-Id: <20030408021238.F19C42C66E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030407134954.A31558@infradead.org> you write:
> On Mon, Apr 07, 2003 at 06:34:17PM +1000, Rusty Russell wrote:
> > Oh good: a serious question.  Why don't we drop the personality field
> > in struct task_struct and just use exec_domain?  Then the flags could
> > be unfolded from the personality number, and placed in a "flags"
> > element in struct exec_domain, the personality() macro would vanish,
> > the set_personality() macro would vanish, and things would be
> > generally clearer?
> 
> The personality number is exposed through sys_personality, so unfortunately
> we can't get rid of it.  I still wonder what crack the person inviting this
> scheme was smoking, though..

Yes.  It's a PITA that the bottom 8 bits map to exec_domain, and the
rest are random flags.  If each different personality mapped to a
separate exec_domain, the flags could be moved to the exec_domain
struct and it'd be far more logical.  But as you say, this would break
userspace which expects to be able to set the exec_domain and the
flags separately 8(.

BTW, there's a module refcount leak here:

int
__set_personality(u_long personality)
{
	struct exec_domain	*ep, *oep;

	ep = lookup_exec_domain(personality);
	if (ep == current_thread_info()->exec_domain) {
		current->personality = personality;
		return 0;
	}

You need "module_put(ep->owner)", since lookup_exec_domain bumps the
refcount.


> > That applies to any kernel mod, of course.  qemu is much more usable
> > (ie. it's sanely packagable) with this functionality, ie. it's pretty
> > much a requirement for increasing adoption.
> 
> You can just easily let it run in a chroot or separate namespace,
> you just won't get second look semantics. (Personally I think that's
> a benefit, but some people disagree with this).

No, then you can't access your files, which is unacceptable for many
users.

I've done the userspace implementation: I'll see if Fabrice chokes on
the speed hit.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
