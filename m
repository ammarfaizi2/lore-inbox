Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWDFWhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWDFWhM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 18:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWDFWhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 18:37:12 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:59312
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751343AbWDFWhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 18:37:10 -0400
Date: Thu, 06 Apr 2006 15:35:18 -0700 (PDT)
Message-Id: <20060406.153518.60508780.davem@davemloft.net>
To: dan@debian.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: fs/binfmt_elf.c:maydump()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060406221519.GA5453@nevyn.them.org>
References: <20060406.140357.14088592.davem@davemloft.net>
	<20060406221519.GA5453@nevyn.them.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Jacobowitz <dan@debian.org>
Date: Thu, 6 Apr 2006 18:15:19 -0400

> On Thu, Apr 06, 2006 at 02:03:57PM -0700, David S. Miller wrote:
> > Yes, this means we might hit the core dump limits quicker but we
> > shouldn't be doing anything which makes less debugging information
> > than necessary available.  Software development is hard enough as
> > it is right? :)
> 
> > -	/* If it hasn't been written to, don't write it out */
> > -	if (!vma->anon_vma)
> > -		return 0;
> > -
> 
> Isn't this, um, a little more extreme than what you really want?
> What goes into coredumps with this patch applied?  I bet it includes
> the complete text segments of every executable and shared library
> involved in the link.  You're going to need those if you want to debug,
> anyway.

With this patch applied, yes, it includes the complete text segments of
every executable and shared library mapped into the program which is
dumping core.

What's a good check to avoid shared libraries and executables?  And do
we really want to avoid including them?  What if a new version of one
of the shared libraries is installed on the system after the core file
is generated?  Wouldn't you want the complete original image so that
the program could be debugged accurately in the face of such changes?

Anyways a possible check would be if the object was mapped with
execute permission, so a test on VM_EXEC being set in vma->vm_flags.

But like the comment above maydump() seems to suggest, I'm of the
opinion that we should include as much as possible into the core
file image.
