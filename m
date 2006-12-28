Return-Path: <linux-kernel-owner+w=401wt.eu-S932827AbWL1KDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932827AbWL1KDz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932875AbWL1KDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:03:55 -0500
Received: from gw-e.panasas.com ([65.194.124.178]:48790 "EHLO
	cassoulet.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932827AbWL1KDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:03:54 -0500
X-Greylist: delayed 3402 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Dec 2006 05:03:54 EST
Message-ID: <4593890C.8030207@panasas.com>
Date: Thu, 28 Dec 2006 11:06:20 +0200
From: Benny Halevy <bhalevy@panasas.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
CC: Arjan van de Ven <arjan@infradead.org>, Jan Harkes <jaharkes@cs.cmu.edu>,
       Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, nfsv4@ietf.org
Subject: Re: Finding hardlinks
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>  <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>  <20061221185850.GA16807@delft.aura.cs.cmu.edu>  <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz> <1166869106.3281.587.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Dec 2006 09:06:03.0319 (UTC) FILETIME=[667EBC70:01C72A5F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka wrote:
>>> If user (or script) doesn't specify that flag, it doesn't help. I think
>>> the best solution for these filesystems would be either to add new syscall
>>>  	int is_hardlink(char *filename1, char *filename2)
>>> (but I know adding syscall bloat may be objectionable)
>> it's also the wrong api; the filenames may have been changed under you
>> just as you return from this call, so it really is a
>> "was_hardlink_at_some_point()" as you specify it.
>> If you make it work on fd's.. it has a chance at least.
> 
> Yes, but it doesn't matter --- if the tree changes under "cp -a" command, 
> no one guarantees you what you get.
>  	int fis_hardlink(int handle1, int handle 2);
> Is another possibility but it can't detect hardlinked symlinks.

It seems like the posix idea of unique <st_dev, st_ino> doesn't
hold water for modern file systems and that creates real problems for
backup apps which rely on that to detect hard links.

Adding a vfs call to check for file equivalence seems like a good idea to me.
A syscall exposing it to user mode apps can look like what you sketched above,
and another variant of it can maybe take two paths and possibly a flags field
(for e.g. don't follow symlinks).

I'm cross-posting this also to nfsv4@ietf. NFS has exactly the same problem
with <fsid, fileid> as fileid is 64 bit wide. Although the nfs client can
determine that two filesystem objects are hard linked if they have the same
filehandle but there are cases where two distinct filehandles can still refer to
the same filesystem object.  Letting the nfs client determine file equivalency
based on filehandles will probably satisfy most users but if the exported
fs supports the new call discussed above, exporting it over NFS makes a
lot of sense to me... What do you guys think about adding such an operation
to NFS?

Benny

> 
> Mikulas
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

