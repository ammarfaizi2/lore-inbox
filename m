Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263203AbVAFXOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbVAFXOB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 18:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263080AbVAFXKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 18:10:17 -0500
Received: from colin2.muc.de ([193.149.48.15]:14095 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263060AbVAFXEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 18:04:24 -0500
Date: 7 Jan 2005 00:04:19 +0100
Date: Fri, 7 Jan 2005 00:04:19 +0100
From: Andi Kleen <ak@muc.de>
To: Ray Bryant <raybry@sgi.com>
Cc: Paul Jackson <pj@sgi.com>, Steve Longerbeam <stevel@mwwireless.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: page migration patchset
Message-ID: <20050106230419.GA26074@muc.de>
References: <41DDA6CB.6050307@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DDA6CB.6050307@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 02:59:55PM -0600, Ray Bryant wrote:
> Now I know there is no locking protection around the mems_allowed
> bitmask, so changing this while the process is still running
> sounds hard.  But part of the plan I am working under assumes
> that the process is stopped before it is migrated.  (Shared
> pages that are only shared among processes all of whom are to be
> moved would similarly be handled; pages shsared among migrated
> and non-migrated processes, e. g. glibc pages, would not
> typically need to be moved at all, since they likely reside
> somewhere outside the set of nodes to be migrated from.)
> 
> But if the process is suspended, isn't all that is needed just
> to do the obvious translation on the mems_allowed vector?

Probably yes. But I can't say for sure since I haven't followed
the design and code of mems_allowed very closely
(it's not in mainline and seems to be only added with the cpumemset
patches). I would take Paul's word more seriously than mine 
on that. 

I assume you stop the process while doing page migration,
and while a process is stopped it should be safe to touch
task_struct fields as long as you lock against yourself.

> (Similarly for the dedicated node stuff, I forget the name for
> that at the moment...)

You mean NUMA API? You would need to modify all the mempolicy
data structures.

They can be safely changed when the mm semaphore is hold. 
However such policies can be attached to files too (e.g. 
in tmpfs) with no association with a process. There are plans
to allow them at arbitary files.

-Andi
