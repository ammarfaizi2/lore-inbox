Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265985AbUA1RTO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 12:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUA1RTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 12:19:14 -0500
Received: from palrel10.hp.com ([156.153.255.245]:12775 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265985AbUA1RSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 12:18:44 -0500
Date: Wed, 28 Jan 2004 09:20:04 -0800
From: Grant Grundler <iod00d@hp.com>
To: Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>
Subject: Re: [RFC/PATCH, 1/4] readX_check() performance evaluation
Message-ID: <20040128172004.GB5494@cup.hp.com>
References: <00a201c3e541$c0e7d680$2987110a@lsd.css.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a201c3e541$c0e7d680$2987110a@lsd.css.fujitsu.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 10:54:28AM +0900, Hironobu Ishii wrote:
> Seto posted "[RFC] How drivers notice a HW error?" (readX_check() I/F)
>    http://marc.theaimsgroup.com/?l=linux-kernel&m=106992207709400&w=2
> 
> Grant will show his idea near future,
>    http://marc.theaimsgroup.com/?l=linux-kernel&m=107453681120603&w=2

I don't work on error recovery full time and that's really a full time job.
In a nutshell, I'd like to treat IO errors as exceptions and hide
most of the support in the regular readX() macros. Arch support
controls readX/writeX implementations and CONFIG_* options can
be used to pick which behavior someone wants. I'd expect drivers
which support error recovery to register a error recovery callback
and "fake" value to hand back for PIO reads until recovery is complete.

I could be wrong. Exception handling is ugly. But my hope is that
by putting all the exception handling in one place in the driver,
the driver will be forced to be methodical in being "deterministic"
WRT to driver state and can return to a known state by calling one
routine. This will keep the drivers maintainable by "part-time hackers"
who don't care about error recovery.

> Conclusion:
>     Performance disadvantage of readX_check() is a very small.
>     I'd like you to understand that such a function will not 
>     cause severe performance disadvantage as you imagine.

This is no surprise. The cost of PIO reads is far greater (100x)
than the extra cost to check for errors.
Eg PIO read on 1GHz HP rx2600 is ~1000-1100 CPU cycles and it's in
the same order of magnitude for all architectures.

> This patch:
>      - is for Fusion MPT driver.
>      - has no error recovery code yet, sorry.

Error recovyer code is the hard part. Find all the locations in the
code and writing instance specific error recovery code. The HPUX driver
I first worked on is amazingly similar to MPT. And it had error recovery
support (for "Host Powerfail") and truly was a PITA to support.

>      - currently supports ia64 only. But I believe that
>        some other CPU(such as SPARC, PPC, PA-RISC) can also
>        support this kind of I/F. 

yes - probably a few others as well.

>        I know, unfortunately, that i386 can't support this kind
>        of I/F, because it can't recover from machine check state.

I think i386 could. The method to check for errors will be different
and the types of errors which are detectable are fewer.
I'm not sure it would be recoverable though. But it should be able
to shutdown a misbehaving driver instance/device before the box crashed.
(well, assuming there is no memory corruption).


thanks,
grant
