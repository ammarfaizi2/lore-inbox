Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263235AbTEMUVC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTEMUVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:21:02 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:12185 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S263161AbTEMUU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:20:59 -0400
Date: Tue, 13 May 2003 16:33:45 -0400
To: "Douglas E. Engert" <deengert@anl.gov>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor and PAG support
Message-ID: <20030513203344.GC1005@delft.aura.cs.cmu.edu>
Mail-Followup-To: "Douglas E. Engert" <deengert@anl.gov>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
References: <8812.1052841957@warthog.warthog> <Pine.LNX.4.44.0305130929340.1678-100000@home.transmeta.com> <20030513172029.GB25295@delft.aura.cs.cmu.edu> <3EC13E94.C9771D1F@anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC13E94.C9771D1F@anl.gov>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 01:51:00PM -0500, Douglas E. Engert wrote:
> Jan Harkes wrote:
> > The local user id is not a 'trusted' identity for a distributed filesystem.
> > Any user still have to prove his identity by obtaining tokens.
...
> > Which is also why joining a PAG should never be allowed.
> 
> Joining a PAG can be allowed, if the connecting process can prove its
> identify to the owner of the PAG. This does not imply that using a
> weak password gets you access to a PAG that was instituted via some
> more secure method. 
> In the example I used of Kerberized rsh, the rshd running as root, would
> only allow a second connection to join the PAG if the second connection was
> also authenticated via  the same Kerberos user.  

The kernel doesn't know whether you got into the system using a
kerberized rsh, ssh, telnet, or by a buffer-overflow.

The 'authenticated' user in fact already got his kerberos tokens on the
system he is logging in from. The kerberized rshd simply adds the token
used as authentication to the new session, if it is a TGT it can be used
to obtain AFS and other credentials either from within the daemon or
through commands in a .login script (using afslog or aklog or something).

> Since each invocation of the server would be placed into its own PAG,
> (sort of by definition of a PAG) then each invocation of the server would 
> have to get a new AFS token. 

Which actually seems logical to me.

> What I am looking for is that the server can verify the identity, of the
> client, then use previously forwarded credentials, such as a TGT or AFS token,
> so it does not have to get a new token., i.e. it joins the existing PAG.

You could have the kerberized rshd remember the tokens it obtained
during a previous login or were forwarded by the client and associate
them with the new PAG. No need to join an existing PAG.

What you propose has completely different behaviour depending on whether
the user happens to have a secondary permanent connection to the target
host or not. If there is no permanent session there will be no PAG to
join and each rsh invocation will have to reauthenticate anyways.

Jan

