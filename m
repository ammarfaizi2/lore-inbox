Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263785AbSJWLxL>; Wed, 23 Oct 2002 07:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264689AbSJWLxL>; Wed, 23 Oct 2002 07:53:11 -0400
Received: from 80-195-6-171.cable.ubr04.ed.blueyonder.co.uk ([80.195.6.171]:19330
	"EHLO sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S263785AbSJWLxL>; Wed, 23 Oct 2002 07:53:11 -0400
Date: Wed, 23 Oct 2002 12:59:07 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Russell Coker <russell@coker.com.au>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021023125907.G2732@redhat.com>
References: <Pine.GSO.4.21.0210171742050.18575-100000@weyl.math.psu.edu> <200210180014.16512.russell@coker.com.au> <20021023013551.A23214@redhat.com> <200210231343.55811.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210231343.55811.russell@coker.com.au>; from russell@coker.com.au on Wed, Oct 23, 2002 at 01:43:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 23, 2002 at 01:43:55PM +0200, Russell Coker wrote:
> On Wed, 23 Oct 2002 02:35, Stephen C. Tweedie wrote:
> > > "system_u:object_r:var_log_t") then how would I go about doing it other
> > > than through a modified open system call?
> > With a "setesid(2)" syscall to set the effective sid.

> Good idea, however there are two potential problems that I can see.
> 
> When creating a file the UID/GID name space for the file is the same as that 
> for the process.  In SE Linux the name space for files to be created does not 
> intersect the name space of the processes.  This makes it much less clean 
> than setfsuid().

setfsuid() creates credentials which are _only_ applied to file
operations.  The namespace happens to be the same one that applies to
processes, but there's nothing that requires that to be the case, and
if you have a corresponding setfssid() to set the effective set for fs
access, you're explicitly requesting the fs namespace, not the process
one.

> Secondly there is the issue of a lack of atomicity.  Is there a potential for 
> a signal handler to create a file between the setesid() and creat() in the 
> main code?  I guess the API open_secure() could remain the same and block all 
> signals for it's operation...

Definitely.  Application writers will need to be aware of that, just
as they have to be aware of the same for setfsuid today.  But when
you've got signal handlers doing complex work, you've got all sorts of
races opening up, and trying to fix every single one of them by
inventing new syscalls for every single combination of operation that
the app might want to do atomically makes no sense!

--Stephen
