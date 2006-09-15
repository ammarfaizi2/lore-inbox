Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWIOH42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWIOH42 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 03:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWIOH42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 03:56:28 -0400
Received: from aun.it.uu.se ([130.238.12.36]:3027 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1750696AbWIOH41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 03:56:27 -0400
Date: Fri, 15 Sep 2006 09:55:20 +0200 (MEST)
Message-Id: <200609150755.k8F7tKUD005518@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: acahalan@gmail.com, jeremy@goop.org
Subject: Re: Assignment of GDT entries
Cc: ak@suse.de, arjan@infradead.org, ebiederm@xmission.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, torvalds@osdl.org,
       zach@vmware.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2006 23:11:05 -0700, Jeremy Fitzhardinge wrote:
>Albert Cahalan wrote:
>> We actually have an ABI problem right now because of this.
>> Note that i386 and x86_64 use different GDT slots.
>>
>> As far as I can tell, users need to hard-code the mapping
>> from TLS slot to segment number. They use 0,1,2 to ask the
>> kernel to set things up (via set_thread_area), but can't
>> just pop that into %fs or %gs.
>
>That's not true at all.  The program I posted earlier in this thread 
>uses set_thread_area() to allocate a GDT slot, and it works on both 
>native 32 bit and 32-under-64.

The i386 TLS API has three components:

(1) set_thread_area(entry_number == -1):
    allocates and sets up the first available TLS entry and
    copies the chosen GDT index back to user-space
(2) set_thread_area(6 <= entry_number && entry_number <= 8):
    allocates and sets up the indicated GDT entry
(3) get_thread_area(6 <= entry_number && entry_number <= 8):
    retrieves the contents of the indicated GDT entry

Only (1) works in x86-64's ia32 emulation, the other two fail
with EINVAL because x86-64 only accepts GDT indices 12 to 14
for TLS entries. glibc only uses (1).

If you move the i386 TLS GDT entries to other indices then you
break (2) and (3) also on i386.

It's not difficult to design a better i386 TLS API that avoids
requiring user-space to know the actual GDT indices (just use
logical TLS indices and always copy the GDT index to user-space).
but unfortunately that doesn't help us now because the TLS GDT
indices must remain fixed as long as the current API is supported.

I _personally_ could certainly handle a post-2.6.18 kernel where
the improved API (new syscalls) is in place, the GDT indices have
been moved, and consequently components (2) and (3) of the old API
are broken. However, this still implies breaking binary compatibility,
which is not something to be done lightly.

(What's _really_ sad is that the implementation of the i386 TLS API
internally operates on logical TLS indices, it's just the syscall
interface that insists on requiring actual GDT indices from user-space.)

/Mikael
