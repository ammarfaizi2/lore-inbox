Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133080AbRANVQI>; Sun, 14 Jan 2001 16:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133105AbRANVP6>; Sun, 14 Jan 2001 16:15:58 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:57606 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S133080AbRANVPt>; Sun, 14 Jan 2001 16:15:49 -0500
Date: Sun, 14 Jan 2001 21:15:41 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go?
In-Reply-To: <Pine.LNX.4.10.10101141209030.4086-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101142107420.25589-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jan 2001, Linus Torvalds wrote:

> This is what "request_module()" and "kmod" is all about. Once we probe the
> hardware, the drievr itself can ask for more drivers.
> 
> I completely fail to see the arguments that have been brought up for drm
> doing ugly things. The code should simply do
> 
> 	drm_agp_head_t * head = inter_module_get("drm_agp");
> 
> 	if (!head) {
> 		request_module("drm-agp");
> 		head = inter_module_get("drm_agp");
> 		if (!head)
> 			return -ENOAGP;
> 	}
> 
> and be done with it. THE ABOVE MAKES SENSE. The code says _exactly_ what
> the module wants to do: it wants to find the AGP support, and if it cannot
> find the AGP support it wants to load them.

It's the same with CFI command-set-specific code. Except that the 
command-set specific code didn't previously have to be initialised at all, 
and now we've got to initialise it (and have it call 
inter_module_register) before it's required by the cfi_probe code.

The difference here is that while drm_agp actually had to do some hardware
initialisation, the CFI command set handlers didn't - the only thing their
module_init routine does is call inter_module_register(). So we've
introduced the init order dependencies where previously they weren't
necessary.

That's the one flaw in the inter_module_get() stuff - we could do with a
way to put entries in the table at _compile_ time, rather than _only_ at
run time. 

While I accept that we can't eliminate init order dependencies completely,
I still think we should avoid them where it's possible. Which it would be
in this case, without much difficulty at all.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
