Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWINGTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWINGTw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 02:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWINGTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 02:19:52 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:46818 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751362AbWINGTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 02:19:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KgLy+pXAPY+iqY3ePkm9vlOoPmu95WKs9GDYEAt0L9/BlENg+e+Naa1gt6WJh91OTmxemKS7VFrELxIrZ2cnshJUA1/Mgi2EjEvNl0mlQVfE309LaSKt0MwRz1Y3LNnA2MvBPNZrGxcmpJJgo4twYuDXLnfAiHZQj7EN9QyW80g=
Message-ID: <787b0d920609132319y660c62c5rc245843aa55fd615@mail.gmail.com>
Date: Thu, 14 Sep 2006 02:19:51 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: Assignment of GDT entries
Cc: torvalds@osdl.org, jeremy@goop.org, mingo@elte.hu, ak@suse.de,
       arjan@infradead.org, zach@vmware.com, linux-kernel@vger.kernel.org
In-Reply-To: <m11wqf12hh.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920609132106p492cc990na471484d7dee8afb@mail.gmail.com>
	 <m11wqf12hh.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/06, Eric W. Biederman <ebiederm@xmission.com> wrote:

> I agree that the difference is annoying.
>
> However I just wrote a user space implementation of fork that
> is capable of copying a process from an i386 only kernel to a x86_64
> kernel, and executing there without having to detect the kernel type.
>
> It didn't takes hacks to accomplish that.
>
> The basic syscall is:
> int set_thread_area (struct user_desc *u_info);
> struct user_desc {
>         unsigned int  entry_number;
>         unsigned long base_addr;
>         unsigned int  limit;
>         unsigned int  seg_32bit:1;
>         unsigned int  contents:2;
>         unsigned int  read_exec_only:1;
>         unsigned int  limit_in_pages:1;
>         unsigned int  seg_not_present:1;
>         unsigned int  useable:1;
> };
>
> If entry_number is -1 the kernel finds a free gdt entry and
> sets up the segment and returns with entry_number set to the
> segment number.

Eeeeeew.

So if I grabbed the first two slots before glibc got to
mess with them, glibc wouldn't break horribly?
If I grabbed one slot and glibc grabbed another, Wine
would be OK with the third instead of the second?

So basically it's not allowed to just grab the 3rd slot?

What if I want to find out what is already in use?
Am I supposed to iterate over all 8191 possible
GDT entries? How do I even tell how many slots
are available without using them all up?

Eeeeeeew. Well this was documented exactly nowhere.
The man page is even vague about entry_number,
meaning I had to dig in the kernel source (AMD manual
by my side) to find if that was a GDT slot or TLS slot,
as array index or byte offset, with or without the low bits
all set up for loading into the segment register, loaded for
me or not, etc.
