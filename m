Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263594AbTEMWCW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbTEMWCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:02:20 -0400
Received: from hermes.ctd.anl.gov ([130.202.113.27]:31922 "EHLO
	hermes.ctd.anl.gov") by vger.kernel.org with ESMTP id S263594AbTEMWCL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:02:11 -0400
Message-ID: <3EC16E3D.B3EB7410@anl.gov>
Date: Tue, 13 May 2003 17:14:21 -0500
From: "Douglas E. Engert" <deengert@anl.gov>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Harkes <jaharkes@cs.cmu.edu>
CC: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor and PAG support
References: <8812.1052841957@warthog.warthog> <Pine.LNX.4.44.0305130929340.1678-100000@home.transmeta.com> <20030513172029.GB25295@delft.aura.cs.cmu.edu> <3EC13E94.C9771D1F@anl.gov> <20030513203344.GC1005@delft.aura.cs.cmu.edu> <3EC16316.AE33A6C0@anl.gov> <20030513214053.GA8745@delft.aura.cs.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Transfer-Encoding: 7bit
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jan Harkes wrote:
> 
> On Tue, May 13, 2003 at 04:26:46PM -0500, Douglas E. Engert wrote:
> > Jan Harkes wrote:
> > > The kernel doesn't know whether you got into the system using a
> > > kerberized rsh, ssh, telnet, or by a buffer-overflow.
> >
> > No, but the sshd, or rshd can look at the credentials and determine if you
> > are establishing a new connection, and then let this process join the
> > previous PAG, i.e. share the credentials if appropriate.
> 
> PAG != tokens.
> 
> PAG is a simple unique session identifier. AFS, Coda and DCE/DFS happen
> associate credentials with a session.
> 
> But there is no reason why multiple PAG's can't map to the same set of
> credentials. 

True. But traditionally with AFS or DCE at lest they have not. Each had its
own set of credentials, and the PAG was only defined to allow the credentials
to be shared. 
 
> You still don't 'join' a PAG, it is up to some filesystem
> specific policy how PAGs are mapped to credentials.

Not sure what you mean here, isn't it the other way around,
the file system uses the credentials, which happen to belong to a PAG.
In the past the credentials only belonged to one PAG, so "joining" was 
a way to use the same credentials. 

>
> > > You could have the kerberized rshd remember the tokens it obtained
> > > during a previous login or were forwarded by the client and associate
> > > them with the new PAG. No need to join an existing PAG.
> >
> > We maybe saying the same thing. I would say the PAG is where this
> > information is stored. One may define the PAG as a kernel only concept
> > which is destroyed when the last process ends, where I am also saying
> > it includes cached credentials which may persist longer.
> 
> I think we are saying the same thing. But abstract at a different level.

Yes I agree. 

> 
> Yes, a new session could use the same credentials as an existing
> session. But it is still a new session.
> 
> > > What you propose has completely different behaviour depending on whether
> > > the user happens to have a secondary permanent connection to the target
> > > host or not. If there is no permanent session there will be no PAG to
> > > join and each rsh invocation will have to reauthenticate anyways.
> >
> > It is possible that the credential can be kept around for some time,
> > as was the case with the k5dcecon, so previous credentials could be reused.
> > In the case of the DCE, there where three files, one of which was the kerberos
> > cache. The filenames has the PAG number as part of the file name.
> 
> How long should the credentials be kept around? The kernel doesn't know
> the difference between a Kerberos ticket, an AFS or Coda token, or a DCE
> security context. In my case only the Coda servers can reliably tell us
> whether the token is valid at all.

How long? Not sure.

It comes down to what is a "session"  A user may say "I will be 
contacting this system for the next four hour, so hold on to any credentials
I send you now, even though I don't have an open connection or an active process."
A user could do something similiar with a sshd and port forwarding, or a VPN,
to keep a session running but they should not have to resort to these
methods if possible. 


> 
> > This was not possible with AFS, since the AFS token was only in the kernel,
> > and would be destroyed when the last process in the PAG finished.
> > (To bad, as we have seen problems if a user saves a big file, then logs off,
> > and the token is destroyed before the cache manager writes the file ac
> > to the server.)
> 
> That seems to be more an implementation issue, the token (or actually
> PAG) has to be associated with the open file handle. Logging out doesn't
> matter, except if the user explicitly flushes all tokens associated with
> his PAG.

Yes its an implementation issue. 

> 
> Jan

-- 

 Douglas E. Engert  <DEEngert@anl.gov>
 Argonne National Laboratory
 9700 South Cass Avenue
 Argonne, Illinois  60439 
 (630) 252-5444
