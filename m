Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285589AbSAEVPa>; Sat, 5 Jan 2002 16:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284659AbSAEVPU>; Sat, 5 Jan 2002 16:15:20 -0500
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:51597 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S284144AbSAEVPG>; Sat, 5 Jan 2002 16:15:06 -0500
From: "Karol Pietrzak" <noodlez84@earthlink.net>
To: linux-kernel@vger.kernel.org
Date: Sat, 5 Jan 2002 15:03:01 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: slow CD ripping from moving from 2.4.4 to 2.4.17
Reply-to: noodlez84@earthlink.net
Message-ID: <3C3715A5.13473.4360DD@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
I am the original poster, and I am happy to say that my problem 
has been solved thanks to Mark Hahn.  The solution was to tweak 
the VM (via /proc/sys/vm/bdflush).

Here's the excerpt from fs/buffer.c which I looked at:

union bdflush_param {
	struct {
		int nfract;	/* Percentage of buffer cache dirty to 
				   activate bdflush */
		int dummy1;	/* old "ndirty" */
		int dummy2;	/* old "nrefill" */
		int dummy3;	/* unused */
		int interval;	/* jiffies delay between kupdate flushes */
		int age_buffer;	/* Time for normal buffer to age before we 
flush it */
		int nfract_sync;/* Percentage of buffer cache dirty to 
				   activate bdflush synchronously */
		int dummy4;	/* unused */
		int dummy5;	/* unused */
	} b_un;
	unsigned int data[N_PARAM];
} bdf_prm = {{40, 0, 0, 0, 5*HZ, 30*HZ, 60, 0, 0}};

After a little tinkering, this is now in my 
/etc/init.d./boot.local :
echo "10 0 0 0 500 3000 5 0 0" > /proc/sys/vm/bdflush 

Thus, the only modified numbers are:
1. nfract : from 40% to 10% (Percentage of buffer cache dirty to 

activate bdflush)
2. nfract_sync : from 60% to 5% (Percentage of buffer cache 
dirty to activate bdflush synchronously)

I don't quite understand what all that means (my knowledge of C 
is very limited), but it works :)

Once again, thank you.  You've made me a happy Linux user...  
Ripping performance, with these changes in place, is now around 
26-30X, where before, it was 13-15X.

On 31 Dec 2001, linux-kernel@vger.kernel.org wrote:

> Hello.
> Using 2.4.4 up to, I believe, 2.4.14, CD ripping was fine.  My
> Plextor 12/10/32S (S for SCSI) ripped audio CDs at around 25X,
> even sometimes at 30X.  While ripping, my hard drive would work
> continuously, and so would my CDRW drive.
> 
> Now with 2.4.17, my hard drive can't keep up with my CDRW drive:
> everything happens in bursts.  My CDRW drive starts ripping as
> fast as possible, but my hard drive doesn't do anything (0-5
> seconds).  Then, my hard drive decides to start writing, which
> stops the CD ripping process (5-8 seconds).  Now that the hard
> drive is done, the CDRW drive continues ripping... for 4 seconds
> and the process continues over and over again.  This brings down
> the ripping speed down to ~18X, a far cry from the 30X achieved
> with 2.4.4 and very close to the writing speed of my CDRW drive
> (12X), which is ridiculous.
> 
> As stated before, ripping is fine in 2.4.4 (which I still keep
> around because of this problem).  What does help in 2.4.17,
> however, is manually entering running the 'sync' command ever
> second or so on another console.  This makes the ripping process
> a lot more "continuous," like 2.4.4.
> 
> I can't burn CDs in 2.4.4, however, because that freezes up my
> computer, for some reason.  That happens a lot less often in
> 2.4.17 (but that's another matter).
> 
> I am using SuSE 7.2 Pro with the latest cdda2wav (1.11a12).
> 
> Linux linux 2.4.17 #2 Fri Dec 21 17:14:19 EST 2001 i586 unknown
> 
> Gnu C                  2.95.3
> Gnu make               3.79.1
> binutils               2.10.91.0.4
> util-linux             2.11b
> mount                  2.11b
> modutils               2.4.5
> e2fsprogs              1.19
> reiserfsprogs          3.x.0k-pre15
> PPP                    2.4.0
> Linux C Library        x    1 root     root      1343073 May 11 
> 2001 /lib/libc.so.6 Dynamic linker (ldd)   2.2.2 Procps          
>       2.0.7 Net-tools              1.60 Kbd                   
> 1.04 Sh-utils               2.0 Modules Loaded         ppp_async
> ppp_generic slhc nls_cp437 vfat fat
> 
> I am using a Pentium I 233 with 32MB of RAM.  I have an Advansys
> Ultra SCSI card with 3 devices total hooked up to it.
> 
> Anyone have any ideas?  Anything I can do?

--
Karol Pietrzak
PGP KeyID: 3A1446A0
