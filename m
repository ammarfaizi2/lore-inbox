Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbUABAMi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 19:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbUABAMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 19:12:38 -0500
Received: from mail.actcom.co.il ([192.114.47.15]:59288 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S261950AbUABAML
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 19:12:11 -0500
Date: Fri, 2 Jan 2004 02:12:04 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [CFT/PATCH] give sound/oss/trident a holiday cleanup for 2.6
Message-ID: <20040102001203.GD1718@actcom.co.il>
References: <20031229183846.GI13481@actcom.co.il> <Pine.LNX.4.58.0312291049020.2113@home.osdl.org> <20040101235147.GC1718@actcom.co.il> <20040101160420.6a326d0a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040101160420.6a326d0a.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01, 2004 at 04:04:20PM -0800, Andrew Morton wrote:

> hmm, how come a whitespace cleanup patch adds nearly 200 lines which have
> trailing whitespace?

That would be either xemacs's or indent's fault. Can't be my
fault. No sir. Anyway, unless whitespace-mode is lying to me now, no
line has more than at most one character of whitespace added. If it
bugs you, I'll clean it up - it's a slow night tonight ;-) 

> >  All of the non-indentation changes are in the
> >  trident-cleanup-fixes-D1-2.6.0 patch, attached here inline. It needs
> >  the indentation patch to be applied before it to apply
> >  cleanly. Compiles, boots and plays music fine. Patch is against
> >  2.6.0. Andrew, please add these two patches to -mm1 instead of the
> >  "humongopatch" currently there. Thanks! 
> 
> Could we please have a description of the substantive changes in
> this patch?

Sure thing: 

- switch lock_set_fmt() and unlock_set_fmt() from macros to inline
functions. Macros that call return() are EVIL.
- simplify lock_set_fmt() and implement it via test_and_set_bit()
rather than a spinlock protecting an int.
- fix a bug wherein we would do an up() on a semaphore that hasn't
been down()ed if a signal happened after timeout in trident_write().
- fix a bug where we would not release the open_sem on OOM.
- make the arguments for prog_dmabuf clearer (int -> enum), and add
two wrapper functions around it, one for record and one for playback. 
- fix a bug where we would call VALIDATE_STATE after
lock_kernel(). Since VALIDATE_STATE does 'return' if validation fails,
bad things can happen. Thanks to Dawson Engler <engler@stanford.edu>
and the Stanford checker for spotting.
- remove the calls to lock_kernel() from trident_release() and
trident_mmap(). trident_release() appears to be covered by the
open_sem, and trident_mmap() is covered by state->sem.
- s/TRUE/1/, s/FALSE/0/

> Thanks.

Entirely my pleasure. 

Cheers, 
Muli 
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic

