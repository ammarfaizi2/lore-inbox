Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263534AbTEMV2M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbTEMV2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:28:12 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:30873 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S263490AbTEMV2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:28:07 -0400
Date: Tue, 13 May 2003 17:40:53 -0400
To: "Douglas E. Engert" <deengert@anl.gov>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor and PAG support
Message-ID: <20030513214053.GA8745@delft.aura.cs.cmu.edu>
Mail-Followup-To: "Douglas E. Engert" <deengert@anl.gov>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
References: <8812.1052841957@warthog.warthog> <Pine.LNX.4.44.0305130929340.1678-100000@home.transmeta.com> <20030513172029.GB25295@delft.aura.cs.cmu.edu> <3EC13E94.C9771D1F@anl.gov> <20030513203344.GC1005@delft.aura.cs.cmu.edu> <3EC16316.AE33A6C0@anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC16316.AE33A6C0@anl.gov>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 04:26:46PM -0500, Douglas E. Engert wrote:
> Jan Harkes wrote:
> > The kernel doesn't know whether you got into the system using a
> > kerberized rsh, ssh, telnet, or by a buffer-overflow.
> 
> No, but the sshd, or rshd can look at the credentials and determine if you
> are establishing a new connection, and then let this process join the
> previous PAG, i.e. share the credentials if appropriate.

PAG != tokens.

PAG is a simple unique session identifier. AFS, Coda and DCE/DFS happen
associate credentials with a session.

But there is no reason why multiple PAG's can't map to the same set of
credentials. You still don't 'join' a PAG, it is up to some filesystem
specific policy how PAGs are mapped to credentials.

> > You could have the kerberized rshd remember the tokens it obtained
> > during a previous login or were forwarded by the client and associate
> > them with the new PAG. No need to join an existing PAG.
> 
> We maybe saying the same thing. I would say the PAG is where this
> information is stored. One may define the PAG as a kernel only concept
> which is destroyed when the last process ends, where I am also saying
> it includes cached credentials which may persist longer.

I think we are saying the same thing. But abstract at a different level.

Yes, a new session could use the same credentials as an existing
session. But it is still a new session.

> > What you propose has completely different behaviour depending on whether
> > the user happens to have a secondary permanent connection to the target
> > host or not. If there is no permanent session there will be no PAG to
> > join and each rsh invocation will have to reauthenticate anyways.
> 
> It is possible that the credential can be kept around for some time, 
> as was the case with the k5dcecon, so previous credentials could be reused. 
> In the case of the DCE, there where three files, one of which was the kerberos
> cache. The filenames has the PAG number as part of the file name. 

How long should the credentials be kept around? The kernel doesn't know
the difference between a Kerberos ticket, an AFS or Coda token, or a DCE
security context. In my case only the Coda servers can reliably tell us
whether the token is valid at all.

> This was not possible with AFS, since the AFS token was only in the kernel,
> and would be destroyed when the last process in the PAG finished. 
> (To bad, as we have seen problems if a user saves a big file, then logs off,
> and the token is destroyed before the cache manager writes the file ac
> to the server.) 

That seems to be more an implementation issue, the token (or actually
PAG) has to be associated with the open file handle. Logging out doesn't
matter, except if the user explicitly flushes all tokens associated with
his PAG.

Jan
