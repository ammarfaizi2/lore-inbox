Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262597AbTCRV7R>; Tue, 18 Mar 2003 16:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262599AbTCRV7R>; Tue, 18 Mar 2003 16:59:17 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:45715 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S262597AbTCRV7N>; Tue, 18 Mar 2003 16:59:13 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Stephan von Krawczynski <skraw@ithnet.com>
Date: Wed, 19 Mar 2003 09:09:49 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15991.39213.798975.721205@notabene.cse.unsw.edu.au>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: kernel nfsd
In-Reply-To: message from Stephan von Krawczynski on Tuesday March 18
References: <20030318155731.1f60a55a.skraw@ithnet.com>
	<15991.15327.29584.246688@charged.uio.no>
	<20030318164204.03eb683f.skraw@ithnet.com>
X-Mailer: VM 7.11 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday March 18, skraw@ithnet.com wrote:
> On Tue, 18 Mar 2003 16:31:43 +0100
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > >>>>> " " == Stephan von Krawczynski <skraw@ithnet.com> writes:
> > 
> >      > Hello Trond, hello all, can you explain what this means:
> > 
> >      > kernel: nfsd-fh: found a name that I didn't expect: <filename>
> > 
> >      > Should something be done against it, or is it simply
> >      > informative?
> > 
> > The comment in the code just above the printk() reads
> > 
> >                 /* Now that IS odd.  I wonder what it means... */
> > 
> > Looks like you and Neil (and possibly the ReiserFS team) might want to
> > have a chat...
> 
> I'm all for it. Who has a glue? I have in fact tons of these messages, it's a
> pretty large nfs server.

When knfsd gets a request for a filehandle which refers to an object
that isn't in the dcache, it needs to get it into the dcache.  This
involves finding it's name and splicing it in.

It gets hold of an inode for the parent directory (don't worry how)
and reads through that directory looking for a name with the right
inode number.  When it finds the name, it checks to see that the name
isn't already in the dcache under that directory.  As the object with
that name isn't in the dcache you would expect the name not to be
their either.  This message indicates that the name was there.

I think there is enough locking in place so that a race between one
process adding the name and another process looking up the name for an
object should not stumble over each other - both hold i_sem for the
directory.  So I don't think that would be the cause.

Maybe this is reiserfs specific.  Has anyone seen it on a non-reiserfs
filesystem?  Possibly reiserfs does something funny with inode numbers
that is confusing the name lookup.

If it doesn't seem to correlate with other symptoms, I probably
wouldn't worry about it.

2.5 does all this quite differently so shouldn't have the same problem
(it certainly doesn't contain the same error message).

NeilBrown
