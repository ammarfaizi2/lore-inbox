Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932686AbWF1Buy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbWF1Buy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 21:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932688AbWF1Buy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 21:50:54 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:16867 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932686AbWF1Bux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 21:50:53 -0400
Subject: Re: [PATCH 00/20] Mount writer count and read-only bind mounts (v3)
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       serue@us.ibm.com
In-Reply-To: <20060627183822.667d9d49.akpm@osdl.org>
References: <20060627221436.77CCB048@localhost.localdomain>
	 <20060627183822.667d9d49.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 18:50:36 -0700
Message-Id: <1151459436.24103.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 18:38 -0700, Andrew Morton wrote:
> On Tue, 27 Jun 2006 15:14:36 -0700
> > One note: the previous patches all worked this way:
> > 
> > 	mount --bind -o ro /source /dest
> > 
> > These patches have changed that behavior.  It now requires two steps:
> > 
> > 	mount --bind /source /dest
> > 	mount -o remount,ro  /dest
> 
> That seems a step backwards.

It is, in a way.  But, it keeps the bind mounting process itself a much
simpler operation in the kernel.  The --bind operation itself stays just
a matter of copying a vfsmount.  Otherwise, you end up trying to manage
a bunch of state transitions if, for instance, the source vfsmount is
r/w and the bind is requested to be r/o.

Plus, the previous behavior was only established by the original
out-of-tree patches from vserver.  Herbert, this doesn't cause you too
much of a headache, right?

> > Since the last revision, the locking in faccessat() and
> > mnt_is_readonly() has been changed to fix a race which might have
> > caused a false-negative mount-is-readonly return when faccessat()
> > is called while another two processes are racing to make a mount
> > readonly.
> > 
> umm, what's it all for?

Mostly for vserver, for now.  They allow a filesystem to be r/w, but
have r/o views into it.  This is really handy so that every vserver can
use a common install but still allow the administrator to update it.

-- Dave

