Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276120AbRI1PWs>; Fri, 28 Sep 2001 11:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276119AbRI1PWi>; Fri, 28 Sep 2001 11:22:38 -0400
Received: from msgbas1x.net.europe.agilent.com ([192.25.19.109]:58054 "HELO
	msgbas1.net.europe.agilent.com") by vger.kernel.org with SMTP
	id <S276118AbRI1PWX>; Fri, 28 Sep 2001 11:22:23 -0400
Message-ID: <3BB495C6.2B0A5ABB@hsgmed.com>
Date: Fri, 28 Sep 2001 17:22:46 +0200
From: Joachim Weller <Joachim_Weller@hsgmed.com>
Organization: Philips Medical Systems Boeblingen - Cardiac and Monitoring Systems 
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: de-DE,fr,es
MIME-Version: 1.0
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: Joachim Weller <JoachimWeller@web.de>, axboe@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: cat /proc/partitions endless loop
In-Reply-To: <200109281448.f8SEmvh08284@mailgate5.cinetic.de> <20010928170004.A14892@caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> On Fri, Sep 28, 2001 at 04:48:57PM +0200, Joachim Weller wrote:
> > Christoph Hellwig <hch@ns.caldera.de> schrieb am 28.09.01:
> > > I think the fix could be simpler.  What about:
> > [...]
> >
> > > + for (gp = gendisk_head; gp != gendisk_head; gp = gp->next) {
> >
> > This will break your for loop immedeately, because the loop criteria
> > is already violated by the initialization !
> >
> > But I tried another solution:
> >   for (gp = gendisk_head; gp && (gp->next != gendisk_head); gp = gp->next) {
> >
> > with no success - the cat /proc/partition only printed the heading line.
> > This proofed to me, that the pointered list is created the wrong way,
> > in other words, gendisk_head->next is a pointer to itself.
> > It looks to me, that the "next" field in
> > /*static*/ struct gendisk *gendisk_head;
> > is not initialized (by the compiler ?) correctly to NULL.
>
> That's odd, could you try initilazing gendisk_head to NULL explicitly and try
> my proposed fix?  The gendisk list handling starts to smell _really_ funny.
You would need to initialize gendisk_head->next to NULL *before* any call to 
add_gendisk(struct gendisk *gp) takes place. The latter is used in many other 
sources, to grow up the pointered list with additional partition info. 
gendisk_head always points to the most recently added item. 
When you step through the list, you reach the very first entry, which existed 
before any call to add_gendisk() was made. And the "next" field of that should 
point to NULL. 
But instead of this, it points to itself, thus forming a ring pointered loop.
I don't know in which part of the kernel sources, that pre-initialization 
of gendisk_head->next to NULL should be made. Maybe it is expected to be done
by the compiler.

But my fix works perfectly for me, resulting in exactly the same behaviour
as 2.4.9.

I should point out, that my 2.4.9 was compiled under gcc 2.95.2 (SuSE-6.4) , whereas
2.4.10 was compiled under 2.95.3 delivered by SuSE-7.2 ! Maybe that's the point.

-- 
Joachim Weller

Philips Medizinsysteme Boeblingen GmbH          Mail:  joachim_weller@hsgmed.com
Cardiac and Monitoring Systems (CMS)            Phone: {+49|0}-7031-463-1891
New Product Engineering                         Fax:   {+49|0}-7031-463-2112

Hewlett-Packard Str. 2, D 71034 Boeblingen      -GERMANY-
