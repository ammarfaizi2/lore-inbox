Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWJMNfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWJMNfn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 09:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWJMNfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 09:35:43 -0400
Received: from smtp161.iad.emailsrvr.com ([207.97.245.161]:16038 "EHLO
	smtp161.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S1750749AbWJMNfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 09:35:42 -0400
Message-ID: <452F9602.1050906@gentoo.org>
Date: Fri, 13 Oct 2006 09:34:58 -0400
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060917)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Michael Rasenberger <miraze@web.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-mm1 violates sandbox feature on linux distribution
References: <451ABE0E.2030904@web.de> <20061001104046.GA10205@uranus.ravnborg.org>
In-Reply-To: <20061001104046.GA10205@uranus.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> Can you point to to some description of this sandbox feature.
> The error you point out looks pretty generic and should happen
> in several places - so I need to understand what problem I shall
> fix before trying to fix it.

It's basically a runtime linker hack (LD_PRELOAD?) which limits a 
processes access to files to a certain portion of the filesystem. In 
Gentoo's package compilation system, the compile processes are limited 
in that they can only write to /var/tmp/portage/<packagename>

Writes onto other parts of the filesystem will cause the whole process 
to bail out. Reads are OK. Compilation happens in 
/var/tmp/portage/<packagename>/work and then installation happens in 
/var/tmp/portage/<packagename>/image. When that is done, the package 
manager moves the contents of image onto the real system (with sandbox 
obviously disabled at this point).

> The point is that we have other places where we create temporary files
> so this should not be the only issue.

It should be noted that this issue is only related to compiling external 
modules through kbuild. Actual kernel compilation is not done in the 
sandbox.

If these other places have been introduced in 2.6.19 then yes there may 
be other issues. However, this sandboxed module compilation system has 
been working flawlessly for a long time now, so either those other 
places don't matter or those build-paths simply don't happen in the 
common cases.

This is a bigger problem for us now that this change has gone into 
Linus' tree. Would you accept a patch to make this output to /dev/null 
like many of the other toolchain checks do?

Thanks,
Daniel

