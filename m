Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276591AbRK0RhP>; Tue, 27 Nov 2001 12:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281762AbRK0RhF>; Tue, 27 Nov 2001 12:37:05 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:61700 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S276591AbRK0Rgs>; Tue, 27 Nov 2001 12:36:48 -0500
Message-ID: <3C03CEFB.780622F1@zip.com.au>
Date: Tue, 27 Nov 2001 09:35:55 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kamil Iskra <kamil@science.uva.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problems with APM suspend and ext3
In-Reply-To: <Pine.LNX.4.33.0111270958320.3391-100000@krakow.science.uva.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kamil,

thank you for the clear and convincing problem description.

It's becoming increasingly clear that we need to do something with
ext3 and laptops.

I don't understand what can be causing the behaviour which you
report.  Presumably, some application is generating disk writes,
and kjournald is thus performing disk IO every five seconds.
But I don't know why this should prevent the machine from suspending,
nor why it's different with other filesystems.

If possible, could you please edit fs/jbd/journal.c and change 

      journal->j_commit_interval = (HZ * 5);
to
      journal->j_commit_interval = (HZ * 30);


Thanks.

Kamil Iskra wrote:
> 
> Hi,
> 
> Kernel 2.4.15 has problems with APM suspend if ext3 filesystem is compiled
> into the kernel.
> 
> I noticed the problems on my just acquired Compaq Armada E500 notebook.
> The problem was also there with kernel 2.4.14 + ext3 patch.  BUT I am
> almost sure that it worked fine on my old Compaq Armada 7800 with the same
> 2.4.14 + ext3, so the problem might in some way be influenced by the
> hardware/BIOS/whatever.
> 
> The problem is that, when I press the suspend button on the laptop or when
> I invoke "apm -s", the screen blanks, but the laptop doesn't suspend.
> After a second or two I get an error beep and the screen is back on again.
> In the kernel log I get "User suspend" from "apmd", followed by "kernel:
> apm: suspend: Unable to enter requested state", followed by "Normal
> resume" from "apmd".  "apm -s" returns with "Input/output error" (EIO) in
> this case.  The chance of a successful suspend is non-zero, but rather
> small, I would say less than 10%.  Appending "apm=debug" on the kernel
> commandline doesn't seem to add any useful info.
> 
> I've been starting my system (RedHat 7.2 on i686) in the single user mode,
> starting just syslogd and apmd, but that doesn't help.  Neither does
> changing the filesystem type back to ext2 in /etc/fstab: kjournald is
> still started and the problem still occurs.  What does help is recompiling
> the kernel without ext3: as soon as this happens, I get a 100% success
> rate with suspends, either in single user mode or with all the daemons and
> X running.  Just loading the ext3 into the kernel with "modprobe ext3"
> doesn't seem to negatively affect it in that case, my guess would be that
> that's due to kjournald not being started.
> 
> I tried to locate others with such problems via Google, and with some
> success, although I can't be entirely sure that the reason for their
> problems is the same as mine, of course.  Some examples would be:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=100444185918459&w=2
> http://groups.google.com/groups?hl=en&selm=9t28me%2416i6h0%241%40ID-106838.news.dfncis.de
> http://groups.google.com/groups?q=apm+ext3&hl=en&rnum=1&selm=Pine.LNX.4.30.0111071331010.26250-100000%40fyspc-rp18.uio.no
> 
> So the problem does seem to be known among some, but somehow I couldn't
> find a clear report in the linux-kernel archives about the issue.  Hence
> this email.
> 
> If you reply, please Cc to me, as I'm not on the list.
> 
> Regards,
> 
> --
> Kamil Iskra                 http://www.science.uva.nl/~kamil/
> Section Computational Science, Faculty of Science, Universiteit van Amsterdam
> kamil@science.uva.nl  tel. +31 20 525 75 35  fax. +31 20 525 74 90
> Kruislaan 403  room F.202  1098 SJ Amsterdam  The Netherlands
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
