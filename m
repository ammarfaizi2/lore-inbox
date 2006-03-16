Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWCPDa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWCPDa6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWCPDa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:30:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60045 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932260AbWCPDa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:30:57 -0500
Date: Wed, 15 Mar 2006 19:28:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rdreier@cisco.com, torvalds@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
Message-Id: <20060315192813.71a5d31a.akpm@osdl.org>
In-Reply-To: <1142477579.6994.124.camel@localhost.localdomain>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	<ada4q27fban.fsf@cisco.com>
	<1141948516.10693.55.camel@serpentine.pathscale.com>
	<ada1wxbdv7a.fsf@cisco.com>
	<1141949262.10693.69.camel@serpentine.pathscale.com>
	<20060309163740.0b589ea4.akpm@osdl.org>
	<1142470579.6994.78.camel@localhost.localdomain>
	<ada3bhjuph2.fsf@cisco.com>
	<1142475069.6994.114.camel@localhost.localdomain>
	<adaslpjt8rg.fsf@cisco.com>
	<1142477579.6994.124.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan O'Sullivan" <bos@pathscale.com> wrote:
>
> On Wed, 2006-03-15 at 18:37 -0800, Roland Dreier wrote:
>  >     Roland> I think you should always be doing a get_page().
>  > 
>  >     Bryan> Yeah.  I think so too, but when I do it, I get an oops.
>  > 
>  > Hmm, looking at that oops might help debug your problem.
> 
>  This is what it looks like when I always call get_page in my nopage
>  handler (after checking that the pfn is valid and pfn_to_page hasn't
>  given me junk).
> 
>  Bad page state at free_hot_cold_page (in process 'mpi_hello', page ffff810002098af8)
>  flags:0x0100000000000404 mapping:0000000000000000 mapcount:0 count:0 (Not tainted)

It still has PG_reserved set.  I'd suggest you simply not set PG_reserved
on these pages.

> Call Trace:<ffffffff80169577>{bad_page+135} <ffffffff8016a743>{free_hot_cold_page+112}
>         <ffffffff8016a839>{__pagevec_free+41} <ffffffff801710ba>{release_pages+331}
>         <ffffffff8017fce9>{free_pages_and_swap_cache+125} <ffffffff80176953>{unmap_vmas+1186}
>         <ffffffff80179a58>{exit_mmap+124} <ffffffff80139fe6>{mmput+37}
>         <ffffffff8013f2d4>{do_exit+584} <ffffffff8013fdd1>{sys_exit_group+0}
>         <ffffffff80149fd9>{get_signal_to_deliver+1594} <ffffffff8010f23a>{do_signal+116}
>         <ffffffff8011017e>{retint_signal+61}

hm.  Are these pages supposed to be owned by the userspace process?  To have their
lifetime controlled by that process?
