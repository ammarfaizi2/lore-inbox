Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273089AbRIIWxJ>; Sun, 9 Sep 2001 18:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273090AbRIIWw7>; Sun, 9 Sep 2001 18:52:59 -0400
Received: from blount.mail.mindspring.net ([207.69.200.226]:47926 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273089AbRIIWwq>; Sun, 9 Sep 2001 18:52:46 -0400
Subject: Re: New SCSI subsystem in 2.4, and scsi idle patch
From: Robert Love <rml@tech9.net>
To: psusi@cfl.rr.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.08.07.08 (Preview Release)
Date: 09 Sep 2001 18:53:34 -0400
Message-Id: <1000076015.18039.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-09-09 at 14:21, Phillip Susi wrote:
> P.S.  I'd like to use a user mode daemon to detect disk idle, and issue the 
> existing ioctl code to spin the disk down, and rely on the kernel to spin it 
> back up as needed.  Isn't there somewhere in /proc that keeps IO counters on 
> the disk I can monitor?  Also, is there a way I could ask the kernel to not 
> flush dirty pages to disk unless it gets a whole lot of them so the disk 
> won't be spun up all the time just to write a few KB?

You can change the behavior of how dirty pages are flushed using
/proc/bdflush.

[18:41:55]rml@phantasy:/proc/sys/vm# cat bdflush 
30	64	64	256	500	3000	60	0	0

Of these 9 parameters, you probably care about the first and sixth.  The
first is percent of buffer full before bdflush kicks in and starts
flushing.  Setting this to 60% is fine, and will work towards your aim.

Note that, Documentation/sysctl/vm.txt is outdated (I will send a patch
off...) this is the correct values of the fields on bdflush:

union bdflush_param {
	struct {
		int nfract;	/* Percentage of buffer cache dirty to 
				   activate bdflush */
		int dummy1;	/* old "ndirty" */
		int dummy2;	/* old "nrefill" */
		int dummy3;	/* unused */
		int interval;	/* jiffies delay between kupdate flushes */
		int age_buffer;	/* Time for normal buffer to age before we flush it */
		int nfract_sync;/* Percentage of buffer cache dirty to 
				   activate bdflush synchronously */
		int dummy4;	/* unused */
		int dummy5;	/* unused */
	} b_un;
	unsigned int data[N_PARAM];
} bdf_prm = {{30, 64, 64, 256, 5*HZ, 30*HZ, 60, 0, 0}};

Finally, I like your idea.  I have an all SCSI system and would like my
disks to spin down. Good luck.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

