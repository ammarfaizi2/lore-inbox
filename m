Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262758AbVDHMCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbVDHMCz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 08:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbVDHMCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 08:02:55 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:54155 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262758AbVDHMCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 08:02:50 -0400
Date: Fri, 8 Apr 2005 14:02:44 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050408120244.GB10129@merlin.emma.line.org>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	Linus Torvalds <torvalds@osdl.org>, Chris Wedgwood <cw@f00f.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408071428.GB3957@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050408071428.GB3957@opteron.random>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli schrieb am 2005-04-08:

> On Thu, Apr 07, 2005 at 09:42:04PM -0700, Linus Torvalds wrote:
> > play with something _really_ nasty (but also very _very_ fast), take a
> > look at kernel.org:/pub/linux/kernel/people/torvalds/.
> 
> Why not to use sql as backend instead of the tree of directories? That solves
> userland journaling too (really one still has to be careful to know the
> read-committed semantics of sql, which is not obvious stuff, but 99% of
> common cases like this one just works safe automatically since all
> inserts/delete/update are always atomic).
> 
> You can keep the design of your db exactly the same and even the command line
> of your script the same, except you won't have deal with the implementation of
> it anymore, and the end result may run even faster with proper btrees and you
> won't have scalability issues if the directory of hashes fills up, and it'll
> get userland journaling, live backups, runtime analyses of your queries with
> genetic algorithms (pgsql 8 seems to have it) etc...
> 
> I seem to recall there's a way to do delayed commits too, so you won't
> be sychronous, but you'll still have journaling. You clearly don't care
> to do synchronous writes, all you care about is that the commit is
> either committed completely or not committed at all (i.e. not an half
> write of the patch that leaves your db corrupt).
> 
> Example:
> 
> CREATE TABLE patches (
> 	patch			BIGSERIAL	PRIMARY KEY,
> 
> 	commiter_name		VARCHAR(32)	NOT NULL CHECK(commiter_name != ''),
> 	commiter_email		VARCHAR(32)	NOT NULL CHECK(commiter_email != ''),

The length is too optimistic and insufficient to import the current BK
stuff.  I'd vote for 64 or at least 48 for each, although 48 is going to
be a tight fit.  It costs a bit but considering the expected payload
size it's irrelevant.

Committer (double t) email is up to 36 characters at the moment and the
name up to 43 characters when analyzing the shortlog script with this
little Perl snippet:

------------------------------------------------------------------------
while (($k, $v) = each %addresses) {
    $lk = length $k;
    $lv = length $v;
    if ($lk > $mk) { $mk = $lk; }
    if ($lv > $mv) { $mv = $lv; }
}
print "max key len $mk, max val len $mv\n";
------------------------------------------------------------------------

which prints: (key is the email, val the name)

max key len 43, max val len 36

-- 
Matthias Andree
