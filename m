Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbUDTLel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbUDTLel (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 07:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbUDTLel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 07:34:41 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54928 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262424AbUDTLeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 07:34:37 -0400
Date: Tue, 20 Apr 2004 13:34:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Warren Togami <wtogami@redhat.com>
Cc: Markus Lidel <Markus.Lidel@shadowconnect.com>,
       Arjan van de Ven <arjanv@redhat.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] i2o_block Fix, possible CFQ elevator problem?
Message-ID: <20040420113429.GL25806@suse.de>
References: <408471E2.8060201@redhat.com> <40848159.7090605@togami.com> <20040420070805.GC25806@suse.de> <4084D83D.8060405@redhat.com> <20040420080325.GD25806@suse.de> <4084E671.4090509@redhat.com> <20040420090523.GE25806@suse.de> <40850143.1090709@redhat.com> <20040420105622.GK25806@suse.de> <40850987.1080603@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40850987.1080603@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20 2004, Warren Togami wrote:
> Jens Axboe wrote:
> >>>
> >>>Repeat the tests that made it crash. The last patch I sent should work
> >>>for you, at least until the real issue is found.
> >>>
> >>
> >>Tested your patch, it indeed does seem to keep the system stable.  If I 
> >>am understanding it right, the patch disables merging in the case where 
> >>it would have caused a BUG condition?  (Less efficiency.)
> >
> >
> 
> Bad news... much later during the test the system locked up.  During 
> this test we did not use "sync" but just let all four bonnie++'s run.
> 
> http://togami.com/~warren/archive/2004/i2o_cfq_quad_bonnie3.txt
> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at cfq_iosched:404
> invalid operand: 0000 [1] SMP

Sorry about that, that's actually expected when we know this bug
exists. You need to move the cfq_remove_merge_hints(q, crq) before the
BUG_ON(q->last_merge == rq) check, or (better) just remove it
completely. There's no way that q->last_merge could be set to this
request after cfq_remove_merge_hints() was called.

-- 
Jens Axboe

