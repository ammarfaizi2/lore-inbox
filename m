Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTKGWWe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbTKGWWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:22:09 -0500
Received: from gaia.cela.pl ([213.134.162.11]:43530 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S264097AbTKGL7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 06:59:30 -0500
Date: Fri, 7 Nov 2003 12:59:28 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Question: Returning values from kernel FIFO to userspace
Message-ID: <Pine.LNX.4.44.0311071247410.26063-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have a kernel FIFO for special keyboard events (considered asynchronous 
to normal keypresses) and a userspace script (invoked by keyboard_signal 
from init) which reads them (one at a time).

And no, these keys can't be handled like normal extended keys as they use 
_a very_ different route to reach the kernel -- and neither would I want 
to - they're of the: lock keyboard, turn off screen, disk, sleep, 
hibernate, etc variety.

Currently, I'm using a mangled proc interface (which is very much a 
hack: reading /proc/special_keycode returns the current value at the head 
of the FIFO, and if the seek offset was 0 then it pops the FIFO.  This 
last part is due to 'cat /proc/file' doing two reads, the first for the 
data with a 1K buffer and the second to determine we're at EOF, both call
the proc read interface.  nb. this means that if proc exports a value that 
is variable length (like jiffies), it is possible for cat /proc/file to 
return junk (at the end of the file) if the proc file length increases 
between first and second read invocation (unlikely, but possible...) - 
perhaps this should be fixed more globally - but how? by cacheing? 
remembering a given proc fd has already EOF'ed and not invoking the 
proc read procedure a second time?).

What would be considered 'the right way' to return an integer
from a 30-value integer FIFO in the kernel to a userspace script (and 
pop the FIFO at the same time).
This is called very very rarely (once a couple minutes, sometimes 
even hours) as it only happens when the user actually presses some 
unusual key-combination.  However a FIFO is necessary because a single 
keypress combination usually results in 2-3 events.

Thanks,
MaZe.

