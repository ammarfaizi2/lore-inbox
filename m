Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUESB2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUESB2J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 21:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUESB2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 21:28:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:26085 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263770AbUESB2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 21:28:00 -0400
Date: Tue, 18 May 2004 18:27:53 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andy Lutomirski <luto@stanford.edu>
Cc: Chris Wright <chrisw@osdl.org>, Andy Lutomirski <luto@myrealbox.com>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       olaf+list.linux-kernel@olafdietsche.de, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] scaled-back caps, take 4 (was Re: [PATCH] capabilites, take 2)
Message-ID: <20040518182751.J21045@build.pdx.osdl.net>
References: <fa.dt4cg55.jnqvr5@ifi.uio.no> <40A4F163.6090802@stanford.edu> <20040514110752.U21045@build.pdx.osdl.net> <200405141548.05106.luto@myrealbox.com> <20040517231912.H21045@build.pdx.osdl.net> <40A9D356.6060807@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <40A9D356.6060807@stanford.edu>; from luto@stanford.edu on Tue, May 18, 2004 at 02:11:51AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski (luto@stanford.edu) wrote:
> Chris Wright wrote:
> > Alright, I tried to write up my expectations for all the various modes
> > w.r.t dropping privs, keeping them, setuid apps, etc.  I then wrote some
> > tests to get a baseline, and well as a way to compare results.  Finally
> > I wrote a patch that meets the requirements I laid out, and compared it
> > against yours.  With one minor exception, the capabilities bits match
> > up.  You drop effective caps when a non-root users execs a non-root
> > setuid app, and I the caps alone.  ...
> 
> Paranoia.  There are legacy setuid programs out there (presumably even 
> setuid-nonroot).  Let's make them behave as closely to the way they 
> currently do as possible.

Yes, that's the goal I have.  Although, the above scenario, they've
already been limited (IOW, if nothing's been touched, all behaves the
same).  Starting with limited inheritable (as say uid 500), execute
a non-root, setuid (say uid 99) program, is this expected to change
effective set?  Currently it's a transition for 0 caps to 0 caps, not
very interesting.  Given they are both unprivelged uids, I kept
the (limited) effective.

> > # Still w/out changing inheritable and with KEEPCAPS set
> > # 10 Root process does setuid(!0), effective caps are dropped
> > # 11 Root process does seteuid(!0), effective caps are dropped
> > # 12 Nonroot process restores uid 0, effective restored to permitted
> 
> I still want some variant on KEEPCAPS that causes setxuid to leave caps 
> completely alone.  Oh, well.

Yeah, digs hole deeper though.

> > # 18 Non-root execs setuid-nonroot process, new caps bound by inheritable
> 
> What new caps?

The caps in the newly exec'd process.  IOW, effective aren't dropped,
but as you'd expect inheritable provides limit.

> >>+	/* Pretend we have VFS capabilities */
> >>+	if ((bprm->secflags & BINPRM_SEC_SETUID) && bprm->e_uid == 0)
> >>+		cap_set_full(bprm->cap_permitted);
> >>+	else
> >>+		cap_clear(bprm->cap_permitted);
> >>+
> > 
> > 
> > Thus far we've kept all this stuff out of core.  I believe we should
> > keep it that way.  This could easily be left in bprm_set().
> 
> True.  But as long as linux_binprm has fields for this stuff, intuitively 
> it should always be filled in (i.e. not just in commoncap).  That way we 
> can say that commoncap doesn't get special treatment :)
> 
> Also, this seems like the right place to check for VFS caps.  This way we can.

This does change the current notion of layering.  I see your point though, 
likening it to say reading inode and finding S_ISUID bit.

> >>+ * The rules of Linux capabilities (not POSIX!)
> >>+ *
> >>+ * What the masks mean:
> >>+ *  pP = capabilities that this process has
> >>+ *  pE = capabilities that this process has and are enabled
> >>+ * (so pE <= pP)
> >>+ *
> >>+ * The capability evolution rules are:
> >>+ *
> >>+ *  pP' = ((fP & cap_bset) | pP) & Y
> >>+ *  pE' = (pE | fP) & pP'
> >>+ *
> >>+ *  X = cap_bset
> >>+ *  Y is zero if uid!=0, euid==0, and setuid non-root
> >>+ *
> >>+ *  Exception: if setuid-nonroot, then pE' is reset to 0.
> > 
> > While this works fine, I was interested to see what we could do to
> > leave the old algorithm.  Seems both work out fine.
> > 
> >>+	/* setuid-nonroot is special. */
> >>+	if (is_setuid && bprm->e_uid != 0 && current->uid != 0 &&
> >>+	    current->euid == 0)
> >>+		cap_clear(new_pP);
> > 
> > 
> > setuid-nonroot from a non-root user needs to clear effective?
> 
> Yes.  Say user 500 runs a setuid-root program, which goes back and runs a 
> setuid-500 program.  uid==euid==500 now, so the program expects to be 
> unprivileged.  This makes that work.  (I'm assuming you meant permitted. 
> Effective gets cleared in cap_mask(new_pE, new_pP)).

Yup, I see.  This works in my patch as well.  I'll add this test.  Also
added test to check disabling priv escalation during ptrace of setuid
app.

> The reason I killed the old algorithm is because it's scary (in the sense 
> of being complicated and subtle for no good reason) and because I don't see 
> the point of inheritable caps.  I doubt anything uses them currently on a 
> vanilla kernel because they don't _do_ anything.  So I killed them.

This does break all those caps aware apps (yeah, tongue-in-cheek ;-)
that actually have the idea to widen the effective set, yet limit the
inheriable set.  Seriously, I don't know how much this matters.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
