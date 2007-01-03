Return-Path: <linux-kernel-owner+w=401wt.eu-S932195AbXACXnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbXACXnX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 18:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbXACXnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 18:43:22 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:52484 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194AbXACXnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 18:43:21 -0500
Date: Thu, 4 Jan 2007 00:43:20 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Frank van Maarseveen <frankvm@frankvm.com>
Cc: Bryan Henderson <hbryan@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: Finding hardlinks
In-Reply-To: <20070103220129.GA4788@janus>
Message-ID: <Pine.LNX.4.64.0701040032460.31506@artax.karlin.mff.cuni.cz>
References: <20070103185815.GA2182@janus>
 <OF9726A29A.AA3902E2-ON85257258.0072E396-88257258.00740500@us.ibm.com>
 <20070103220129.GA4788@janus>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2007, Frank van Maarseveen wrote:

> On Wed, Jan 03, 2007 at 01:09:41PM -0800, Bryan Henderson wrote:
>>> On any decent filesystem st_ino should uniquely identify an object and
>>> reliably provide hardlink information. The UNIX world has relied upon
>> this
>>> for decades. A filesystem with st_ino collisions without being hardlinked
>>> (or the other way around) needs a fix.
>>
>> But for at least the last of those decades, filesystems that could not do
>> that were not uncommon.  They had to present 32 bit inode numbers and
>> either allowed more than 4G files or just didn't have the means of
>> assigning inode numbers with the proper uniqueness to files.  And the sky
>> did not fall.  I don't have an explanation why,
>
> I think it's mostly high end use and high end users tend to understand
> more. But we're going to see more really large filesystems in "normal"
> use so..
>
> Currently, large file support is already necessary to handle dvd and
> video. It's also useful for images for virtualization. So the failing stat()
> calls should already be a thing of the past with modern distributions.

As long as glibc compiles by default with 32-bit ino_t, the problem exists 
and is severe --- programs handling large files, such as coreutils, tar, 
mc, mplayer, already compile with 64-bit ino_t and off_t, but the user (or 
script) may type something like:

cat >file.c <<EOF
#include <sys/types.h>
#include <sys/stat.h>
main()
{
 	int h;
 	struct stat st;
 	if ((h = creat("foo", 0600)) < 0) perror("creat"), exit(1);
 	if (fstat(h, &st)) perror("stat"), exit(1);
 	close(h);
 	return 0;
}
EOF
gcc file.c; ./a.out

--- and you certainly do not want this to fail (unless you are out of disk 
space).

The difference is, that with 32-bit program and 64-bit off_t, you get 
deterministic failure on large files, with 32-bit program and 64-bit 
ino_t, you get random failures.

Mikulas
