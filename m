Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268767AbRHBKy5>; Thu, 2 Aug 2001 06:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268817AbRHBKyr>; Thu, 2 Aug 2001 06:54:47 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:41732 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S268767AbRHBKyi>; Thu, 2 Aug 2001 06:54:38 -0400
Message-ID: <3B693040.2185C3AE@idb.hist.no>
Date: Thu, 02 Aug 2001 12:49:37 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.8-pre3 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        linux-kernel@vger.kernel.org
Subject: Re: kswapd eats the cpu without swap
In-Reply-To: <Pine.A41.4.31.0108020049360.61934-100000@pandora.inf.elte.hu> <3B691F87.2182A1BA@loewe-komp.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Wächtler wrote:

> when the system runs low on memory (on a 64MB setop box like device
> with _no_ swap partition/file), the harddisk gets very active and
> the system does not respond for 1-5 seconds.
> The VM (in mm/oom_kill.c) is killing the "memory hog" (simple program
> that calls malloc() in a loop and touching the mem). I think the
> amount of "busyness" depends on the size of malloc chunks. If they
> are bigger the process gets killed faster.
> 
> Until now, I don't understand what is happening. Several subsystems
> in the kernel compete for memory: dentry cache, buffer cache, VM
> that wants at least /proc/sys/vm/freepages free.
> Is demand loading involved? Does the VM quashes text pages when
> running low on memory? What about relocation then?
> 
> Or simpler: what keeps the harddisk so busy?

The VM system drop unwriteable pages (i.e. program code) when out of
memory.  This is the only kind of "swapping" when you don't
have a swap partition/file.  It will of course also empty the
various disk caches (page cache, buffer cache, inode/dentry caches)
so every little file operation might need several disk accesses.

Getting really low on memory with no swap device means that you
have almost no program code loaded.  Data is unswappable without
a device and fills memory, every little piece of code that needs
execution have to be re-loaded from the executables on disk.

This is why your disk get busy.  Your machine is trashing.
Trashin happens both with and without a swap device.

Having swap can help a lot - the VM subsystem will then be able to
page out old unused data leaving more room for often-used code.
You will then get a lot better performance even though you
don't have more RAM.  Of course you may run into trashing with
a swap device too - but it happens later after using much more
memory.  With luck you don't get that far with normal use.  If 
you do - get more RAM.

Helge Hafting
