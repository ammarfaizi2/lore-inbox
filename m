Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWINDXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWINDXT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 23:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWINDXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 23:23:19 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:22726 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751056AbWINDXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 23:23:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Udew/n5+e55w3zQZhZuR90/glEsiZoolv5tWrXJoI5pshAca/4OraH+56tjgqXP/kbY8HTrN4NKiyn43mzzeklB/KgbIVrWE8CAi/8Rd/r0QhWpr4LW4wG6GnovN8klZJyr3K+IHVDC52ZP784q4FXP2ht/0c0L3DQZ646B7IpA=
Message-ID: <787b0d920609132023t1686525ei9c1703b044029909@mail.gmail.com>
Date: Wed, 13 Sep 2006 23:23:18 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: torvalds@osdl.org, jeremy@goop.org, mingo@elte.hu, ak@suse.de,
       ebiederm@xmission.com, arjan@infradead.org, zach@vmware.com,
       linux-kernel@vger.kernel.org
Subject: Re: Assignment of GDT entries
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> On Wed, 13 Sep 2006, Jeremy Fitzhardinge wrote:

>> So does this mean that moving the user-visible cs/ds isn't
>> likely to break stuff, if it has been done before?
>
> Yes. I _think_ we could do it. It's been done before, and nobody noticed.
>
> That said, it may actually be that programs have since become much more
> aware of segments, for a rather perverse reason: the TLS stuff. Old
> programs are all very much coded and compiled for a totally flat model,
> and as such they really don't know _anything_ about segments. But with
> more TLS stuff, it's possible that a modern threded program is at least
> aware of _some_ of it.

We actually have an ABI problem right now because of this.
Note that i386 and x86_64 use different GDT slots.

As far as I can tell, users need to hard-code the mapping
from TLS slot to segment number. They use 0,1,2 to ask the
kernel to set things up (via set_thread_area), but can't
just pop that into %fs or %gs.

So a 32-bit app using set_thread_area can work on i386 or x86_64,
but not both. I guess glibc gets %gs set up free via clone() with
the right flags, and thus does not need to determine the kernel.
For anything involving set_thread_area though, it gets nasty.

Typical hacks that result from this:

call uname() and look for "x86_64"
see of the addresses of local variables exceed 0xbfffffff
examine /proc/1/maps
check for a /lib64 directory
change SSE register 8 in a signal handler frame and see if it sticks
checksum the vdso code
...

Please save us from these foul hacks.
