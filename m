Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752395AbWAFHBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbWAFHBn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 02:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbWAFHBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 02:01:43 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:3297 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1752395AbWAFHBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 02:01:42 -0500
Date: Fri, 6 Jan 2006 08:01:26 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Roberto Nibali <ratz@drugphish.ch>
cc: Nuno Monteiro <nuno+lkml@itsari.org>,
       "Leonard Milcin Jr." <leonard.milcin@post.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ttyrpld-user@lists.sourceforge.net
Subject: Re: [OT] Re: keyboard driver of 2.6 kernel
In-Reply-To: <43BDABA1.1060607@drugphish.ch>
Message-ID: <Pine.LNX.4.61.0601060752110.22809@yvahk01.tjqt.qr>
References: <Pine.LNX.4.60.0601041359380.7341@lantana.cs.iitm.ernet.in>
 <1136363622.2839.6.camel@laptopd505.fenrus.org> <43BB906F.3010900@post.pl>
 <Pine.LNX.4.61.0601041017560.29257@yvahk01.tjqt.qr> <43BCF005.1050501@drugphish.ch>
 <Pine.LNX.4.61.0601051249030.21555@yvahk01.tjqt.qr> <43BD146B.2010308@drugphish.ch>
 <20060105210751.GC4332@hobbes.itsari.org> <43BDABA1.1060607@drugphish.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> rid of the extra fluff -- the dependency on moduleparm.h which doesn't
>> exit in 2.4.22

Good to know.

>> the BSD defines

In the kernel part? Where?

>> the 2.6 defines, etc. Also, if built as a
>> module, it'll be called 'rpl' instead of 'rpldev'.
>
> Why?

By default, it's called rpldev everywhere.

> Thanks for sharing your work! Comments on the coding style aside (it's not
> exactly winning a beauty contest), one thing I spotted while skimming over your
> patch:
>
>> +static int urpl_open(struct inode *inode, struct file *filp) {
>> +    // This one is called when the device node has been opened.
>> +    if(inode != NULL) {
>> +        inode->i_mtime = CURRENT_TIME;
>> +        inode->i_mode &= ~(S_IWUGO | S_IXUGO);
>> +    }
>> +
>> +    /* The RPL device should only be opened once, since otherwise, 
> different
>> +    packets could go to different readers. */
>> +    down(&Open_lock);
>> +    if(Open_count) {
>> +        up(&Open_lock);
>> +        return -EBUSY;
>> +    }
>> +    ++Open_count;
>> +    up(&Open_lock);
>> +
>> +    down(&Buffer_lock);
>> +    Buffer = __vmalloc(Bufsize, GFP_KERNEL | __GFP_HIGHMEM, 
> PAGE_KERNEL);
>> +    if(Buffer == NULL) {
>> +        up(&Buffer_lock);
>> +        up(&Open_lock);
>
> This does not seem to be correct. This semaphore has been released already and
> urpl_open is not called under a lock AFAICS.

Semaphoring is right, i.e. Open_lock is only acquired to check Open_count.
However, that last line is certainly invalid - Open_lock is up'ped twice, 
which can't be. Thanks for spotting that.

I will have 2.4 put back in.


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
