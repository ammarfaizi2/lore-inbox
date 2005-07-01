Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263228AbVGANFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbVGANFV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 09:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbVGANFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 09:05:21 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:63414 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S263228AbVGANFL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 09:05:11 -0400
Date: Fri, 1 Jul 2005 15:05:10 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: frankvm@frankvm.com, akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: FUSE merging?
Message-ID: <20050701130510.GA5805@janus>
References: <E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu> <1120126804.3181.34.camel@laptopd505.fenrus.org> <1120129996.5434.1.camel@imp.csi.cam.ac.uk> <20050630124622.7c041c0b.akpm@osdl.org> <20050630222828.GA32357@janus> <E1DoFTR-0002NH-00@dorka.pomaz.szeredi.hu> <20050701092444.GA4317@janus> <E1DoIjd-0002bM-00@dorka.pomaz.szeredi.hu> <20050701120028.GB5218@janus> <E1DoKko-0002ml-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DoKko-0002ml-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 02:36:22PM +0200, Miklos Szeredi wrote:
> > > You mean suid programs are never to touch paths passed to them?
> > 
> > never when euid==root.
> > The pathname could even point into /proc or anything else yet unknown,
> > e.g. by putting some symlinks at the right places. The mere act of
> > opening the file as root could have unwanted side effects already.
> 
> OK, open is out.  However other operations (stat, unlink, chmod etc)
> are always without side effects on "normal" filesystems.  However on
> FUSE they are very much unsafe (can block, not do what was instructed
> and return success, etc).

What about tricking a setuid program to stat into /auto (/mnt/auto,
/misc, whatever it is called)? then the automounter will act upon a root
request with again possibly unwanted side effects. See how careful a
setuid/full-root program must be in handling userdata including pathnames?

FUSE suddenly makes this more obvious but it is not new.

> > > > -	/proc isn't a problem: most root processes tend to avoid it because
> > > > 	it is synthetic and thus uninteresting. Maybe we should extend
> > > > 	the idea of "synthetic file-systems being uninteresting" to any
> > > > 	process which cannot receive signals from the FUSE mount owner. When
> > > > 	one cannot hide data by a FUSE mount and its synthetic anyway so not
> > > > 	interesting then just show the original empty mount point.
> > > 
> > > Been there.  People (like Al Viro) didn't like it.
> > 
> > including changing the ptraceability test by a signal test and including
> > the (IMHO) required emptyness of the mount stub?
> 
> It's been thrown out for the reason, that it's unacceptable if suid
> programs see a different namespace as non-suid.

You mean root versus non-root. or user versus other user I assume. Because
the euid (fsuid) is what matters.

But then: this _is_ already the case for NFS when squash_root is in effect
(what about kerberos et.al?). So there are several reasons to consider
FUSE a nonlocal fs instead of a local one so nothing new there. FUSE could
be used to implement a usable (not perfect) userspace NFS/ftp client.

To require an empty stub to mount FUSE upon makes the whole picture
cleaner: users are only able to extend the namespace _leaf_ nodes for
themselves and processes they can send signals to: setuid programs
which do not fully become root. The existing namespace [nodes] remains
unchanged for everyone.

-- 
Frank
