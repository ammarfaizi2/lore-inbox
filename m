Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbUDJTxJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 15:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUDJTxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 15:53:08 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:12548 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261725AbUDJTxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 15:53:03 -0400
Date: Sat, 10 Apr 2004 21:52:56 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andreas Schwab <schwab@suse.de>
Cc: Martin Rode <martin.rode@zeroscale.com>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: cp fails in this symlink case, kernel 2.4.25, reiserfs + ext2
Message-ID: <20040410195256.GA1909@wsdw14.win.tue.nl>
References: <1081359310.1212.537.camel@marge.pf-berlin.de> <1081365374.11164.24.camel@shaggy.austin.ibm.com> <1081410996.3770.1405.camel@marge.pf-berlin.de> <je1xmy3jr5.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <je1xmy3jr5.fsf@sykes.suse.de>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : mailhost.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 11:24:14AM +0200, Andreas Schwab wrote:

> >> > 5) cp fails
> >> > apu:/home/martin/tmp/bug# (cd alpha/beta; cp ../latest/myfile .)
> >> > cp: cannot stat `../latest/myfile': No such file or directory
> >> 
> >> When you cd to alpha/beta, your current directory is really
> >> .../tmp/bug/beta.  Your shell may remember that you got there through
> >> the symlink in alpha, but cp will follow .., which is really bug.
> >
> > Bug in "cp", "bash" or in the kernel fs-layer? 
> 
> Neither.

POSIX is seriously broken here. It is terrible to have a system
where "cd .." does not go to the directory that is listed by "ls ..".

Thus, one should always set -o physical.

(We should have had a command "cd.." to go back to where we came from,
distinct from "cd ..".)

But also bash is broken and violates POSIX:
% pwd
/foo
% mkdir abc
% cd abc
% pwd
/foo/abc
% mv ../abc ../qqq
% /bin/pwd
/foo/qqq
% pwd
/foo/abc
% pwd -L
/foo/abc
% pwd -P
%

We see two bugs: "pwd -P" gives no output at all, and "pwd"
gives the wrong output.

POSIX says:
       -L     If the PWD environment variable contains  an  abso-
              lute  pathname  of  the current directory that does
              not contain the filenames dot or dot-dot, pwd shall
              write  this pathname to standard output. Otherwise,
              the -L option shall behave as the -P option.

So, in the situation where PWD contains /foo/abc but that is
not an absolute pathname of the current directory, the output
must be /foo/qqq and not $PWD.

Andries
