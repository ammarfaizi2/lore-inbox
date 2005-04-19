Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVDSOuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVDSOuZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 10:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVDSOuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 10:50:25 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:45573 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261555AbVDSOuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 10:50:05 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [PATCH] sha512: replace open-coded be64 conversions
Date: Tue, 19 Apr 2005 17:49:22 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, vital@ilport.com.ua
References: <200504190918.10279.vda@port.imtp.ilyichevsk.odessa.ua> <200504191712.09590.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.62.0504191635370.2074@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0504191635370.2074@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504191749.22666.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 April 2005 17:41, Jesper Juhl wrote:
> On Tue, 19 Apr 2005, Denis Vlasenko wrote:
> 
> > On Tuesday 19 April 2005 12:04, Jesper Juhl wrote:
> > > On Tue, 19 Apr 2005, Denis Vlasenko wrote:
> > > 
> > > > This + next patch were "modprobe tcrypt" tested.
> > > > See next mail.
> > > 
> > > Could you please send patches inline instead of as attachments. 
> > > Attachments mean there's more work involved in getting at them to read 
> > > them, and they are a pain when you want to reply and quote the patch to 
> > > comment on it.
> > > Thanks.
> > 
> > I'm afraid Kmail tend to subtly mangle inlined patches.
> > Then people start to complain that patch does not apply, and rightly so. :(
> > 
> > However, I can try.
> > 
> Thanks.
> 
> A few small comments below.
> 
> 
> [...]
> > @@ -483,12 +483,8 @@ static int anubis_setkey(void *ctx_arg, 
> >  	ctx->R = R = 8 + N;
> >  
> >  	/* * map cipher key to initial key state (mu): */
> > -		for (i = 0, pos = 0; i < N; i++, pos += 4) {
> > -		kappa[i] =
> > -			(in_key[pos    ] << 24) ^
> > -			(in_key[pos + 1] << 16) ^
> > -			(in_key[pos + 2] <<  8) ^
> > -			(in_key[pos + 3]      );
> > +	for (i = 0; i < N; i++) {
> > +		kappa[i] = be32_to_cpu( ((__be32*)in_key)[i] );
>                                          ^^^^^^^            ^
>                  is this cast really nessesary ?      No space there.

Yes, it is necessary. It (a) casts pointer to u32*,
this allows index [i] to work as inteneded.
Adn (b) it marks value as big-endian. IIRC this is needed
for sparse checking.

Spaces are there because otherwise it is a bit hard to visually
check for correct number and placement of three pairs of ()'s.

> >  	}
>         ^
>      Those braces are superfluous.

Yes. Since they were there from the start, I decided to not touch 'em.
--
vda

