Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263111AbUCNEja (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 23:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263279AbUCNEja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 23:39:30 -0500
Received: from [213.227.237.65] ([213.227.237.65]:3712 "EHLO
	berloga.shadowland") by vger.kernel.org with ESMTP id S263111AbUCNEj1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 23:39:27 -0500
Subject: Re: possible kernel bug in signal transit.
From: Alex Lyashkov <shadow@psoft.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040313171856.37b32e52.akpm@osdl.org>
References: <1079197336.13835.15.camel@berloga.shadowland>
	 <20040313171856.37b32e52.akpm@osdl.org>
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Organization: PSoft
Message-Id: <1079239159.8186.24.camel@berloga.shadowland>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Sun, 14 Mar 2004 06:39:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

В Вск, 14.03.2004, в 03:18, Andrew Morton пишет:
> Alex Lyashkov <shadow@psoft.net> wrote:
> >
> > Hello All
> > 
> > I analyze kernel vanila 2.6.4 and found one possible bug in
> > __kill_pg_info function.
> > 
> >         for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid) {
> >                 err = group_send_sig_info(sig, info, p);
> >                 if (retval)
> >                         retval = err;
> >         }
> > but I think if (retval) is incorrect check. possible this cycle must be
> >         for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid) {
> >                 err = group_send_sig_info(sig, info, p);
> >                 if (ret) {
> >                         retval = err;
> > 			break;
> > 		}
> >         }
> > because in original variant me assign to retval only first value from
> > ret and other be ignored if this value be 0.
> > 
> 
> No, the code's OK, albeit undesirably obscure.  It will return -ESRCH if
> none of the tasks had a matching pgrp and will return the result of the
> final non-zero-returning group_send_sig_info() if one or more of the
> group_send_sig_info() calls failed, and will return zero if all of the
> group_send_sig_info() calls returned zero.
> 
> Thanks for checking though..
No. it can`t return final non-zero-returning group_send_sig_info() if
first call group_send_sig_info return 0.
Example me have 3 groups it will return
1 - zero
2 - nonzero (example -1)
3 - nonzero (example -2)
original code will return zero.
but you say it will return last non zero - "-2" in example.
(do only first assignment after it retval is zero and no assignments
does.)
For her logic me can write.
=====
	int retval = 0;
	int err = -1;
        for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid) {
                 err = group_send_sig_info(sig, info, p);
		if( err )
			retval = err;

         }
	return err==-1 ? -ESRCH : retval;
===
If me not enter to this cycle - retval = -ESRCH, and last non zero err
if cycle is worked or zero if all group_send_sig_info() return zero.


-- 
Alex Lyashkov <shadow@psoft.net>
PSoft
