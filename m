Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbUDGVJz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 17:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264193AbUDGVJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 17:09:55 -0400
Received: from pirx.hexapodia.org ([65.103.12.242]:18535 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S264192AbUDGVJw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 17:09:52 -0400
Date: Wed, 7 Apr 2004 16:09:50 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Paul Eggert <eggert@CS.UCLA.EDU>
Cc: Andrew Morton <akpm@osdl.org>, bug-coreutils@gnu.org,
       linux-kernel@vger.kernel.org
Subject: Re: dd PATCH: add conv=direct
Message-ID: <20040407210950.GG2814@hexapodia.org>
References: <20040406220358.GE4828@hexapodia.org> <20040406173326.0fbb9d7a.akpm@osdl.org> <20040407173116.GB2814@hexapodia.org> <20040407111841.78ae0021.akpm@osdl.org> <87vfkbms7s.fsf@penguin.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vfkbms7s.fsf@penguin.cs.ucla.edu>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 01:46:31PM -0700, Paul Eggert wrote:
> Andrew Morton <akpm@osdl.org> writes:
> > In 2.6 we do the check at open() and fcntl() time.  In 2.4 we don't
> > fail until the actual I/O attempt.
> 
> This raises the issue of what "dd conv=direct" should do in 2.4
> kernels.  I propose that it should report an error and exit, when the
> write fails, since conv=direct can't be implemented.  The basic idea
> is that on systems that lack direct I/O, conv=direct should fail.

I agree, this is the appropriate behavior.  When "dd conv=direct" is
used on a fd that cannot support direct I/O, and the kernel doesn't tell
us until it's too late, erroring on the I/O is the only sane action.

Fortuitously, that's what happens with the patches I posted.

(Note that it's a function of the kernel and the underlying FS whether
direct I/O is going to work.  So some kind of heuristic on kernel
version is a bad idea.)

> Another issue with this patch: in Solaris, direct I/O is done by
> invoking directio(DIRECTIO_ON); see
> <http://docs.sun.com/db/doc/816-0213/6m6ne37so?q=directio&a=view>.
> Is Solaris direct I/O a direct analog to Linux direct I/O, or are
> there subtle differences in semantics that should be made visible to
> the users of GNU "dd"?

The Solaris semantics are more sane than the Linux ones, to be sure --
it always does the I/O, falling back to buffered I/O if conditions are
not right for direct.

I don't believe I have a test system for the Solaris case (when was
directio(3C) added?) so someone else will have to add that support.

-andy
