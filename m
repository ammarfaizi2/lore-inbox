Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266825AbUBRAMu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266544AbUBRAJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:09:50 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:61889 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S266721AbUBRAGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:06:12 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: tridge@samba.org
Date: Wed, 18 Feb 2004 11:06:03 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16434.44139.524682.438028@notabene.cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: message from tridge@samba.org on Wednesday February 18
References: <16433.38038.881005.468116@samba.org>
	<Pine.LNX.4.58.0402162034280.30742@home.osdl.org>
	<16433.47753.192288.493315@samba.org>
	<16433.53708.264048.307137@notabene.cse.unsw.edu.au>
	<16434.39473.822318.998268@samba.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday February 18, tridge@samba.org wrote:
> 
> Samba (and any other system that wants case-insensitive semantics on
> Linux) can't make do with "oh, it probably doesn't exist". That way
> leads to data loss. You have to know with 100% certainty that the file
> doesn't exist in any case combination.
> 
> Unfortunately, that is also the hardest thing to do.

Hi Tridge,

Maybe if it is so hard, we should just define it to be easy.... just
change the universe a bit.....

I'm, sure you've thought about this a lot more that I have or will, so
I must be missing something, but there seems to be a solution that is
efficient, predictable, and should we acceptable.

The first observation is that POSIX applications and WIN32 application
cannot both get exactly the file system, semantics they expect in the
same directory. The example:
    POSIX:
       create "Makefile"
       create "makefile"
    WIN32:
       unlink "MakeFile"
seems to show that.

So decide up front that a WIN32 application will see something
different, and decide what the best thing for it to see would be
(i.e. change the universe).

First cut:
   An application that wants case-insensitive filenames only
   sees those filenames that are in a case-insensitive-canonical-form.
   So the interface maps all file names in requests to a canonical
   form, and the readdir equivalent discards all non-canonical names. 

   Thus in the above example, the WIN32 app would unlink "makefile"
   and never notice that "Makefile" exists.

   This has (to me) two problems.
    1/ case gets lost, so if I save "My File", I will find "my file"
    has been created (unless the application pretty-cases things, in
    which case I can expect case to change anyway).

    2/ Files created by posix apps might be invisible.


    To answer 2/, I'd say "tough".  If you want posix files to be
    visible to WIN32 apps, choose appropriate names.  However I would
    allow there to be a process, either once-off or periodic, which
    creates symlinks from canonical names to non-canocial filenames.
    This would allow you to access pre-existing files where there was
    no ambiguity.

    To answer 1/ I would suggest a second cut at the problem...

Second cut:
    As above, but readdir tries to be clever.  If it sees two (or
    more) names which have the same canonical form, it chooses just
    one of them (predictably), prefering a non-canonical name which is
    a symlink to the canonical name.

    Then when creating an a object, you create it with the canonical
    name and (if that succeeds) subsequently create a symlink from the
    requested name to the canonical name (if that is possible, don't
    worry if it isn't).


Given this approach:

  If only case-insensitive apps use a linux filesystem, they will see
  exactly the semantics they expect, with minimal performance impact.

  If case-sensitive and case-insensitive apps use a linux filesystem,
  they will each see a consistent view and though they may not see the
  same view, there will be well-defined mechanisms which can work at a
  user-space level to resolve or highlight any issues.


The biggest cost I see with this is with large directories.  The
"readdir" equivalent would need to read the whole directory before it
could reliably return any of it.
However  dropping the "guarantee to preserve case" semantic on really
large directories probably isn't an enormous cost (and could be
configurable).

NeilBrown
