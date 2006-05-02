Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWEBONK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWEBONK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 10:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWEBONK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 10:13:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:17372 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964829AbWEBONJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 10:13:09 -0400
Date: Tue, 2 May 2006 15:13:05 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Avi Kivity <avi@argo.co.il>
Cc: Martin Mares <mj@ucw.cz>, Willy Tarreau <willy@w.ods.org>,
       David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
Message-ID: <20060502141305.GV27946@ftp.linux.org.uk>
References: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com> <MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com> <20060502051238.GB11191@w.ods.org> <44573525.7040507@argo.co.il> <mj+md-20060502.111446.9373.atrey@ucw.cz> <445741F5.6060204@argo.co.il> <mj+md-20060502.124648.6316.atrey@ucw.cz> <44576435.80603@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44576435.80603@argo.co.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 04:52:53PM +0300, Avi Kivity wrote:
> static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
> 			   size_t count, loff_t max)
> {
> 	loff_t pos;
> 	ssize_t retval;
> 
> 	/*
> 	 * Get input file, and verify that it is ok..
> 	 */
> 	light_file_ptr in_file(in_fd);

*snerk*
Good luck defining copying and conversion to file * for that puppy.  

> 	if (!in_file.valid())
> 		return -EBADF;
> 	if (!in_file->readable())
> 		return -EBADF;
> 	retval = -EINVAL;
> 	struct inode *in_inode = in_file->dentry()->inode();

Lovely.  Let's expose all fields as methods?

> 	if (!in_inode)
> 		return -EINVAL;

BTW, that can't happen.  Applies to the original as well.

> 	// I'm assuming here that the default sendfile() returns -EINVAL
> 	if (!ppos)
> 		ppos = &in_file->f_pos;
> 	else
> 		if (!(in_file->mode() & FMODE_PREAD))
> 			return -ESPIPE;

As opposed to ->readable() for checking FMODE_READ?

> 	light_file_ptr out_file(out_fd);
> 	if (!out_file)
> 		return -EBADF;

?

> 	if (!max)
> 		max = min(in_inode->i_sb->s_maxbytes, 
> 		out_inode->i_sb->s_maxbytes);

While we are at it, that's the only place where in_inode and out_inode
are used.  Also... how does one remember which of ->dentry, ->inode
and ->i_sb are methods and which are public fields?

> // now, with exceptions
> static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
> 			   size_t count, loff_t max)
> {
> 	loff_t pos;
> 
> 	/*
> 	 * Get input file, and verify that it is ok..
> 	 */
> 	light_file_ptr in_file(in_fd);
> 	in_file->verify_readable();

That assumes that error value returned in that case is the same everywhere.
It isn't.
