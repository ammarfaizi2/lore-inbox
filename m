Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272472AbTG1BRn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272537AbTG1AD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:03:29 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272740AbTG0W6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:47 -0400
Date: Sun, 27 Jul 2003 22:02:03 +0100
From: Matthew Wilcox <willy@debian.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, John Belmonte <jvb@prairienet.org>,
       Ben Collins <bcollins@debian.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       Michael Wawrzyniak <gan@planetlaz.com>
Subject: Re: [ACPI] Re: [PATCH] bad strlcpy conversion breaks toshiba_acpi
Message-ID: <20030727210203.GU1485@parcelfarce.linux.theplanet.co.uk>
References: <3F2142CE.4090608@prairienet.org> <20030725161510.GA31565@vana.vc.cvut.cz> <20030725165709.GA670@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030725165709.GA670@win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 06:57:09PM +0200, Andries Brouwer wrote:
> strlcpy is for strings, not for character arrays.
> The *BSD version accesses the source past the size-1 characters that are copied:
> 	while (*s++)
> 		;
> Thus, replacing strncpy (used to copy character arrays, possibly not 0-terminated)
> by strlcpy is wrong.

But using strncpy() is _also_ wrong because of its NUL-padding behaviour.
There's really four different situations and strncpy is only suitable
for one of them:

a) Copy at most n bytes of a string to another string (strlcpy)
b) Copy at most n bytes from a character array into a string (strncat?)
c) Copy at most n bytes from a string to a character array that will
   be returned to user space (strncpy)
d) Copy n bytes from one character array to another (memcpy)

stpcpy is another interesting variant on the awful strcpy, but we'd need
a stpncpy too.  strncat is a little dubious for case (b) since you need
to initialise the dest with a NUL in the first byte.

C's string handling sucks, and everybody knows it.  Making strings a first
class object may be a cure worse than the disease (for the intended use
of C; for scripting languages it makes perfect sense).

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
