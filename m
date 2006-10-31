Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423582AbWJaQqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423582AbWJaQqg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423585AbWJaQqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:46:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:34652 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423582AbWJaQqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:46:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ShxbOzj3hLzUI7F8MqM4ayjK2kEgEFB1dHIY5JBVk64eC5XaXT6Rz1HDyUdv/13nej3yRthLue3hec5J/bNn6Itdnnhw26/X8SuUQuHdLzyxl2dRWQ7cITNciqmw4/82v75xw7WMkFRC5mjP48q6pzh1JRAyUUE80TJI/uDDsHw=
Message-ID: <f46018bb0610310846p27f561b3uaf651b8d9b01c693@mail.gmail.com>
Date: Tue, 31 Oct 2006 11:46:17 -0500
From: "Holden Karau" <holden@pigscanfly.ca>
To: "Matthew Wilcox" <matthew@wil.cx>
Subject: Re: [PATCH 1/1] fat: improve sync performance by grouping writes revised
Cc: "Holden Karau" <holdenk@xandros.com>,
       "Josef Sipek" <jsipek@fsl.cs.sunysb.edu>, hirofumi@mail.parknet.co.jp,
       linux-kernel@vger.kernel.org, "akpm@osdl.org" <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "J?rn Engel" <joern@wohnheim.fh-wedel.de>
In-Reply-To: <20061031162825.GD26964@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <454765AC.1050905@xandros.com>
	 <20061031162825.GD26964@parisc-linux.org>
X-Google-Sender-Auth: 3eefa355a2f20771
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/06, Matthew Wilcox <matthew@wil.cx> wrote:
> On Tue, Oct 31, 2006 at 10:03:08AM -0500, Holden Karau wrote:
> > @@ -343,52 +344,65 @@ int fat_ent_read(struct inode *inode, st
> >       return ops->ent_get(fatent);
> >  }
> >
> > -/* FIXME: We can write the blocks as more big chunk. */
> > -static int fat_mirror_bhs(struct super_block *sb, struct buffer_head **bhs,
> > -                       int nr_bhs)
> > +
> > +static int fat_mirror_bhs_optw(struct super_block *sb, struct buffer_head **bhs,
> > +                            int nr_bhs , int wait)
> >  {
> >       struct msdos_sb_info *sbi = MSDOS_SB(sb);
> > -     struct buffer_head *c_bh;
> > +     struct buffer_head *c_bh[nr_bhs*(sbi->fats)];
> >       int err, n, copy;
> >
> > +     /* Always wait if mounted -o sync */
> > +     if (sb->s_flags & MS_SYNCHRONOUS )
> > +             wait = 1;
> >       err = 0;
> >       for (copy = 1; copy < sbi->fats; copy++) {
> >               sector_t backup_fat = sbi->fat_length * copy;
> > -
> > -             for (n = 0; n < nr_bhs; n++) {
> > -                     c_bh = sb_getblk(sb, backup_fat + bhs[n]->b_blocknr);
> > -                     if (!c_bh) {
> > +             for (n = 0 ; n < nr_bhs ;  n++ ) {
> > +                     c_bh[(copy-1)*nr_bhs+n] = sb_getblk(sb, backup_fat + bhs[n]->b_blocknr);
> > +                     if (!c_bh[(copy-1)*nr_bhs+n]) {
> > +                             printk(KERN_CRIT "fat: out of memory while copying backup fat. possible data loss\n");
>
> I don't like that at all.
Not much to be done about that. The amount of memory required is
fairly small, but if its not there its not there.
>
> >                               err = -ENOMEM;
> >                               goto error;
> >                       }
> > -                     memcpy(c_bh->b_data, bhs[n]->b_data, sb->s_blocksize);
> > -                     set_buffer_uptodate(c_bh);
> > -                     mark_buffer_dirty(c_bh);
> > -                     if (sb->s_flags & MS_SYNCHRONOUS)
> > -                             err = sync_dirty_buffer(c_bh);
> > -                     brelse(c_bh);
> > -                     if (err)
> > -                             goto error;
> > +             memcpy(c_bh[(copy-1)*nr_bhs+n]->b_data, bhs[n]->b_data, sb->s_blocksize);
> > +             set_buffer_uptodate(c_bh[(copy-1)*nr_bhs+n]);
> > +             mark_buffer_dirty(c_bh[(copy-1)*nr_bhs+n]);
> >               }
> >       }
> > +
> > +     if (wait) {
> > +             for (n = 0 ; n < nr_bhs ; n++) {
> > +                     printk("copying to %d to  %d\n" ,n,  nr_bhs*(sbi->fats-1)+n);
>
> Is this the right version of the patch?  The printk should never be left in.
> Plus, as far as I can tell, that whole loop is actually just memcpy().
whoops. That was in for debugging, I thought I took that out. The loop
structure is how it was before, but I don't see a way to get rid of
it, do you have an idea?
>


-- 
Cell: 613-276-1645
