Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbVJTP0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVJTP0H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 11:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbVJTP0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 11:26:07 -0400
Received: from mail.s.netic.de ([212.9.160.11]:58635 "EHLO mail.s.netic.de")
	by vger.kernel.org with ESMTP id S932105AbVJTP0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 11:26:05 -0400
From: Guido Fiala <gfiala@s.netic.de>
To: Badari Pulavarty <pbadari@gmail.com>
Subject: Re: large files unnecessary trashing filesystem cache?
Date: Thu, 20 Oct 2005 17:23:52 +0200
User-Agent: KMail/1.7.2
Cc: lkml <linux-kernel@vger.kernel.org>
References: <200510182201.11241.gfiala@s.netic.de> <1129668484.23632.82.camel@localhost.localdomain>
In-Reply-To: <1129668484.23632.82.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510201723.52858.gfiala@s.netic.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 October 2005 22:48, Badari Pulavarty wrote:
> On Tue, 2005-10-18 at 22:01 +0200, Guido Fiala wrote:
> > Story:
> > Once in while we have a discussion at the vdr (video disk recorder)
> > mailing list about very large files trashing the filesystems memory cache
> > leading to unnecessary delays accessing directory contents no longer
> > cached.
> > [...]
> Is there a reason why those applications couldn't use O_DIRECT ?
>
> Thanks,
> Badari

I asked a vdr-expert on this and here is the reason why O_DIRECT is not 
suitable:

O_DIRECT would be great if it were a simple option for opening files.
But as a matter of facts O_DIRECT completely changes the semantics of 
file access. You have to read blocks of a defines size to memory that 
is aligned to defined block borders. Memory provided by normal malloc() 
or new() is not usable and results in IO errors. So the result is you 
have to have a complete rewrite of the whole IO subsystem of the 
affected program. Most maintainers of non-trivial applications are 
completely resistant against such changes - for good reasons.

If there would be an O_DIRECT_EX32++ (or O_STREAMING) that doesn't have 
this change in semantic it would be much easier to apply the necessary 
changes.

BTW: In the case of the VDR program not even a per process limit in used 
buffer caches would help: the same program reads huge files _and_ huge 
directory trees with a lot of small files that should be cached. A 
heuristic for this case has to work on per file base. It needs to 
detect that some files are only used in a streaming manner - with very 
seldom jumps in random directions (skipping commercials, review a 
scene). I don't know if such a heuristic is possible and if it would 
not break other things.

PS: using f_advise helps a bit. One can keep IO semantics but you have 
to add a virtualisation layer for all streaming IO. And you can't 
combine posix_fadvise(POSIX_FADV_DONTNEED) with 
posix_fadvise(POSIX_FADV_WILLNEED) when you possibly have jumps in your 
access pattern because you can't cancel (at least to my knowledge) the 
POSIX_FADV_WILLNEED call when you see the read ahead is not needed any 
more. It would be an interesting add on if POSIX_FADV_DONTNEED would 
cancel the read of a region that has been requested by 
POSIX_FADV_WILLNEED before.

Ralf (forwarded by me on his request)

---
Hopefully i did now correctly "reply all" - sorry if i accidently caused some 
trouble.
