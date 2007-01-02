Return-Path: <linux-kernel-owner+w=401wt.eu-S932622AbXABAEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbXABAEK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 19:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbXABAEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 19:04:10 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:57909 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700AbXABAEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 19:04:09 -0500
Date: Tue, 2 Jan 2007 01:04:06 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: Finding hardlinks
In-Reply-To: <20070101235320.GS8104@delft.aura.cs.cmu.edu>
Message-ID: <Pine.LNX.4.64.0701020055580.32128@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu> <20061221185850.GA16807@delft.aura.cs.cmu.edu>
 <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
 <1166869106.3281.587.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
 <20061229100223.GF3955@ucw.cz> <Pine.LNX.4.64.0701012333380.5162@artax.karlin.mff.cuni.cz>
 <20070101235320.GS8104@delft.aura.cs.cmu.edu>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jan 2007, Jan Harkes wrote:

> On Mon, Jan 01, 2007 at 11:47:06PM +0100, Mikulas Patocka wrote:
>>> Anyway, cp -a is not the only application that wants to do hardlink
>>> detection.
>>
>> I tested programs for ino_t collision (I intentionally injected it) and
>> found that CP from coreutils 6.7 fails to copy directories but displays
>> error messages (coreutils 5 work fine). MC and ARJ skip directories with
>> colliding ino_t and pretend that operation completed successfuly. FTS
>> library fails to walk directories returning FTS_DC error. Diffutils, find,
>> grep fail to search directories with coliding inode numbers. Tar seems
>> tolerant except incremental backup (which I didn't try). All programs
>> except diff were tolerant to coliding ino_t on files.
>
> Thanks for testing so many programs, but... did the files/symlinks with
> colliding inode number have i_nlink > 1? Or did you also have directories
> with colliding inode numbers. It looks like you've introduced hardlinked
> directories in your test which are definitely not supported, in fact it
> will probably cause not only issues for userspace programs, but also
> locking and garbage collection issues in the kernel's dcache.

I tested it only on files without hardlink (with i_nlink == 1) --- most 
programs (except diff) are tolerant to collision, they won't store st_ino 
in memory unless i_nlink > 1.

I didn't hardlink directories, I just patched stat, lstat and fstat to 
always return st_ino == 0 --- and I've seen those failures. These failures 
are going to happen on non-POSIX filesystems in real world too, very 
rarely.

BTW. POSIX supports (optionally) hardlinked directories but doesn't 
supoprt colliding st_ino --- so programs act according to POSIX --- but 
the problem is that this POSIX requirement no longer represents real world 
situation.

> I'm surprised you're seeing so many problems. The only find problem that
> I am aware of is the one where it assumes that there will be only
> i_nlink-2 subdirectories in a given directory, this optimization can be
> disabled with -noleaf.

This is not a bug but a feature. If filesystem doesn't count 
subdirectories, it should set directory's n_link to 1 and find will be ok.

> The only problems I've encountered with ino_t collisions are archivers 
> and other programs that recursively try to copy a tree while preserving 
> hardlinks. And in all cases these seem to have no problem with such 
> collisions as long as i_nlink == 1.

Yes, but they have big problems with directory ino_t collisions. They 
think that directories are hardlinked and skip processing them.

Mikulas

> Jan
>
