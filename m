Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWEBNxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWEBNxE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 09:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWEBNxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 09:53:04 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:37645 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S964824AbWEBNxB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 09:53:01 -0400
Message-ID: <44576435.80603@argo.co.il>
Date: Tue, 02 May 2006 16:52:53 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: Willy Tarreau <willy@w.ods.org>, David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
References: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com> <MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com> <20060502051238.GB11191@w.ods.org> <44573525.7040507@argo.co.il> <mj+md-20060502.111446.9373.atrey@ucw.cz> <445741F5.6060204@argo.co.il> <mj+md-20060502.124648.6316.atrey@ucw.cz>
In-Reply-To: <mj+md-20060502.124648.6316.atrey@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 May 2006 13:52:58.0617 (UTC) FILETIME=[B878BE90:01C66DEF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares wrote:
> Hello!
>
>   
>> But it executed C++ code within a few cycles of entering the reset 
>> vector (no standard BIOS), including but not limited to: programming the 
>> memory controller (430MX chipset), servicing interrupts, hardware 
>> accelerated 2D graphics (C&T 65550), IDE driver, simple filesystem, 
>> simple windowing GUI, network driver (Tulip) etc.
>>     
>
> I really don't claim it's impossible to write kernels in C++ -- it's
> clearly possible given that everything you can do in C, you can do in
> C++ as well. But what I argued about is whether kernel programming in C++
> can be easier and more efficient, which is why I wanted you to show
> some examples. Real code speaks better than thousand theories.
>
>   

Here are three versions of do_sendfile(). When you read it, please 
assume you know light_file_ptr as well as you know f{get,put}_light, etc.

The (IMO) improvement is not dramatic since this is fairly much straight line code.

static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
			   size_t count, loff_t max)
{
	struct file * in_file, * out_file;
	struct inode * in_inode, * out_inode;
	loff_t pos;
	ssize_t retval;
	int fput_needed_in, fput_needed_out;

	/*
	 * Get input file, and verify that it is ok..
	 */
	retval = -EBADF;
	in_file = fget_light(in_fd, &fput_needed_in);
	if (!in_file)
		goto out;
	if (!(in_file->f_mode & FMODE_READ))
		goto fput_in;
	retval = -EINVAL;
	in_inode = in_file->f_dentry->d_inode;
	if (!in_inode)
		goto fput_in;
	if (!in_file->f_op || !in_file->f_op->sendfile)
		goto fput_in;
	retval = -ESPIPE;
	if (!ppos)
		ppos = &in_file->f_pos;
	else
		if (!(in_file->f_mode & FMODE_PREAD))
			goto fput_in;
	retval = rw_verify_area(READ, in_file, ppos, count);
	if (retval < 0)
		goto fput_in;
	count = retval;

	retval = security_file_permission (in_file, MAY_READ);
	if (retval)
		goto fput_in;

	/*
	 * Get output file, and verify that it is ok..
	 */
	retval = -EBADF;
	out_file = fget_light(out_fd, &fput_needed_out);
	if (!out_file)
		goto fput_in;
	if (!(out_file->f_mode & FMODE_WRITE))
		goto fput_out;
	retval = -EINVAL;
	if (!out_file->f_op || !out_file->f_op->sendpage)
		goto fput_out;
	out_inode = out_file->f_dentry->d_inode;
	retval = rw_verify_area(WRITE, out_file, &out_file->f_pos, count);
	if (retval < 0)
		goto fput_out;
	count = retval;

	retval = security_file_permission (out_file, MAY_WRITE);
	if (retval)
		goto fput_out;

	if (!max)
		max = min(in_inode->i_sb->s_maxbytes, out_inode->i_sb->s_maxbytes);

	pos = *ppos;
	retval = -EINVAL;
	if (unlikely(pos < 0))
		goto fput_out;
	if (unlikely(pos + count > max)) {
		retval = -EOVERFLOW;
		if (pos >= max)
			goto fput_out;
		count = max - pos;
	}

	retval = in_file->f_op->sendfile(in_file, ppos, count, file_send_actor, out_file);

	if (retval > 0) {
		current->rchar += retval;
		current->wchar += retval;
	}
	current->syscr++;
	current->syscw++;

	if (*ppos > max)
		retval = -EOVERFLOW;

fput_out:
	fput_light(out_file, fput_needed_out);
fput_in:
	fput_light(in_file, fput_needed_in);
out:
	return retval;
}



static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
			   size_t count, loff_t max)
{
	loff_t pos;
	ssize_t retval;

	/*
	 * Get input file, and verify that it is ok..
	 */
	light_file_ptr in_file(in_fd);
	if (!in_file.valid())
		return -EBADF;
	if (!in_file->readable())
		return -EBADF;
	retval = -EINVAL;
	struct inode *in_inode = in_file->dentry()->inode();
	if (!in_inode)
		return -EINVAL;
	// I'm assuming here that the default sendfile() returns -EINVAL
	if (!ppos)
		ppos = &in_file->f_pos;
	else
		if (!(in_file->mode() & FMODE_PREAD))
			return -ESPIPE;
	retval = rw_verify_area(READ, in_file, ppos, count);
	if (retval < 0)
		return retval;
	count = retval;

	retval = security_file_permission (in_file, MAY_READ);
	if (retval)
		return retval;

	/*
	 * Get output file, and verify that it is ok..
	 */
	light_file_ptr out_file(out_fd);
	if (!out_file)
		return -EBADF;
	if (!(out_file->writable())
		return -EBADF;
	// Again, assuming default sendpage returns -EINVAL
	struct inode *out_inode = out_file->dentry()->inode();
	retval = rw_verify_area(WRITE, out_file, &out_file->f_pos, count);
	if (retval < 0)
		return retval;
	count = retval;

	retval = security_file_permission (out_file, MAY_WRITE);
	if (retval)
		return retval;

	if (!max)
		max = min(in_inode->i_sb->s_maxbytes, out_inode->i_sb->s_maxbytes);

	pos = *ppos;
	if (unlikely(pos < 0))
		return -EINVAL;
	if (unlikely(pos + count > max)) {
		if (pos >= max)
			return -EOVERFLOW;
		count = max - pos;
	}

	retval = in_file->sendfile(ppos, count, file_send_actor, out_file);

	if (retval > 0) {
		current->rchar += retval;
		current->wchar += retval;
	}
	current->syscr++;
	current->syscw++;

	if (*ppos > max)
		return -EOVERFLOW;

	return retval;
}

// now, with exceptions
static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
			   size_t count, loff_t max)
{
	loff_t pos;

	/*
	 * Get input file, and verify that it is ok..
	 */
	light_file_ptr in_file(in_fd);
	in_file->verify_readable();
	struct inode *in_inode = in_file->dentry()->inode();
	if (!in_inode)
		throw EINVAL;
	// I'm assuming here that the default sendfile() returns -EINVAL
	if (!ppos)
		ppos = &in_file->f_pos;
	else
        in_file->verify_preadable();
	count = in_file->verify_area(READ, ppos, count);

	in_file->security_verify_permission(MAY_READ);

	/*
	 * Get output file, and verify that it is ok..
	 */
	light_file_ptr out_file(out_fd);
	out_file->verify_writable();
	// Again, assuming default sendpage returns -EINVAL
	struct inode *out_inode = out_file->dentry()->inode();
	count = out_file->verify_area(WRITE, &out_file->f_pos, count);

	out_file->security_verify_permission(MAY_WRITE);

	if (!max)
		max = min(in_inode->i_sb->s_maxbytes, out_inode->i_sb->s_maxbytes);

	pos = *ppos;
	if (unlikely(pos < 0))
		throw EINVAL;
	if (unlikely(pos + count > max)) {
		if (pos >= max)
			throw EOVERFLOW;
		count = max - pos;
	}

	count = in_file->sendfile(ppos, count, file_send_actor, out_file);

	current->rchar += count;
	current->wchar += count;
	current->syscr++;
	current->syscw++;

	if (*ppos > max)
		throw EOVERFLOW;

	return count;
}


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

