Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWAJQ2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWAJQ2D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 11:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWAJQ2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 11:28:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51403 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932215AbWAJQ2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 11:28:02 -0500
Date: Tue, 10 Jan 2006 08:27:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [GIT PATCHES] kbuild updates
In-Reply-To: <20060109211157.GA14477@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.64.0601100821440.4939@g5.osdl.org>
References: <20060109211157.GA14477@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Jan 2006, Sam Ravnborg wrote:
>
> Please pull from:
> 	ssh://master.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git

Ok, pulled.

However, fixing up a trivial conflict in i386/Makefile, I noticed this:

	cflags-$(CONFIG_REGPARM) += $(shell if [ $(call cc-version) -ge 0300 ] ; then \
				    echo "-mregparm=3"; fi ;)

and it strikes me that this is WRONG.

It's wrong for some subtle reasons: it means that CONFIG_REGPARM is set 
whether or not it is actually _used_, which means that anybody who depends 
on CONFIG_REGPARM in the sources is just screwed.

Now, for this particular usage, the only breakage is in the i386 
<asm/module.h>, which will report "REGPARM" in MODULE_REGPARM regardless 
of whether the kernel was compiled with -mregparm=3 or not. So it's mainly 
cosmetic.

But it strikes me that we'd be a _lot_ better off if the Kconfig phase 
would check the compiler version, instead of us checking it dynamically a 
hundred times in the Makefiles. It would be more efficient, and we could 
make things like this more _correct_. 

Comments?

		Linus
