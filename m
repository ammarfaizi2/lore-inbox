Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWEMM7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWEMM7I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 08:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWEMM7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 08:59:06 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:31757 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932402AbWEMM7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 08:59:04 -0400
Date: Sat, 13 May 2006 14:58:48 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Mark Rosenstand <mark@borkware.net>
Cc: Bernd Petrovitsch <bernd@firmix.at>, linux-kernel@vger.kernel.org
Subject: Re: Executable shell scripts
Message-ID: <20060513125848.GK11191@w.ods.org>
References: <20060513103841.B6683146AF@hunin.borkware.net> <1147517786.3217.0.camel@laptopd505.fenrus.org> <20060513110324.10A38146AF@hunin.borkware.net> <1147519329.3084.20.camel@gimli.at.home> <20060513114509.3A90D146AF@hunin.borkware.net> <1147521363.3084.34.camel@gimli.at.home> <20060513122330.CAA54146AF@hunin.borkware.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060513122330.CAA54146AF@hunin.borkware.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2006 at 02:23:30PM +0200, Mark Rosenstand wrote:
> (Cutting Arjan off the CC list, he's been bugged enough for his attempt
> to help.)
> 
> Bernd Petrovitsch <bernd@firmix.at> wrote:
> > On Sat, 2006-05-13 at 13:45 +0200, Mark Rosenstand wrote:
> > > Bernd Petrovitsch <bernd@firmix.at> wrote:
> > > > On Sat, 2006-05-13 at 13:03 +0200, Mark Rosenstand wrote:
> > > > [...]
> > > > > A more useful case is when you setuid the script (and no, this doesn't
> > > > > need to be running as root and/or executable by all.)
> > > > 
> > > > Apart from the permission bug: This has been purposely disabled since it
> > > > is way to easy to write exploitable shell or other scripts.
> > > > Use a real programming languages, sudo or a trivial wrapper in C ....
> > s/languages/language/
> > 
> > And I forgot to mention that a kernel patch is another possibility.
> 
> I'm too stupid to provide such myself, but I'd sure enable the Kconfig
> option if it was there :)
> 
> > > It isn't a bug on systems that support executable shell scripts.
> > 
> > I never wrote that (or anything which implies that directly).
> 
> I was commenting on the "Apart from the permission bug" part.
> 
> > > Doing security policy based on programming language seems weird at
> > > best, especially when the only user able to make those decisions is the
> > > superuser.
> > 
> > It boils down to "how easy is it for root to shoot in the foot"?
> > And the workarounds are somewhere between trivial and simple.
> 
> Or "dare we handle root a gun, it's a powerful weapon but can be used
> to shoot at feet." It's obvious what the answer have been for that in
> other operating systems, and probably one of the reasons we're here.

Well, at first I thought you did not understand how permissions work. I
apologize for this, but your question was not clear at all. I've checked
on OpenBSD and can confirm that it works. However, it does not exactly
work, it passes /dev/fd/3 to the shell as Neil suggested it. Moreover,
argv[0] gets changed to /dev/fd/3 when the script is not readable, not
very useful :

$ cat > foo
#!/bin/sh
echo \$0=$0 \$1=$1 ...

$ chmod 755 foo
$ ./foo bar
$0=./foo $1=bar ...

$ chmod 111 foo
$ ./foo bar
$0=/dev/fd/3 $1=bar ...

So the very common dirname or ${0%/*} tricks used to get the execution
directory from the running script will not work. Worse, behaviour will
have to be validated both with AND without read permissions since it
works differently in both cases.

At least, feeding the script to stdin and renaming argv[0] to point to
it would have been better.

Regards,
Willy

