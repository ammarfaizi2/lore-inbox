Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbWBSOP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbWBSOP2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 09:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbWBSOP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 09:15:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18135 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932505AbWBSOP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 09:15:27 -0500
Date: Sun, 19 Feb 2006 14:15:18 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       autofs mailing list <autofs@linux.kernel.org>
Subject: Re: [PATCH] autofs4 - fix comms packet struct size
Message-ID: <20060219141517.GA7942@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ian Kent <raven@themaw.net>, Andrew Morton <akpm@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	autofs mailing list <autofs@linux.kernel.org>
References: <Pine.LNX.4.64.0602192206440.24506@eagle.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602192206440.24506@eagle.themaw.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 10:11:31PM +0800, Ian Kent wrote:
> 
> Set userspace communication struct fields to fixed size.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> 
> --- linux-2.6.16-rc3-mm1/include/linux/auto_fs4.h.fix-v5-packet-size	2006-02-17 19:15:49.000000000 +0800
> +++ linux-2.6.16-rc3-mm1/include/linux/auto_fs4.h	2006-02-17 19:12:09.000000000 +0800
> @@ -65,10 +65,10 @@ struct autofs_v5_packet {
>  	autofs_wqt_t wait_queue_token;

Hiding types in user visible structures behind typedefs is bad.
What type is behind this?  If this is not an __u32 you have
a padding issue.

>  	__u32 dev;
>  	__u64 ino;
> -	uid_t uid;
> -	gid_t gid;
> -	pid_t pid;
> -	pid_t tgid;
> +	__u64 uid;
> +	__u64 gid;
> +	__u64 pid;
> +	__u64 tgid;

These should be 32bit values.

>  	int len;

this should become a fixed-size type aswell.

>  	char name[NAME_MAX+1];
>  };
> --- linux-2.6.16-rc3-mm1/fs/autofs4/autofs_i.h.fix-v5-packet-size	2006-02-17 19:17:03.000000000 +0800
> +++ linux-2.6.16-rc3-mm1/fs/autofs4/autofs_i.h	2006-02-17 19:17:25.000000000 +0800
> @@ -79,10 +79,10 @@ struct autofs_wait_queue {
>  	char *name;
>  	u32 dev;
>  	u64 ino;
> -	uid_t uid;
> -	gid_t gid;
> -	pid_t pid;
> -	pid_t tgid;
> +	u64 uid;
> +	u64 gid;
> +	u64 pid;
> +	u64 tgid;
>  	/* This is for status reporting upon return */
>  	int status;
>  	atomic_t notified;

This is an in-kernel structure, isn't it?  No need to use u64 here.

