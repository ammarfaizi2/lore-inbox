Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423068AbWJSR3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423068AbWJSR3w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423082AbWJSR3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:29:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:730 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1423068AbWJSR3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:29:51 -0400
Date: Thu, 19 Oct 2006 18:29:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Vasily Tarasov <vtaras@openvz.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jan Kara <jack@suse.cz>,
       Dmitry Mishin <dim@openvz.org>, Vasily Averin <vvs@sw.ru>,
       Kirill Korotaev <dev@openvz.org>,
       OpenVZ Developers List <devel@openvz.org>
Subject: Re: [PATCH] diskquota: 32bit quota tools on 64bit architectures
Message-ID: <20061019172948.GA30975@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Vasily Tarasov <vtaras@openvz.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Jan Kara <jack@suse.cz>,
	Dmitry Mishin <dim@openvz.org>, Vasily Averin <vvs@sw.ru>,
	Kirill Korotaev <dev@openvz.org>,
	OpenVZ Developers List <devel@openvz.org>
References: <200610191232.k9JCW7CF015486@vass.7ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610191232.k9JCW7CF015486@vass.7ka.mipt.ru>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 04:32:07PM +0400, Vasily Tarasov wrote:
> +asmlinkage long sys32_quotactl(unsigned int cmd, const char __user *special,
> +						qid_t id, void __user *addr)
> +{
> +	long ret;
> +	unsigned int cmds;
> +	mm_segment_t old_fs;
> +	struct if_dqblk dqblk;
> +	struct if32_dqblk {
> +		__u32 dqb_bhardlimit[2];
> +		__u32 dqb_bsoftlimit[2];
> +		__u32 dqb_curspace[2];
> +		__u32 dqb_ihardlimit[2];
> +		__u32 dqb_isoftlimit[2];
> +		__u32 dqb_curinodes[2];
> +		__u32 dqb_btime[2];
> +		__u32 dqb_itime[2];
> +		__u32 dqb_valid;
> +	} dqblk32;
> +
> +	cmds = cmd >> SUBCMDSHIFT;
> +
> +	switch (cmds) {
> +		case Q_GETQUOTA:
> +			old_fs = get_fs();
> +			set_fs(KERNEL_DS);
> +			ret = sys_quotactl(cmd, special, id, &dqblk);
> +			set_fs(old_fs);

Please allocate the structure using compat_alloc_userspace and copy
with copy_in_user instead of the set_fs trick.

