Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbTEMSi5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbTEMSi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:38:56 -0400
Received: from hermes.ctd.anl.gov ([130.202.113.27]:23744 "EHLO
	hermes.ctd.anl.gov") by vger.kernel.org with ESMTP id S262483AbTEMSiv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:38:51 -0400
Message-ID: <3EC13E94.C9771D1F@anl.gov>
Date: Tue, 13 May 2003 13:51:00 -0500
From: "Douglas E. Engert" <deengert@anl.gov>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Harkes <jaharkes@cs.cmu.edu>
CC: Linus Torvalds <torvalds@transmeta.com>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor and PAG support
References: <8812.1052841957@warthog.warthog> <Pine.LNX.4.44.0305130929340.1678-100000@home.transmeta.com> <20030513172029.GB25295@delft.aura.cs.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Transfer-Encoding: 7bit
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jan Harkes wrote:
> 
> The local user id is not a 'trusted' identity for a distributed filesystem.
> Any user still have to prove his identity by obtaining tokens.
> 
> If someone obtains my user id on in any way (i.e. weak password/
> bufferoverflow/ root exploit), he should not be allowed to use or access
> my tokens as he hasn't proven his identity. In this case he would either
> still be in his original process authentication group, or a new and
> empty PAG. But definitely not in any of my authentication groups.
> 
> Which is also why joining a PAG should never be allowed.

Joining a PAG can be allowed, if the connecting process can prove its
identify to the owner of the PAG. This does not imply that using a weak password
gets you access to a PAG that was instituted via some more secure 
method. 
In the example I used of Kerberized rsh, the rshd running as root, would
only allow a second connection to join the PAG if the second connection was
also authenticated via  the same Kerberos user.  

> 
> Any arguments about 'it avoids the cost of obtaining credentials' are
> stupid because that cost is exactly what it takes to prove that a new
> session is in fact associated with a specific user. 

No that is not true.  In a Kerberos example, the client needs a service
ticket, to prove its identity to the server, and then it delegates a 
forwardable TGT to the server so the server can act on behalf of the user.
The server can then use the forwarded TGT to obtain additional 
tickets for AFS for example. 

Since each invocation of the server would be placed into its own PAG,
(sort of by definition of a PAG) then each invocation of the server would 
have to get a new AFS token. 

What I am looking for is that the server can verify the identity, of the
client, then use previously forwarded credentials, such as a TGT or AFS token,
so it does not have to get a new token., i.e. it joins the existing PAG.

Note that the ability to join a PAG requires root access to place the new
process in the existing PAG. A user process can not on its own join a PAG.


> If our identity already was proven beyond reasonable doubt,

Maybe to the local system, but not to a third party. 

> we clearly already have our
> 'token' and the additional cost to associate this with the new PAG is
> zero.

I would say the "token" is in the PAG, so the new process would join 
the existing PAG. We may be saying the same thing, just describing 
how PAGs are used. Traditionally a PAG was created for a process and
inherited by its children. I am saying  root processes could add additional
processes to the existing PAG, such as in the rshd example. 
 



> 
> Jan
> 
> _______________________________________________
> OpenAFS-devel mailing list
> OpenAFS-devel@openafs.org
> https://lists.openafs.org/mailman/listinfo/openafs-devel

-- 

 Douglas E. Engert  <DEEngert@anl.gov>
 Argonne National Laboratory
 9700 South Cass Avenue
 Argonne, Illinois  60439 
 (630) 252-5444
