Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285593AbRLGWFe>; Fri, 7 Dec 2001 17:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285592AbRLGWF3>; Fri, 7 Dec 2001 17:05:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23052 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285593AbRLGWFP>; Fri, 7 Dec 2001 17:05:15 -0500
Message-ID: <3C113CFA.5090109@zytor.com>
Date: Fri, 07 Dec 2001 14:04:42 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: andersen@codepoet.org
CC: linux-kernel@vger.kernel.org
Subject: Re: On re-working the major/minor system
In-Reply-To: <3C10A057.BD8E1252@evision-ventures.com> <E16CJnv-0005c0-00@the-village.bc.nu> <20011207135100.A17683@codepoet.org> <9urbtm$69e$1@cesium.transmeta.com> <20011207145535.A18152@codepoet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:

> 
> Ok, so we go through, change sys/sysmacros.h, tar.h, cpio.h, and
> any other offending header file.  And guess what?  Not only has
> nothing changed (since those are macros, not functions), but you
> just broke every older .deb and .rpm in existance on your updated
> system.
> 
> In sys/sysmacros.h it defines major() and minor() as macros, so
> just dropping in an updated C library binary isn't going to do
> squat until all of userspace gets recompiled.  And tar.h and
> cpio.h define long standing (well over 10 years now) binary
> structures.  We can't just go changing this stuff, since now when
> a dev_t is some magic cookie, if I go to install something from
> my old Debian 1.2 CD or my old RedHat 4.0 CD, my system will puke
> trying to install using cookies that in fact are old 8/8 split
> device nodes and not cookies at all.
> 


It's clear a painful change is needed.  **We don't have a choice.**
However, the fewer places we have to make source code changes the better.

What we agreed upon when this was discussed last year was the following:

dev_t is extended to a 12:20 (32-bit size.)  I personally would rather
have seen a 64-bit size (32:32) but was outvoted :(

New major 0 is reserved, except that dev_t == 0 remains the code for "no
device".  The unnamed device major becomes major 256.

If (dev_t & ~0xFFFF) == 0, the dev_t is interpreted as an old-format
dev_t, and is interpreted according to the following algorithm:

	if ( dev && (dev & ~0xFFFF) == 0 ) {
		major = (dev >> 8) ? (dev >> 8) : 256;
		minor = dev & 0xFF;
	} else {
		major = dev >> 20;
		minor = dev & 0xFFFFF;
	}

	-hpa




