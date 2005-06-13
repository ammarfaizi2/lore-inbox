Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVFMDYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVFMDYx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 23:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVFMDYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 23:24:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45264 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261336AbVFMDYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 23:24:19 -0400
Date: Sun, 12 Jun 2005 20:26:05 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: jnf <jnf@innocence-lost.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       drepper@redhat.com
Subject: Re: Add pselect, ppoll system calls.
In-Reply-To: <Pine.LNX.4.62.0506121815070.24789@fhozvffvba.vaabprapr-ybfg.arg>
Message-ID: <Pine.LNX.4.58.0506122018230.2286@ppc970.osdl.org>
References: <1118444314.4823.81.camel@localhost.localdomain>
 <1118616499.9949.103.camel@localhost.localdomain>
 <Pine.LNX.4.58.0506121725250.2286@ppc970.osdl.org>
 <Pine.LNX.4.62.0506121815070.24789@fhozvffvba.vaabprapr-ybfg.arg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 12 Jun 2005, jnf wrote:

> Hi. I realize this is off subject to the mailing list, however its not
> really off subject to the thread. What is the suggested method for
> dealing with this? i.e. catching sigint which sets a global variable and
> then having select() inside the loop, i.e.
> 
> while (boolean < 1 ) {
>    [...]
>    select(...);

Nope, that will have a race in between testing "boolean" and the select.

The simplest way is to do

	if (sigsetjmp(..)) {
		... handle signal ...
	}
	for (;;) {
		select(..)
	}

but a lot of people find the control flow very confusing, and I can't much 
blame them. 

One pretty simple alternative is to just make the timeout be a global, and 
have the signal handler clear it, guaranteeing that if we're just about to 
hit the select(), we'll exit immediately.

A third alternative that some people prefer (although I personally find it
to be the most complex of the bunch and it's also the least efficient, but
it works in threaded environments) is to have the signal handler write a
byte to a pipe, and have the select() mask contain that pipe as one of the
inputs so that the main loop sees the signal even as a pipe readability
test.

Anyway, that's three different approaches, all of which are portable and 
thus preferable to pselect() which is not.

			Linus
