Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287697AbSAFEOx>; Sat, 5 Jan 2002 23:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287701AbSAFEOn>; Sat, 5 Jan 2002 23:14:43 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:47627 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S287697AbSAFEOd>;
	Sat, 5 Jan 2002 23:14:33 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15415.52749.90870.849084@argo.ozlabs.ibm.com>
Date: Sun, 6 Jan 2002 15:09:49 +1100 (EST)
To: "Joseph S. Myers" <jsm28@cam.ac.uk>
Cc: <jkl@miacid.net>, Florian Weimer <fw@deneb.enyo.de>, <dewar@gnat.com>,
        <Dautrevaux@microprocess.com>, <Franz.Sirl-kernel@lauterbach.com>,
        <benh@kernel.crashing.org>, <gcc@gcc.gnu.org>, <jtv@xs4all.nl>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.linuxppc.org>,
        <minyard@acm.org>, <rth@redhat.com>, <trini@kernel.crashing.org>,
        <velco@fadata.bg>
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <Pine.LNX.4.33.0201051929080.485-100000@kern.srcf.societies.cam.ac.uk>
In-Reply-To: <Pine.BSI.4.10.10201051111100.8542-100000@hevanet.com>
	<Pine.LNX.4.33.0201051929080.485-100000@kern.srcf.societies.cam.ac.uk>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph S. Myers writes:

> Just because you've created a pointer P, and it compares bitwise equal to
> a valid pointer Q you can use to access an object, does not mean that P
> can be used to access that object.  Look at DR#260, discussing the

I looked at this, and it starts out with an example that includes a
statement free(p); (where p was assigned a value returned from malloc)
and then states that "After the call to free the value of p is
indeterminate."!

This seems absolutely and completely bogus to me.  Certainly, after
the free, the value of *p is indeterminate, but the value of p itself
*is* determinate; its value after the free is identical to its value
before the free.  Why do they say that the value of p itself is
indeterminate after the free?

The two examples of why a compiler might want to change the value are
also bogus; the compiler can avoid writing the value of p from a
register back to memory only if the value is dead, and it isn't in the
example given.  As for the debugging opportunity, if I want p to be
set to NULL or some other pattern for debugging I'll do it explicitly.

In general I think that when a pointer value has been obtained by a
cast to an integer or by passing the address of a pointer to a
function, the compiler should assume that the pointer can point
anywhere.  That means reduced opportunities for optimization, but so
be it.  Note that all of the examples in DR#260 involve passing &p to
some function.

Paul.
