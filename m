Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267447AbUJRVkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267447AbUJRVkG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 17:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267449AbUJRVkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 17:40:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:25509 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267543AbUJRVj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 17:39:58 -0400
Date: Mon, 18 Oct 2004 14:43:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [PATCH] add unschedule_delayed_work to the workqueue API
Message-Id: <20041018144354.2118138f.akpm@osdl.org>
In-Reply-To: <1098134994.2792.325.camel@mulgrave>
References: <1098117067.2011.64.camel@mulgrave>
	<20041018142524.5b81a09a.akpm@osdl.org>
	<1098134824.2011.322.camel@mulgrave>
	<1098134994.2792.325.camel@mulgrave>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> On Mon, 2004-10-18 at 16:26, James Bottomley wrote:
> > On Mon, 2004-10-18 at 16:25, Andrew Morton wrote:
> > > The usual way of doing this is:
> > > 
> > > 	cancel_delayed_work(...);
> 
> OK, found it in the headers, sorry .. it's not synchronous, so it can't
> really be used in most of the cases where we use del_timer_sync().

cancel_delayed_work() will tell you whether it successfully cancelled the
timer.  If it didn't, you should run flush_workqueue() to wait on the final
handler.  The combination of the two is synchronous.

The missing link is cancellation of a delayed work which re-adds itself and
where the calling code has no way of telling the handler to not re-arm
itself.  There's a patch in -mm to add that function, but I don't like it.
That's cancel_rearming_delayed_work.patch.
