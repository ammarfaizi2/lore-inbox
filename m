Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVCBQLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVCBQLv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 11:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVCBQLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 11:11:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10200 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262344AbVCBQLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 11:11:39 -0500
Date: Wed, 2 Mar 2005 08:38:46 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "John L. Males" <jlmales@softhome.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4.27 - 2.4.29 tar: /dev/nst0: Warning: Cannot seek: Illegal seekg
Message-ID: <20050302113846.GA1559@logos.cnet>
References: <20050227190939.023df845.jlmales@softhome.net> <20050227195908.GB23606@logos.cnet> <20050228174444.5f414d2b.jlmales@softhome.net> <20050301142224.GA31152@logos.cnet> <20050302064434.152f2457.jlmales@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050302064434.152f2457.jlmales@softhome.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm ccing Linux kernel because this bug is also present in v2.6.

Andrew, Viro: tar --verify (which uses lseek) on SCSI tapes fails with: 

tar: /dev/nst0: Warning: Cannot seek: Illegal seek

The problem was introduced by Viro's f_pos fixes which added "no_llseek" 
as the llseek method in st.c.

John removed "no_llseek" and things are working again for him.

On Wed, Mar 02, 2005 at 06:44:34AM -0500, John L. Males wrote:
> Hi Marcello,
> 
> I manage to complete the test using the suggested code change to st.c
> you requested.  I did the change to 2.4.29.  The tar --verify worked,
> but discovered a new tape file system bug that I very much believe if
> different issue.  
> First question I would have is this code change test I made to st.c,
> is it only a quick means to access the issue for the kernel developers
> so they can created a more appropriate fix?
> 
> Second question is your thought for this quick change as a temporary
> workaround.

I think this is the appropriate fix - AFAICS its legit to perform "llseek"
on tapes. Please correct me if I'm wrong.

> Third question, would you agree the new  tape file system bug I found
> that I believe not realted to the tar: /dev/nst0: Warning: Cannot
> seek: Illegal seek I should report as a new eMail with one liner
> description of problem as subject?

Please report that problem separately!

> 
> 
> Regards,
> 
> John L. Males
> Willowdale, Ontario
> Canada
> 02 March 2005 (06:28 -) 06:44
> 01 March 2005 (14:05 - 20:45)
> 
> 
> ********** Reply Seperator **********
> 
> On (Tue) 2005-03-01 11:22:24 -0300 
> Marcelo Tosatti wrote in Message-ID: 20050301142224.GA31152@logos.cnet
> 
> To: "John L. Males" <jlmales@softhome.net>
> From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
> Subject: Re: [BUG] 2.4.27 - 2.4.29 tar: /dev/nst0: Warning: Cannot
> seek: Illegal seekg
> Date: Tue, 1 Mar 2005 11:22:24 -0300
> 
> > 
> > Hi John, 
> > 
> > I'm very sorry for the delay. 
> > 
> > Please do the following: 
> > 
> > Edit drivers/char/st.c, line 3871:
> > 
> > static struct file_operations st_fops =
> > {
> >         owner:          THIS_MODULE,
> >         read:           st_read,
> >         write:          st_write,
> >         ioctl:          st_ioctl,
> >         llseek:         no_llseek,
> >         open:           st_open,
> >         flush:          st_flush,
> >         release:        st_release,
> > };
> > 
> > Comment out the "llseek" entry:
> > 
> > static struct file_operations st_fops =
> > {
> >         owner:          THIS_MODULE,
> >         read:           st_read,
> >         write:          st_write,
> >         ioctl:          st_ioctl,
> > //      llseek:         no_llseek,
> >         open:           st_open,
> >         flush:          st_flush,
> >         release:        st_release,
> > };
> > 
> > And retest.
> >                                                                   
>                                                                       
>                                          
> > Thanks.
> > 
> > 
> > On Mon, Feb 28, 2005 at 05:44:44PM -0500, John L. Males wrote:
> > > Marcelo,
> > > 
> > > > > ********** Reply Seperator **********
> > > > > 
> > > > > On (Sat) 2005-02-26 07:50:52 -0300 
> > > > > Marcelo Tosatti wrote in Message-ID:
> > > > > 20050226105052.GD16460@logos.cnet
> > > > > 
> > > > > To: "John L. Males" <jlmales@softhome.net>
> > > > > From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
> > > > > Subject: Re: Fw[05]: [BUG] 2.4.27 - 2.4.29 tar: /dev/nst0:
> > > > > Warning: Cannot seek: Illegal seek
> > > > > Date: Sat, 26 Feb 2005 07:50:52 -0300
> > > > > 
> > > > > > 
> > > > > > Hi John,
> > > > > > 
> > > > > > On Wed, Feb 23, 2005 at 10:03:08AM -0500, John L. Males
> > > > > > wrote:
> > > > > > > Marcelo,
> > > > > > > 
> > > > > > > I have tried to post the attached bug to ther LKML about
> > > > > > > 13:10 yesterday and it has not posted, nor any message
> > > > > > > about why will not. I never had problems posting to the
> > > > > > > LKML in past, but it has been a couple years since I did. 
> > > > > > > My current understanding is bugzilla if for reporting 2.6
> > > > > > > issues and not 2.4 issues.  Is this correct?
> > > > > > 
> > > > > > There are some v2.4 bugs reported at the bugzilla, but you
> > > > > > are right: bugzilla should be used for 2.6 issues only, I'm
> > > > > > personally tracking the v2.4 buglist.
> > > > > > 
> > > > > > That being said, please contact me personally whenever you
> > > > > > have a 2.4 bugreport!
> > > > > > 
> > > > > > > I searched high and low to find your eMail address and
> > > > > > > with no luck. I eMailed someone that made a patch realted
> > > > > > > to tapes just to find out how I can get the bug sent to
> > > > > > > you.  They gave me your eMail address. I fully understand
> > > > > > > the problem of being a Kernel maintainer, not to mention
> > > > > > > the SPAM problems why I seemed unable to find your eMail
> > > > > > > address listed anywhere.
> > > > > > > 
> > > > > > > A couple updates to the original bug eMail details that
> > > > > > > are attached. I do not believe the issue is controller
> > > > > > > specific, but just for record the system has two
> > > > > > > AHA-2940UW with 2.57.2 firmware.  I looked at the delta
> > > > > > > patch for 2.4.26 to 2.4.27 and seems there were no AIC7XXX
> > > > > > > changes, there seemed to be some tape related changes and
> > > > > > > a llseek change.  Not sure if that will help narrow the
> > > > > > > scope of bug I am experiencing. Someone suggested it was
> > > > > > > important issue to report to you and may be "introduced
> > > > > > > along with the f_pos race fixes".
> > > > > > 
> > > > > > Ok, can you please try v2.4.27-rc4? The "f_pos race fixes"
> > > > > > have been introduced during v2.5.
> > > > > 
> > > > > I can, but will likley be a few days before I have time to
> > > > > build and test as a few personal matters arose on Friday that
> > > > > will have my attention for a few days.
> > > > > 
> > > > > > 
> > > > > > In case you confirm that 2.4.27-rc4 works, we should track
> > > > > > down the exact change which caused the problem.
> > > > > > 
> > > > > > > If you or someone that needs to have more details of the
> > > > > > > problem just eMail me.  I am now using the 2.4.29 stock
> > > > > > > Kernel with no additional patches.  I would think this is
> > > > > > > an important issue for those still needing to do tape
> > > > > > > backups using tar.  Not sure if you have any other reports
> > > > > > > of this problem already of if those that do use tar are
> > > > > > > using an older kernel and so are not aware of the issue as
> > > > > > > yet.
> > > > > > 
> > > > > > Hope you can help tracking this bug down! :)
> > > > > > 
> > > > > > Thanks for your bugreport and sorry for taking so long to
> > > > > > answer.
> > > > > > 
> > > > > > Question: the latest v2.6 kernels also show the same problem
> > > > > > on tar--verify? 
> > > > > > 
> > > > > 
> > > > > Marcelo I suspect you are still digging through your eMail and
> > > > > have not yet seen my eMail  "Re[06]: [BUG] 2.4.27 - 2.4.29
> > > > > tar:/dev/nst0: Warning: Cannot seek: Illegal seek" of 25
> > > > > February 2005(17:45 -) 18:30 which answers the above question
> > > > > you had related to the 2.6 kernel.  I have copied the part of
> > > > > the eMail that relates to your 2.6 kernel question below, but
> > > > > left the other question I posed as an aside to be answered
> > > > > later when you have time from that eMail:
> > > > > 
> > > > > Marcelo,
> > > > > 
> > > > > Just an update.  I managed to figure out how to load the
> > > > > 2940UW Kernel drivers from Knoppix listed as "CAUTION".  Some
> > > > > of the AIC7xxx drivers do not work in the early Knoppix
> > > > > versions that have a 2.6 kernel in Knoppix.  I know you do not
> > > > > maintain the 2.6 kernel.  I just hought it might be helpful to
> > > > > have these observations in realtion to the 2.4 kernel bug I
> > > > > reported in case it is helpful.
> > > > > 
> > > > > Using Knoppix:
> > > > > 
> > > > > V3.6 Kernel 2.6.7 tar verify for tape works
> > > > > 
> > > > > V3.7 Kernel 2.6.9 tar verify for tape fails
> > > > > 
> > > > > Looking at the delta patches it seems in the 2.6.8 to 2.6.9
> > > > > patch set there are alot of llseek related changes, many more
> > > > > than in the 2.4.26 to 2.4.27 patch set.  That said, there were
> > > > > very similar llseek patches in 2.4.9 and the 2.4.27 patch sets
> > > > > that I suspect may have some relationship to the bug I am
> > > > > experiencing.
> > > > > 
> > > > > I would be interested to know if the bug I reported can be
> > > > > duplicated and when the patch is created.  The latter as
> > > > > sometimes reading the change log is is hard for me to deduce
> > > > > what the fix description may read like compared to the bug I
> > > > > experienced.
