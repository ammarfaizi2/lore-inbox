Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267512AbSLSB4B>; Wed, 18 Dec 2002 20:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267517AbSLSB4B>; Wed, 18 Dec 2002 20:56:01 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:23304
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267512AbSLSBz6>; Wed, 18 Dec 2002 20:55:58 -0500
Subject: RE: [PATCH 2.5.52] Use __set_current_state() instead of current->
	state = (take 1)
From: Robert Love <rml@tech9.net>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C7806CACA2D@orsmsx116.jf.intel.com>
References: <A46BBDB345A7D5118EC90002A5072C7806CACA2D@orsmsx116.jf.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1040263444.854.118.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Dec 2002 21:04:04 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-18 at 20:53, Perez-Gonzalez, Inaky wrote:

> - any setting before a return should be barriered unless we 
>   return to a place[s] known to be harmless

Not sure.

> - any setting to TASK_RUNNING should be kind of safe

Yes, I agree.  It may race, but with what?

> - exec.c:de_thread(), 
> 
>  	while (atomic_read(&oldsig->count) > count) {
>  		oldsig->group_exit_task = current;
> -		current->state = TASK_UNINTERRUPTIBLE;
> +		__set_current_state(TASK_UNINTERRUPTIBLE);
>  		spin_unlock_irq(&oldsig->siglock);
> 
>   Should be safe, as spin_unlock_irq() will do memory clobber
>   on sti() [undependant from UP/SMP].

The memory clobber only acts as a compiler barrier and insures the
compiler does not reorder the statements from the order in the C code.

What we need is a memory barrier to ensure the processor does not
reorder statements.  In other words, the processor can completely
rearrange loads and stores as they are issued to it, as long as it does
not break obvious data dependencies.  On a weakly ordered processor,
sans memory barrier, there is no telling when and where a store will
actually reach memory.  This is regardless of the order of the C code or
anything else.

That said, I do not know if the above example is a problem or not.  On a
very quick glance, the only issue I saw is the one I pointed out
earlier, and you fixed it.

	Robert Love

