Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274455AbRITMbn>; Thu, 20 Sep 2001 08:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274456AbRITMbd>; Thu, 20 Sep 2001 08:31:33 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:22778 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S274455AbRITMbS> convert rfc822-to-8bit; Thu, 20 Sep 2001 08:31:18 -0400
Message-ID: <3BA9D8F8.5000801@eorga.com>
Date: Thu, 20 Sep 2001 13:54:32 +0200
From: Dirk =?ISO-8859-1?Q?F=F6rsterling?= <dirk.foersterling@eorga.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en,English/United States [en-US]U) egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: stdin/pipe problem with kernel 2.4.9
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I repost this because you may have been distracted by the date contained
in the old subject line. So far there was no response at all. No hint,
no trick, no RTFM (pointers?) or whatever. So far I wasn't able to find
anything related using google, the kernel docs and the linux-kernel archive.
The SuSE support won't help me with 2.4 and the support database doesn't contain
any (findable) article related to my problem. So I decided to repost my question.



-------- Original Message --------
Subject: stdin problem kernel 2.4.9 (was: Re: Your post from 2000/07/15)
Date: Fri, 14 Sep 2001 13:14:58 +0200
From: Dirk Försterling <dirk.foersterling@eorga.com>
To: linux-kernel@vger.kernel.org
CC: Henrik Størner <henrik@hswn.dk>
In-Reply-To: <3BA1B881.60800@eorga.com> <20010914101230.A10082@hswn.dk>

Henrik Størner wrote:

  > Hi Dick,


It's Dirk (funny, I know, because of the similarity with that knife-like tool..)

------8<--------8<--------8<---------

Desperately crawling the web for people having similar problems iI stumbled into
an article in linux-kernel. I contacted its author in hope of getting some hint
on what's going on on my system. He told me that the problem discussed in that
article was solved before the 2.4.0 release.

  >
  > #From: Linus Torvalds <torvalds@transmeta.com>
  > #Date: Fri, 8 Sep 2000 13:41:46 -0700 (PDT)
  > #Subject: Linux-2.4.0-test8
  > #
  > #Ok, as the truncate problems really seem to be fixed, it's time to do an
  > #official test8, the first development kernel in about a year and a half
  > #that should have a working truncate() again.
  >
  > I don't have the problem with the current (2.4.9) kernels. So
  > I would suggest that you try the linux-kernel@vger.kernel.org

So I do. If anyone has a hint for me, please cc: the answer to me, thanks.

  > mailinglist to see if someone else has any idea what is happening
  > on your system.
  >
  > If you have a way of reproducing the problem, that would of
  > course make things a lot easier!

Well, I really don't know if it has something to do with kernel 2.4, but
I suspect the kernel 2.4 because I don't have the problem with 2.2.x

After investigating my examples any further I can say that the problem
I encountered doesn't affect pipes in general but only stdin which cannot be
read by some processes.

Here are my examples:

1) bash-scripts run through cron.

I used to start some scripts through cron running a remote command using ssh
like this (kernel 2.2.x):

crontab:
0 8 * * * /usr/local/bin/gettime.sh >> /var/log/gettime.log

gettime.sh:
#!/bin/bash
/bin/date -s "`/usr/local/bin/ssh server01 -l timeuser date '+%x\ %X`"

After upgrading to Linux 2.4.x the script failed badly. On server01 it appeared that
there was no ssh connection made. However, I found a workaround by changing the
gettime.sh script. Note the input redirection from /dev/null.

#!/bin/bash
/bin/date -s "`/usr/local/bin/ssh server01 -l timeuser date '+%x\ %X` < /dev/null"


2) Modem connection using mgetty. Intermixes modem commands and console i/o.
A user logs into a shell account on the system using a modem. Everything works fine
with 2.2.x. Switching to kernel 2.4.x, the user gets its output garbled with modem
control chars. Sometimes there are modem command strings appearing on the remote terminal.
I have no solution or workaround for this one so far.

3) "smbprint" invoked by lpd.
The script is configured as an input-filter and gets its input from stdin and hands it over
to smbclient's stdin via pipe. With 2.2.x everything works fine. Using 2.4.x the filter script
doesn't return. I found out that the "bad" guy seems to be smbclient here. I changed the script
not to use a pipe but a temporary file, which now works.

4) A java process (started by a shell script also run by cron like in the first example) fails
to connect the stdin/stdout/stderr of a spawned shell-subproces to redirect properly. Calling
stream.available() on the external input stream causes the following exception:
java.io.IOException: Inappropriate ioctl for device. No solution here also. The < /dev/null
doesn't seem to work here.

About the system(s): All of the systems involved are PCs running SuSE linux 7.2. In addition to
the SuSE-built kernel I tried vanilla 2.4.7 and 2.4.9 on these systems. No matter which kernel I
used, the problems always occur. The 2.2 kernels I used include 2.2.16 and 2.2.19 (both
SuSE-built and straight from kernel.org).

I'm curious if this really is a kernel issue. Maybe this is onyly a misconfiguration of the
kernel. I'm not sure. Maybe this is a SuSE specific problem, but I seem to be the only SuSE
7.2 user having this particular problem.

     -dirk

-- 
:: Dirk Försterling :: Support & Entwicklung
:: eORGA Bernhard Üllenberg
:: Klosterstr. 49 :: c/o com.in.to GmbH :: 40211 Düsseldorf
:: Fon +49.211.3985823 :: Fax +49.211.3985824

