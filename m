Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265692AbUGDTb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265692AbUGDTb5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 15:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265715AbUGDTb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 15:31:56 -0400
Received: from holomorphy.com ([207.189.100.168]:23499 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265692AbUGDTbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 15:31:55 -0400
Date: Sun, 4 Jul 2004 12:31:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: force O_LARGEFILE in sys_swapon() and sys_swapoff()
Message-ID: <20040704193152.GN21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <20040704064440.GZ21066@holomorphy.com> <Pine.LNX.4.44.0407042010450.5234-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407042010450.5234-100000@localhost.localdomain>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jul 2004, William Lee Irwin III wrote:
>> For 32-bit, one quickly discovers that swapon() is not given an fd
>> already opened with O_LARGEFILE to act upon and the forcing of
>> O_LARGEFILE for 64-bit is irrelevant, as the system call's argument is
>> a path. So this patch manually forces it for swapon() and swapoff().

On Sun, Jul 04, 2004 at 08:21:25PM +0100, Hugh Dickins wrote:
> This one looks good, thanks.  I'm not so sure of your more general
> patch to open, others know better on that.
> I doubt huge amounts of swap work at all well when used, but you're
> really concerned with commit at present: of course it was silly not
> to have used O_LARGEFILE here.

The story on the more general one is that it silently broke -EFBIG
returns for 32-bit emulation. Arnd posted a patch to consolidate 32-bit
open() emulation, which I followed up with a hoist of the O_LARGEFILE
check to there above filp_open(). The forcing of O_LARGEFILE is still
needed for other, non-open()-related situations, and I may need to
sweep 32-bit emulation for other syscalls. Of course, it's a lose-lose
situation, as 64-bit now can't do internal kernel filp_open() on files
larger than 64-bit unsafe 32-bit apps can. In short, a large headache.

-- wli
