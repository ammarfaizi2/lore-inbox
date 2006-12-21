Return-Path: <linux-kernel-owner+w=401wt.eu-S1423141AbWLUXto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423141AbWLUXto (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 18:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423139AbWLUXto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 18:49:44 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:33656 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423138AbWLUXtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 18:49:43 -0500
Date: Fri, 22 Dec 2006 00:49:42 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: Finding hardlinks
In-Reply-To: <20061221185850.GA16807@delft.aura.cs.cmu.edu>
Message-ID: <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu> <20061221185850.GA16807@delft.aura.cs.cmu.edu>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2006, Jan Harkes wrote:

> On Wed, Dec 20, 2006 at 12:44:42PM +0100, Miklos Szeredi wrote:
>> The stat64.st_ino field is 64bit, so AFAICS you'd only need to extend
>> the kstat.ino field to 64bit and fix those filesystems to fill in
>> kstat correctly.
>
> Coda actually uses 128-bit file identifiers internally, so 64-bits
> really doesn't cut it. Since the 128-bit space is used pretty sparsely
> there is a hash which avoids most collistions in 32-bit i_ino space, but
> not completely. I can also imagine that at some point someone wants to
> implement a git-based filesystem where it would be more natural to use
> 160-bit SHA1 hashes as unique object identifiers.
>
> But Coda only allow hardlinks within a single directory and if someone
> renames a hardlinked file and one of the names ends up in a different
> directory we implicitly create a copy of the object. This actually
> leverages off of the way we handle volume snapshots and the fact that we
> use whole file caching and writes, so we only copy the metadata while
> the data is 'copy-on-write'.

The problem is that if inode number collision happens occasionally, you 
get data corruption with cp -a command --- it will just copy one file and 
hardlink the other.

> Any application that tries to be smart enough to keep track of which
> files are hardlinked should (in my opinion) also have a way to disable
> this behaviour.

If user (or script) doesn't specify that flag, it doesn't help. I think 
the best solution for these filesystems would be either to add new syscall
 	int is_hardlink(char *filename1, char *filename2)
(but I know adding syscall bloat may be objectionable)
or add new field in statvfs ST_HAS_BROKEN_INO_T, that applications can 
test and disable hardlink processing.

Mikulas

> Jan
>
