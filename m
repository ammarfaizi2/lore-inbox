Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWAEX2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWAEX2l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWAEX2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:28:41 -0500
Received: from drugphish.ch ([69.55.226.176]:36814 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S1751387AbWAEX2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:28:40 -0500
Message-ID: <43BDABA1.1060607@drugphish.ch>
Date: Fri, 06 Jan 2006 00:28:33 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Nuno Monteiro <nuno+lkml@itsari.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Leonard Milcin Jr." <leonard.milcin@post.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: keyboard driver of 2.6 kernel
References: <Pine.LNX.4.60.0601041359380.7341@lantana.cs.iitm.ernet.in> <1136363622.2839.6.camel@laptopd505.fenrus.org> <43BB906F.3010900@post.pl> <Pine.LNX.4.61.0601041017560.29257@yvahk01.tjqt.qr> <43BCF005.1050501@drugphish.ch> <Pine.LNX.4.61.0601051249030.21555@yvahk01.tjqt.qr> <43BD146B.2010308@drugphish.ch> <20060105210751.GC4332@hobbes.itsari.org>
In-Reply-To: <20060105210751.GC4332@hobbes.itsari.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'll let you know if I need it; I reckon it might not be too 
>> difficult to backport it anyway, so I can also do it myself ;).
>>
> I stumbled upon ttyrpld a couple weeks ago and thought it was pretty 
> useful, to keep track of all actions performed on a couple of machines 
> where only the admins have local accounts. Since I'm running a (heavily 
> modified) custom 2.4.22 kernel, I took the version Jan offered for 
> 2.4.29 (in ttyrpld-2.03.5) and synced it up with the work he did on 
> later versions. I think it's identical, functionality wise, to the 
> patch he offered on ttyrpld 2.10. I also massaged it a bit so it would 
> build statically into the kernel (my boxes don't have module support) 
> and to get rid of the extra fluff -- the dependency on moduleparm.h 
> which doesn't exit in 2.4.22, the BSD defines, the 2.6 defines, etc. 
> Also, if built as a module, it'll be called 'rpl' instead of 'rpldev'.

Why?

> I'm running it now on a couple boxes, with the latest userspace bits 
> (libHX 1.74 and ttyrpld 2.10), and It Works For Me (tm). So, with that 
> disclaimer out of the way, here's the patch. It's diffed against my 
> custom 2.4.22 kernel, but should apply fairly well to any 2.4.

Thanks for sharing your work! Comments on the coding style aside (it's 
not exactly winning a beauty contest), one thing I spotted while 
skimming over your patch:

 > +static int urpl_open(struct inode *inode, struct file *filp) {
 > +    // This one is called when the device node has been opened.
 > +    if(inode != NULL) {
 > +        inode->i_mtime = CURRENT_TIME;
 > +        inode->i_mode &= ~(S_IWUGO | S_IXUGO);
 > +    }
 > +
 > +    /* The RPL device should only be opened once, since otherwise, 
different
 > +    packets could go to different readers. */
 > +    down(&Open_lock);
 > +    if(Open_count) {
 > +        up(&Open_lock);
 > +        return -EBUSY;
 > +    }
 > +    ++Open_count;
 > +    up(&Open_lock);
 > +
 > +    down(&Buffer_lock);
 > +    Buffer = __vmalloc(Bufsize, GFP_KERNEL | __GFP_HIGHMEM, 
PAGE_KERNEL);
 > +    if(Buffer == NULL) {
 > +        up(&Buffer_lock);
 > +        up(&Open_lock);

This does not seem to be correct. This semaphore has been released 
already and urpl_open is not called under a lock AFAICS.

I'll see if we can fit something like this into the next kernel round 
for our distro. The code needs major cleanup though.

Best regards,
Roberto Nibali, ratz
-- 
echo 
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc
