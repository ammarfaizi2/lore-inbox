Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269281AbUIBXL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269281AbUIBXL5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 19:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269260AbUIBXIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 19:08:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:54963 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269185AbUIBXAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:00:22 -0400
Date: Thu, 2 Sep 2004 15:57:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Simon Derr <Simon.Derr@bull.net>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Possible race in sysfs_read_file() and
 sysfs_write_file()
Message-Id: <20040902155758.1eba30a5.akpm@osdl.org>
In-Reply-To: <Pine.A41.4.53.0409020917350.122970@isabelle.frec.bull.fr>
References: <Pine.A41.4.53.0409010924250.122970@isabelle.frec.bull.fr>
	<20040901163436.263802bc.akpm@osdl.org>
	<Pine.A41.4.53.0409020917350.122970@isabelle.frec.bull.fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Derr <Simon.Derr@bull.net> wrote:
>
> @@ -140,13 +145,17 @@
>   	struct sysfs_buffer * buffer = file->private_data;
>   	ssize_t retval = 0;
> 
>  -	if (!*ppos) {
>  +	down(&buffer->sem);
>  +	if ((!*ppos) || (!buffer->page)) {
>   		if ((retval = fill_read_buffer(file->f_dentry,buffer)))
>  -			return retval;
>  +			goto out;

Why are we testing *ppos at all in here?
