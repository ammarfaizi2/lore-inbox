Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287798AbSBEDMJ>; Mon, 4 Feb 2002 22:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288124AbSBEDL7>; Mon, 4 Feb 2002 22:11:59 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:20679 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S287798AbSBEDLy>;
	Mon, 4 Feb 2002 22:11:54 -0500
Date: Mon, 4 Feb 2002 19:11:52 -0800
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.3] wavelan_cs.c : new WE api
Message-ID: <20020204191152.B7010@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020204110138.B6533@bougret.hpl.hp.com> <3C5F4522.8D4D74A6@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C5F4522.8D4D74A6@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Feb 04, 2002 at 09:36:18PM -0500
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2002 at 09:36:18PM -0500, Jeff Garzik wrote:
> Comments pertaining to all three of wavelan, wavelan_cs, and netwave_cs:
> * wv_splhi should really just be spin_lock_irqsave.  calling
> spin_lock_irqsave with 'flags' from another function is non-portable. 
> doing so to an inline function is just barely portable, and is
> discouraged :)

	We will have to agree to disagree. I won't oppose a patch (as
long as the driver still works after it).

> * I still see a couple save_flags/restore_flags in there...

	Of course, I haven't removed them, just moved them around.

	Old code (simplified) :
---------------------------
xxx_ioctl()
{
	save_flags();
	switch(cmd) {
		[...]
		copy_from_user(extra, ...);
		outsb(..., extra);
		[...]
	}
	restore_flags();
}
----------------------------
	Alan told me that this is a no-no.

	New code :
-----------------------
xxx_set_xxx(... , char *extra)
{
	save_flags();
	[...]
	outsb(..., extra);
	[...]
	restore_flags();
}
-----------------------
	copy_to/from_user is handled before reaching the wireless
handler. What is nice is that the new API *enforce* the proper
behaviour.

	Actually, you may want to add that to the list of cleanups for
the kernel janitors, check that all copy_to/from_user in device ioctl
functions are not done with irq disabled. Actually, I think it was
mostly in Wireless drivers...

> otherwise looks ok to me.

	Good. If I understood the new "official" procedure from Linus
himself, you are supposed to forward my patches to hin ;-)

> Jeff Garzik

	Have fun...

	Jean
