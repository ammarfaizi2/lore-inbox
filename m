Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273269AbRJYNED>; Thu, 25 Oct 2001 09:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273305AbRJYNDx>; Thu, 25 Oct 2001 09:03:53 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:12051 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S273269AbRJYNDe>;
	Thu, 25 Oct 2001 09:03:34 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Mike Castle <dalgoda@ix.netcom.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: modprobe problem with block-major-11 
In-Reply-To: Your message of "Thu, 25 Oct 2001 00:52:03 MST."
             <20011025005202.A24125@thune.mrc-home.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 25 Oct 2001 23:03:56 +1000
Message-ID: <27036.1004015036@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2001 00:52:03 -0700, 
Mike Castle <dalgoda@ix.netcom.com> wrote:
>alias block-major-11 sr_mod          # load sr_mod upon access of scd0
>pre-install sr_mod modprobe ide-scsi # load ide-scsi before sr_mod

* User does 'head /dev/scd0'.
* The kernel runs modprobe block-major-11.  modprobe is running
  setuid(0) because the original user was not root.
* modprobe maps block-major-11 to sr_mod.
* modprobe sees a pre-install command for sr_mod and uses system() to
  invoke the command.
* The system() function issues '/bin/sh -c "command"', sh is linked to
  bash.
* Bash detects that it was invoked as 'sh' and is running setuid.  Bash
  silently turns off the setuid privilege before running the command.
  WRONG!!
* The second command (modprobe ide-scsi) needs root authority but bash
  has removed the authority.  modprobe fails :(

The problem is caused by a bash "feature", it was added in bash 2.01.
I cannot fix it without writing my own replacement for the system()
function.  Doing setuid(0) in modprobe before calling system() would
reopen the security exposure that was closed in modutils 2.3.21, that
is not an option.

Workaround: Replace 
  pre-install foo modprobe bar
with
  before foo bar
That does all the work internally without using the system() function
and falling foul of the bash feature.  It is also faster and it lets
modprobe maintain the chain of modules for unload.

BTW, users can never run rmmod, only root can do that.

