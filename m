Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269768AbRHDDNg>; Fri, 3 Aug 2001 23:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269769AbRHDDN1>; Fri, 3 Aug 2001 23:13:27 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:6 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269768AbRHDDNO>; Fri, 3 Aug 2001 23:13:14 -0400
Date: Sat, 4 Aug 2001 05:13:20 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010804051320.B16516@emma1.emma.line.org>
Mail-Followup-To: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <01080317471707.01827@starship> <20010803121638.A28194@cs.cmu.edu> <0108031854120A.01827@starship> <Pine.LNX.4.33L.0107301320370.11893-100000@imladris.rielhome.conectiva> <s5gvgkacqlm.fsf@egghead.curl.com> <200107301711.f6UHBWHE001945@acap-dev.nas.cmu.edu> <20010803132457.A30127@cs.cmu.edu> <s5g3d78261g.fsf@egghead.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <s5g3d78261g.fsf@egghead.curl.com>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Aug 2001, Patrick J. LoPresti wrote:

> To fill in more of the table, Qmail does:
> 
>   fd = open(tmp)
>   write(fd)
>   fsync(fd)
>   link(tmp,final)
>   close(fd)

http://cr.yp.to/qmail/faq/reliability.html

> ...and Postfix does:
> 
>   fd = open(final)
>   write(fd)
>   (should be an "fsync(fd)" here, but I cannot find it)
>   fchmod(fd,+execute)
>   fsync(fd)
>   close(fd)

> Postfix apparently uses the execute bit to indicate that delivery is
> complete.  I am probably misreading the source (version 20010228
> Patchlevel 3), but I do not see any fsync() between the write and the
> fchmod.  Surely it is there or this delivery scheme is not reliable on
> any system, since without an intervening fsync() the writes to the
> data and the permissions can happen out of order.

Not really. The error code if fsync() or close failed are propagated
back to the caller who then decides what to do. smtpd.c nukes the file.
postdrop.c/sendmail.c do not, but the pickup daemon will see that the
file had problems on sync and discard it.

I'm asking Wietse off-list how reliable this approach is and will report
back privately. It should be fairly reliable.

> Anyway, it is certainly true that it is largely useless to have
> fsync() commit only one path to a file; many applications expect to be
> able to force a simple link(x,y) to be committed to disk.

BSD FFS + softupdates sync all file names, traversing from the mount
point down to the actual directory entries that need to be synched.

>   1) People disagree about what SuS mandates, but at least a few
>      critical developers (e.g., sct) say it definitely does not
>      require synchronizing directory entries for fsync().
> 
>   2) It would be fairly easy and efficient for fsync() to chase one
>      chain of directory entries up to the root, but a lot harder and
>      slower to find and commit all of them.

For BSD FFS + softupdates, this is already done.

>   3) Most (?) core developers, including Linus (?), would not object
>      to "dirsync" as a mount option and/or directory attribute, but
>      somebody has to rise to the occasion and create the patches.
> 
> Is this an accurate summary?

It looks so to me. After the MTA behaviour has been dug up, the dirsync
option could be even weaker if fsync() behaved like FFS + softupdates:
sync the directory entries, including those of link and rename, as well.

The only things to consider would be unlink and symlink. symlinks are
tough since you cannot open() them. Not sure about unlink, looks as if
there's really no way apart from fsync(2)ing the directory or sync(2)ing
the world for these two unless there's a dirsync option coming up.

-- 
Matthias Andree
