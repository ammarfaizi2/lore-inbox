Return-Path: <linux-kernel-owner+w=401wt.eu-S1161045AbXAHXAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045AbXAHXAY (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161064AbXAHXAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:00:24 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:60809 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161045AbXAHXAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:00:22 -0500
Date: Mon, 8 Jan 2007 17:00:18 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Erez Zadok <ezk@cs.sunysb.edu>
Cc: Andrew Morton <akpm@osdl.org>, "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       David Quigley <dquigley@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation
Message-ID: <20070108230018.GB3756@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20070108111852.ee156a90.akpm@osdl.org> <200701082051.l08KpV8b011212@agora.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701082051.l08KpV8b011212@agora.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 03:51:31PM -0500, Erez Zadok wrote:
> BTW, this is a problem with all stackable file systems, including
> ecryptfs.  To be fair, our Unionfs users have come up against this
> problem, usually for the first time they use Unionfs :-).

I suspect that the only reason why this has not yet surfaced as a
major issue in eCryptfs is because nobody is bothering to manipulate
the eCryptfs-encrypted lower files. The only code out there right now
that can make sense of the files is in the eCryptfs kernel module.

> Now, we've discussed a number of possible solutions.  Thanks to
> suggestions we got at OLS, we discussed a way to hide the lower
> namespace, or make it readonly, using existing kernel facilities.
> But my understanding is that even it'd work, it'd only address new
> processes: if an existing process has an open fd in a lower branch
> before we "lock up" the lower branch's name space, that process may
> still be able to make lower-level changes.

Again, eCryptfs is fortunate in that the vast majority of users who
access the lower eCryptfs files will only want to read the encrypted
files (to do backups, for instance). I do not know of any userspace
utilities that can write correct eCryptfs lower file content.

> Detecting such processes may not be easy.  What to do with them,
> once detected, is also unclear.  We welcome suggestions.

My first instinct is to say that stacked filesystem should not even
begin to open the file if it is already opened by something other than
the stacked filesystem (-EPERM with a message in the syslog about the
problem). In the case when a stacked filesystem wants to open a file
that is already opened by something other than the stacked filesystem,
the stacked filesystem loses. Once the process closes the file, the
process is hitherto prevented from accessing the file again (via the
before-mentioned mechanism of hiding the lower namespace).

> Another possibility is that after, hopefully, both Unionfs and
> ecryptfs are in, and some more user experience has been accumulated,
> that we'll look into addressing this page-cache consistency problem
> for all stacked f/s.

Unionfs and eCryptfs share almost exactly the same namespace
issues. Unionfs happens to be impacted by them more than eCryptfs
because of the differences in how people actually access the files
under the two filesystems.

> Jeff, I don't think it's acceptable to OOPS.

For now, stacked filesystems just need to stay on their toes. There
are several places where assumptions need to be checked.

Mike
