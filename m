Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbUCAJEe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 04:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbUCAJEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 04:04:33 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:27398 "EHLO
	ford.pronto.tv") by vger.kernel.org with ESMTP id S261237AbUCAJEK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 04:04:10 -0500
To: Marc Giger <gigerstyle@gmx.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel unaligned acc on Alpha
References: <20040229215546.065f42e9.gigerstyle@gmx.ch>
	<yw1xvflp1sv6.fsf@kth.se> <20040229230318.493034b2.gigerstyle@gmx.ch>
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Sun, 29 Feb 2004 23:36:48 +0100
In-Reply-To: <20040229230318.493034b2.gigerstyle@gmx.ch> (Marc Giger's
 message of "Sun, 29 Feb 2004 23:03:18 +0100")
Message-ID: <yw1xishp1pj3.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Giger <gigerstyle@gmx.ch> writes:

> Hi Måns,
>
> On Sun, 29 Feb 2004 22:24:45 +0100
> mru@kth.se (Måns Rullgård) wrote:
>
>> Marc Giger <gigerstyle@gmx.ch> writes:
>> 
>> > Hi All,
>> >
>> > I have a lot of unaligned accesses in kernel space:
>> >
>> > kernel unaligned acc    : 2191330
>> > (pc=fffffffc002557d8,va=fffffffc00256059)
>> >
>> > It seems to be located in the networking part (iptables?) from the
>> > kernel. Can someone please help me how to find the location of these
>> > uac's? I already have recompiled the kernel with debugging enabled
>> > and tried to debug it with gdb. 
>> 
>> Find the matching function in System.map.  Look for the entry with the
>> highest address less than or equal to the pc value.
>
> The highest address in System.map is 
> fffffc000076fab0 A _end
>
> /proc/ksyms is more informative. It seems the function is in a
> module.

Yes, of course.

> fffffffc00254800 ipt_unregister_table   [ip_tables]
> fffffffc00256051 __insmod_ip_tables_S.rodata_L16        [ip_tables]

That seems to support my suspicion that something is doing unaligned
accesses of static data.

> ipt_unregister_table is the most matching funtion, but makes no sense to
> me, since I don't load and unload it 2191330 times:-)

There is probably some function after ipt_unregister_table in the
source code that is not being exported from the object file.

> Do you have more tips how to find the right funtion in the modules?

Disassemble (objdump -s) the module and look for load or store
instructions with the same page offset as the reported pc value, in
this case 0x17d8.  You'll want to compile with debugging symbols so
you get the function names printed even for static functions.

Another thing is to look for casts to (int *) or (long *) in the
source code.  There's often one somewhere close to the unaligned
access.  You might also check where static data is being accessed.
Depending on the amount of static data and the number of accesses this
might be more trouble than it's worth.

BTW, which kernel version is this?

-- 
Måns Rullgård
mru@kth.se
