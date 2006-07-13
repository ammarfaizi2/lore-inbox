Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbWGMGjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbWGMGjr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 02:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbWGMGjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 02:39:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12681 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932566AbWGMGjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 02:39:46 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Albert Cahalan" <acahalan@gmail.com>
Cc: ak@suse.de, tytso@mit.edu, drepper@redhat.com, arjan@infradead.org,
       rdunlap@xenotime.net, akpm@osdl.org, linux-kernel@vger.kernel.org,
       libc-alpha@sourceware.org
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
References: <787b0d920607122200m4785f7ddmddf40c079a7460cb@mail.gmail.com>
Date: Thu, 13 Jul 2006 00:38:02 -0600
In-Reply-To: <787b0d920607122200m4785f7ddmddf40c079a7460cb@mail.gmail.com>
	(Albert Cahalan's message of "Thu, 13 Jul 2006 01:00:38 -0400")
Message-ID: <m164i257sl.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert Cahalan" <acahalan@gmail.com> writes:

> Andi Kleen writes:
>> On Thursday 13 July 2006 01:24, Theodore Tso wrote:
>
>>> P.S.  I happen to be one those developers who think the binary
>>> interface is not so bad, and for compared to reading from /proc/sys,
>>> the sysctl syscall *is* faster.  But at the same there, there really
>>> isn't anything where really does require that kind of speed, so that
>>> point is moot.  But at the same time, what is the cost of leaving
>>> sys_sysctl in the kernel for an extra 6-12 months, or even longer,
>>> starting from now?
>>
>> The numerical namespace for sysctl is unsalvagable imho. e.g.
>> distributions regularly break it because there is no central
>> repository of numbers so it's not very usable anyways in practice.
>
> Huh? How exactly is this different from system call numbers,
> ioctl numbers, fcntl numbers, ptrace command numbers, and every
> other part of the Linux ABI?

The only practical difference is that what people use is
/proc/sys so the binary sysctl interface is not seriously maintained
and bugs crop up.

> Normal sysctl works very well for FreeBSD. I'm jealous.
> They also have a few related calls that are very nice.
>
> Here we fight over a few CPU cycles in the syscall entry path,
> then piss away performance by requiring open-read-close and
> marshalling everything through decimal ASCII text. WTF? Let's
> just have one system call (make_XML_SOAP_request) and be done.

There is a cost to open-read-close.  But as a simple benchmark
against a file will show reading data from /proc/sys is much slower
than reading data from a file.

>From what I have been able to measure so far, open-read-close only
seems to double the cost over sysctl, and access can do the filename
resolution about as quickly as sysctl can deal with a binary path.  So
I suspect it is the allocation of struct file that makes
open-read-close more expensive.  Reading the data is in the noise.

sysfs current does a lot better than /proc/sys I think it was only
60% heavier than performing the same operation on a real file.

Part of the problem with /proc/sys and other data in proc is
that we deliberately kill the drop everything out of the dcache
as soon as we have found it.  Which is terrible performance wise.

All of those measurements were with string data that I don't
interpret on either side.

Performance wise there does seem to be a problem with the
implementation.  How to fix it I don't yet know.  But I have
yet to see ascii text be implicated.

Eric
