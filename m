Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932690AbWJLQp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbWJLQp7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 12:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932689AbWJLQp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 12:45:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20182 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932690AbWJLQp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 12:45:58 -0400
Message-ID: <452E7100.2010102@redhat.com>
Date: Thu, 12 Oct 2006 11:44:48 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jan Kara <jack@suse.cz>, Badari Pulavarty <pbadari@us.ibm.com>,
       Eric Sandeen <sandeen@sandeen.net>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 ext3 panic.
References: <20061009225036.GC26728@redhat.com>	<20061010141145.GM23622@atrey.karlin.mff.cuni.cz>	<452C18A6.3070607@redhat.com>	<1160519106.28299.4.camel@dyn9047017100.beaverton.ibm.com>	<452C4C47.2000107@sandeen.net>	<20061011103325.GC6865@atrey.karlin.mff.cuni.cz>	<452CF523.5090708@sandeen.net>	<20061011142205.GB24508@atrey.karlin.mff.cuni.cz>	<1160589284.1447.19.camel@dyn9047017100.beaverton.ibm.com>	<452DAA26.6080200@redhat.com>	<20061012122820.GK9495@atrey.karlin.mff.cuni.cz> <20061012094036.e1a3f9f1.akpm@osdl.org>
In-Reply-To: <20061012094036.e1a3f9f1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 12 Oct 2006 14:28:20 +0200
> Jan Kara <jack@suse.cz> wrote:
> 
>> Where can we call
>> journal_dirty_data() without PageLock?
> 
> block_write_full_page() will unlock the page, so ext3_writepage()
> will run journal_dirty_data_fn() against an unlocked page.
> 
> I haven't looked into the exact details of the race, but it should
> be addressable via jbd_lock_bh_state() or j_list_lock coverage.

Yep, that's what I've been hashing out with Stephen today...

In one of my cases journal_dirty_data has dropped & re-acquired the
bh_state lock and j_list_lock, and journal_unmap_buffer has come along
in the meantime.

So it looks like we are missing some state tests, i.e. buffer_mapped(),
at a couple points after we acquire jbd_lock_bh_state().

-Eric
