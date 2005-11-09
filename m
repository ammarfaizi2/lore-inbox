Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030381AbVKIT0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbVKIT0P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 14:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbVKIT0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 14:26:14 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:61111 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030361AbVKIT0O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 14:26:14 -0500
Date: Wed, 9 Nov 2005 19:26:07 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ram Pai <linuxram@us.ibm.com>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
Message-ID: <20051109192607.GA7992@ftp.linux.org.uk>
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk> <E1EZUC9-0007oJ-00@dorka.pomaz.szeredi.hu> <1131464926.5400.234.camel@localhost> <E1EZVoO-000807-00@dorka.pomaz.szeredi.hu> <1131561849.5400.384.camel@localhost> <Pine.LNX.4.64.0511091054290.3247@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511091054290.3247@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 10:59:47AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 9 Nov 2005, Ram Pai wrote:
> >
> > And 'umount .' really doen't make sense. What does it mean? umount the 
> > current mount? or umount of the mount that is mounted on this dentry?
> 
> "umount <directory>" _absolutely_ makes sense, whether "directory" is "." 
> or something else. People do it all the time.

With current (and all previous, actually) tree umount . is usually -EBUSY.

The case Mikulas is talking about is much uglier - it's "mount on top
of current directory, then umount .".  _That_ (i.e. when . is overmounted)
happens to work.  And semantics is really, really not well-defined.

Situation with overmounts is nasty - it's *not* just a chain, unfortunately.
I certainly intended it to be such.  However, we can get a *tree* of
overmounts due to side-effects I've missed back then.

We really need it sanitized (and that's what I'm doing right now), but
yes, it *will* cause user-visible changes.  Incidentally, one of those
will be that umount . will work...

The trouble begins since we allow to attach vfsmounts to the *middle* of
overmount chain.  I.e.

mount foo /tmp
cd /tmp
mount bar .
mount baz .

will end up with *two* vfsmounts having root of foo as mountpoint and having
the same mnt_parent.  Which one is seen depends on phase of moon - the only
answer is "whichever is first in mnt_hash chain".  Which is certainly not a
sane answer.  We need explicit rules dealing with effect of overmounts;
anything that seriously relies on details of current behaviour in that sort
of corner cases is very definitely broken.

And "we allow" above should be read as "Al had not thought about that mess
back in 2001" ;-/  Current behaviour in that sort setups is an accident -
as soon as it gets to such forked chains of overmounts sanity exits stage
left.  To be fixed...
