Return-Path: <linux-kernel-owner+w=401wt.eu-S933232AbWLaVUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933232AbWLaVUf (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 16:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933234AbWLaVUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 16:20:35 -0500
Received: from gw-e.panasas.com ([65.194.124.178]:36079 "EHLO
	cassoulet.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933232AbWLaVUd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 16:20:33 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Finding hardlinks
Date: Sun, 31 Dec 2006 16:19:15 -0500
Message-ID: <E472128B1EB43941B4E7FB268020C89B149CF0@riverside.int.panasas.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Finding hardlinks
Thread-Index: AccrMc3Qb7nQqpkARPm0ddvyybtkxwB6o9cJ
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz><E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu><20061221185850.GA16807@delft.aura.cs.cmu.edu><Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz><1166869106.3281.587.camel@laptopd505.fenrus.org><Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz><4593890C.8030207@panasas.com> <4593C524.8070209@poochiereds.net><4593DEF8.5020609@panasas.com> <1167387128.6106.32.camel@lade.trondhjem.org>
From: "Halevy, Benny" <bhalevy@panasas.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Cc: "Jeff Layton" <jlayton@poochiereds.net>,
       "Mikulas Patocka" <mikulas@artax.karlin.mff.cuni.cz>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Jan Harkes" <jaharkes@cs.cmu.edu>,
       "Miklos Szeredi" <miklos@szeredi.hu>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, <nfsv4@ietf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
>  
> On Thu, 2006-12-28 at 17:12 +0200, Benny Halevy wrote:
> 
> > As an example, some file systems encode hint information into the filehandle
> > and the hints may change over time, another example is encoding parent
> > information into the filehandle and then handles representing hard links
> > to the same file from different directories will differ.
> 
> Both these examples are bogus. Filehandle information should not change
> over time (except in the special case of NFSv4 "volatile filehandles")
> and they should definitely not encode parent directory information that
> can change over time (think rename()!).
> 
> Cheers
>   Trond
> 

The first one is a real life example.  Hints in the filehandle change
over time.  The old filehandles are valid indefinitely, until the file
is deleted and hence can be considered permanent and not volatile.
What you say above, however, contradicts the NFS protocol as I understand
it. Here's some relevant text from the latest NFSv4.1 draft (the text in
4.2.1 below exists in in a similar form also in NFSv3, rfc1813)

| 4.2.1.  General Properties of a Filehandle
| ...
| If two filehandles from the same server are equal, they MUST refer to
| the same file. Servers SHOULD try to maintain a one-to-one correspondence
| between filehandles and files but this is not required. Clients MUST use
| filehandle comparisons only to improve performance, not for correct behavior
| All clients need to be prepared for situations in which it cannot be
| determined whether two filehandles denote the same object and in such cases,
| avoid making invalid assumptions which might cause incorrect behavior.
| Further discussion of filehandle and attribute comparison in the context of
| data caching is presented in the section "Data Caching and File Identity".
...
| 9.3.4.  Data Caching and File Identity
| ...
|  When clients cache data, the file data needs to be organized according to
| the file system object to which the data belongs. For NFS version 3 clients,
| the typical practice has been to assume for the purpose of caching that
| distinct filehandles represent distinct file system objects. The client then
| has the choice to organize and maintain the data cache on this basis.
|
| In the NFS version 4 protocol, there is now the possibility to have
| significant deviations from a "one filehandle per object" model because a
| filehandle may be constructed on the basis of the object's pathname.
| Therefore, clients need a reliable method to determine if two filehandles
| designate the same file system object. If clients were simply to assume that
| all distinct filehandles denote distinct objects and proceed to do data
| caching on this basis, caching inconsistencies would arise between the
| distinct client side objects which mapped to the same server side object.
|
| By providing a method to differentiate filehandles, the NFS version 4
| protocol alleviates a potential functional regression in comparison with the
| NFS version 3 protocol. Without this method, caching inconsistencies within
| the same client could occur and this has not been present in previous
| versions of the NFS protocol. Note that it is possible to have such
| inconsistencies with applications executing on multiple clients but that is
| not the issue being addressed here.
|
| For the purposes of data caching, the following steps allow an NFS version 4
| client to determine whether two distinct filehandles denote the same server
| side object:
|
|     * If GETATTR directed to two filehandles returns different values of the
|       fsid attribute, then the filehandles represent distinct objects.
|     * If GETATTR for any file with an fsid that matches the fsid of the two
|       filehandles in question returns a unique_handles attribute with a value
|       of TRUE, then the two objects are distinct.
|     * If GETATTR directed to the two filehandles does not return the fileid
|       attribute for both of the handles, then it cannot be determined whether
|       the two objects are the same. Therefore, operations which depend on that
|       knowledge (e.g. client side data caching) cannot be done reliably.
|     * If GETATTR directed to the two filehandles returns different values for
|       the fileid attribute, then they are distinct objects.
|     * Otherwise they are the same object.

Even for NFSv3 (that doesn't have the unique_handles attribute I think
that the linux nfs client can do a better job.  If you'd have a filehandle
cache that points at inodes you could maintain a many to one relationship
from multiple filehandles into one inode.  When you discover a new filehandle
you can look up the inode cache for the same fileid and if one is found you
can do a getattr on the old filehandle (without loss of generality you should 
always use the latest filehandle that was returned for that filesystem object,
although any filehandle that refers to it can be used).
If the getattr succeeded then the filehandles refer to the same fs object and
you can create a new entry in the filehandle cache pointing at that inode.
Otherwise, if getattr says that the old filehandle is stale I think you should
mark the inode as stale and keep it around so that applications can get an
appropriate error until last close, before you clean up the fh cache from the
stale filehandles. A new inode structure should be created for the new filehandle.

Benny
