Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbVHIUs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbVHIUs4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 16:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbVHIUs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 16:48:56 -0400
Received: from nef2.ens.fr ([129.199.96.40]:2564 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S964952AbVHIUsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 16:48:55 -0400
Date: Tue, 9 Aug 2005 22:48:54 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Cc: Valdis.Kletnieks@vt.edu
Subject: Re: capabilities patch (v 0.1)
Message-ID: <20050809204854.GA4983@clipper.ens.fr>
References: <20050809052621.GA7970@clipper.ens.fr> <200508092028.j79KSVYW028307@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508092028.j79KSVYW028307@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Tue, 09 Aug 2005 22:48:54 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 04:28:31PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 09 Aug 2005 07:26:21 +0200, David Madore said:
> > * Second, a much more extensive change, the patch introduces a third
> > set of capabilities for every process, the "bounding" set.  Normally
> > the bounding set has every capability in it
> 
> How is this different in semantics from the existing 'permitted' capset?

The permitted sets is a set of capabilities really available to the
process (though they may be temporarily dropped by removing them from
the effective set, they are still available to take back).  In
contrast, the bounding set capabilities are not readily available to
the process; it just means that the capabilities in question *might*
be acquired by running a suid program (or setcap program if filesystem
support for capabilities ever comes to Linux).

Currently this is more or less an all-or-nothing process: since
capabilities can only be acquired by running a suid program, removing
any capability from the bounding set means the program will never be
permitted to execute a suid program any more (execve() will fail with
EPERM).  But maybe I'll reinstate the CAP_SETPCAP thing in some future
version of the patch (I'm still waiting for someone to tell me what
was wrong with CAP_SETPCAP and why it was removed), and then the
bounding set should also prohibit capabilities being given through
that interface.

The bottom line is: if you have some untrusted process, it might be
wise to remove empty its bounding set, making it incapable of
executing a suid root program and thus acquiring new capabilities.  (I
also plan to add some normally-available-to-all capabilities such as
"permission to fork()", "permission to exec()" and so on, and then it
will also be useful to remove these from a process's permitted set.)

> include/linux/capabilities.h:
> 
> typedef struct __user_cap_data_struct {
>         __u32 effective;
>         __u32 permitted;
>         __u32 inheritable;
> } __user *cap_user_data_t;
> 

And my patch adds a __u32 bounding to that structure.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
