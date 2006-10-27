Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752410AbWJ0S4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbWJ0S4V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 14:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752419AbWJ0S4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 14:56:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:38430 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752414AbWJ0S4S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 14:56:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=qMvwrLeGS+2hqHCN63/B2dZCuw90HH1hBU3kzaczz3EUAhgXH+TOpw9xgNHZEzZFR/EOGQjjwDgOhM1q4AqEU45mvc1l8yiTyQR0Ct0C+xAFE10Mmoe3WP/zAAiNmndvVnx/DITxf2SdzBsBu2ZPFdyBJz2ArivGWrEUFJObKxA=
Message-ID: <f46018bb0610271156p63e71eebg7992b99ec50ce005@mail.gmail.com>
Date: Fri, 27 Oct 2006 14:56:16 -0400
From: "Holden Karau" <holden@pigscanfly.ca>
To: "=?ISO-8859-1?Q?J=F6rn_Engel?=" <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH 1/1] fat: improve sync performance by grouping writes in fat_mirror_bhs [really unmangled]
Cc: "Josef Sipek" <jsipek@fsl.cs.sunysb.edu>, hirofumi@mail.parknet.co.jp,
       linux-kernel@vger.kernel.org, holdenk@xandros.com,
       "akpm@osdl.org" <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       holden.karau@gmail.com
In-Reply-To: <20061026153037.GB12596@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <4540A32E.5050602@pigscanfly.ca>
	 <20061026153037.GB12596@wohnheim.fh-wedel.de>
X-Google-Sender-Auth: d300ebc3d4655836
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jörn,

Thanks for your time, I'll make those changes [along with a few other
things I noticed while benchmarking it]. Before I put together a
patch, does anyone else see any obvious stuff I should clean up?

Cheers,

Holden :-)

On 10/26/06, Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> I didn't pay too much attention, but found some low hanging fruits.
>
> On Thu, 26 October 2006 07:59:42 -0400, Holden Karau wrote:
> >
> > -/* FIXME: We can write the blocks as more big chunk. */
> >  static int fat_mirror_bhs(struct super_block *sb, struct buffer_head **bhs,
> > -                       int nr_bhs)
> > +                       int nr_bhs ) {
> > +  return fat_mirror_bhs_optw(sb , bhs , nr_bhs, 0);
> > +}
> > +
> > +static int fat_mirror_bhs_optw(struct super_block *sb, struct buffer_head **bhs,
> > +                            int nr_bhs , int wait)
>
> Does this compile without warnings?  Looks as if you should reverse
> the order of the two functions.
>
For some reason it compiles without warnings for me, but I'll switch the order.
> >  {
> >       struct msdos_sb_info *sbi = MSDOS_SB(sb);
> > -     struct buffer_head *c_bh;
> > +     struct buffer_head *c_bh[nr_bhs];
> >       int err, n, copy;
> >
> > +     /* Always wait if mounted -o sync */
> > +     if (sb->s_flags & MS_SYNCHRONOUS ) {
> > +       wait = 1;
> > +     }
>
> Coding style.  Use a tab for indentation and don't use braces for
> single-line conditional statements.
>
Sorry about that. A lot of the places where I used braces are because
I had some debugging output in there while I was hacking on it. I'll
change it.
> > +
> >       err = 0;
> > +     err = fat_sync_bhs_optw( bhs  , nr_bhs , wait);
>
> The err=0; is superfluous now, isn't it?
>
.... no comment :-)
> > +     if (err)
> > +       goto error;
>
> Indentation.
>
oops :-) I'll fix that.
> Jörn
>
> --
> Fantasy is more important than knowledge. Knowledge is limited,
> while fantasy embraces the whole world.
> -- Albert Einstein
>


-- 
Cell: 613-276-1645
