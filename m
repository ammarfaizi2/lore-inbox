Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752235AbWKASCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbWKASCQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 13:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752239AbWKASCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 13:02:16 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:23978 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752232AbWKASCP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 13:02:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=G0GQUR9QuUEKAIwpc5hCNqIYV6NMZSdRciAAGKWY6aA9381zLk7xCe3w7YT5vSIb76AUNrL7uZOxEuGWUiFTfemsJZdHkc7Bo37NfFsSXgxgUeiVayCpRnkcnHuDGH0ZhCSrIKY8CYrKsh8WhWgS1b4TgWy2sqVNHQVfkMEAXZo=
Message-ID: <f46018bb0611011002h1b3b6e5fjdc6cc032a7503dbd@mail.gmail.com>
Date: Wed, 1 Nov 2006 13:02:12 -0500
From: "Holden Karau" <holden@pigscanfly.ca>
To: "=?ISO-8859-1?Q?J=F6rn_Engel?=" <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH 1/1] fat: improve sync performance by grouping writes revised again
Cc: "Josef Sipek" <jsipek@fsl.cs.sunysb.edu>, hirofumi@mail.parknet.co.jp,
       linux-kernel@vger.kernel.org, "Holden Karau" <holdenk@xandros.com>,
       "akpm@osdl.org" <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Matthew Wilcox" <matthew@wil.cx>
In-Reply-To: <20061101164715.GC16154@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <4548C8AE.2090603@pigscanfly.ca>
	 <20061101164715.GC16154@wohnheim.fh-wedel.de>
X-Google-Sender-Auth: c90d1a4bc21f1f41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/06, Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> On Wed, 1 November 2006 11:17:50 -0500, Holden Karau wrote:
> > +     c_bh = kmalloc(nr_bhs*(sbi->fats) , GFP_KERNEL);
> > +     if (NULL == c_bh) {
> > +             printk(KERN_CRIT "not enough memory to store pointers to FAT blocks, will not sync. Possible data loss\n");
> > +             err = -ENOMEM;
> > +             goto error;
> > +     }
>
> o I personally hate Yoda code ("Null the pointer is not, young Jedi").
> o Old code simply returned -ENOMEM without printk.  Assuming this was
>   sufficient before, the printk can be dropped.
Ok, I'll drop the printk
> o Some people prefer assigning err outside the condition.  It is
>   supposed to give slightly better code on i386, iirc.
>
> Result would be something like:
>         c_bh = kmalloc(...
>         err = -ENOMEM;
>         if (!c_bh)
>                 goto error;
That wouldn't work so well since we always return err, and possibly
slightly better code for i386 doesn't seem all that worth it.
>
> > +             for (n = 0 ; n < nr_bhs ;  n++ ) {
> > +                     c_bh[(copy-1)*nr_bhs+n] = sb_getblk(sb, backup_fat + bhs[n]->b_blocknr);
> > +                     /* If there is not enough memory, fall back to the old system */
> > +                     if (!c_bh[(copy-1)*nr_bhs+n]) {
> > +                             printk("fat: not enough memory for all blocks , syncing at %d\n" ,(copy-1)*nr_bhs+n);
>
> Whether this printk makes sense, I cannot tell.
I suppose I might as well drop it.
>
> > +                             fat_sync_bhs_optw( c_bh+i  , (copy-1)*nr_bhs+n-i-1 , wait );
> > +                             /* Free the now sync'd blocks */
> > +                             for (; i < (copy-1)*nr_bhs+n ; i++)
> > +                                     brelse(c_bh[i]);
> > +                             /* We try the same block again */
> > +                             c_bh[(copy-1)*nr_bhs+n] = sb_getblk(sb, backup_fat + bhs[n]->b_blocknr);
> > +                             if (!c_bh[(copy-1)*nr_bhs+n]) {
> > +                                     printk(KERN_CRIT "fat:not enough memory for block after existing blocks released. Possible data loss.\n");
Based on the same reasoning you provided, I should probably drop this one too.
> > +                                     err = -ENOMEM;
> > +                                     goto error;
> > +                             }
>
> As above.
I'll drop the printk, but the same holds true about err
>
> >  error:
> > +     if (NULL != c_bh) {
> > +             kfree(c_bh);
> > +     }
>
> kfree(NULL) works just fine.  You can remove the condition.
Thanks, I should have checked that :-)
>
> > +int fat_sync_bhs_optw(struct buffer_head **bhs, int nr_bhs ,int wait)
> >  {
> >       int i, err = 0;
> >
> >       ll_rw_block(SWRITE, nr_bhs, bhs);
> > -     for (i = 0; i < nr_bhs; i++) {
> > -             wait_on_buffer(bhs[i]);
> > -             if (buffer_eopnotsupp(bhs[i])) {
> > -                     clear_buffer_eopnotsupp(bhs[i]);
> > -                     err = -EOPNOTSUPP;
> > -             } else if (!err && !buffer_uptodate(bhs[i]))
> > -                     err = -EIO;
> > +     if (wait) {
> > +             for (i = 0; i < nr_bhs; i++) {
> > +                     wait_on_buffer(bhs[i]);
> > +                     if (buffer_eopnotsupp(bhs[i])) {
> > +                             clear_buffer_eopnotsupp(bhs[i]);
> > +                             err = -EOPNOTSUPP;
> > +                     } else if (!err && !buffer_uptodate(bhs[i]))
> > +                             err = -EIO;
> > +             }
> >       }
> > +
> >       return err;
> >  }
>
> You could keep the old indentation if your condition was changed to
>
>         if (!wait)
>                 return 0;
Sounds good.
>
> Jörn
>
> --
> You can take my soul, but not my lack of enthusiasm.
> -- Wally
>


-- 
Cell: 613-276-1645
