Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317412AbSFCQVa>; Mon, 3 Jun 2002 12:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317413AbSFCQV3>; Mon, 3 Jun 2002 12:21:29 -0400
Received: from relay1.pair.com ([209.68.1.20]:60685 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S317412AbSFCQV2>;
	Mon, 3 Jun 2002 12:21:28 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3CFB97D9.3EB46E26@kegel.com>
Date: Mon, 03 Jun 2002 09:22:49 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
CC: linux-kernel@vger.kernel.org,
        "wine-devel@winehq.com" <wine-devel@winehq.com>
Subject: Re: SMB filesystem
In-Reply-To: <3CFB03B3.90353B54@kegel.com> <1023113698.18181.5.camel@testbed.linkvest.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Eric Cuendet wrote:
> > > I'm thinking of implementing an smb filesystem, the way AFS implement 
> > > the AFS client fs kernel driver.
> > > - Mount the smb filesystem on /smb (done at boot time)
> > > - Every user has list dir access on /smb
> > > - There, you see each workgroup/domain available on the network
> > > - Then in each domain, a list of machines
> > > - Then in each machine, a list of shares
> > > - Then a list of files/dirs
> > > Access will be granted using the SMB token (like a kerberos ticket) 
> > > issued by the primary domain controller.
> > > It's the way the windows explorer works. It's cool and useful.
> >
> > Dan Kegel wrote:
> > I've been hoping somebody would take this on.
>
> Why did you hope someone took this one? Do you think it's REALLY needed
> or is there non-solvable problems?

I'm interested in the Wine project, in particular, the kernel module
being developed to speed up execution of win32 programs.
It would really benefit from what you're proposing.
(Wine is currently starting to do its own SMB client stuff,
probably using the same shared library you're proposing to use,
but not in a way that would be usable by the wine kernel
module, I think.  Wine could use your enhanced smbfs, if present,
to allow all file operations to be handled by the wine kernel module.)
	
> > Question: how will you carry the SMB token around?
> > Let's imagine somebody starts a script that runs two programs
> > that access SMB shares, and that they're initially not logged in at
> > all.
> > If this were Windows, it would prompt them once for their username
> > and password, and then allow access from then on. ...
>
> For The user/pwd problem, you are right, user should be prompted for a
> password. This could be achieve in the following way:
> - If no token available: logged in anonymous or Guest
> - The application could ask the daemon if a token is available, then
> prompt the user for it before accessing the files.
> - Make a generic callback way to call an arbitrary process
> - When no token available, return a "NO LOGIN" message, so the
> application should ask the user/password, create the token, or failed.
> 
> I think that 1 or 4 is the best way to do it.

I favor #4, it's the simplest.  When the time comes that
somebody wants closer emulation of windows behavior,
something fancier could be done.

> For the token [itself], it could be a file on the disk:
> /tmp/user.smb.token, like with kerberos

If that's how kerberos does it, that's probably fine.
(In fact, in the future, won't you just use kerberos for
a lot of windows networks?)  But it might be awkward to
access from inside the kernel, so I can imagine you might
want to store it inside your smbfs kernel module instead.

> What about putting that in a ENV VAR?

Nope, environment variables are not global enough.

Some posters have proposed using autofs to do the mounting.
That's a good idea if it saves work and lets you have
the per-user semantics you want.  So all you need to
do is implement an smbfs that uses the user's token
to validate each open/rm/mv, and you're done.  
(Modulo somebody hooking an smb browser into an ldap server, 
but that may already have been done.)
- Dan
