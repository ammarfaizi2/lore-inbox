Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261816AbTC0IxS>; Thu, 27 Mar 2003 03:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261818AbTC0IxS>; Thu, 27 Mar 2003 03:53:18 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:19972 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261816AbTC0IxQ>; Thu, 27 Mar 2003 03:53:16 -0500
Message-ID: <3E82BF2D.8080508@aitel.hist.no>
Date: Thu, 27 Mar 2003 10:06:53 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: erik@hensema.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Delaying writes to disk when there's no need
References: <slrnb843gi.2tt.usenet@bender.home.hensema.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Hensema wrote:
> In all kernels I've tested writes to disk are delayed a long time even when
> there's no need to do so.
> 
Short answer - it is supposed to do that!

> A very simple test shows this: on an otherwise idle system, create a tar of
> a NFS-mounted filesystem to a local disk. The kernel starts writing out the
> data after 30 seconds, while a slow and steady stream would be much nicer
> to the system, I think.
>
You're wrong then.  There's no need for a slow steady stream, why do
you want that.  Of course you can set up cron to run sync at
regular (short) intervals to achieve this.

> On 2.4.x this can block the system for several seconds. 2.5.6x and
> 2.5.6x-mm (with AS) also show this behaviour, but the system doesn't block
> anymore. I'm using a preemtable kernel.
> 
Writing out stuff is not supposed to block the machine, and as you say,
it is fixed in 2.5.  No need for the steady writing.

> I only started to notice this behaviour when I upgraded from 256 MB ram to
> 512 MB. In other words: Linux behaves more nicely with 256 MB.
> 
Why do you think that is more nice?

Writing is delayed because that accumulate bigger writes and
fewer seeks.  This helps performance a lot.  Delaying writes
has another advantage - somw writes won't be done at all,
saving 100% writing time.  This is the case for temporary
files that gets written to, read, and deleted before they
get written to disk. It all happens in cache, improving
performance tremendously.  To see the alternative,
try booting with mem=4M or 16M or some such, with _no_ swapping.

Another case is a file that gets overwritten several times.
This all happens in memory because of the delay, only the final
version gets written to disk.  This is ver common, even for files
that are written only once.  (slowly extending a file
and writing it to disk every time _will_ write the same stuff
over and over because it is impossible to add a few bytes only.
You always write a whole block, adding anything less than that
involves reading the half-full block, updating it, and writing it
back.  Keeping such operations in memory saves quite a few
disk writes.)

For more detailed information, read a book about how filesystems and
disk caching works.

Helge Hafting

