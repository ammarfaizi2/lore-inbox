Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289628AbSBJNp6>; Sun, 10 Feb 2002 08:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289653AbSBJNpv>; Sun, 10 Feb 2002 08:45:51 -0500
Received: from pat.uio.no ([129.240.130.16]:19635 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S289628AbSBJNph>;
	Sun, 10 Feb 2002 08:45:37 -0500
From: Terje Malmedal <terje.malmedal@usit.uio.no>
To: Larry McVoy <lm@bitmover.com>
CC: linux-kernel@vger.kernel.org
In-Reply-To: Larry McVoy's message of Sat, 9 Feb 2002 20:28:21 GMT
Subject: Re: pull vs push (was Re: [bk patch] Make cardbus compile in -pre4)
In-Reply-To: <fa.hme158v.ki228f@ifi.uio.no> <fa.h89cnvv.116ski0@ifi.uio.no>
MIME-Version: 1.0
Message-Id: <E16ZuIK-0000VR-00@morgoth>
Date: Sun, 10 Feb 2002 14:45:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Larry McVoy]
> This is my problem.  You could help if you could tell me what exactly 
> are the magic wands to wave such that you can ssh in without typing
> a password.  I know about ssh-agent but that doesn't help for this, 
> I know that in certain cases ssh lets me in without anything.  I thought
> there was some routine where you ssh-ed one way and then the other way
> and it left enough state that it trusted you, does any ssh genuis out 
> there know what I'm talking about?  If I have this, I can set up the
> cron job, I'm sure this is obvious and I'm just overlooking something
> but I can't find it.

When I'm paranoid I do something like this: 

Source host: 
$ ssh-keygen -t dsa -b 2048 -f keyfile -P ""

on the target add a line to ~someuser/.ssh/authorized_keys2: 

from="allowed.hostname",command="/some/command" ssh-dss AA[and the rest of keyfile.pub]

/some/command looks like this: 
#!/bin/sh
if cd /target ; then
:
else
  echo FAILED1
  exit
fi
if cat > filename ; then
:
else
  echo FAILED4
  exit
fi
if [ \! -s filename ] ; then
  echo FAILED2
  exit
fi
prev=".9"
for i in  .8 .7 .6 .5 .4 .3 .2 .1 ""; do
  mv filename$i filename$prev >/dev/null 2>&1
  prev=$i
done
if mv filename.transport filename ; then
  check=`sum -r filename | awk '{print $1}'`
  echo OK$check
  exit
fi
echo FAILED3

The command to send the file is typically: 
#!/bin/sh
check=`sum -r /file/to/send | awk '{print $1}'`
reply=`(cat /file/to/send ; sleep 5 ) | \
   ssh -l someuser -i keyfile target "echo hello there"`
if [ "x$reply" = "xOK$check" ] ; then
  echo Copy OK $check
else
  echo COPY NOT OK. Please do something. 
fi


-- 
 - Terje
malmedal@usit.uio.no
