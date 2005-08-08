Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbVHHWdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbVHHWdI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbVHHWco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:32:44 -0400
Received: from nef2.ens.fr ([129.199.96.40]:14600 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S932322AbVHHWcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:32:39 -0400
Date: Tue, 9 Aug 2005 00:32:38 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: understanding Linux capabilities brokenness
Message-ID: <20050808223238.GA523@clipper.ens.fr>
References: <20050808211241.GA22446@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808211241.GA22446@clipper.ens.fr>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Tue, 09 Aug 2005 00:32:38 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for replying to myself...

On Mon, Aug 08, 2005 at 09:13:06PM +0000, David Madore wrote:
> However, what I do not understand is precisely _how_ one gets a
> sendmail process without CAP_SETUID: for that is the heart of the
> problem, and that is where the bug really was.  But [#3] and [#4] are
> very obscure (and I found nothing conclusive in lkml archives).  I
> understand that the problem lies in some combination of the
> inheritable capability set and the CAP_SETPCAP capability, but I don't
> see what that combination is.  Certainly removing capabilities from
> the inheritable set should not prevent suid root programs from having
> them reinstated (in the language of [#6], the suid root bit should
> correspond to a full forced set of capabilities), so I don't see what
> that has to do with it, and CAP_SETPCAP indeed allows to remove
> capabilities from a given process but I don't see how the user could
> gain that capability (and indeed if he can then we can expect him to
> gain all capabilities very rapidly).

After some more intensive Googling, I found the answer in the archives
of the linux-privs-discuss mailing-list (whose existence I did not
know of):

<URL:
http://sourceforge.net/mailarchive/forum.php?thread_id=1588083&forum_id=25120
 >

The explanation from the sendmail team was incorrect: CAP_SETPCAP is a
red herring, it's only about CAP_SETUID, the implementation of the
inheritable set was broken in that it controlled not only capabilities
automatically passed across execve() but also those _gained_ by suid
root programs (contrary to the claim in the sendmail analysis) and,
worse, instead of failing on execve() when the program could not gain
privileges, it proceeded with the capabilities missing.  Hence the
catastrophic failure.

This does not tell me, then, why CAP_SETPCAP was globally disabled by
default, nor why passing of capabilities across execve() was entirely
removed instead of being fixed.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
