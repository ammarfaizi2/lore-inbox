Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315699AbSECUrX>; Fri, 3 May 2002 16:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315700AbSECUrW>; Fri, 3 May 2002 16:47:22 -0400
Received: from pc132.utati.net ([216.143.22.132]:35486 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S315699AbSECUrW>; Fri, 3 May 2002 16:47:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: vda@port.imtp.ilyichevsk.odessa.ua, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback
Date: Fri, 3 May 2002 10:48:50 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <9595.1020174038@ocs3.intra.ocs.com.au> <200205011416.g41EFnX04718@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020503211039.4F680644@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 May 2002 03:18 pm, Denis Vlasenko wrote:

> The fact that minix,ext[23],etc has inode #s is an *implementation detail*.
> Historically entrenched in Unix.
>
> Bad:
> inum_a = inode_num(file1);
> inum_b = inode_num(file2);
> if(inum_a == inum_b) { same_file(); }
>
> Better:
> if(is_hardlinked(file1,file2) { same_file(); }
>
> Yes, new syscal, blah, blah, blah... Not worth the effort, etc...
> lets start a flamewar...

If I'm backing up a million files off of a big server, I don't want an 
enormous loop checking each and every one of them against each and every 
other one of them via some system call (potentially through the network) to 
go looking for dupes.  I want some kind of index I can hash against on MY 
side of the wire to go "Have I seen this guy before?".

That's EXACTLY what an inode is: a unique index for each file that can be 
compared to see if two directory entries refer to the same actual file.  
(Anything ELSE an inode is is an implementation detail, sure.)

These kind of numeric identifiers show up all over the place.  Process ids, 
user ids, filehandles...  It's not an implementation detail, it's a sane API.

Having them be persistent across reboots is only really needed for network 
exported filesystems (things like "tar" don't care).  In theory, the clients 
could be informed of server reboots and resync when necessary (about like 
samba does).  Of course there's a certain three-letter network server 
(originally from another three letter word) that tries to maintain no state 
whatsoever about its clients, when the entire JOB of a filesystem is 
basically to maintain persistent state...

But we won't go there.  And calculating whatever the heck your unique hash is 
entirely from your persistent data, in a reproducible way, generally isn't 
brain surgery... 

Rob
