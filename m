Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267638AbUGWLQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267638AbUGWLQb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 07:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267643AbUGWLQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 07:16:31 -0400
Received: from [195.23.16.24] ([195.23.16.24]:3043 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S267638AbUGWLQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 07:16:25 -0400
Subject: Re: Compression filter for Loopback device
From: Paulo Marques <pmarques@grupopie.com>
Reply-To: pmarques@grupopie.com
To: Lei Yang <leiyang@nec-labs.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <951A499AA688EF47A898B45F25BD8EE80126D4D6@mailer.nec-labs.com>
References: <951A499AA688EF47A898B45F25BD8EE80126D4D6@mailer.nec-labs.com>
Content-Type: text/plain
Organization: Grupo PIE
Message-Id: <1090581375.22679.20.camel@pmarqueslinux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 23 Jul 2004 12:16:15 +0100
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.26.0.10; VDF: 6.26.0.41; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-22 at 20:27, Lei Yang wrote:
> Hi all,
> 
> Is there anything like 'losetup' that allows choosing encryption
> algorithm for a loopback device that can be used on compression
> algorithms? Or in other words, when the data passes through loopback
> device to a real storage device, it can be filtered and the filter is
> compression instead of encryption; when kernel ask for data in a storage
> device that is mounted to a loopback device with compression, it will be
> filtered again -- decompressed.
> 
> If there is not a ready-to-use method for this, is there any way I can
> implement the idea?

There is cloop. The only problem with cloop is that it is read-only.

If you want read-write, there is no solution AFAIK(*).

I did start working on something like that a while ago. I even
registered for a project on sourceforge: 

http://sourceforge.net/projects/zloop/

I stopped working on it because:

1 - I didn't have the time

2 - There are some nasty issues with this concept:

    - The image file would ideally shrink and grow according to the 
achieved compression ratio. In the worst case it would have to grow to
more than the size of the "block device" (if you wrote a bunch of
already compressed files to the device, for instance), because it has to
keep some metadata. This reduces the scenarios where this sort of
compressed loopback device could be used.

    - Respect the sequence of writes to the block device is tricky. This
is important because you have to guarantee that a journaled filesystem
on top of the block device will assure data integrity. This is worst
than on a normal loopback because you have to make sure the "block
device metadata" is also written at appropriate times. I actually
conceived an algorithm that could acomplish this with little overhead,
but never got to implement it.

    - The block device doesn't understand anything about files. This is
an advantage because it will compress the filesystem metadata
transparently, but it is bad because it compresses "unused" blocks of
data. This could probably be avoided with a patch I saw floating around
a while ago that zero'ed delete ext2 files. Zero'ed blocks didn't accupy
any space at all in my compressed scheme, only metadata (only 2 bytes
per block).

3 - There didn't seem to be much interest from the commmunity in
something like this.


If interest rises now, I'll probably have the time to resume the project
where I left off.

I did a proof of concept using a nbd server. This way I could test
everything in user space.

With this NBD server I tested the compression ratios that my scheme
could achieve, and they were much better than those achieved by cramfs,
and close to tar.gz ratios. This I wasn't expecting, but it was a nice
surprise :)

Anyway, any feedback, suggestions, ideas on this will be greatly
appreciated.

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"



(*) There is JFFS2 that you can mount on top of a mtd-block device. I
never tried it personally, because it seemed a bit of a cludge, and it
didn't get the shrink and grow effect that I wanted from the compressed
loop-back. There is also an old ext2 "compression extension" that seemed
not to be mantained for a long time, last time I checked.





