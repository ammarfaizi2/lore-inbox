Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbTDEIXv (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 03:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbTDEIXv (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 03:23:51 -0500
Received: from mail.hometree.net ([212.34.181.120]:10473 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP id S261952AbTDEIXt (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 03:23:49 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: [2.4] ptrace bugfix breaks strace and keeps processes in STOPPED state (was: Re: How to fix the ptrace flaw without rebooting)
Date: Sat, 5 Apr 2003 08:35:20 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <b6m4g8$rp1$1@tangens.hometree.net>
References: <200304040622_MC3-1-32FC-81F2@compuserve.com> <1049454936.2150.0.camel@dhcp22.swansea.linux.org.uk>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1049531720 28449 212.34.181.4 (5 Apr 2003 08:35:20 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Sat, 5 Apr 2003 08:35:20 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>On Gwe, 2003-04-04 at 12:18, Chuck Ebbert wrote:
>> Erik Hensema wrote:
>> 
>> 
>> > A better fix in a running system is to simply disable dynamic module
>> > loading: echo /no/such/file > /proc/sys/kernel/modprobe
>> 
>> 
>>  You mean like this?
>> 
>>    # echo 'x'>/proc/sys/kernel/modprobe
>>    bash: /proc/sys/kernel/modprobe: No such file or directory

>Thats not a sufficient fix except for people blindly running the
>example exploit

Speaking of the exploit fix: Since I run a kernel which has it
installed, I can no longer strace processes which do run as root but
have a gid sbit set, e.g.

# ls -la /tmp/bash 
-rwxr-sr-x    1 root     smmsp      541096 Apr  5 10:21 /tmp/bash
# id
uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel)
# /tmp/bash
bash-2.05a# echo $$
2625

(in another shell)

# strace -f -p 2625
trace: ptrace(PTRACE_SYSCALL, ...): Operation not permitted
detach: ptrace(PTRACE_DETACH, ...): Operation not permitted

but the shell with the pid of 2625 is now "dead" until one sends it a 
SIGCONT:

# kill -CONT 2625

(other shell now works again)

% uname -an
Linux henning-pc 2.4.18-27.7.x #1 Fri Mar 14 06:44:53 EST 2003 i686 unknown

I'm running the most current strace (4.4.94) because of the STOP/CONT
problems before (RH bugzilla #64303, #75709) but this is new after
installing the exploit fix.

(I found this BTW trying to trace sendmail that's why I have that test
case with setgid to smmsp).

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire
