Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264972AbRFUODU>; Thu, 21 Jun 2001 10:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264975AbRFUODK>; Thu, 21 Jun 2001 10:03:10 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:41247 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S264974AbRFUODB>; Thu, 21 Jun 2001 10:03:01 -0400
Date: Thu, 21 Jun 2001 09:02:54 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200106211402.JAA78332@tomcat.admin.navo.hpc.mil>
To: landley@webofficenow.com
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
In-Reply-To: <0106201412240B.00776@localhost.localdomain>
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <landley@webofficenow.com>:
> 
> On Wednesday 20 June 2001 17:20, Albert D. Cahalan wrote:
> > Rob Landley writes:
> > > My only real gripe with Linux's threads right now [...] is
> > > that ps and top and such aren't thread aware and don't group them
> > > right.
> > >
> > > I'm told they added some kind of "threadgroup" field to processes
> > > that allows top and ps and such to get the display right.  I haven't
> > > noticed any upgrades, and haven't had time to go hunting myself.
> >
> > There was a "threadgroup" added just before the 2.4 release.
> > Linus said he'd remove it if he didn't get comments on how
> > useful it was, examples of usage, etc. So I figured I'd look at
> > the code that weekend, but the patch was removed before then!
> 
> Can we give him feedback now, asking him to put it back?
> 
> > Submit patches to me, under the LGPL please. The FSF isn't likely
> > to care. What, did you think this was the GNU system or something?
> 
> I've stopped even TRYING to patch bash.  try a for loop calling "echo $$&", 
> eery single process bash forks off has the PARENT'S value for $$, which is 
> REALLY annoying if you spend an afternoon writing code not knowing that and 
> then wonder why the various process's temp file sare stomping each other...

Actually - you have an error there. $$ gets evaluated during the parse, not
during execution of the subprocess. To get what you are describing it is
necessary to "sh -c 'echo $$'" to force the delay of evaluation. The only
"bug" interpretation is in the evaluation of the quotes. IF echo '$$' &
delayed the interpretation of "$$", then when the subprocess shell
"echo $$" reparsed the line the $$ would be substituted as you wanted.
This delay can only be done via the "sh -c ..." method. (its the same with
bourne/korn shell).

> Oh, and anybody who can explain this is welcome to try:
> 
> lines=`ls -l | awk '{print "\""$0"\""}'`
> for i in $lines
> do
>   echo line:$i
> done

That depends on what you are trying to do. Are you trying to echo the
entire "ls -l"? or are you trying to convert an "ls -l" into a single
column based on a field extracted from "ls -l".

If the latter, then the script should be:

ls -l | awk '{print $<fieldno>}' | while read i
do
    echo line: $i
done

If the fields don't matter, but you want each line processed in the
loop do:

ls -l | while read i
do
   echo line:$i
done

Bash doesn't need patching for this.

Again, the evaluation of the quotes is biting you. When the $lines
parameter is evaluated, the quotes are present.

bash is doing a double evaluation for "for" loop. It expects
a list of single tokens, rather than a list of quoted strings. This is
the same as in the bourne/korn shell.

If you want such elaborate handling of strings, I suggest using perl.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
