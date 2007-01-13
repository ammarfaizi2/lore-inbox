Return-Path: <linux-kernel-owner+w=401wt.eu-S1422680AbXAMOae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422680AbXAMOae (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 09:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422681AbXAMOae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 09:30:34 -0500
Received: from 1wt.eu ([62.212.114.60]:1935 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422680AbXAMOad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 09:30:33 -0500
Date: Sat, 13 Jan 2007 15:30:27 +0100
From: Willy Tarreau <w@1wt.eu>
To: Toon van der Pas <toon@hout.vanvergehaald.nl>
Cc: Kumar Gala <galak@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: tuning/tweaking VM settings for low memory (preventing OOM)
Message-ID: <20070113143027.GA16868@1wt.eu>
References: <D7BBB18A-F5D4-4FE0-903F-3683333D957C@kernel.crashing.org> <20070113072217.GW24090@1wt.eu> <20070113131601.GA12901@shuttle.vanvergehaald.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070113131601.GA12901@shuttle.vanvergehaald.nl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Toon,

On Sat, Jan 13, 2007 at 02:16:01PM +0100, Toon van der Pas wrote:
> On Sat, Jan 13, 2007 at 08:22:18AM +0100, Willy Tarreau wrote:
> > > 
> > > Which makes me think that we aren't writing back fast enough.  If I  
> > > mount the drive "sync" the issue clearly goes away.
> > > 
> > > It appears from an strace we are doing ftruncate64(5, 178257920) when  
> > > we OOM.
> > > 
> > > Any ideas on VM parameters to tweak so we throttle this from occurring?
> > 
> > Take a look at /proc/sys/vm/bdflush. There are several useful parameters
> > there (doc is in linux-xxx/Documentation). For instance, the first column
> > is the percentage of memory used by writes before starting to write on
> > disk. When using tcpdump intensively, I lower this one to about 1%.
> > 
> > Willy
> 
> Hi Willy,
> 
> I know you're doing a great job on keeping the 2.4 kernel in shape,
> but do you also have a good advice for people with more recent
> kernels?  (hint: the file /proc/sys/vm/bdflush is missing)

OK OK OK... Next time I will have coffee *before* replying :-)

Check /proc/sys/vm/dirty_ratio and dirty_background_ratio. Both are
percentage of total memory. The first one is for "foreground" writes
(ie the writing process may block) while the second one is for
"background" writes :

$ uname -a
Linux hp 2.6.16-rc2-pa1 #1 Fri Feb 3 23:34:56 MST 2006 parisc unknown
$ cat /proc/sys/vm/dirty_ratio 
40
$ cat /proc/sys/vm/dirty_background_ratio 
10

Again, lowering those values should help writing data to disk sooner.
Also you should take a look at min_free_kbytes (although I've not played
with it yet) :

[from Documentation/sysctl/vm.txt] :
  min_free_kbytes:

  This is used to force the Linux VM to keep a minimum number 
  of kilobytes free.  The VM uses this number to compute a pages_min
  value for each lowmem zone in the system.  Each lowmem zone gets 
  a number of reserved free pages based proportionally on its size.

Docuemntation/filesystems/proc.txt is your friend here too.

Regards,
Willy

