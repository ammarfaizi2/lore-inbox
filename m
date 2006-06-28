Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932818AbWF1Ow4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932818AbWF1Ow4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932823AbWF1Owz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:52:55 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:5868 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S932817AbWF1Owx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:52:53 -0400
Date: Wed, 28 Jun 2006 16:52:51 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk, serue@us.ibm.com
Subject: Re: [PATCH 00/20] Mount writer count and read-only bind mounts (v3)
Message-ID: <20060628145251.GF5572@MAIL.13thfloor.at>
Mail-Followup-To: Dave Hansen <haveblue@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	viro@ftp.linux.org.uk, serue@us.ibm.com
References: <20060627221436.77CCB048@localhost.localdomain> <20060627183822.667d9d49.akpm@osdl.org> <1151459436.24103.70.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151459436.24103.70.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 06:50:36PM -0700, Dave Hansen wrote:
> On Tue, 2006-06-27 at 18:38 -0700, Andrew Morton wrote:
> > On Tue, 27 Jun 2006 15:14:36 -0700
> > > One note: the previous patches all worked this way:
> > > 
> > > 	mount --bind -o ro /source /dest
> > > 
> > > These patches have changed that behavior.  It now requires two steps:
> > > 
> > > 	mount --bind /source /dest
> > > 	mount -o remount,ro  /dest
> > 
> > That seems a step backwards.
> 
> It is, in a way.  But, it keeps the bind mounting process itself a much
> simpler operation in the kernel.  The --bind operation itself stays just
> a matter of copying a vfsmount.  Otherwise, you end up trying to manage
> a bunch of state transitions if, for instance, the source vfsmount is
> r/w and the bind is requested to be r/o.

the actual issue is that the sys_mount() only allows
to pass 'positive' flags, and not 'negative' ones
(i.e. you can add flags, but you cannot remove flags
on a mount) which makes is somewhat complicated to
handle, especially with rbind mounts which would
replace/apply the given flags to _all_ vfsmounts

IMHO the best solution would be to have a new syscall
sys_mount2(), which passes a flag set to be added
and another one to be removed, but I doubt that will
be accepted ... 

> Plus, the previous behavior was only established by the original
> out-of-tree patches from vserver.  

> Herbert, this doesn't cause you too much of a headache, right?

ah, no, I'm used to "we want A", "here is A", "no
we actually want B", "okay here is B", "no, no, you
got it wrong, make it C", "hrmp, okay here is C",
"sorry C is not acceptable, maybe A would be a good
alternative?" :)

> > > Since the last revision, the locking in faccessat() and
> > > mnt_is_readonly() has been changed to fix a race which might have
> > > caused a false-negative mount-is-readonly return when faccessat()
> > > is called while another two processes are racing to make a mount
> > > readonly.
> > > 
> > umm, what's it all for?
> 
> Mostly for vserver, for now.  They allow a filesystem to be r/w, but
> have r/o views into it.  This is really handy so that every vserver can
> use a common install but still allow the administrator to update it.

although it is used in Linux-VServer and similar
setups on a regular basis, many folks not using that
consider it useful too, here are a few scenarios:

 - you want to enhance security by making certain
   parts of your filesystem read-only e.g.
   /etc /usr /sbin ... but you do not want to have
   separate filesystems for that

 - you have certain areas e.g. /var/spool/mail
   where you do not want atime to be recorded, but
   you do not want to disable it for the entire
   filesystem

 - you want to share a directory with other users
   in a read only manner (but you ahve to feed the
   data into that dir (somehow)

HTC,
Herbert

> -- Dave
