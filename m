Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291401AbSDEA2K>; Thu, 4 Apr 2002 19:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292229AbSDEA2A>; Thu, 4 Apr 2002 19:28:00 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:48388 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S291401AbSDEA1z>; Thu, 4 Apr 2002 19:27:55 -0500
Message-ID: <3CACEF18.CE742314@zip.com.au>
Date: Thu, 04 Apr 2002 16:26:00 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: joeja@mindspring.com
CC: linux-kernel@vger.kernel.org
Subject: Re: faster boots?
In-Reply-To: <Springmail.0994.1017964447.0.72656900@webmail.atl.earthlink.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

joeja@mindspring.com wrote:
> 
> Hello,
>     Is there some way of making the linux kernel boot faster?
> 

Joe, you're speaking to a bunch of people who reboot their
boxes ten times an hour or more.  It's an interesting topic.

- If your BIOS has an option to not call the bios functions
  of add-in cards, try using it.  Every card seems to have
  its own inbuilt ten-second keyboard timeout, and this
  option trumps them all.

- Remove as many of those nice vendor-provided initscripts
  as you can.  It sounds like you're running kudzu or
  equivalent?  `rpm -e' or `chkconfig kudzu off'.

- Modify /etc/init.d/rd.c/xinted so that it starts xinetd
  asynchronously.  For some reason, xinetd has a nice
  five-second sleep before allowing the initscripts to
  continue.  I haven't noticed it do anything useful.

- If you're using SCSI, (aic7xxx), go into the kernel
  config system and reduce its "initial bus reset delay
  in milli-seconds".  I use 1500.

If you want to get really radical you could investigate
Richard Gooch's boot scripts which I believe allow all the
initscripts to be launched in parallel.  Which is a good
thing to do.

	http://www.atnf.csiro.au/people/rgooch/linux/boot-scripts/

Once everything is trimmed up and tightened down, you should
have reasonably good boot times.  There isn't a lot more
to be squeezed out of it.

Last year I developed a bunch of code which was designed to
speed up the boot process.  It works as follows:

1: Boot the machine, start your X server or whatever you
   normally do.  Wait for everything to settle down.

2: Load a kernel module and run a userspace app which dumps
   out a directory of your pagecache and buffercache contents
   to a database file.  It's of the form:

	filename:page,page,page,page and
	device:block,block,block,

   The database file is sorted in ascending block order.

3: Next time you reboot, load a different kernel module and
   run a different userspace app which together walk that
   database and preload the pagecache and buffercache.

The theory was lovely.  And I tried all sorts of stuff.  But
the bottom line benefit was only about 10%.  The whole thing
was constrained by buffercache seek time - filesytem metadata.

Oh well.  The best benefit was in fact from launching all
the initscripts in parallel.  Lots of stuff broke because
of the lack of any sort of dependency system, but it was
appreciably quicker.

I guess the greatest benefit would come from reorganising the
layout of the root filesystem's data and metadata so the
pagecache prepopulation doesn't have to seek all over the place.

-
