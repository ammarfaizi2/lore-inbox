Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130970AbRCFP4a>; Tue, 6 Mar 2001 10:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130981AbRCFP4V>; Tue, 6 Mar 2001 10:56:21 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:48985 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S130970AbRCFP4O>; Tue, 6 Mar 2001 10:56:14 -0500
Date: Tue, 6 Mar 2001 09:56:09 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200103061556.JAA94341@tomcat.admin.navo.hpc.mil>
To: schwab@suse.de, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: binfmt_script and ^M
Cc: Paul Flinders <paul@dawa.demon.co.uk>,
        Paul Flinders <P.Flinders@ftel.co.uk>, Jeff Mcadams <jeffm@iglou.com>,
        Rik van Riel <riel@conectiva.com.br>,
        John Kodis <kodis@mail630.gsfc.nasa.gov>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, bug-bash@gnu.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil> writes:
> 
> |> Andreas Schwab <schwab@suse.de>:Andreas Schwab <schwab@suse.de>Andreas Schwab <schwab@suse.de>
> |> > Paul Flinders <paul@dawa.demon.co.uk> writes:
> |> > 
> |> > |> Andreas Schwab wrote:
> |> > |> 
[snip]
> |> > |> It's a difficult one - logically white space should terminate the interpreter
> |> > 
> |> > No, IFS-whitespace delimits arguments in the Bourne shell.
> |> 
> |> IFS can be defined in the environment.
> 
> No, the shell won't import it.

I wasn't directly referring to the bourn shell or bash. The "shell" is whatever
program is specified on the "#!<shellprog>". The arbitrary <shellprog> could
import it, depending on the definition. (IFS=....; export IFS). If <shellprog>
imports it then it could be used, but only after the <shellprog> is running.

By default, IFS is a non-exported environment variable. It can be exported
to other programs if desired, those other programs can be used in
"#!<shellprog>" constructs.

And some systems do import IFS. IRIX bourn shell will import it:

tomcat 54% sh
$ echo "..${IFS}.."
.. 
..
tomcat 54% sh
$ echo "..${IFS}.."	--(default: space, tab and \n")
.. 
..
$ IFS="         ^M" 	--(space, tab and \r)
$ export IFS
$ echo "..${IFS}.."
.. 
$ sh			-- new subshell
$ echo "..${IFS}.."
.. 			-- space, tab and \r.
$ 

The same test on bash shows that it will not import it:

bash-2.04$ bash
bash-2.04$ echo "..${IFS}.."
.. 
..
bash-2.04$ IFS=" ^M"
bash-2.04$ export IFS
bash-2.04$ echo "..${IFS}.."
.. 
bash-2.04$ bash
bash-2.04$ echo "..${IFS}.."
.. 
..
bash-2.04$

The same test done on ash shows that it will import it:

bash-2.04$ ash
$ echo "..${IFS}.."
.. 
..
$ IFS="         ^M"
$ export IFS
$ echo "..${IFS}.."
.. 
$ ash
$ echo "..${IFS}.."
.. 
$ 

The csh shell, on the other hand, doesn't use IFS. It always uses blank or tab
unless they are escaped with \ or are enclosed in quotes.

Personally, I wouldn't want to change the kernel. There is no good way to
determine which error should be given: the script doesn't exist, or the
shell doesn't exist. Either may be nonexistant, and there is only two
possibilities. First do a "ls -l" on the script (must be readable as well
as executable, second do a "ls -l 'line' where line is the first line
of the shell script, minus the "#!". Sometimes it takes a vi/emacs/...
session to look for any funny characters.

The first case is that the shell script doesn't exist. This is reported
by the users command interpreter. The second case is reported by the
kernel. If all that is wanted is to change the format of the message, then
that should be doable - it has to report a different error than "No such
file..." which is the standard error status for this error. Just because the
file that isn't found is the shell program is no reason to change the status -
it really IS "No such file...". There will be some programs that depend
on this status return (menu/window managers come to mind) to issue an
appropriate status.

If the error is "Permission denied", then the equivalent situation exists.
The difference is that the "ls" alone is enough to determine why. (permission
may be denied for the shell program as well as the script).

A case can be made that the shell programs (bash/ash/csh...) do not do a
complete analysis of the exit status. All they appear to do is a "perror".

If the command does exist, then assume it is the shell program that is
missing?? I would implement this by doing a "stat" on the command path (if
it doesn't exist/permission denied/whatever - issue message about the command
path), then do the exec, followed by the return status analysis. Of course
this isn't easy when using execl, which is why it isn't done - perhaps a
change to the exec.. library funtions?

This is a user mode issue and not a kernel issue.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
