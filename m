Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262288AbVBQPYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbVBQPYC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 10:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVBQPWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 10:22:32 -0500
Received: from styx.suse.cz ([82.119.242.94]:51942 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261413AbVBQPVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 10:21:18 -0500
Date: Thu, 17 Feb 2005 16:19:11 +0100
From: Jirka Bohac <jbohac@suse.cz>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Jirka Bohac <jbohac@suse.cz>, lkml <linux-kernel@vger.kernel.org>,
       vojtech@suse.cz, roman@augan.com, hch@nl.linux.org
Subject: Re: [rfc] keytables - the new keycode->keysym mapping
Message-ID: <20050217151911.GA10351@dwarf.suse.cz>
References: <20050209132654.GB8343@dwarf.suse.cz> <20050209152740.GD12100@apps.cwi.nl> <20050209171921.GB11359@dwarf.suse.cz> <20050209200330.GB15005@apps.cwi.nl> <20050210125344.GA5196@dwarf.suse.cz> <20050216182035.GA7094@dwarf.suse.cz> <20050216214958.GA7682@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050216214958.GA7682@apps.cwi.nl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2005 at 10:49:58PM +0100, Andries Brouwer wrote:
> On Wed, Feb 16, 2005 at 07:20:35PM +0100, Jirka Bohac wrote:
>
> For the time being I look only at the diacr for unicode part.
> The fragment below looks like a strange kludge.
> 
> > -	if (diacr)
> > -		value = handle_diacr(vc, value);
> > +	if (diacr) {
> > +		v = handle_diacr(vc, value);
> > +
> > +		if (kbd->kbdmode == VC_UNICODE) {
> > +			to_utf8(vc, v & 0xFFFF);
> > +			return;
> > +		}
> > +
> > +		/* 
> > +		 * this makes at least latin-1 compose chars work 
> > +		 * even when using unicode keymap in non-unicode mode
> > +		 */
> > +		value = v & 0xFF; 
> > +	}
> >  
> >  	if (dead_key_next) {
> >  		dead_key_next = 0;
> > @@ -637,7 +652,7 @@
> >  {
> >  	if (up_flag)
> >  		return;
> > -	diacr = (diacr ? handle_diacr(vc, value) : value);
> > +	diacr = (diacr ? handle_diacr(vc, value) & 0xff : value);

I can't see your point ... you mean there is a problem that when 
kbd->kbdmode == VC_UNICODE, then control will not reach the 
"if (dead_key_next)"?

I don't think this is a problem. You have type a really strange sequence
of keypresses -- sth like: <a dead key><Compose> <a letter> in Unicode
mode ... then the behaviour would slightly differ from today's one. 
If you think this is worth fixing, I can do it.

> I see twice "& 0xff" but why?

Ok, it's not needed, because it would have been done automatically, as 
diacr and value are both unsigned chars. But at least we can clearly see
what's happening.

> The original code was good, so the only change should be to transport
> more than 8 bits.

You only want to transport more bits when handling a dead key. If the
put_queue at the end of the function was simply replaced by to_utf8, you
would modify the behaviour of normal KT_LATIN keys with value > 127;
Somebody may be rely on the current meaning.

regards,

-- 
Jirka Bohac <jbohac@suse.cz>
SUSE Labs, SUSE CR

