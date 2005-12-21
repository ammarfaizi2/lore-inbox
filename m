Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbVLUQgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbVLUQgo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 11:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVLUQgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 11:36:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:178 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750877AbVLUQgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 11:36:43 -0500
Date: Wed, 21 Dec 2005 16:36:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>,
       linux-xfs@oss.sgi.com
Subject: Re: [patch 1/8] mutex subsystem, XFS namespace collision fixes
Message-ID: <20051221163639.GA9735@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjanv@infradead.org>,
	Jes Sorensen <jes@trained-monkey.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Oleg Nesterov <oleg@tv-sign.ru>,
	David Howells <dhowells@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Nicolas Pitre <nico@cam.org>, linux-xfs@oss.sgi.com
References: <20051221155426.GB7243@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221155426.GB7243@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 04:54:26PM +0100, Ingo Molnar wrote:
> Fixup the XFS code to avoid name clashing with the mutex code by 
> introducing xfs_mutex_ functions.
> 
> Signed-off-by: Jes Sorensen <jes@trained-monkey.org>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> ----
> 
>  fs/xfs/linux-2.6/mutex.h       |   10 +++++-----
>  fs/xfs/quota/xfs_dquot.c       |   12 ++++++------
>  fs/xfs/quota/xfs_dquot.h       |    4 ++--
>  fs/xfs/quota/xfs_qm.c          |   20 ++++++++++----------
>  fs/xfs/quota/xfs_qm.h          |    4 ++--
>  fs/xfs/quota/xfs_qm_bhv.c      |    2 +-
>  fs/xfs/quota/xfs_qm_syscalls.c |   24 ++++++++++++------------
>  fs/xfs/quota/xfs_quota_priv.h  |    8 ++++----
>  fs/xfs/support/uuid.c          |   12 ++++++------
>  fs/xfs/xfs_mount.c             |    4 ++--
>  fs/xfs/xfs_mount.h             |    4 ++--
>  11 files changed, 52 insertions(+), 52 deletions(-)
> 
> Index: linux/fs/xfs/linux-2.6/mutex.h
> ===================================================================
> --- linux.orig/fs/xfs/linux-2.6/mutex.h
> +++ linux/fs/xfs/linux-2.6/mutex.h
> @@ -30,10 +30,10 @@
>  #define MUTEX_DEFAULT		0x0
>  typedef struct semaphore	mutex_t;
>  
> -#define mutex_init(lock, type, name)		sema_init(lock, 1)
> -#define mutex_destroy(lock)			sema_init(lock, -99)
> -#define mutex_lock(lock, num)			down(lock)
> -#define mutex_trylock(lock)			(down_trylock(lock) ? 0 : 1)
> -#define mutex_unlock(lock)			up(lock)
> +#define xfs_mutex_init(lock, type, name)	arch_sema_init(lock, 1)
> +#define xfs_mutex_destroy(lock)			arch_sema_init(lock, -99)
> +#define xfs_mutex_lock(lock, num)		arch_down(lock)
> +#define xfs_mutex_trylock(lock)			(arch_down_trylock(lock) ? 0 : 1)
> +#define xfs_mutex_unlock(lock)			arch_up(lock)

As the name implies these use mutex xsemantics, just remove the
defines and use mutex_lock/mutex_unlock and mutex_trylock directly
(the latter only if mutex_trylock has the same return value as
spin_trylock, not the broken down_trylock version)
not sure what to do about mutex_init, do you have one in your patches?
mutex_destroy should be a simple no-op.

