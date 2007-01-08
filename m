Return-Path: <linux-kernel-owner+w=401wt.eu-S1161184AbXAHGT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161184AbXAHGT2 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 01:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161183AbXAHGT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 01:19:27 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:57831 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161180AbXAHGT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 01:19:26 -0500
Date: Mon, 8 Jan 2007 07:19:25 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Frank van Maarseveen <frankvm@frankvm.com>
Cc: Bryan Henderson <hbryan@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: Finding hardlinks
In-Reply-To: <20070104001224.GA5980@janus>
Message-ID: <Pine.LNX.4.64.0701080717150.3506@artax.karlin.mff.cuni.cz>
References: <20070103185815.GA2182@janus>
 <OF9726A29A.AA3902E2-ON85257258.0072E396-88257258.00740500@us.ibm.com>
 <20070103220129.GA4788@janus> <Pine.LNX.4.64.0701040032460.31506@artax.karlin.mff.cuni.cz>
 <20070104001224.GA5980@janus>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Currently, large file support is already necessary to handle dvd and
>>> video. It's also useful for images for virtualization. So the failing
>>> stat()
>>> calls should already be a thing of the past with modern distributions.
>>
>> As long as glibc compiles by default with 32-bit ino_t, the problem exists
>> and is severe --- programs handling large files, such as coreutils, tar,
>> mc, mplayer, already compile with 64-bit ino_t and off_t, but the user (or
>> script) may type something like:
>>
>> cat >file.c <<EOF
>> #include <sys/types.h>
>> #include <sys/stat.h>
>> main()
>> {
>> 	int h;
>> 	struct stat st;
>> 	if ((h = creat("foo", 0600)) < 0) perror("creat"), exit(1);
>> 	if (fstat(h, &st)) perror("stat"), exit(1);
>> 	close(h);
>> 	return 0;
>> }
>> EOF
>> gcc file.c; ./a.out
>>
>> --- and you certainly do not want this to fail (unless you are out of disk
>> space).
>>
>> The difference is, that with 32-bit program and 64-bit off_t, you get
>> deterministic failure on large files, with 32-bit program and 64-bit
>> ino_t, you get random failures.
>
> What's (technically) the problem with changing the gcc default?

Technically none (i.e. edit gcc specs or glibc includes). But persuading 
all distribution builders to use this version is impossible. Plus there 
are many binary programs that are unchangable.

> Alternatively we could make the error deterministic in various ways. Start
> st_ino numbering from 4G (except for a few special ones maybe such
> as root/mounts). Or make old and new programs look differently at the
> ELF level or by sys_personality() and/or check against a "ino64" mount
> flag/filesystem feature. Lots of possibilities.

I think the best solution would be to drop -EOVERFLOW on st_ino and let 
legacy 32-bit programs live with coliding inodes. They'll have anyway.

Mikulas
