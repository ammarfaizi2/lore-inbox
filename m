Return-Path: <linux-kernel-owner+w=401wt.eu-S936859AbWLKQlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936859AbWLKQlX (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 11:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937049AbWLKQlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 11:41:23 -0500
Received: from smtp.osdl.org ([65.172.181.25]:42119 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936859AbWLKQlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 11:41:22 -0500
Date: Mon, 11 Dec 2006 08:40:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>,
       Andrew MChuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
In-Reply-To: <20061211161212.GJ4587@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612110834520.12500@woody.osdl.org>
References: <20061211011327.f9478117.akpm@osdl.org> <20061211092130.GB4587@ftp.linux.org.uk>
 <20061211012545.ed945cbd.akpm@osdl.org> <20061211093314.GC4587@ftp.linux.org.uk>
 <20061211014727.21c4ab25.akpm@osdl.org> <20061211100301.GD4587@ftp.linux.org.uk>
 <20061211021718.a6954106.akpm@osdl.org> <20061211022746.9ec80c03.akpm@osdl.org>
 <20061211104556.GF4587@ftp.linux.org.uk> <Pine.LNX.4.64.0612110748570.12500@woody.osdl.org>
 <20061211161212.GJ4587@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2006, Al Viro wrote:
> 
> FWIW, I really think that this sort of bugs ("oh, I call hotplug,
> rootfs is there but kernel is not ready, woe is me") clearly show
> that many, _many_ users of hotplug are BS.  The reason is simple -
> if we have a call of hotplug that early, we have a driver that lives
> with hotplug failures _and_ with different behaviour in built-in
> and modular cases.  I would argue that any such driver is broken.

Now, you are probably right that many of them are unnecessary, but I don't 
agree in _general_. 

It's perfectly normal behaviour to say "I discovered this device".

The fact that device discovery happens during early bootup and nobody even 
_cares_ (because early bootup ends up enumerating all discovered devices 
on its own) is a separate issue. The fact that many distros don't care 
during early bootup doesn't mean that they don't care later on.

Another reason for "unnecessary" hotplug events is that generic functions 
like "I added a bus" happen both for static buses _and_ for "hey, somebody 
loaded a module that found this bus". Again, the static case may be 
something that people don't _care_ about, but we should (a) use common 
code and (b) be consistent, so we do a hotplug event regardless.

That said, I definitely agree that people shouldn't expect hotplug events 
to be delievered too early. If it's something that runs in a 
core_initcall, and is compiled in, no way in *hell* should we actually 
expose that to anything - it's just too early.

So it makes perfect sense to say

   "you won't be getting any notification by anything built-in, until 
    'device_initcall' (which is the default module_init, of course)".

which in the case of certain drivers obviously _does_ mean that they had 
better not try to use any early initcalls to load firmware.

		Linus
