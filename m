Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWE2HX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWE2HX0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 03:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWE2HX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 03:23:26 -0400
Received: from gw.openss7.com ([142.179.199.224]:2754 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S1750736AbWE2HXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 03:23:25 -0400
Date: Mon, 29 May 2006 01:23:20 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: 4Front Technologies <dev@opensound.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: How to check if kernel sources are installed on a system?
Message-ID: <20060529012319.D20649@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: 4Front Technologies <dev@opensound.com>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>
References: <1148835799.3074.41.camel@laptopd505.fenrus.org> <1148838738.21094.65.camel@mindpipe> <1148839964.3074.52.camel@laptopd505.fenrus.org> <1148846131.27461.14.camel@mindpipe> <20060528224402.A13279@openss7.org> <1148878368.3291.40.camel@laptopd505.fenrus.org> <447A883C.5070604@opensound.com> <1148883077.3291.47.camel@laptopd505.fenrus.org> <20060529005705.C20649@openss7.org> <447A9D28.9010809@opensound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <447A9D28.9010809@opensound.com>; from dev@opensound.com on Mon, May 29, 2006 at 12:05:12AM -0700
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4Front,

On Mon, 29 May 2006, 4Front Technologies wrote:
> 
> How about external modules that have a kernel dependant part and kernel
> independant part?. Kernel independant part could live in a separate tree and
> has its own makefiles.
> 
> But regparm requires that ALL parts linked into the module need to have
> regparm defined. So it's another headache to write makefiles for the kernel
> independant part to figure out if the distro support regparm or not.

They way I approached it was to get CFLAGS for compiling both the kernel
dependent part and kernel independent part.

The interface exported from the kernel dependent part to the indepdent part
have the regparms attribute explicity pinned on exported symbols (e.g.  on
supporting architectures either to  __attribute__((__regparm__(3))) or
__attribute__((__regparm(0)))).  LiS uses regparm(0) for binary compatible
(kernel independent) STREAMS modules for historical reasons.  Linux
Fast-STREAMS uses regparm(3).

Taking a similar approach, make all your kernel dependent part exported
function (and function pointer) symbols "fastcall" and then forget about the
compiler flag.  If you access regular kernel symbols, you, of course, do not
have this choice.

It would have been nice if the kernel would set the regparms on all exported
symbols, but external modules was really just an afterthought.

The autoconf approach that I take does not use kbuild, primarily because of
the inherent separation between kernel depedent part and independent part
for STREAMS (STREAMS subsystem is kernel dependent, STREAMS modules attempt
to be somewhat kernel independent and use an SVR4.2 ABI).

The autoconf/automake makefiles handle the building of both.  And, of course,
they nicely handle building all the othter GNU/Linux things like user space
programs built on the same definitions, manual pages, etc.

--brian

