Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWIOIUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWIOIUQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 04:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWIOIUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 04:20:16 -0400
Received: from gw.goop.org ([64.81.55.164]:33004 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750732AbWIOIUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 04:20:14 -0400
Message-ID: <450A6238.9050404@goop.org>
Date: Fri, 15 Sep 2006 01:20:08 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: acahalan@gmail.com, ak@suse.de, arjan@infradead.org, ebiederm@xmission.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, torvalds@osdl.org,
       zach@vmware.com
Subject: Re: Assignment of GDT entries
References: <200609150755.k8F7tKUD005518@alkaid.it.uu.se>
In-Reply-To: <200609150755.k8F7tKUD005518@alkaid.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> The i386 TLS API has three components:
>
> (1) set_thread_area(entry_number == -1):
>     allocates and sets up the first available TLS entry and
>     copies the chosen GDT index back to user-space
> (2) set_thread_area(6 <= entry_number && entry_number <= 8):
>     allocates and sets up the indicated GDT entry
> (3) get_thread_area(6 <= entry_number && entry_number <= 8):
>     retrieves the contents of the indicated GDT entry
>
> Only (1) works in x86-64's ia32 emulation, the other two fail
> with EINVAL because x86-64 only accepts GDT indices 12 to 14
> for TLS entries. glibc only uses (1).
>
> If you move the i386 TLS GDT entries to other indices then you
> break (2) and (3) also on i386.
>   

(2) and (3) are always OK if you pass it the result of (1) - ie to 
update or readback a previously allocated descriptor.  Neither is useful 
without having done (1) first.  The fact that 32-on-32 and 32-on-64 
differ here means that nothing can (an apparently nothing does) depend 
on hardcoded knowledge of the TLS descriptor indicies anyway.

> It's not difficult to design a better i386 TLS API that avoids
> requiring user-space to know the actual GDT indices (just use
> logical TLS indices and always copy the GDT index to user-space).
> but unfortunately that doesn't help us
>   

You still need the real indicies to construct a selector to put into a 
segment register - ie, actually do something useful.  Changing the API 
to use abstract "TLS indicies" would also require a call to return the 
"TLS base", which hardly seems like an improvement.

Also, there's no inherent reason why the TLS indicies should be 
contigious; it happens to be true, but there's nothing useful userspace 
can do with that knowledge.  Allowing them to be discontigious may be 
helpful, for example, in packing the most used TLS entries (ie #1) into 
a hot cache line, while putting the lesser-used ones elsewhere.  The 
current API could deal with this without needing to change.

    J
