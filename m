Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269615AbRHCVWT>; Fri, 3 Aug 2001 17:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269619AbRHCVWK>; Fri, 3 Aug 2001 17:22:10 -0400
Received: from egghead.curl.com ([216.230.83.4]:64529 "HELO egghead.curl.com")
	by vger.kernel.org with SMTP id <S269615AbRHCVVw>;
	Fri, 3 Aug 2001 17:21:52 -0400
From: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <01080317471707.01827@starship> <20010803121638.A28194@cs.cmu.edu> <0108031854120A.01827@starship> <Pine.LNX.4.33L.0107301320370.11893-100000@imladris.rielhome.conectiva> <s5gvgkacqlm.fsf@egghead.curl.com> <200107301711.f6UHBWHE001945@acap-dev.nas.cmu.edu> <20010803132457.A30127@cs.cmu.edu>
Date: 03 Aug 2001 17:21:47 -0400
In-Reply-To: <mit.lcs.mail.linux-kernel/20010803132457.A30127@cs.cmu.edu>
Message-ID: <s5g3d78261g.fsf@egghead.curl.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Harkes <jaharkes@cs.cmu.edu> writes:

> Here is the relevant mail,
> 
> On Mon, Jul 30, 2001 at 01:11:32PM -0400, Lawrence Greenfield wrote:
> } BSD softupdates allows you to call fsync() on the file, and this will
> } sync the directories all the way up to the root if necessary.
> } 
> } Thus BSD fsync() actually guarantees that when it returns, the file
> } (and all of it's filenames) will survive a reboot.
> } 
> } Sendmail does:
> } fd = open(tmp)
> } write(fd)
> } fsync(fd)
> } rename(tmp, final)
> } fsync(fd)
> } 
> } Cyrus IMAP does:
> } fd = open(tmp)
> } write(fd)
> } fsync(fd)
> } link(tmp, final1)
> } link(tmp, final2)
> } link(tmp, final3)
> } fsync(fd)
> } close(fd)
> } unlink(tmp)
> } 
> } The idea that Linux fsync() doesn't actually make the file survive
> } reboots is pretty ridiculous.
> 
> As you can see, the 'sync a path leading to the file' semantics from SuS
> don't work in the Cyrus IMAP case as is specifically requires to have
> _all_ paths committed to disk before fsync returns.

To fill in more of the table, Qmail does:

  fd = open(tmp)
  write(fd)
  fsync(fd)
  link(tmp,final)
  close(fd)

...and Postfix does:

  fd = open(final)
  write(fd)
  (should be an "fsync(fd)" here, but I cannot find it)
  fchmod(fd,+execute)
  fsync(fd)
  close(fd)

Postfix apparently uses the execute bit to indicate that delivery is
complete.  I am probably misreading the source (version 20010228
Patchlevel 3), but I do not see any fsync() between the write and the
fchmod.  Surely it is there or this delivery scheme is not reliable on
any system, since without an intervening fsync() the writes to the
data and the permissions can happen out of order.

Anyway, it is certainly true that it is largely useless to have
fsync() commit only one path to a file; many applications expect to be
able to force a simple link(x,y) to be committed to disk.

I know this thread is already much too long, but I am still not sure I
understand the conclusions.  I *think* it is true that:

  1) People disagree about what SuS mandates, but at least a few
     critical developers (e.g., sct) say it definitely does not
     require synchronizing directory entries for fsync().

  2) It would be fairly easy and efficient for fsync() to chase one
     chain of directory entries up to the root, but a lot harder and
     slower to find and commit all of them.

  3) Most (?) core developers, including Linus (?), would not object
     to "dirsync" as a mount option and/or directory attribute, but
     somebody has to rise to the occasion and create the patches.

Is this an accurate summary?

 - Pat
