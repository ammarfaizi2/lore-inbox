Return-Path: <linux-kernel-owner+w=401wt.eu-S1754866AbWL1PNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754866AbWL1PNv (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 10:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754865AbWL1PNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 10:13:51 -0500
Received: from gw-e.panasas.com ([65.194.124.178]:54883 "EHLO
	cassoulet.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754862AbWL1PNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 10:13:50 -0500
Message-ID: <4593DEF8.5020609@panasas.com>
Date: Thu, 28 Dec 2006 17:12:56 +0200
From: Benny Halevy <bhalevy@panasas.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Jeff Layton <jlayton@poochiereds.net>
CC: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Arjan van de Ven <arjan@infradead.org>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
Subject: Re: Finding hardlinks
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>  <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>  <20061221185850.GA16807@delft.aura.cs.cmu.edu>  <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz> <1166869106.3281.587.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz> <4593890C.8030207@panasas.com> <4593C524.8070209@poochiereds.net>
In-Reply-To: <4593C524.8070209@poochiereds.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Dec 2006 15:12:43.0585 (UTC) FILETIME=[9FACEB10:01C72A92]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Layton wrote:
> Benny Halevy wrote:
>> It seems like the posix idea of unique <st_dev, st_ino> doesn't
>> hold water for modern file systems and that creates real problems for
>> backup apps which rely on that to detect hard links.
>>
> 
> Why not? Granted, many of the filesystems in the Linux kernel don't enforce that 
> they have unique st_ino values, but I'm working on a set of patches to try and 
> fix that.

That's great and will surely help most file systems (apparently not Coda as
Jan says they use 128 bit internal file identifiers).

What about 32 bit architectures? Is ino_t going to be 64 bit
there too?

> 
>> Adding a vfs call to check for file equivalence seems like a good idea to me.
>> A syscall exposing it to user mode apps can look like what you sketched above,
>> and another variant of it can maybe take two paths and possibly a flags field
>> (for e.g. don't follow symlinks).
>>
>> I'm cross-posting this also to nfsv4@ietf. NFS has exactly the same problem
>> with <fsid, fileid> as fileid is 64 bit wide. Although the nfs client can
>> determine that two filesystem objects are hard linked if they have the same
>> filehandle but there are cases where two distinct filehandles can still refer to
>> the same filesystem object.  Letting the nfs client determine file equivalency
>> based on filehandles will probably satisfy most users but if the exported
>> fs supports the new call discussed above, exporting it over NFS makes a
>> lot of sense to me... What do you guys think about adding such an operation
>> to NFS?
>>
> 
> This sounds like a bug to me. It seems like we should have a one to one 
> correspondence of filehandle -> inode. In what situations would this not be the 
> case?

Well, the NFS protocol allows that [see rfc1813, p. 21: "If two file handles from
the same server are equal, they must refer to the same file, but if they are not
equal, no conclusions can be drawn."]

As an example, some file systems encode hint information into the filehandle
and the hints may change over time, another example is encoding parent
information into the filehandle and then handles representing hard links
to the same file from different directories will differ.

> 
> -- Jeff
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

