Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbTKHMuS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 07:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTKHMuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 07:50:17 -0500
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:54937 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S261755AbTKHMuH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 07:50:07 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Maciej Zenczykowski <maze@cela.pl>
Subject: Re: Question: Returning values from kernel FIFO to userspace
Date: Sat, 8 Nov 2003 13:48:33 +0100
User-Agent: KMail/1.5.4
References: <Pine.LNX.4.44.0311071247410.26063-100000@gaia.cela.pl>
In-Reply-To: <Pine.LNX.4.44.0311071247410.26063-100000@gaia.cela.pl>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311081348.52887.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Maciej,

On Friday 07 November 2003 12:59, Maciej Zenczykowski wrote:
> I have a kernel FIFO for special keyboard events (considered asynchronous
> to normal keypresses) and a userspace script (invoked by keyboard_signal
> from init) which reads them (one at a time).

Just write a simple misc device, where you implement read and write.

open -> control open behavior, setup file->private to point to your data
read -> reads from your FIFO one value at a time
write -> flush fifo (not needed?)
llseek -> no_llseek (since you are a fifo!)
poll -> waits for at least one entry in the fifo
release -> free your private data allocated for file->private

In read() you check whether *ppos != file->f_pos and return -ESPIPE in this
case.

You also check, whether size is the right size for your data and return
- -EINVAL, if not.

Implementing poll would be nice, if you want your script to deamonize,
but is not needed, if you trigger reading via init.

write ignores all arguments and simply flushes the FIFO.

If you allow multiple open by not returning -EBUSY on the second open,
you should take care of locking your FIFO.

> And no, these keys can't be handled like normal extended keys as they use
> _a very_ different route to reach the kernel -- and neither would I want
> to - they're of the: lock keyboard, turn off screen, disk, sleep,
> hibernate, etc variety.
>
> Currently, I'm using a mangled proc interface (which is very much a
> hack: reading /proc/special_keycode returns the current value at the head
> of the FIFO, and if the seek offset was 0 then it pops the FIFO.  

/proc is only good for showing values, but not for FIFOs.

> What would be considered 'the right way' to return an integer
> from a 30-value integer FIFO in the kernel to a userspace script (and
> pop the FIFO at the same time).

A misc character device is perfect.

BTW: Which kernel(s) do you target in your development?

Regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/rOYsU56oYWuOrkARAtxgAKCbbifYj95CtzjOgk6bDJ0q0ZWjbQCeNoGz
aHFSYTPCQRb/ntKVMWVkyvM=
=GmJl
-----END PGP SIGNATURE-----

