Return-Path: <linux-kernel-owner+w=401wt.eu-S1753056AbXABXug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056AbXABXug (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 18:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753770AbXABXuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 18:50:35 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:42231 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016AbXABXue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 18:50:34 -0500
Date: Wed, 3 Jan 2007 00:50:33 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Arjan van de Ven <arjan@infradead.org>, Benny Halevy <bhalevy@panasas.com>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
Subject: Re: Finding hardlinks
In-Reply-To: <1167779668.6090.95.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.64.0701030042080.10633@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz> 
 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>  <20061221185850.GA16807@delft.aura.cs.cmu.edu>
  <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz> 
 <1166869106.3281.587.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz> 
 <4593890C.8030207@panasas.com>  <1167300352.3281.4183.camel@laptopd505.fenrus.org>
  <Pine.LNX.4.64.0612281909200.2960@artax.karlin.mff.cuni.cz> 
 <1167388475.6106.51.camel@lade.trondhjem.org> 
 <Pine.LNX.4.64.0612300154510.19928@artax.karlin.mff.cuni.cz>
 <1167779668.6090.95.camel@lade.trondhjem.org>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2007, Trond Myklebust wrote:

> On Sat, 2006-12-30 at 02:04 +0100, Mikulas Patocka wrote:
>>
>> On Fri, 29 Dec 2006, Trond Myklebust wrote:
>>
>>> On Thu, 2006-12-28 at 19:14 +0100, Mikulas Patocka wrote:
>>>> Why don't you rip off the support for colliding inode number from the
>>>> kernel at all (i.e. remove iget5_locked)?
>>>>
>>>> It's reasonable to have either no support for colliding ino_t or full
>>>> support for that (including syscalls that userspace can use to work with
>>>> such filesystem) --- but I don't see any point in having half-way support
>>>> in kernel as is right now.
>>>
>>> What would ino_t have to do with inode numbers? It is only used as a
>>> hash table lookup. The inode number is set in the ->getattr() callback.
>>
>> The question is: why does the kernel contain iget5 function that looks up
>> according to callback, if the filesystem cannot have more than 64-bit
>> inode identifier?
>
> Huh? The filesystem can have as large a damned identifier as it likes.
> NFSv4 uses 128-byte filehandles, for instance.

But then it needs some other syscall to let applications determine 
hardlinks --- which was the initial topic in this thread.

> POSIX filesystems are another matter. They can only have 64-bit
> identifiers thanks to the requirement that inode numbers be 64-bit
> unique and permanently stored, however Linux caters for a whole
> truckload of filesystems which will never fit that label: look at all
> those users of iunique(), for one...

I see them. The bad thing is that many programmers read POSIX, write 
programs as if POSIX specification was true and these programs break 
randomly on non-POSIX filesystem. Each non-POSIX filesystem invents st_ino 
on its own, trying to minimize hash collision, making the failure even 
less probable and worse to find.

The current situation is (for example) that cp does stat(), open(), 
fstat() and compares st_ino/st_dev --- if they mismatch, it writes error 
and doesn't copy files --- so if kernel removes the inode from cache 
between stat() and open() and filesystem uses iunique(), cp will fail.

What utilities should the user use on those non-POSIX filesystems, if not 
cp?

Probably some file-handling guidelines should be specified and written to 
Documentation/ as a form of standard that can appliaction programmers use.

Mikulas

> Trond
>
