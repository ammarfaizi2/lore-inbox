Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135344AbRANUCg>; Sun, 14 Jan 2001 15:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135427AbRANUC0>; Sun, 14 Jan 2001 15:02:26 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:56838 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S135344AbRANUCL>; Sun, 14 Jan 2001 15:02:11 -0500
Date: Sun, 14 Jan 2001 20:02:06 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go?
In-Reply-To: <Pine.LNX.4.10.10101141111370.4086-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101141927200.18971-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jan 2001, Linus Torvalds wrote:

> Note that previously there _were_ order dependencies. In fact, I consider
> it very tasteless to have modules that act differently on whether another
> module is loaded. I saw some arguments saying that this is th "right
> thing", and I disagree completely.

The only valid behaviour I can think of is...

 if (!feature_present)
	try_to_load_it();

 if (feature_present)
	use_it();
 else
	if (we_can_live_without())
		deal_with_it();
	else
		whinge_and_die();

In this case, it's not really depending on whether the desired feature has
been loaded yet or not. It's depending on whether the desired feature is
available or not. In this sense, inter_module_get_request() is an
improvement, because it makes that explicit.

Obviously, in the case where we'd eventually just whinge_and_die(),
usually it's best to just make this code depend on whatever feature it is
that's being used, by referencing it directly.

But in the case of the CFI probe code and also I believe DRM, we don't
actually know precisely which feature we're going to require until we've
done the hardware probe at runtime. We don't want the generic code having
a hard dependency on each possible submodule, and doing it with ifdefs
according to what happens to be compiled in is just ugly. So the above
logic was useful, and get_module_symbol(), even though it wasn't
wonderful, provided it.

The reason you didn't get the current CFI code with the rest of the update 
I gave you for 2.4.0-test12 is because I'm intending to rewrite it first, 
and hopefully deal with this issue in a better way while I'm at it.

But as it stands, the best option I can see is to have the generic probe
code have ifdefs on the chipset-specific options, and reference only the
ones which are present. It's not the end of the world, and as rmk 
suggests, many embedded systems are run without module support in 
production anyway. 

--
dwmw2



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
