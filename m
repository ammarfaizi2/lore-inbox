Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161055AbWGUKbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161055AbWGUKbJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 06:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbWGUKbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 06:31:09 -0400
Received: from outmx003.isp.belgacom.be ([195.238.4.100]:8381 "EHLO
	outmx003.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1161055AbWGUKbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 06:31:07 -0400
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to
	k(z|c)alloc.
From: Panagiotis Issaris <takis@gna.org>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, jgarzik@pobox.com,
       vandrove@vc.cvut.cz, adaplas@pol.net, thomas@winischhofer.net,
       weissg@vienna.at, philb@gnu.org, linux-pcmcia@lists.infradead.org,
       jkmaline@cc.hut.fi, paulus@samba.org
In-Reply-To: <200607210850.17878.eike-kernel@sf-tec.de>
References: <20060720190529.GC7643@lumumba.uhasselt.be>
	 <200607210850.17878.eike-kernel@sf-tec.de>
Content-Type: text/plain
Date: Fri, 21 Jul 2006 12:30:39 +0200
Message-Id: <1153477839.9489.25.camel@hemera>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On vr, 2006-07-21 at 08:50 +0200, Rolf Eike Beer wrote:
>[...]
> Space after comma.
>[...]
> sizeof(*ltp)?
> 
> [more of this snipped]

> 
> > @@ -443,12 +442,11 @@ int con_clear_unimap(struct vc_data *vc,
> >  	p = (struct uni_pagedir *)*vc->vc_uni_pagedir_loc;
> >  	if (p && p->readonly) return -EIO;
> >  	if (!p || --p->refcount) {
> > -		q = (struct uni_pagedir *)kmalloc(sizeof(*p), GFP_KERNEL);
> > +		q = kzalloc(sizeof(*p), GFP_KERNEL);
> >  		if (!q) {
> >  			if (p) p->refcount++;
> >  			return -ENOMEM;
> >  		}
> > -		memset(q, 0, sizeof(*q));
> >  		q->refcount=1;
> >  		*vc->vc_uni_pagedir_loc = (unsigned long)q;
> >  	} else {
> 
> This one still changes the way the code works. Before your patch *p will be 
> always zeroed out. Now if p is there before it will keep it's contents.
Hmm. I do not really see the functional change here: If the memory
allocation failed, then in both cases, q will be zero and the function
will return. If the memory allocation succeeds, then in both cases a
memset will occur. Is it more subtle than that?

Before change:
if (!p || --p->refcount) {
    q = kmalloc(sizeof(*p), GFP_KERNEL);
    if (!q) {
        if (p) 
            p->refcount++;
        return -ENOMEM;
    }
    memset(q, 0, sizeof(*q));
    q->refcount=1;
    *vc->vc_uni_pagedir_loc = (unsigned long)q;
}

After change:
if (!p || --p->refcount) {
    q = kzalloc(sizeof(*p), GFP_KERNEL);
    if (!q) {
        if (p) 
            p->refcount++;
        return -ENOMEM;
    }
    q->refcount=1;
    *vc->vc_uni_pagedir_loc = (unsigned long)q;
}

If !p then in both cases, q will be assigned some memory,
and if that succeeds, the block of memory will be cleared,
if it fails, it will not be cleared and the function will
exit.

If p then if --p->refcount<>0, a new block will be allocated
and if the allocation succeeds, it will be cleared in both cases.
If --p->refcount==0, nothing will be allocated nor cleared, in both
cases.

With friendly regards,
Takis

