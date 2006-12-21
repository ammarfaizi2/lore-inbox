Return-Path: <linux-kernel-owner+w=401wt.eu-S1423051AbWLUTXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423051AbWLUTXf (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 14:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423050AbWLUTXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 14:23:35 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:53070 "EHLO
	delft.aura.cs.cmu.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423046AbWLUTXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 14:23:34 -0500
X-Greylist: delayed 1480 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 14:23:33 EST
Date: Thu, 21 Dec 2006 13:58:50 -0500
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mikulas@artax.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: Finding hardlinks
Message-ID: <20061221185850.GA16807@delft.aura.cs.cmu.edu>
Mail-Followup-To: Miklos Szeredi <miklos@szeredi.hu>,
	mikulas@artax.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz> <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 12:44:42PM +0100, Miklos Szeredi wrote:
> The stat64.st_ino field is 64bit, so AFAICS you'd only need to extend
> the kstat.ino field to 64bit and fix those filesystems to fill in
> kstat correctly.

Coda actually uses 128-bit file identifiers internally, so 64-bits
really doesn't cut it. Since the 128-bit space is used pretty sparsely
there is a hash which avoids most collistions in 32-bit i_ino space, but
not completely. I can also imagine that at some point someone wants to
implement a git-based filesystem where it would be more natural to use
160-bit SHA1 hashes as unique object identifiers.

But Coda only allow hardlinks within a single directory and if someone
renames a hardlinked file and one of the names ends up in a different
directory we implicitly create a copy of the object. This actually
leverages off of the way we handle volume snapshots and the fact that we
use whole file caching and writes, so we only copy the metadata while
the data is 'copy-on-write'.

I'm considering changing the way we handle hardlinks by having link(2)
always create a new object with copy-on-write semantics (i.e. replacing
link with some sort of a copyfile operation). This way we can get rid of
several special cases like the cross-directory rename. It also avoids
problems when the various replicas of an object are found to be
inconsistent and we allow the user to expand the file. On expansion a
file becomes a directory that contains all the objects on individual
replicas. Handling the expansion in a dcache friendly way is nasty
enough as is and complicated by the fact that we really don't want such
an expansion to result in hard-linked directories, so we are forced to
inventing new unique object identifiers, etc. Again, not having
hardlinks would simplify things somewhat here.

Any application that tries to be smart enough to keep track of which
files are hardlinked should (in my opinion) also have a way to disable
this behaviour.

Jan

