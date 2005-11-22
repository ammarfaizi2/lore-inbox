Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbVKVRKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbVKVRKs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 12:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbVKVRKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 12:10:48 -0500
Received: from ns2.suse.de ([195.135.220.15]:27095 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965013AbVKVRKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 12:10:47 -0500
Date: Tue, 22 Nov 2005 18:10:42 +0100
From: Andi Kleen <ak@suse.de>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: rfc/rft: use r10 as current on x86-64
Message-ID: <20051122171040.GY20775@brahms.suse.de>
References: <20051122165204.GG1127@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122165204.GG1127@kvack.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 11:52:04AM -0500, Benjamin LaHaise wrote:
> Hello Andi et al,
> 
> The patch below converts x86-64 to use r10 as the current pointer instead 
> of gs:pcurrent.  This results in a ~34KB savings in the code segment of 
> the kernel.  I've tested this with running a few regular applications, 
> plus a few 32 bit binaries.  If this patch is interesting, it probably 
> makes sense to merge the thread info structure into the task_struct so 
> that the assembly bits for syscall entry can be cleaned up.  Comments?

I think you could get most of the benefit by just dropping
the volatile and "memory" from read_pda(). With that gcc would
usually CSE current into a register and it would would work essentially
the same way with only minor more .text overhead, but r10 would be still
available.

Unfortunately when that's done then the kernel doesn't boot.
It's probably something silly, but i never had time to track it down.
Might want to look into that?

Looking at your patch it might be enough to make sure all users
of current after the changes in __switch_to you did use some 
other way to access it (there is unfortunately no way I know
of to make gcc flush all CSEd items without addings barriers
in the original get_current function)

-Andi
