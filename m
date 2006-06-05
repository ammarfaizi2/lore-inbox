Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751249AbWFESBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWFESBn (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 14:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWFESBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 14:01:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6109 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751249AbWFESBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 14:01:43 -0400
Date: Mon, 5 Jun 2006 11:00:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: 76306.1226@compuserve.com, linux-kernel@vger.kernel.org,
        jbeulich@novell.com, Ingo Molnar <mingo@elte.hu>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: 2.6.17-rc5-mm1
Message-Id: <20060605110046.2a7db23f.akpm@osdl.org>
In-Reply-To: <4484584D.4070108@free.fr>
References: <200606042101_MC3-1-C19B-1CF4@compuserve.com>
	<20060604181002.57ca89df.akpm@osdl.org>
	<44840838.7030802@free.fr>
	<4484584D.4070108@free.fr>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jun 2006 18:14:05 +0200
Laurent Riffard <laurent.riffard@free.fr> wrote:

> > 
> > Random Oops (recursive dies) on early boot. I sometimes succeded on 
> > booting but the system dies on "pktsetup test /dev/dvd". I can't get a full 
> > trace since I don't have my second box here for some days. I tried to boot
> > with vga=791, but system hangs with a blank screen.
> 
> Here is a bunch of message I got with 2.6.17-rc5-mm3-lockdep with 8K 
> stack and CONFIG_DEBUG_STACK_USAGE=y. It happens when I start pktcdvd.
> 
> Does it give any hints ?
> 

It gives some hints.

> 
> cdrom: This disc doesn't have any tracks I recognize!
> pktcdvd: writer pktcdvd0 mapped to hdc
> ----------------------------->
> | new stack fill maximum: vol_id/2233, 3696 bytes (out of 8136 bytes).
> | Stack fill ratio: 45% - that's still OK, no need to report this.
> ------------|
> {   20} [<c013ba14>] debug_stackoverflow+0x80/0xae
> {   28} [<c013cbb6>] __mcount+0x2a/0x97
> {   20} [<c010e434>] mcount+0x14/0x18
> {  304} [<c0238c28>] ide_do_drive_cmd+0x11/0x16c
> {  100} [<e0e553aa>] cdrom_queue_packet_command+0x45/0xd8
> {  204} [<e0e559e1>] cdrom_check_status+0x58/0x60
> {   88} [<e0e55a57>] ide_cdrom_drive_status+0x2a/0x99
> {  376} [<e0c8a84b>] cdrom_open+0x7b/0x7ef
> {   32} [<e0e54756>] idecd_open+0x8a/0xbd
> {  564} [<c016297c>] do_open+0x2db/0x3d4
> {  568} [<c0162ad7>] blkdev_get+0x62/0x6a
> {  564} [<e0ecb370>] pkt_open+0x92/0xbe2
> {  564} [<c0162747>] do_open+0xa6/0x3d4
> {   36} [<c0162c31>] blkdev_open+0x28/0x57
> {   28} [<c0159c47>] __dentry_open+0xb8/0x192
> {   32} [<c0159d9b>] nameidata_to_filp+0x25/0x3a
> {   92} [<c0159de9>] do_filp_open+0x39/0x42
> {   44} [<c015add2>] do_sys_open+0x45/0xc0
> {   24} [<c015ae80>] sys_open+0x18/0x1a
> {=3688} [<c02a87ba>] sysenter_past_esp+0x63/0xa1
> <---------------------------

Ingo, what does "vol_id/2233" mean?

The first column is, I assume, stack usage by that function?

blkdev_get() allocates 700 bytes of stack space.  Do you have any lockdep
features enabled in config as well?  They will increase the size of the
inode and dentry to a total of over 2 kbytes and we'll really start getting
into trouble in blkdev_get().

But I don't see why the above trace is (apparently) claiming that
do_open(), ptk_open(), etc are using a lot of stack.

I guess we should force 8k stacks if the lockdep features are enabled.

But x86_64 has no such option.  Problem.

<wonders how on earth that on-stack inode+dentry got in there>

And lock-validator-special-locking-bdev.patch add two more copies of the
same sin, while falsely claiming "Has no effect on non-lockdep kernels."
