Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270885AbTGPOt5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 10:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270892AbTGPOt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 10:49:57 -0400
Received: from ns2.uk.superh.com ([193.128.105.170]:22409 "EHLO
	ns2.uk.superh.com") by vger.kernel.org with ESMTP id S270885AbTGPOto
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 10:49:44 -0400
Date: Wed, 16 Jul 2003 16:03:26 +0100
From: Richard Curnow <Richard.Curnow@superh.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mundt <lethal@linux-sh.org>,
       Ben Gaster <Benedict.Gaster@superh.com>,
       Sean McGoogan <sean.mcgoogan@superh.com>,
       Boyd Moffat <boyd.moffat@superh.com>
Subject: Re: NFS structure allocation alignment patch
Message-ID: <20030716150326.GA320@malvern.uk.w2k.superh.com>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Paul Mundt <lethal@linux-sh.org>,
	Ben Gaster <Benedict.Gaster@superh.com>,
	Sean McGoogan <sean.mcgoogan@superh.com>,
	Boyd Moffat <boyd.moffat@superh.com>
References: <20030630135233.GN5586@malvern.uk.w2k.superh.com> <1057835121.21073.208.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057835121.21073.208.camel@passion.cambridge.redhat.com>
User-Agent: Mutt/1.4i
X-OS: Linux 2.6.0-test1 i686
X-OriginalArrivalTime: 16 Jul 2003 15:04:04.0866 (UTC) FILETIME=[7F97EE20:01C34BAB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jul, 2003 at 12:05pm, David Woodhouse wrote:
> On Mon, 2003-06-30 at 14:52, Richard Curnow wrote:
> > Hi Trond, Marcelo,
> > 
> > Below is a patch against 2.4.21 to tidy up the allocation of two
> > structures in nfs3_proc_unlink_setup.  We need this change for NFS to
> > work on the sh64 architecture, which has just been merged into 2.4 in
> > the last couple of days.  Otherwise, 'res' is 4-byte aligned but not
> > necessarily 8-byte aligned, but struct nfs_attr contains fields that are
> > 8 bytes wide.  This leads to alignment exceptions on loads and stores
> > into that structure.
> 
> What's wrong with alignment exceptions? They get fixed up by your
> exception handler, surely?
> 
> If you assert that it's a performance-critical path and hence we
> shouldn't be relying on the exception fixup, that's fine -- but in that
> case it's not a correctness fix, it's just an optimisation.

Apart from this issue, we haven't seen any code- or compiler-related
problems due to misaligned loads and stores occurring.  Indeed, because
gcc takes care to lay out structures to honour load/store alignments, we
deliberately don't 'fix-up' misaligned accesses, rather an oops is
raised since they are almost certainly due to something having gone
wrong, e.g.  a pointer has been overwritten somehow.

I bet someone will wonder how the misalignment hadn't shown up before.
Recall there were 2 structures being allocated with 1 kmalloc call.  The
first (nfs3_diropargs) contains 2 pointers and an unsigned int.  The
second (nfs_fattr) contains amongst other things some __u64's.  On sh64,
the __u64's will be accessed with single 8-byte load/store operations.
Although the SHmedia instruction set fully supports 64-bit addressing,
the current generation implements 32-bit (with sign-extension to 64) so
the toolchains currently store pointers as 32-bit to save memory &
cache.  Hence the 1st structure is only compiled with 4-byte alignment
=> insufficiently aligned 2nd structure in the old code.  I presume all
the other 64-bit architectures already use 64-bit pointers so the
alignment problem didn't happen.  With the patch I sent, the required
alignments are assured for any architecture.

HTH
Richard

-- 
Richard \\\ SuperH Core+Debug Architect /// .. At home ..
  P.    /// richard.curnow@superh.com  ///  rc@rc0.org.uk
Curnow  \\\ http://www.superh.com/    ///  www.rc0.org.uk
