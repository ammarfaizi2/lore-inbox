Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263240AbUCNBS5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 20:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263242AbUCNBS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 20:18:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:41153 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263240AbUCNBSz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 20:18:55 -0500
Date: Sat, 13 Mar 2004 17:18:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alex Lyashkov <shadow@psoft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible kernel bug in signal transit.
Message-Id: <20040313171856.37b32e52.akpm@osdl.org>
In-Reply-To: <1079197336.13835.15.camel@berloga.shadowland>
References: <1079197336.13835.15.camel@berloga.shadowland>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Lyashkov <shadow@psoft.net> wrote:
>
> Hello All
> 
> I analyze kernel vanila 2.6.4 and found one possible bug in
> __kill_pg_info function.
> 
>         for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid) {
>                 err = group_send_sig_info(sig, info, p);
>                 if (retval)
>                         retval = err;
>         }
> but I think if (retval) is incorrect check. possible this cycle must be
>         for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid) {
>                 err = group_send_sig_info(sig, info, p);
>                 if (ret) {
>                         retval = err;
> 			break;
> 		}
>         }
> because in original variant me assign to retval only first value from
> ret and other be ignored if this value be 0.
> 

No, the code's OK, albeit undesirably obscure.  It will return -ESRCH if
none of the tasks had a matching pgrp and will return the result of the
final non-zero-returning group_send_sig_info() if one or more of the
group_send_sig_info() calls failed, and will return zero if all of the
group_send_sig_info() calls returned zero.

Thanks for checking though..
