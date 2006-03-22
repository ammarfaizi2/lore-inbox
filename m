Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWCVMUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWCVMUI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 07:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWCVMUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 07:20:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54203 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750852AbWCVMUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 07:20:06 -0500
Date: Wed, 22 Mar 2006 12:19:41 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com
Subject: Re: [dm-devel] Re: dm: bio split bvec fix
Message-ID: <20060322121941.GS26428@agk.surrey.redhat.com>
Mail-Followup-To: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20060320192155.GU4724@agk.surrey.redhat.com> <20060322113235.GC4285@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060322113235.GC4285@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 12:32:35PM +0100, Jens Axboe wrote:
> Why isn't this just handled in the merge callback? Can a single page bio
> span > 2 targets?
 
Yes.  (Unit of size if the sector - and things don't have to
be aligned nicely, just aligned to sector.)

IIRC the merge function assumes the number of bytes that can
be added is only a function of the offset: but in our case
it's also a function of time.  To make this work it should
reserve those bytes with device-mapper, and guarantee either to 
supply them to us subsequently (and preferably quickly) or to 
cancel that reservation.  Device-mapper for its part would
guarantee to accept the bio without needing to split it.
Or dm could have a rejection mechanism that refuses bios
that are too big (because the max number of bytes we accept
got reduced between the initial call and the bio actually being 
presented) and they go back and get processed again.

Alasdair
-- 
agk@redhat.com
