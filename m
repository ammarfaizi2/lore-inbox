Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVDCFAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVDCFAe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 00:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVDCFAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 00:00:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56479 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261502AbVDCFA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 00:00:26 -0500
Date: Sun, 3 Apr 2005 06:00:24 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Isn't there race issue during fput() and the dentry_open()?
Message-ID: <20050403050024.GV8859@parcelfarce.linux.theplanet.co.uk>
References: <BF571719A4041A478005EF3F08EA6DF0D96394@pcsmail03.pcs.pc.ome.toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BF571719A4041A478005EF3F08EA6DF0D96394@pcsmail03.pcs.pc.ome.toshiba.co.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2005 at 10:56:44AM +0900, Tomita, Haruo wrote:
> Isn't there race issue during fput() and the dentry_open()?
> When booting kernel, the following deadlocks are experienced.


> Stack traceback for pid 2130
> 0xf717f1b0	2130	1	1	0	R	0xf717f400 *irqbalance
> ESP	EIP	Function (args)
> 0xf75bfe38 0xc02d04b2 _spin_lock+0x2e (0xf7441a80)
> 0xf75bff34 0xc015667c file_move+0x14 (0xf63080e4, 0xf75bff58, 0x0, 0xf74bf000)
> 0xf75bff40 0xc0154e37 dentry_open+0xb9 (0xf63080e4, 0xf7f5ad80, 0xc02d00e6, 0x100100, 0x246)
> 0xf75bff58 0xc0154d78 filp_open+0x36
> 0xf75bffb4 0xc0155079 sys_open+0x31
> 0xf75bffc4 0xc02d196f syscall_call+0x7
> 
> The patch was made. Is this patch right?
> 
> diff -urN linux-2.6.12-rc1.orig/fs/file_table.c linux-2.6.12-rc1/fs/file_table.c
> --- linux-2.6.12-rc1.orig/fs/file_table.c	2005-03-02 16:37:47.000000000 +0900
> +++ linux-2.6.12-rc1/fs/file_table.c	2005-03-31 17:50:46.323999320 +0900
> @@ -209,11 +209,11 @@
>  
>  void file_kill(struct file *file)
>  {
> +	file_list_lock();
>  	if (!list_empty(&file->f_list)) {
> -		file_list_lock();
>  		list_del_init(&file->f_list);
> -		file_list_unlock();
>  	}
> +	file_list_unlock();
>  }

This is absolutely useless.  What are you trying to protect and how the
hell could keeping a lock around that check prevent any sort of deadlock?

Besides, who could possibly call fput() on struct file allocated by
dentry_open() and do that before the latter returns a reference to
that struct file?
