Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265317AbUFOGbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265317AbUFOGbf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 02:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265319AbUFOGbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 02:31:35 -0400
Received: from visp230-172.visp.co.nz ([210.54.172.230]:44499 "EHLO
	freerider.asterisk") by vger.kernel.org with ESMTP id S265317AbUFOGb2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 02:31:28 -0400
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: In-kernel Authentication Tokens (PAGs)
References: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com>
	<1087080664.4683.8.camel@lade.trondhjem.org>
	<D822E85F-BCC8-11D8-888F-000393ACC76E@mac.com>
	<1087084736.4683.17.camel@lade.trondhjem.org>
	<DD67AB5E-BCCF-11D8-888F-000393ACC76E@mac.com>
From: Blair Strang <bls@asterisk.co.nz>
Date: 15 Jun 2004 18:38:45 +1200
In-Reply-To: <DD67AB5E-BCCF-11D8-888F-000393ACC76E@mac.com>
Message-ID: <87smcxqqa2.fsf@asterisk.co.nz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> writes:

> On Jun 12, 2004, at 19:58, Trond Myklebust wrote:
> > So this would be more like an in-kernel keyring then?
> Yeah, that seems about right.
> 

Hi,

Disclaimer: I haven't looked at the LSM stuff.

Surely the only logical reason to tag a process with extra security
information /in the kernel/ is because that information is going to be
used /by the kernel/.  I can't think of a good reason to put a
generalised keystore in the kernel.

Distributed filesystem credentials are a sensible thing to associate
with a process because then they can be easily used by the filesystem
code.  Keeping this information per-uid would be easier, but PAGs are
more general.
  
>From that point of view, AFS PAGs boil down to the idea of annotating
processes with authorisation tokens that can be easily used by the
kernel.  IIRC, in AFS, they just tack on a couple of magic
supplementary GIDs.  It is good if the "annotation" can be carried out
by a userspace process.

To be most useful for distributed filesystems, PAG ids should be
per-process and inherited across fork/exec.

This is somewhat different from the genereal idea of a keystore, or
capabilities ala http://www.cap-lore.com/CapTheory/.

So that you can see where I'm coming from (and tell me I'm wrong :)
here's my braindead idea of what generic PAG support would look like.
I would be very surprised if there were not some more generic
mechanism of which this is a subset.  LSM?

=====

There needs to be some capability set to allow trusted processes to
grant a PAG id to a process.  In a simple implementation, say,
CAP_PAG_ALLOCATE allows you to assign them.  In some cases, the kernel
might attach a PAG id to a process.

Each process may have a list of PAG ids.

A PAG id list entry has two important parts, a pag_domain [which might
be PAG_DOMAIN_AFS or PAG_DOMAIN_CODA, whatever -- it just identifies
the kernel subsystem to which the PAG is meaningful] and a pag_id,
which is considered opaque.

You might also have CAP_PAG_GIVEAWAY to allow giveaways by processes
with PAG ids.  I haven't thought that part through very well.

A pag-er (allocator) needs at least:

* some way to give a process a unique PAG id.
* some subsystem specific support to associate more data with that PAG id.

And the pag-ee needs at least:

* some (allocator specific) way to ask for a PAG id.  this happens in 
  userspace 
* some way to enumerate PAG ids.
* some way to get rid of PAG ids.
* perhaps some way to give PAG ids away.

Regards,

    Blair.

-- 
Hello.  Just walk along and try NOT to think about your INTESTINES
 being almost FORTY YARDS LONG!! ; C-u M-x yow 
