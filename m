Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWIQNFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWIQNFA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 09:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWIQNFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 09:05:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45999 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932425AbWIQNE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 09:04:59 -0400
Date: Sun, 17 Sep 2006 15:04:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Madore <david.madore@ens.fr>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>,
       Louis Kruger <lpkruger@cs.wisc.edu>, "Bill O'Donnell" <billodo@sgi.com>,
       Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH] security: add a "cuppabilities" security module (preliminary version)
Message-ID: <20060917130458.GL2741@elf.ucw.cz>
References: <20060916232540.GA15092@clipper.ens.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060916232540.GA15092@clipper.ens.fr>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch adds a Linux Security Module called "cuppabilities", which
> allows for an easy creation of underprivileged processes:
> 
>  * add a "cuppabilities" field to the task structure, and two prctl()
>    calls (PR_GET_CUPS and PR_ADD_CUPS) which manipulate it,
> 
>  * add a LSM which forbids certain operations when various bits are
>    set in this field (otherwise it also calls commoncap operations
>    secondarily).
> 
> So far this is only a preliminary demonstration of concept, so only
> very uninteresting cuppabilities are included: CUP_FORK, some variants
> on CUP_EXEC (including CUP_EXEC_SXID) and CUP_PTRACE.

Basically looks good to me.

> 		*** IMPORTANT NOTE ***
> 
> 	This patch IS NOT related (nor compatible) with the one posted
> 	a few days ago on this list under the name "new capabilities
> 	patch".  The latter treated underprivileged processes as
> 	lacking some capabilities.  It has been abandoned due to heavy
> 	criticism on LKML.  *This* patch adds a completely different
> 	field, "cuppabilities", and treats cuppabilities in a simpler
> 	fashion than capabilities (only one set per task rather than
> 	permitted/effective/inheritable, and just a simple prctl() to
> 	add cups - for example, a simple prctl(PR_ADD_CUPS,
> 	(1<<CUP_EXEC_SXID)) forbids suid/sgid exec from then on).
> 
> 	This patch should not break (or indeed change!) anything for
> 	those who don't activate support for cuppabilities.
> 
> 	Comments are appreciated on whether this is the right way to
> 	proceed, especially from those who criticized my earlier
> 	(aforementioned) capabilities patch.

This should go to Documentation/, somewhere.

Why the cuppability name?

> +/*
> + * This is <linux/cuppability.h>
> + *
> + * David A. Madore <david.madore@ens.fr>
> + */ 
> +
> +#ifndef _LINUX_CUPPABILITY_H
> +#define _LINUX_CUPPABILITY_H
> +
> +#define CUP_NONE 0UL
> +#define CUP_ALL 0xffffffUL
> +
> +#define CUP_TO_MASK(x) (1UL << (x))
> +#define cup_raise(c, flag)   ((c) |=  CAP_TO_MASK(flag))
> +#define cup_lower(c, flag)   ((c) &= ~CAP_TO_MASK(flag))
> +#define cup_raised(c, flag)  ((c) & CAP_TO_MASK(flag))
> +
> +#define CUP_FORK		0 /* Forbid fork() */

This is reverted from normal meaning, now?

> @@ -2055,6 +2056,12 @@ asmlinkage long sys_prctl(int option, un
>  		case PR_SET_ENDIAN:
>  			error = SET_ENDIAN(current, arg2);
>  			break;
> +		case PR_GET_CUPS:
> +			error = current->cuppabilities;
> +			break;

Yep, it seems so.

> +#if defined(CONFIG_SECURITY_CUPPABILITY_MODULE)
> +#define MY_NAME THIS_MODULE->name
> +#else
> +#define MY_NAME "cuppability"
> +#endif

Now this is what I'd call a hack...

> +static int cup_ptrace (struct task_struct *parent, struct task_struct *child)
> +{
> +	if (cup_raised (current->cuppabilities, CUP_PTRACE))
                      ~
		      \- you should avoid this space.

> +static void cup_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
> +{
> +	if (bprm->is_suid || bprm->is_sgid) {
> +		current->cuppabilities = CUP_NONE;
> +	}

Hmm, meaning is really inverted CUP_NONE means "forbid nothing".. not
forbid everything... right?

> +MODULE_DESCRIPTION("Root Plug sample LSM module, written for Linux Journal article");

Hmm, probably not...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
