Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266914AbUJVTYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266914AbUJVTYc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 15:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266888AbUJVTWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 15:22:16 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3968 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266386AbUJVTUv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:20:51 -0400
Date: Fri, 22 Oct 2004 15:20:39 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: =?ISO-8859-15?Q?Kristian_S=F8rensen?= <ks@cs.aau.dk>
cc: andre@tomt.net, Kasper Sandberg <lkml@metanurb.dk>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>, umbrella@cs.aau.dk
Subject: Re: Gigantic memory leak in linux-2.6.[789]!
In-Reply-To: <41795E69.9090909@cs.aau.dk>
Message-ID: <Pine.LNX.4.61.0410221507340.6092@chaos.analogic.com>
References: <200410221613.35913.ks@cs.aau.dk> <1098455535.12574.1.camel@localhost>
 <Pine.LNX.4.61.0410221102300.12605@chaos.analogic.com>
 <41792C36.4070301@users.sourceforge.net> <Pine.LNX.4.61.0410221208230.17016@chaos.analogic.com>
 <41795E69.9090909@cs.aau.dk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-1216637763-1098472839=:6092"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1678434306-1216637763-1098472839=:6092
Content-Type: TEXT/PLAIN; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 22 Oct 2004, [ISO-8859-15] Kristian S=F8rensen wrote:

> Richard B. Johnson wrote:
>
>> On Fri, 22 Oct 2004, [ISO-8859-15] Kristian S=F8rensen wrote:
>>=20
>>> Richard B. Johnson wrote:
>>>=20
>>>> On Fri, 22 Oct 2004, Kasper Sandberg wrote:
>>>>=20
>>>>> On Fri, 2004-10-22 at 16:13 +0200, Kristian S=F8rensen wrote:
>>>>>=20
>>>>>> Hi all!
>>>>>>=20
>>>>>> After some more testing after the previous post of the OOPS in
>>>>>> generic_delete_inode, we have now found a gigantic memory leak in Li=
nux=20
>>>>>> 2.6.
>>>>>> [789]. The scenario is the same:
>>>>>>=20
>>>>>> File system: EXT3
>>>>>> Unpack and delete linux-2.6.8.1.tar.bz2 with this Bash while loop:
>>>>>>=20
>>>>>> let "i =3D 0"
>>>>>> while [ "$i" -lt 10 ]; do
>>>>>>    tar jxf linux-2.6.8.1.tar.bz2;
>>>>>>    rm -fr linux-2.6.8.1;
>>>>>>    let "i =3D i + 1"
>>>>>> done
>>>>>>=20
>>>>>> When the loop has completed, the system use 124 MB memory more _each=
_=20
>>>>>> time....
>>>>>> so it is pretty easy to make a denial-of-service attack :-(
>>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>> Do something like this with your favorite kernel version.....
>>>>=20
>>>> while true ; do tar -xzf linux-2.6.9.tar.gz ; rm -rf linux-2.6.9 ; vms=
tat=20
>>>> ; done
>>>>=20
>>>> You can watch this for as long as you want. If there is no other
>>>> activity, the values reported by vmstat remain, on the average, stable=
=2E
>>>> If you throw in a `sync` command, the values rapidly converge to
>>>> little memory usage as the disk-data gets flused to disk.
>>>=20
>>> The problem is, that the free memory reported by vmstat is decresing by=
=20
>>> 124mb for each 10-iterations....
>>>=20
>>> The allocated memory does not get freed even if the system has been lef=
t=20
>>> alone for three hours!
>>>=20
>>=20
>> Yes. So?  Why would it be freed? It's left how it was until it
>> is needed. Freeing it would waste CPU cycles.
>
> Okay :-) So it looks like two of you says we have been mistaken :-D (and =
the=20
> behaviour has been changed since linux-2.4)
>
> Anyway - How does this work in practice? Does the file system implementat=
ion=20
> use a wrapper for kfree or?
> Is there any way to force instant free of kernel memory - when freed? Els=
e it=20
> is quite hard testing for possible memory leaks in our Umbrella kernel mo=
dule=20
> ... :-/
>
>
> Best regards,
>

First, you can always execute sync() and flush most of the file-buffers
to disk. This frees up a lot.

In the kernel....
If you are doing a lot of kmalloc() allocation and free(), you
can write out the pointer values using printk(). I use '0' before
such ... printk("0 %p\n", ptr); do `dmesg | sort >xxx.xxx`. Now
you can look at the file and see the sorted pointer values. If
they repeat, chances are pretty good that you are not leaking
memory.

In user space...
Periodically look at the break address.
If it keeps going up, you may have a leak. If it's stable
you probably are okay.

The only sure way of detecting a memory leak is to use
some substitute code (maybe a macro) that substitutes
for (intercepts) the allocator and deallocator. It eventually
executes the allocator and deallocator after saving information
somewhere you define (array, file, etc). You can sort that
information and determine if there are as many (k)mallocs() as
there are for (z)frees()  (for instance) of the same pointer values.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.
--1678434306-1216637763-1098472839=:6092--
