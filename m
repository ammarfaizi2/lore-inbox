Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbUL0VgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUL0VgP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 16:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbUL0VgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 16:36:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2786 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261988AbUL0VgJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 16:36:09 -0500
Date: Mon, 27 Dec 2004 17:04:36 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Brent Casavant <bcasavan@sgi.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: Oops on 2.4.x invalid procfs i_ino value
Message-ID: <20041227190436.GA21575@logos.cnet>
References: <Pine.SGI.4.61.0412171611120.27132@kzerza.americas.sgi.com> <20041218003835.GD771@holomorphy.com> <20041218004703.GE771@holomorphy.com> <Pine.SGI.4.61.0412201624340.46534@kzerza.americas.sgi.com> <20041222154627.GE3088@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041222154627.GE3088@logos.cnet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 01:46:27PM -0200, Marcelo Tosatti wrote:
> On Mon, Dec 20, 2004 at 04:35:18PM -0600, Brent Casavant wrote:
> > On Fri, 17 Dec 2004, William Lee Irwin III wrote:
> > 
> > > On Fri, Dec 17, 2004 at 04:49:44PM -0600, Brent Casavant wrote:
> > > >> On a related note, if it matters, on about half the crash dumps I've
> > > >> looked at, I see a pid of 0 has been assigned to a user process,
> > > >> tripping this same problem.  I suspect there's another bug somewhere
> > > >> that's allowing a pid of 0 to be chosen in the first place -- but I
> > > >> don't totally discount that this problem may lay in SGI's patches to
> > > >> this particular kernel -- I'll need to take a more thorough look.
> > > 
> > > On Fri, Dec 17, 2004 at 04:38:35PM -0800, William Lee Irwin III wrote:
> > > > That's rather ominous. I'll pore over pid.c and see what's going on.
> > > > Also, does the pid.c in your kernel version match 2.6.x-CURRENT?
> > > 
> > > Ouch, 2.4.21; this will be trouble. So next, what patches atop 2.4.21?
> > 
> > I wouldn't worry about the pid=0 issue -- I think it's most likely
> > due to the PAGG patches (http://oss.sgi.com/projects/pagg) causing
> > some sort of problem at process teardown (all the pid=0 processes are
> > in the process of exiting).
> > 
> > I'm more concerned about the (0 == pid & 0xffff) bug, which is present
> > in the unpatched mainline 2.4.x kernel.  It seems that the easiest fix
> > is marking such pids as in-use at pidmap allocation, so that they are
> > never assigned to real tasks.  I've got the code almost done, but need
> > to port it to top-of-tree before submitting a patch.
> 
> Hi Brent,
> 
> Wouldnt it be feasible to have another "procfs inode type" to indicate such 
> lower 16-bit zeroed pid's with a new type PROC_PID_INO_ZERO16BIT (or a better
> name) and have fake_ino() handle these case by then using the upper 16-bits on
> the inode for this "special" pid's.
> 
> And have proc_pid_make_inode() and related code handle this new type? No?
> 
> I'm not a big fan of making such pids unuseable for real tasks, so it would be 
> nice if we could come up a fix for the buggy proc inode logic.

Actually, while talking to wli on IRC:

#define PID_MAX 0x8000

So it shouldnt be a problem at all in mainline v2.4.
