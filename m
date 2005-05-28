Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262548AbVE1JLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbVE1JLk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 05:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbVE1JLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 05:11:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40839 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262548AbVE1JLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 05:11:24 -0400
Date: Sat, 28 May 2005 10:11:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS lstat() _very_ slow on SMP
Message-ID: <20050528091123.GA19330@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Kasprzak <kas@fi.muni.cz>, linux-kernel@vger.kernel.org,
	linux-xfs@oss.sgi.com
References: <20050516162506.GB19415@fi.muni.cz> <20050518140258.GA22587@infradead.org> <20050518174530.GF19173@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050518174530.GF19173@fi.muni.cz>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 07:45:30PM +0200, Jan Kasprzak wrote:
> Christoph Hellwig wrote:
> : On Mon, May 16, 2005 at 06:25:06PM +0200, Jan Kasprzak wrote:
> : > 	Hi all,
> : > 
> : > 	I have a big XFS volume on my fileserver, and I have noticed that
> : > making an incremental backup of this volume is _very_ slow. The incremental
> : > backup essentially checks mtime of all files on this volume, and it
> : > takes ~4ms of _system_ time (i.e. no iowait or what) to do a lstat().
> : 
> : Thanks a lot for the report, I'll investigate what's going on once I get
> : a little time.  (Early next week I hope)
> 
> 	Hmm, I feel like I am hunting ghosts - after a fresh reboot
> of the 4-CPU server I did four runs of 128*128*128 files with various
> sizes of the underlying filesystem (in order to eliminate the volume
> size as a problematic factor). I've got the following numbers:
> 
> Volume size   create time           find -mtime +1000     cost of lseek()
>   5GB         55m77 real 52m51 sys  1m1 real 0m53 sys       19 usecs
>  25GB         58m15 real 55m27 sys  83m47 real 82m15 sys  2171 usecs (!!!!!!)
> 125GB         67m0 real 61m35 sys   0m55 real 0m48 sys      18 usecs
> 625GB         68m30 real 62m38 sys  0m57 real 0m49 sys      18 usecs
> 
> 	So the results are probably not dependent on the volume size,
> but on something totally random (such as which cpu the command
> ends up running on or something like that), or on the system uptime
> (and implied fragmentation of memory or what).
> 
> 	I've tried to re-run the same test the next day (i.e. on
> server with longer uptime), but the server crashed - my test script
> ended locked up somewhere in kernel (probably holding some locks),
> and then other processes started to lock up after accessing the file
> system (my top(1) was running OK, but when I tried to "touch newfile"
> in another shell, it locked up as well).  So I had to reset this server
> again.
> 
> 	I am not really sure where exactly the problem is. I think
> it is related to XFS, big memory of this server (26 GB), four CPUs,
> and maybe even the x86_64 architecture. I was not able to reproduce
> the problem on the same HW using ext3fs, and the problem is also
> a magnitude smaller on 2-way system with 4GB of RAM. Maybe I should
> try to reproduce this on our Altix box to eliminate the x86_64 as the
> possible source of problems.
> 
> 	I use the attached "bigtree.pl" to create the directory structure
> ("time ./bigtree.pl /new-volume 3 128" for 128*128*128 files), and then
> "strace -c find /new-volume -type f -mtime +1000 -print" (the numbers
> without strace are almost the same, so strace is not a problem here).

I couldn't reproduce the odd case here.  Could you try to get some profiling
data with oprofile for the odd and one of the normal cases?
