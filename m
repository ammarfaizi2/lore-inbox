Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264551AbUFNWlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264551AbUFNWlQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 18:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264560AbUFNWlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 18:41:15 -0400
Received: from salzburg.nitnet.com.br ([200.157.204.105]:56987 "EHLO
	nat.cesarb.net") by vger.kernel.org with ESMTP id S264551AbUFNWlN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 18:41:13 -0400
Date: Mon, 14 Jun 2004 19:40:06 -0300
To: Alexandre Oliva <aoliva@redhat.com>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] O_NOATIME support
Message-ID: <20040614224006.GD1961@flower.home.cesarb.net>
References: <20040612011129.GD1967@flower.home.cesarb.net> <orpt81sv1g.fsf@free.redhat.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orpt81sv1g.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Mutt/1.5.6+20040523i
From: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 06:12:59PM -0300, Alexandre Oliva wrote:
> On Jun 11, 2004, Cesar Eduardo Barros <cesarb@nitnet.com.br> wrote:
> 
> > int O_NOATIME  	Macro
> >   If this bit is set, read will not update the access time of the file.
> >   See File Times. This is used by programs that do backups, so that
> >   backing a file up does not count as reading it. Only the owner of the
> >   file or the superuser may use this bit.
> 
> IMHO it's a bad idea to enable the owner of the file to avoid changing
> the atime of their files.  I've heard more than once about the atime
> bit being used to as proof that a user had actually seen the contents
> of a file although s/he claimed s/he hadn't.  If it was root-only,
> atime could still be used for the same purpose, and would enable
> backups with tools that accessed the filesystem through the FS layer,
> as opposed to though the block layer, to keep such proof unchanged.

I'm not the one who invented O_NOATIME; it's the GNU people, and so I
wanted to avoid diverging from their description (the text you quoted
above is from the glibc manual).

The semantics of O_NOATIME are the same as using utimes or variants, and
utimes has the same security restriction (only the file owner or the
superuser). The only thing O_NOATIME gains is the absence of a race
condition where another program can read the file without it being noted
in the atime.

I believe the Unix philosophy is that a user can do anything with the
files he owns, with the exception that root can do anything with any
file. This is why various functions (chown, chmod, etc) check if
current->fsuid equals inode->i_uid or CAP_FOWNER is set.

If you want to use the atime as proof of wrongdoing, you probably want a
root-only O_NOATIME to avoid checksummers and backup daemons creating a
race condition due to their restoring of the old atime; however, I fail
to see how can reading a file you own would be wrongdoing. If the file
isn't yours, you can't use O_NOATIME (you get -EPERM). So, a user
ignoring atime updates on his own files is no big deal.

And finally, nothing prevents a user from running his own backup
programs/checksummers/storage managers, which would benefit from
O_NOATIME.

The atime was never intended as an auditing feature (if it were, utimes
and related functions would be root only).

-- 
Cesar Eduardo Barros
cesarb@nitnet.com.br
cesarb@dcc.ufrj.br
