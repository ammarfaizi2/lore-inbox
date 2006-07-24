Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWGXVIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWGXVIt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 17:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWGXVIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 17:08:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7360 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751449AbWGXVIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 17:08:48 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Wolfgang Draxinger <Wolfgang.Draxinger@campus.lmu.de>,
       Bodo Eggert <7eggert@gmx.de>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [RFC][PATCH] procfs: add privacy options
References: <44C50A2B.3040203@lsrfire.ath.cx>
Date: Mon, 24 Jul 2006 15:07:04 -0600
In-Reply-To: <44C50A2B.3040203@lsrfire.ath.cx> (Rene Scharfe's message of
	"Mon, 24 Jul 2006 19:58:03 +0200")
Message-ID: <m18xmiogp3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Roughly a year ago I sent out a few patches intended to give normal
> users a bit of privacy in their parts the /proc filesystem.  The first
> incarnations were described as rootkits, later ones met a bit less
> resistance. :-D  Then I got distracted; the patches never went anywhere.
> Now that Wolfgang Draxinger asked about something like it, I think it's
> time to revive the thing.
>
> So I dusted off the last version and ported it to 2.6.18-rc2.  It's
> inspired by the Openwall kernel option CONFIG_HARDEN_PROC.  The patch
> introduces two kernel boot options, proc.privacy and proc.gid.  They
> can be used to restrict visibility of process details for regular users.
>
> Setting proc.privacy to 2 let's users only enter their own /proc/<pid>
> directories, while a setting of 1 allows them to enter root's process
> dirs, too.  In this way tools like pstree keep working, because all
> parents of a user process up to init (e.g. sshd, getty, init itself)
> keep being visible.  It's a rough heuristic, but I think it makes sense:
> root can alway see you, and in turn you can see root.  If root is shy he
> can set proc.privacy=2; the price is that his users get slightly strange
> results from pstools etc.
>
> proc.gid is the GID of the group that has read and execute access to
> all /proc/<pid> dirs, regardless what the file mode and group ownership
> says.  Unlike in Openwall and in my previous attempts I implemented it
> as a .permission function this time.  That means owner and group
> attributes of /proc/<pid> dirs are not changed; tools like top and ps
> can still gather euid and egid that way.
>
> Normally .permission functions are not the way to implement access
> control in procfs, because the condition on which to grant/deny access
> could change between open and actual access (think setuid).  This is of
> no concern in the case of this patch, because the it unconditionally
> grants some access to the members of one group, independent from /proc
> data or meta-data.
>
> I briefly tested the patch on a Fedora Core 6 test1 system on top of
> a vanilla 2.6.18-rc2 kernel and it seems to work as described here: it
> boots, it restricts, and if I'm in the right group I see every process
> in ps' output again.
>
> Questions, suggestions or even flames are very much welcome.  Did I
> manage to do something stupid in these few lines of code?


I don't really like filesystem magic options as kernel boot time options.
Mount time or runtime options are probably more interesting.

How is it expected that users will use this?

A lot of the privacy you are talking about is provided by the may_ptrace
checks in the more sensitive parts of proc so we may want to extend
that.

Eric

