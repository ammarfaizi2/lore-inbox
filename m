Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946375AbWJTLr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946375AbWJTLr7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 07:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946374AbWJTLr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 07:47:59 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:26361 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1946376AbWJTLr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 07:47:58 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: Correct way to format spufs file output.
Date: Fri, 20 Oct 2006 10:23:10 +0200
User-Agent: KMail/1.9.5
Cc: Dwayne Grant McConnell <decimal@us.ibm.com>, linuxppc-dev@ozlabs.org
References: <Pine.WNT.4.64.0610182227120.6056@doodlebug>
In-Reply-To: <Pine.WNT.4.64.0610182227120.6056@doodlebug>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610201023.12796.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 October 2006 05:30, Dwayne Grant McConnell wrote:
> In a recent submission I added the lslr file and used "%llx" for the 
> format string. You mentioned that it should probably be "0x%llx" so it 
> would be clearly parsed as hex so I changed it in the next submission. But 
> I noticed that there seems to be some inconsistent usage of 0x as follows:

Thanks for bringing this up, I guess I screwed up in some way here, so
we should fix it up one way or another:

> signal1_type (%llu)
> signal2_type (%llu)

These are fine, they can only ever be 1 or 0.

> npc (%llx)

I think we used to access this in _very_ old versions of libspe,
before we move to a syscall based interface.

> decr (%llx)
> decr_status (%llx)
> spu_tag_mask (%llx)
> event_mask (%llx)
> event_status (%llx)
> srr0 (%llx)

These are used exclusively for debugging purposes, and no publically
available version of gdb accesses them, so I guess we can still change
them, although it's not nice.

> phys_id (0x%llx)

This one is used in some forks of libspe, we should not change it.

> object_id (0x%llx)

This is used in libspe, gdb and oprofile, but only in fairly recent
versions.

> lslr (0x%llx)

As this is introduced by your own patch, there is no precedent for
it yet.

Current kernels now also have 'cntl' (0x%08lx), which was introduced
in 2.6.19 and is so far unused. I guess we should change that one
to be consistant with the others as well.

> Should all the %llx be changed to 0x%llx or should the 0x be dropped from 
> those that have it or is the inconsistency acceptable?

I'd rather have it consistant. Moreover, I guess the "%llx" format is
actually harmful, because that means you can not use the same format
for read and write. The simple_attr_write function currently uses
the simple_strtol helper to interpret the value written to it, and that
requires the input to be wither decimal, or hexadecimal with a preceding
0x. I'd suggest we change all files to take a 0x%llx format on output.

	Arnd <><

