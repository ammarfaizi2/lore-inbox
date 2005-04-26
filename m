Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVDZAji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVDZAji (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 20:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVDZAjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 20:39:36 -0400
Received: from fire.osdl.org ([65.172.181.4]:13952 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261202AbVDZAj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 20:39:27 -0400
Date: Mon, 25 Apr 2005 17:37:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <roland@topspin.com>
Cc: timur.tabi@ammasso.com, hch@infradead.org, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-Id: <20050425173757.1dbab90b.akpm@osdl.org>
In-Reply-To: <52acnmtmh6.fsf@topspin.com>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	<20050411142213.GC26127@kalmia.hozed.org>
	<52mzs51g5g.fsf@topspin.com>
	<20050411163342.GE26127@kalmia.hozed.org>
	<5264yt1cbu.fsf@topspin.com>
	<20050411180107.GF26127@kalmia.hozed.org>
	<52oeclyyw3.fsf@topspin.com>
	<20050411171347.7e05859f.akpm@osdl.org>
	<4263DEC5.5080909@ammasso.com>
	<20050418164316.GA27697@infradead.org>
	<4263E445.8000605@ammasso.com>
	<20050423194421.4f0d6612.akpm@osdl.org>
	<426BABF4.3050205@ammasso.com>
	<52is2bvvz5.fsf@topspin.com>
	<20050425135401.65376ce0.akpm@osdl.org>
	<521x8yv9vb.fsf@topspin.com>
	<20050425151459.1f5fb378.akpm@osdl.org>
	<426D6D68.6040504@ammasso.com>
	<20050425153256.3850ee0a.akpm@osdl.org>
	<52vf6atnn8.fsf@topspin.com>
	<20050425171145.2f0fd7f8.akpm@osdl.org>
	<52acnmtmh6.fsf@topspin.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <roland@topspin.com> wrote:
>
>     Andrew> How does the driver detect process exit?
> 
> I already answered earlier but just to be clear: registration goes
> through a character device, and all regions are cleaned up in the
> ->release() of that device.

yup.

> I don't currently have any code accounting against RLIMIT_MEMLOCK or
> testing CAP_FOO, but I have no problem adding whatever is thought
> appropriate.  Userspace also has control over the permissions and
> owner/group of the /dev node.

I guess device node permissions won't be appropriate here, if only because
it sounds like everyone will go and set them to 0666.

RLIMIT_MEMLOCK sounds like the appropriate mechanism.  We cannot rely upon
userspace running mlock(), so perhaps it is appropriate to run sys_mlock()
in-kernel because that gives us the appropriate RLIMIT_MEMLOCK checking.

However an hostile app can just go and run munlock() and then allocate
some more pinned-by-get_user_pages() memory.

umm, how about we

- force the special pages into a separate vma

- run get_user_pages() against it all

- use RLIMIT_MEMLOCK accounting to check whether the user is allowed to
  do this thing

- undo the RMLIMIT_MEMLOCK accounting in ->release

This will all interact with user-initiated mlock/munlock in messy ways. 
Maybe a new kernel-internal vma->vm_flag which works like VM_LOCKED but is
unaffected by mlock/munlock activity is needed.

A bit of generalisation in do_mlock() should suit?
