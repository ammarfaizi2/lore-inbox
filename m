Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286239AbRLJLwg>; Mon, 10 Dec 2001 06:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286237AbRLJLwa>; Mon, 10 Dec 2001 06:52:30 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:6896 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S286235AbRLJLwW>; Mon, 10 Dec 2001 06:52:22 -0500
Date: Mon, 10 Dec 2001 11:52:09 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Nathan Scott <nathans@sgi.com>
Cc: "Stephen C . Tweedie" <sct@redhat.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [PATCH] Revised extended attributes interface
Message-ID: <20011210115209.C1919@redhat.com>
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <20011207202036.J2274@redhat.com> <20011208155841.A56289@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011208155841.A56289@wobbly.melbourne.sgi.com>; from nathans@sgi.com on Sat, Dec 08, 2001 at 03:58:41PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Dec 08, 2001 at 03:58:41PM +1100, Nathan Scott wrote:
> On Fri, Dec 07, 2001 at 08:20:36PM +0000, Stephen C. Tweedie wrote:
> 
> > This is looking OK as far as EAs go.  However, there is still no
> > mention of ACLs specifically, except an oblique reference to
> > "system.posix_acl_access".  
> 
> Yup - there's little mention of ACLs because they are only an
> optional, higher-level consumer of the API, & so didn't seem
> appropriate to document here.

Unfortunately, if there are many filesystems wanting to use posix
ACLs, then standardising the API is still desirable.

> We have implemented POSIX ACLs above this interface - there
> is source to new versions of Andreas' user tools here:
> http://oss.sgi.com/cgi-bin/cvsweb.cgi/linux-2.4-xfs/cmd/acl2
> These have been tested with XFS and seem to work fine, so we
> are ready to transition over from our old implementation to
> this new one.

But the ACL encoding is still hobbled: there's no namespace for
credentials other than uid/gid.  This has been brought up before, but
it's worth going over some of the things we'd like to be able to do
with extended credentials again:

* NFSv4.  

NFSv4 credentials are of the form "user@realm", and an NFSv4 server
needs to be able to apply ACLs using such credentials so that it can
securely serve users in foreign realms.

* Kerberos single-signon.

I want to be able to get a kerberos login ticket on the desktop in
front of me and access files in my entire organisation securely.  I
want to be able to login to remote systems in different departments
and still have ACLs work.  So "foo@SALES.CO.COM" might login to a
machine in the "DEVEL.CO.COM", and would only get a "guest" uid, but
the ACL system would allow access based on the full "foo@SALES.CO.COM"
credentials.

* Samba.

Is there any reason not to allow an NT SID to be used as the
credential for an ACL?

* Sub-IDs.

There was a beautiful paper presented at a recent Usenix in which the
concept of user-manageable sub-ids was presented.  I am on a secure
intranet, but I'm constantly accessing untrusted data.  Every time
Mozilla accesses a web site I am potentially vulnerable to web
rendering bugs which could allow a site to take over my machine.
Plugins such as flash just make the matter worse.  Even in the home
environment we'd like to make it easy to allow multiuser games to be
run without compromising the whole local system.

The sub-id concept proposes allowing users to create process groups
with restricted rights to the system.  I would _really_ like to give
Mozilla write access to ~/tmp and ~/.mozilla, but not to the rest of
my homedir.  Can't I use a "sct/mozilla" credential for my ACLs?


Authentication is about *much* more than just local uid/gids, but the
current EA/ACL specs are creating an implicit standard for ACLs
without addressing any of these concerns.

> The existence of a POSIX ACL implementation using attributes
> system.posix_acl_access and system.posix_acl_default doesn't
> preclude other types of ACLs from being implemented (obviously
> using different attributes) as well of course, if someone had
> an itch to scratch.

I am not talking about other types of ACLs!  I am talking about
*POSIX* ACLs, but using a credentials namespace which is more than
just uid/gid.  Only the credentials change: the rest of the POSIX
semantics still apply.  The CITI NFSv4 implementation is already doing
POSIX ACLs and GSSAPI krb5 authentication on top of the bestbits API,
so we already have at least one application ready and waiting to use
such an extension.

Cheers,
 Stephen
