Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTEMVOv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTEMVOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:14:51 -0400
Received: from hermes.ctd.anl.gov ([130.202.113.27]:7837 "EHLO
	hermes.ctd.anl.gov") by vger.kernel.org with ESMTP id S263354AbTEMVOi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:14:38 -0400
Message-ID: <3EC16316.AE33A6C0@anl.gov>
Date: Tue, 13 May 2003 16:26:46 -0500
From: "Douglas E. Engert" <deengert@anl.gov>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Harkes <jaharkes@cs.cmu.edu>
CC: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor and PAG support
References: <8812.1052841957@warthog.warthog> <Pine.LNX.4.44.0305130929340.1678-100000@home.transmeta.com> <20030513172029.GB25295@delft.aura.cs.cmu.edu> <3EC13E94.C9771D1F@anl.gov> <20030513203344.GC1005@delft.aura.cs.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Transfer-Encoding: 7bit
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jan Harkes wrote:
> 
> On Tue, May 13, 2003 at 01:51:00PM -0500, Douglas E. Engert wrote:
> > Jan Harkes wrote:
> > > The local user id is not a 'trusted' identity for a distributed filesystem.
> > > Any user still have to prove his identity by obtaining tokens.
> ...
> > > Which is also why joining a PAG should never be allowed.
> >
> > Joining a PAG can be allowed, if the connecting process can prove its
> > identify to the owner of the PAG. This does not imply that using a
> > weak password gets you access to a PAG that was instituted via some
> > more secure method.
> > In the example I used of Kerberized rsh, the rshd running as root, would
> > only allow a second connection to join the PAG if the second connection was
> > also authenticated via  the same Kerberos user.
> 
> The kernel doesn't know whether you got into the system using a
> kerberized rsh, ssh, telnet, or by a buffer-overflow.

No, but the sshd, or rshd can look at the credentials and determine if you
are establishing a new connection, and then let this process join the
previous PAG, i.e. share the credentials if appropriate.

> 
> The 'authenticated' user in fact already got his kerberos tokens on the
> system he is logging in from. The kerberized rshd simply adds the token
> used as authentication to the new session, if it is a TGT it can be used
> to obtain AFS and other credentials either from within the daemon or
> through commands in a .login script (using afslog or aklog or something).

True but I am saying that you don't want to have to call aklog to get new
AFS tokens for each connection, but would rather use the existing AFS token
or credentials already present from the previous session. 

When we did this back in 1997 we did this with the DFS PAG as the overhead
of getting a DCE context could be quite large, requiring many tickets
Here are some comments forom the k5dcecon.c program:


/*
 * k5dcecon - Program to convert a K5 TGT to a DCE context,
 * for use with DFS and its PAG.
 * 
 * The program is designed to be called as a sub process, 
 * and return via stdout the name of the cache which implies 
 * the PAG which should be used. This program itself does not 
 * use the cache or PAG itself, so the PAG in the kernel for 
 * this program may not be set. 
 * 
 * The calling program can then use the name of the cache
 * to set the KRB5CCNAME and PAG for its self and its children. 
 *
 * If no ticket was passed, an attemplt to join an existing
 * PAG will be made. 
 * 
 * If a forwarded K5 TGT is passed in, either a new DCE 
 * context will be created, or an existing one will be updated.
 * If the same ticket was already used to create an existing
 * context, it will be joined instead. 
 * 
 * Parts of this program are based on k5dceauth,c which was
 * given to me by HP and by the k5dcelogin.c which I developed. 
 * A slightly different version of k5dcelogin.c, was added to
 * DCE 1.2.2
 * 
 * D. E. Engert 6/17/97 ANL
 */


> 
> > Since each invocation of the server would be placed into its own PAG,
> > (sort of by definition of a PAG) then each invocation of the server would
> > have to get a new AFS token.
> 
> Which actually seems logical to me.
> 
> > What I am looking for is that the server can verify the identity, of the
> > client, then use previously forwarded credentials, such as a TGT or AFS token,
> > so it does not have to get a new token., i.e. it joins the existing PAG.
> 
> You could have the kerberized rshd remember the tokens it obtained
> during a previous login or were forwarded by the client and associate
> them with the new PAG. No need to join an existing PAG.

We maybe saying the same thing. I would say the PAG is where this information is
stored. One may define the PAG as a kernel only concept which is destroyed
when the last process ends, where I am also saying it includes cached credentials
which may persist longer.


> 
> What you propose has completely different behaviour depending on whether
> the user happens to have a secondary permanent connection to the target
> host or not. If there is no permanent session there will be no PAG to
> join and each rsh invocation will have to reauthenticate anyways.

It is possible that the credential can be kept around for some time, 
as was the case with the k5dcecon, so previous credentials could be reused. 
In the case of the DCE, there where three files, one of which was the kerberos
cache. The filenames has the PAG number as part of the file name. 

The DFS cache manager process would assist the kernel in getting additional
tickets and use these files. 

This was not possible with AFS, since the AFS token was only in the kernel,
and would be destroyed when the last process in the PAG finished. 
(To bad, as we have seen problems if a user saves a big file, then logs off,
and the token is destroyed before the cache manager writes the file ac
to the server.) 



> 
> Jan

-- 

 Douglas E. Engert  <DEEngert@anl.gov>
 Argonne National Laboratory
 9700 South Cass Avenue
 Argonne, Illinois  60439 
 (630) 252-5444
