Return-Path: <linux-kernel-owner+w=401wt.eu-S1422648AbXAERdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422648AbXAERdf (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 12:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbXAERde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 12:33:34 -0500
Received: from mx2.netapp.com ([216.240.18.37]:22725 "EHLO mx2.netapp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422644AbXAERdd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 12:33:33 -0500
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jan 2007 12:33:33 EST
X-IronPort-AV: i="4.12,243,1165219200"; 
   d="scan'208"; a="18103333:sNHT35381822"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [nfsv4] RE: Finding hardlinks
Date: Fri, 5 Jan 2007 12:24:56 -0500
Message-ID: <C98692FD98048C41885E0B0FACD9DFB8023DF912@exnane01.hq.netapp.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [nfsv4] RE: Finding hardlinks
Thread-Index: AccwtLYE4grVIT7GRUan+v1G4ZZsygANKZIA
From: "Noveck, Dave" <Dave.Noveck@netapp.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>,
       "Benny Halevy" <bhalevy@panasas.com>
Cc: "Jan Harkes" <jaharkes@cs.cmu.edu>, "Miklos Szeredi" <miklos@szeredi.hu>,
       <nfsv4@ietf.org>, <linux-kernel@vger.kernel.org>,
       "Mikulas Patocka" <mikulas@artax.karlin.mff.cuni.cz>,
       <linux-fsdevel@vger.kernel.org>,
       "Jeff Layton" <jlayton@poochiereds.net>,
       "Arjan van de Ven" <arjan@infradead.org>
X-OriginalArrivalTime: 05 Jan 2007 17:24:42.0910 (UTC) FILETIME=[634403E0:01C730EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For now, I'm not going to address the controversial issues here,
mainly because I haven't decided how I feel about them yet.

     Whether allowing multiple filehandles per object is a good
     or even reasonably acceptable idea.

     What the fact that RFC3530 talks about implies about what
     clients should do about the issue.

One thing that I hope is not controversial is that the v4.1 spec
should either get rid of this or make it clear and implementable.
I expect plenty of controversy about which of those to choose, but
hope that there isn't any about the proposition that we have to 
choose one of those two.

> SECINFO information is, for instance, given
> out on a per-filehandle basis, does that mean that the server will
have
> different security policies? 

Well yes, RFC3530 does say "The new SECINFO operation will allow the 
client to determine, on a per filehandle basis", but I think that
just has to be considered as an error rather than indicating that if
you have two different filehandles for the same object, they can have 
different security policies.  SECINFO in RFC3530 takes a directory fh
and a name, so if there are multiple filehandles for the object with
that name, there is no way for SECINFO to associate different policies
with different filehandles.  All it has is the name to go by.  I think
this should be corrected to "on a per-object basis" in the new spec no 
matter what we do on other issues.

I think the principle here has to be that if we do allow multiple 
fh's to map to the same object, we require that they designate the 
same object, and thus it is not allowed for the server to act as if 
you have multiple different object with different characteristics.

Similarly as to:

> In some places, people haven't even started
> to think about the consequences: 
>
>     If GETATTR directed to the two filehandles does not return the
>     fileid attribute for both of the handles, then it cannot be
>     determined whether the two objects are the same.  Therefore,
>     operations which depend on that knowledge (e.g., client side data
>     caching) cannot be done reliably.

I think they (and maybe "they" includes me, I haven't checked the
history
here) started to think about them, but went in a bad direction.

The implication here that you can have a different set of attributes
supported for the same object based on which filehandle is used to 
access the attributes is totally bogus.

The definition of supp_attr says "The bit vector which would retrieve
all mandatory and recommended attributes that are supported for this 
object.  The scope of this attribute applies to all objects with a
matching fsid."  So having the same object have different attributes
supported based on the filehandle used or even two objects in the same
fs having different attributes supported, in particular having fileid
supported for one and not the other just isn't valid.

> The fact is that RFC3530 contains masses of rope with which
> to allow server and client vendors to hang themselves. 

If that means simply making poor choices, then OK.  But if there are 
other cases where you feel that the specification of a feature is simply

incoherent and the consequences not really thought out, then I think 
we need to discuss them and not propagate that state of affairs to v4.1.

-----Original Message-----
From: Trond Myklebust [mailto:trond.myklebust@fys.uio.no] 
Sent: Friday, January 05, 2007 5:29 AM
To: Benny Halevy
Cc: Jan Harkes; Miklos Szeredi; nfsv4@ietf.org;
linux-kernel@vger.kernel.org; Mikulas Patocka;
linux-fsdevel@vger.kernel.org; Jeff Layton; Arjan van de Ven
Subject: Re: [nfsv4] RE: Finding hardlinks


On Fri, 2007-01-05 at 10:28 +0200, Benny Halevy wrote:
> Trond Myklebust wrote:
> > Exactly where do you see us violating the close-to-open cache
> > consistency guarantees?
> > 
> 
> I haven't seen that. What I did see is cache inconsistency when
opening
> the same file with different file descriptors when the filehandle
changes.
> My testing shows that at least fsync and close fail with EIO when the
filehandle
> changed while there was dirty data in the cache and that's good.
Still,
> not sharing the cache while the file is opened (even on a different
file
> descriptors by the same process) seems impractical.

Tough. I'm not going to commit to adding support for multiple
filehandles. The fact is that RFC3530 contains masses of rope with which
to allow server and client vendors to hang themselves. The fact that the
protocol claims support for servers that use multiple filehandles per
inode does not mean it is necessarily a good idea. It adds unnecessary
code complexity, it screws with server scalability (extra GETATTR calls
just in order to probe existing filehandles), and it is insufficiently
well documented in the RFC: SECINFO information is, for instance, given
out on a per-filehandle basis, does that mean that the server will have
different security policies? In some places, people haven't even started
to think about the consequences:

      If GETATTR directed to the two filehandles does not return the
      fileid attribute for both of the handles, then it cannot be
      determined whether the two objects are the same.  Therefore,
      operations which depend on that knowledge (e.g., client side data
      caching) cannot be done reliably.

This implies the combination is legal, but offers no indication as to
how you would match OPEN/CLOSE requests via different paths. AFAICS you
would have to do non-cached I/O with no share modes (i.e. NFSv3-style
"special" stateids). There is no way in hell we will ever support
non-cached I/O in NFS other than the special case of O_DIRECT.


...and no, I'm certainly not interested in "fixing" the RFC on this
point in any way other than getting this crap dropped from the spec. I
see no use for it at all.

Trond


_______________________________________________
nfsv4 mailing list
nfsv4@ietf.org
https://www1.ietf.org/mailman/listinfo/nfsv4
