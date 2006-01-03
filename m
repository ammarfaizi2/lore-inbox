Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWACWlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWACWlz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 17:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWACWlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 17:41:55 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:52671 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932541AbWACWly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 17:41:54 -0500
Subject: Re: [PATCHSET] thread_info annotations and fixes
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
In-Reply-To: <E1EttNa-0008PA-2x@ZenIV.linux.org.uk>
References: <E1EttNa-0008PA-2x@ZenIV.linux.org.uk>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 17:41:45 -0500
Message-Id: <1136328105.3658.2.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-03 at 21:07 +0000, Al Viro wrote:
> 	Patchset annotates arch/* uses of ->thread_info.  Ones that really
> are about access of thread_info of given process are simply switched to
> task_thread_info(task); ones that deal with access to objects on stack
> are switched to new helper - task_stack_page().  A _lot_ of the latter are
> actually open-coded instances of "find where pt_regs are"; those are
> consolidated into task_pt_regs(task) (many architectures actually have
> such helper already).
> 
> 	Note that these annotations are not mandatory - any code not
> converted to these helpers still works.  However, they clean up a lot
> of places and have actually caught a number of bugs, so converting out
> of tree ports would be a good idea...
> 
> 	As an example of breakage caught by that stuff, see i386
> pt_regs mess - we used to have it open-coded in a bunch of places
> and when back in April Stas had fixed a bug in copy_thread(), the
> rest had been left out of sync.  That required two followup patches
> (the latest - just before 2.6.15) _and_ still had left /proc/*/stat
> eip field broken.  Try ps -eo eip on i386 and watch the junk...

As long as this is just wrappering the existing pointers, then that's
fine, but just in case it matters, I should point out that, at least for
parisc, the wrappering is incomplete: we have references to the
thread_info pointer in the task struct via our assembly glue as well (in
just two places: the smp secondary CPU start and the _switch_to
implementation).

James


