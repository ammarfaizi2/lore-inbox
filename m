Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270772AbUJUPfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270772AbUJUPfY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 11:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270779AbUJUPbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 11:31:55 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:31114 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S270755AbUJUP3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 11:29:07 -0400
From: Paolo Giarrusso <blaisorblade_personal@yahoo.it>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/1] dm: fix printk warnings about whether %lu/%Lu is right for sector_t
Date: Thu, 21 Oct 2004 17:27:04 +0200
User-Agent: KMail/1.6.1
Cc: Alasdair G Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org,
       neilb@cse.unsw.edu.au
References: <20041008144034.EB891B557@zion.localdomain> <20041019174115.GC6408@agk.surrey.redhat.com> <20041019155258.75f35416.akpm@osdl.org>
In-Reply-To: <20041019155258.75f35416.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410211727.04286.blaisorblade_personal@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 October 2004 00:52, Andrew Morton wrote:
> Alasdair G Kergon <agk@redhat.com> wrote:
> > On Fri, Oct 08, 2004 at 12:12:39PM -0700, Andrew Morton wrote:
> >  > I would prefer that SECTOR_FORMAT be removed altogether.
> >  >
> >  > The industry-standard way of printing a sector_t is:
> >  > 	printk("%llu", (unsigned long long)sector);
> >
> >  What about reading a sector_t with sscanf, which looks like the
> >  reason for the existence of SECTOR_FORMAT?
>
> I'm not sure that it has arisen.  I'd do:

> 	unsigned long long temp;
> 	sector_t sector;
>
> 	sscanf(buf, "%llu", &temp);
> 	sector = temp;

It is already meaningless, IMHO, in this short example. But when you have such 
code:

        if (sscanf(argv[2], SECTOR_FORMAT, &cc->iv_offset) != 1) {
                ti->error = PFX "Invalid iv_offset sector";
                goto bad4;
        }

        if (sscanf(argv[4], SECTOR_FORMAT, &cc->start) != 1) {
                ti->error = PFX "Invalid device sector";
                goto bad4;
        }

it becomes even uglier.

Why cannot we simply define the macro in linux/types.h and go along? There is 
no reason at all for arch-dependent definition of this macro; we can handle 
CONFIG_LBD in arch-independent code. In fact, it's what I'm doing.

I'm resending the patch, removing altogether HAVE_SECTOR_T and anything in 
arch-code referring to that. For h8300, I'm unconditionally defining 
CONFIG_LBD in Kconfig.

An even better road would would be to use always a "unsigned long long" for 
64-bit sector_t even on 64-bit archs.

Is there any reason for having u/s64 being "(unsigned) long" instead of 
"(unsigned) long long"? I.e., must we cope with braindead gcc? If not, this 
should be fixed, to avoid even other such problems.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
