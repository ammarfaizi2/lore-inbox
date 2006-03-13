Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWCMSNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWCMSNE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWCMSNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:13:01 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:53426 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932273AbWCMSM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:12:59 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [discuss] Re: 2.6.16-rc5-mm3: spinlock bad magic on CPU#0 on AMD64
Date: Mon, 13 Mar 2006 19:12:09 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       ak@suse.de, cmm@us.ibm.com
References: <200603120024.04938.rjw@sisk.pl> <200603131307.37402.rjw@sisk.pl> <1142265735.21442.51.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1142265735.21442.51.camel@dyn9047017100.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603131912.10356.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 March 2006 17:02, Badari Pulavarty wrote:
> On Mon, 2006-03-13 at 13:07 +0100, Rafael J. Wysocki wrote:
> > On Monday 13 March 2006 12:45, Andrew Morton wrote:
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > >
> > > > > This should fix:
> > > >  > 
> > > >  > --- devel/fs/ext3/inode.c~ext3-get-blocks-maping-multiple-blocks-at-a-once-journal-reentry-fix	2006-03-12 14:25:04.000000000 -0800
> > > >  > +++ devel-akpm/fs/ext3/inode.c	2006-03-12 14:25:04.000000000 -0800
> > > >  > @@ -830,7 +830,7 @@ ext3_direct_io_get_blocks(struct inode *
> > > >  >  	handle_t *handle = journal_current_handle();
> > > >  >  	int ret = 0;
> > > >  >  
> > > >  > -	if (!handle)
> > > >  > +	if (!create)
> > > >  >  		goto get_block;		/* A read */
> > > >  >  
> > > >  >  	if (max_blocks == 1)
> > > > 
> > > >  Er, it doesn't apply to either 2.6.16-rc5-mm3 or 2.6.16-rc6-mm1.
> > > 
> > > Nope, it applies OK to rc6-mm1.
> > 
> > Well, this means my rc6-mm1 is different to what you have. :-)
> > 
> > Anyway in "my" version there's a function ext3_get_block() which reads like this:
> > 
> > static int ext3_get_block(struct inode *inode, sector_t iblock,
> >                         struct buffer_head *bh_result, int create)
> > {
> >         handle_t *handle = journal_current_handle();
> >         int ret = 0;
> >         unsigned max_blocks = bh_result->b_size >> inode->i_blkbits;
> > 
> >         if (!handle)
> >                 goto get_block;         /* A read */
> > 
> >         if (max_blocks == 1)
> >                 goto get_block;         /* A single block get */
> > 
> > etc.
> > 
> > I guess I should replace the "if (!handle)" with "if (!create)"?
> 
> Yes. In "-mm" ext3_get_block() == ext3_direct_io_getblocks() in
> mainline. 
> 
> I renamed ext3_direct_io_getblocks() to ext3_get_block() (in -mm) 
> since both of them do same thing now. (both can deal with mapping
> multiple blocks).

Ah, I see, thanks.

Replacing the  "if (!handle)" with "if (!create)" fixed the problem for me.

Greetings,
Rafael
