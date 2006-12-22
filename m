Return-Path: <linux-kernel-owner+w=401wt.eu-S1945933AbWLVFF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945933AbWLVFF7 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 00:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945938AbWLVFF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 00:05:59 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:33778 "EHLO
	delft.aura.cs.cmu.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945933AbWLVFF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 00:05:58 -0500
Date: Fri, 22 Dec 2006 00:05:50 -0500
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: Finding hardlinks
Message-ID: <20061222050550.GY16375@delft.aura.cs.cmu.edu>
Mail-Followup-To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz> <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu> <20061221185850.GA16807@delft.aura.cs.cmu.edu> <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2006 at 12:49:42AM +0100, Mikulas Patocka wrote:
> On Thu, 21 Dec 2006, Jan Harkes wrote:
> >On Wed, Dec 20, 2006 at 12:44:42PM +0100, Miklos Szeredi wrote:
> >>The stat64.st_ino field is 64bit, so AFAICS you'd only need to extend
> >>the kstat.ino field to 64bit and fix those filesystems to fill in
> >>kstat correctly.
> >
> >Coda actually uses 128-bit file identifiers internally, so 64-bits
> >really doesn't cut it. Since the 128-bit space is used pretty sparsely
> 
> The problem is that if inode number collision happens occasionally, you 
> get data corruption with cp -a command --- it will just copy one file and 
> hardlink the other.

Our 128-bit space is fairly sparse and there is some regularity so we
optimized the hash to minimize the chance on collisions. This is also
useful for iget5_locked, each 32-bit ino_t is effectively a hash bucket
in our case and avoiding collisions makes the lookup in the inode cache
more efficient.

Another part is that only few applications actually care about hardlinks
(cp -a, rsync, tar/afio). All of these already could miss some files or
create false hardlinks when files in the tree are renamed during the
copy. We also have a special atomic volume snapshot function that is
used to create a backup, which backs up additional attributes that are
not visible through the standard POSIX/vfs api (directory acls,
creator/owner information, version-vector information for conflict
detection and resolution)

I've also found that most applications that care about hardlinks already
have a check whether the link count is greater than one and the object
is not a directory. This is probably done more for efficiency, it would
be a waste of memory to track every object as a possible hardlink.

And because Coda already restrict hardlinks in many cases they end up
not being used very much, or get converted by a cross-directory rename
to COW objects which of course have nlink == 1.

> If user (or script) doesn't specify that flag, it doesn't help. I think 
> the best solution for these filesystems would be either to add new syscall
> 	int is_hardlink(char *filename1, char *filename2)
> (but I know adding syscall bloat may be objectionable)
> or add new field in statvfs ST_HAS_BROKEN_INO_T, that applications can 
> test and disable hardlink processing.

BROKEN_INO_T sounds a bit harsh, and something like that would really
have to be incorporated in the SuS standard for it to be useful. It also
would require all applications to be updated to check for this flag. On
the other hand if we don't worry about this flag we just have to fix the
few applications that do not yet check that nlink>1 && !IS_DIR. Those
applications would probably appreciate the resulting reduced memory
requirements and performance increase because they end up with
considerably fewer candidates in their internal list of potential
hardlinked objects.

Of course this doesn't solve the problem for some filesystem with
larger than 64-bit object identifiers that wants to support normal
hardlinked files. But adding a BROKEN_INO_T flag doesn't solve it
either, since the backup/copy would not perform hardlink processing in
which case such a file system can just as well always pretend that
i_nlink for files is always one.

Jan

