Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268164AbUIKP17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268164AbUIKP17 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 11:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268165AbUIKP17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 11:27:59 -0400
Received: from the-village.bc.nu ([81.2.110.252]:20915 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268164AbUIKP1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 11:27:55 -0400
Subject: Re: radeon-pre-2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Airlie <airlied@linux.ie>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409110137590.26651@skynet>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <Pine.LNX.4.58.0409100209100.32064@skynet>
	 <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <20040910153135.4310c13a.felix@trabant>
	 <9e47339104091008115b821912@mail.gmail.com>
	 <1094829278.17801.18.camel@localhost.localdomain>
	 <9e4733910409100937126dc0e7@mail.gmail.com>
	 <1094832031.17883.1.camel@localhost.localdomain>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <1094853588.18235.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409110137590.26651@skynet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094912726.21157.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 11 Sep 2004 15:25:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-09-11 at 01:50, Dave Airlie wrote:
> So the IDE-CD driver and IDE-disk drivers both program registers on the
> IDE controller directly.. oh no the ide driver seems to do that.. this is
> FUD,

Its a shame the DRI people having nothing better to do than tell folks
to shut up or mutter FUD about things they don't grasp. You've almost
got the point by now at least.

The IDE CD and IDE disk drivers do both write to registers on the IDE
controller directly - often the same registers. The reason it doesn't
end up in a nasty heap is because the core IDE code does co-ordination. 
Two drivers, independant drivers, an access protocol an the ability for
some entity to co-ordinate them and lo - it all works.

>  a graphics card is a device, singular one device, it requires one
> device driver,

That appears to be the pet religion but repeating bullshit doesn't make
it true.

> I can't write a user space IDE driver and still expect the kernel one to
> be happy, I can't write a second IDE driver for a chipset for formatting
> disks and expect the normal kernel driver to stay working with it, why do
> people think graphics driver are meant to be different..

Because they are not different, and you can write such a formatting
driver providing it follows the IDE access protocols in the core code.
You won't have to modify existing IDE drivers either. It works because
the co-ordination layer is there.

> Alan, I agree with how you want to proceed with this, and keep things
> stable, but anything short of a single card-specific driver looking after
> the registers and DMA queueing and locking is going to have deficiencies
> and the DRM has a better basis than the fb drivers,

"I want to own it, mine mine". Pathetic really isn't it. The FB writers
I've no doubt think they should own it and their code is better too.
They also support a lot more hardware than you do of course, and on
platforms that DRI doesn't support.

What is actually so hard about driver code that instead looks like


my_fb_attach_notify(struct vga_dev *dev, int type)
{
	if(type == TYPE_DRI)
	{
		me->fb_ops = &dri_ops;
		my_fb_dri_init(dev);
		return 0;
	}
	if(type == TYPE_OVERLAY && dev->rev < 0xC4) /* Errata */
		return -EINVAL; /* Refuse overlays in fb mode */
}

or

	down(&dev->lock);
	vga_quiesce_all_drivers(dev);
	do nasty non parallel stuff
	up(&dev->lock);

This is essentially what the IDE layer does, although its closer to

	queue_this_function_and_args_to_list(dev, callback, args);
	if(!doing_stuff);
		begin_queue_run(dev);

Either model works

