Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbTAJMkp>; Fri, 10 Jan 2003 07:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265190AbTAJMkp>; Fri, 10 Jan 2003 07:40:45 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:1426
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265174AbTAJMkn>; Fri, 10 Jan 2003 07:40:43 -0500
Subject: Re: Problem in IDE Disks cache handling in kernel 2.4.XX
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: fverscheure@wanadoo.fr,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.10.10301100256240.31168-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10301100256240.31168-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042205732.28469.89.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 13:35:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 11:14, Andre Hedrick wrote:
> The drive does random and automatic flush caches, if an error happens it
> does not report. *sigh*  When APM hits it with a flush and pray the error
> is from this flush, but it does not matter ... the kernel does not have
> the paths to deal this issue ... so bye bye data!  Now it if the current
> flush is not the owner of the error OMFG is suggested.

For that matter the BIOS tends to issue the flush, in fact APM is
supposed to be transparent so the BIOS is required to handle it and
since a critical shutdown from the APM PM might not even hit the OS
it has to. Of course pigs also fly 8)

> > > I had a look at patch 2.4.21pre3 and the code looks the same.
> > > 
> > > And by the way how are powered off the IDE drives ?
> > > Because a FLUSH CACHE or STANDY or SLEEP is MANDATORY before powering off the 
> > > drive with cache enabled or you will enjoy lost data
> > 
> > IDE disagrees with itself over this but when we get a controlled power
> > off we do this. The same ATA5/ATA6 problem may well be present there
> > too. I will review both
> 
> Not true, the firmware knows to commit the data to platter.
> If it was true you would be screaming long ago.

IDE disagrees with itself because it is meant to work compatibly but if
you run it compatibly you lose data on poweroff.

> 
> > Any specific opinion Andre ?
> 
> A dirty trick used to date is to pop the STANDY or SLEEP, and depend on
> the drive to deal with the double dirty flush error.  If the FLUSH CACHE
> was not valid, the drive would spin back up from STANDY, but not from
> SLEEP, this could be a problem.  However SLEEP issued by the driver only
> happens at shutdown unless it has been changed.  In the shutdown process,
> each partition unmount was flushed and also once extra when the usage
> count was set to zero.  Worst case was 2 flush min.
> 

The original question however is whether we are skipping issuing the flush
and sleep on ATA3-5 devices when we should not, because the test is over
strong.

It seems weakening the test is the best option, it fixes ATA-5 and any device
told to sleep, standby or flush that doesn't know the command is just going
to go "Huh ?" and we'll get a nice easy to handle error.

Alan


